`timescale 1 ps  /  1 ps
module ITLB
    #(
        parameter   DATA_WIDTH        = 64              ,
        parameter   ADDR_WIDTH        = 64                              ,
    parameter   VPN_LEN           = 9               ,
    parameter   MODE_LEN          = 4               ,
    parameter   ASID_LEN          = 16              ,
    parameter   PPN_LEN           = DATA_WIDTH-MODE_LEN-ASID_LEN    ,
    parameter   PPN2_LEN          = PPN_LEN-(2*VPN_LEN)     ,
    parameter   PAGE_OFFSET_WIDTH = 12              , 
    parameter   TLB_DEPTH         = 256             ,
    parameter   PTESIZE           = 8               ,
    parameter   LEVELS            = 3               ,
    parameter   virt_addr_init    = 32'h0001_0000               ,
        parameter   init_op           = 3                                               
    ) (
        input                           CLK                             ,
        input               RST             ,
    input               TLB_FLUSH           ,
     
    //Signals from Branch Predictor
    input      [ADDR_WIDTH-1 : 0]   VIRT_ADDR           ,
    input               VIRT_ADDR_VALID         ,
    output wire[ADDR_WIDTH-1 : 0]   CURR_ADDR           ,
    //Signals to I-Cache
    output  reg         PHY_ADDR_VALID          ,
    output     [64-1 : 0]   PHY_ADDR            ,
    //Signals to/from AXI Master
    output              ADDR_TO_AXIM_VALID      ,
    output     [ADDR_WIDTH-1 : 0]   ADDR_TO_AXIM            ,
    input               DATA_FROM_AXIM_VALID        ,
    input      [DATA_WIDTH-1 : 0]   DATA_FROM_AXIM          ,
    input                   CACHE_READY         ,

        input      [1             :0]   OP_TYPE             ,
        output wire             PAGE_FAULT          ,
        output reg          ACCESS_FAULT            ,
        output wire[1         :0]   FAULT_TYPE          ,
        input      [DATA_WIDTH-1  :0]   SATP                ,
        input      [1         :0]   MPP             ,
        input               MPRV                ,
    input      [1         :0]   CURR_PREV,
    input OFF_TRANSLATION_FROM_TLB,
    output [1:0] OP_TYPE_OUT,
    input SUM_BIT

    );

    `include "PipelineParams.vh"

    localparam TLB_ADDR_WIDTH = logb2(TLB_DEPTH);
    localparam PTESIZE_WIDTH  = logb2(PTESIZE);

    localparam IDLE        = 0;
    localparam ITER_1      = 1;
    localparam ITER_2      = 2;
    localparam ITER_3      = 3;
    reg                     tlb_flush_reg;
    reg  [1             :0] op_type_reg;
    reg  [1             :0] mpp_reg;
    reg             mprv_reg;
    reg  [1             :0] curr_prev_reg;
    reg off_translation_from_tlb_reg;
    wire [MODE_LEN  -1  :0] satp_mode;
    wire [ASID_LEN  -1  :0] satp_asid;
    wire [PPN_LEN   -1  :0] satp_ppn;

    //pte_memory signals
    reg             pa_mem_wren;
    wire [TLB_ADDR_WIDTH-1 : 0] pa_mem_raddr;
    reg  [TLB_ADDR_WIDTH-1 : 0] pa_mem_waddr;
    reg  [PPN_LEN-1        : 0] pa_mem_data_in;
    wire [PPN_LEN-1        : 0] pa_mem_data_out;
    wire            dirty_out;
    reg             dirty_in;

    //tag memory signals
    reg  tag_mem_wren;
    wire [TLB_ADDR_WIDTH-1          : 0] tag_mem_raddr;
    reg  [TLB_ADDR_WIDTH-1          : 0] tag_mem_waddr;
    reg  [(LEVELS*VPN_LEN)-TLB_ADDR_WIDTH-1 : 0] tag_mem_data_in;
    wire [(LEVELS*VPN_LEN)-TLB_ADDR_WIDTH-1 : 0] tag_mem_data_out;

    //valid memory signals
    reg             valid_wren;
    reg [63:0]      physical_addr_reg;
    reg             valid_wren_reg;
    reg  [TLB_ADDR_WIDTH-1 : 0] valid_waddr;
    wire [TLB_ADDR_WIDTH-1 : 0] valid_raddr;
    wire            valid_out;

    wire            tlb_addr_valid;//TLB Hit signal

    reg tlb_addr_valid_reg;
    reg             addr_to_axim_valid_reg;
    reg  [ADDR_WIDTH-1 : 0] addr_to_axim_reg;

    reg  [1        : 0] state;
    wire            translation_off;
    wire            tlb_hit;

    reg             page_fault_reg;
    reg  [1     :0] fault_type_reg;
    wire            page_fault_comb;

    
    reg  [ADDR_WIDTH        -1 : 0] virt_addr_reg;
    reg  [ADDR_WIDTH        -1 : 0] virt_addr_reg_d1;

    wire [24               : 0] extra_bits;
    wire [VPN_LEN           -1 : 0] vpn2;
    wire [VPN_LEN           -1 : 0] vpn1;
    wire [VPN_LEN           -1 : 0] vpn0;
    wire [PAGE_OFFSET_WIDTH     -1 : 0] page_offset;

    assign {extra_bits,vpn2,vpn1,vpn0,page_offset} = tlb_addr_valid_reg? virt_addr_reg: virt_addr_reg_d1;

    wire [ 9:0] pte_reserved;
    wire [25:0] pte_ppn2;
    wire [ 8:0] pte_ppn1;
    wire [ 8:0] pte_ppn0;
    wire [ 1:0] pte_rsw;
    wire        pte_d;
    wire        pte_a;
    wire        pte_g;
    wire        pte_u;
    wire        pte_x;
    wire        pte_w;
    wire        pte_r;
    wire        pte_v;

    assign {pte_reserved,pte_ppn2,pte_ppn1,pte_ppn0,pte_rsw,pte_d,pte_a,pte_g,pte_u,pte_x,pte_w,pte_r,pte_v} = DATA_FROM_AXIM;

    reg  [DATA_WIDTH-1  :0] satp_reg;

    assign satp_mode = satp_reg[DATA_WIDTH-1 -: MODE_LEN];
    assign satp_asid = satp_reg[PPN_LEN +: ASID_LEN];
    assign satp_ppn  = satp_reg[PPN_LEN-1 : 0];


    always@(*)
    begin
        PHY_ADDR_VALID = tlb_addr_valid_reg ;
    end

    always @(posedge CLK) begin
        if (RST) begin
            virt_addr_reg        <=   virt_addr_init;
            op_type_reg          <=   init_op;
             satp_reg         <=   0;
             mpp_reg      <=   0; // mpp intial value * should check
             mprv_reg         <=   0;
             curr_prev_reg    <=   mmode; // *should check       
             tlb_flush_reg<=0;
             physical_addr_reg <= virt_addr_init;
        end
        else if (tlb_addr_valid_reg & VIRT_ADDR_VALID &  CACHE_READY) begin
             virt_addr_reg        <=   VIRT_ADDR; 
             virt_addr_reg_d1 <= virt_addr_reg;
             op_type_reg          <=   OP_TYPE;
             satp_reg         <=   SATP;
             mpp_reg      <=   MPP;
             mprv_reg         <=   MPRV;
             curr_prev_reg    <=   CURR_PREV;
             tlb_flush_reg<=TLB_FLUSH;
             off_translation_from_tlb_reg <= OFF_TRANSLATION_FROM_TLB;
        end  
        else
            tlb_flush_reg <=0;  
        if(RST) begin
            physical_addr_reg <= virt_addr_init;
        end
        else if(VIRT_ADDR_VALID & CACHE_READY) begin
             physical_addr_reg   <= translation_off ? virt_addr_reg : {pa_mem_data_out,page_offset};
        end

    end
    

    always@(posedge CLK)
    begin
        if (RST)
        begin
            addr_to_axim_valid_reg  <=0;
            addr_to_axim_reg        <=0;
            state                   <=IDLE;
            page_fault_reg          <=0;
            ACCESS_FAULT            <=0;
            fault_type_reg          <=0;
        end
        else if (~tlb_addr_valid_reg & ~valid_wren & ~valid_wren_reg & ~page_fault_reg)begin   //check whether cache ready and make sure flag goes 0 one cycle before data get written
            if(~addr_to_axim_valid_reg & (state == IDLE)   )begin
                addr_to_axim_valid_reg    <= 1;
                addr_to_axim_reg          <= {8'd0,satp_ppn,vpn2,3'd0}; // calculate the AXI address from SATP
                state                     <= ITER_1;
            end
            else if(state != IDLE) begin
                if (DATA_FROM_AXIM_VALID)begin
                    if(~pte_v)begin
                    addr_to_axim_valid_reg  <= 0;
                    page_fault_reg      <= 1;
                    fault_type_reg      <= op_type_reg;
                    state           <= IDLE;
                    end
                    else if(pte_r | pte_x)begin // some other conditions are there for page fault
                    addr_to_axim_valid_reg    <= 0;
                    if(~pte_a | ((op_type_reg == 2) & ~pte_d))begin
                       page_fault_reg <= 1;
                       fault_type_reg <= op_type_reg;
                       state          <= IDLE;
                    end
                    else begin
                               state          <= IDLE; // leaf page found, update the cache in below always block
                    end
                    end
                    else begin
                    if(state == ITER_1) begin
                                addr_to_axim_valid_reg    <= 1;
                                addr_to_axim_reg          <= {8'd0,pte_ppn2,pte_ppn1,pte_ppn0,vpn1,3'd0}; // calculate the AXI address from PTE
                                state                     <= ITER_2;
                    end
                    else if(state == ITER_2) begin
                         addr_to_axim_valid_reg    <= 1;
                         addr_to_axim_reg          <= {8'd0,pte_ppn2,pte_ppn1,pte_ppn0,vpn0,3'd0}; // calculate the AXI address from PTE
                         state                     <= ITER_3;
                    end
                    else begin
                                addr_to_axim_valid_reg    <= 0;
                        page_fault_reg        <= 1;
                        fault_type_reg        <= op_type_reg;
                        state             <= IDLE;
                    end                     
                    end
                end
                        else begin
                           addr_to_axim_valid_reg <= 0;
                        end
                    end
        end
    else if(page_fault_reg & VIRT_ADDR_VALID &  CACHE_READY) page_fault_reg <= 0; // shoould check
    else;

    if(RST)begin
        pa_mem_wren            <= 0;
        tag_mem_wren           <= 0;
        valid_wren             <= 0;
    end
    else if(DATA_FROM_AXIM_VALID)begin
         if(pte_v & (pte_r | pte_x) & pte_a & ((op_type_reg != 2) | pte_d))begin // all conditions upto IDLE state of above block
        pa_mem_wren    <= 1;
                pa_mem_waddr   <= pa_mem_raddr;
                tag_mem_wren   <= 1;
                tag_mem_waddr  <= tag_mem_raddr;
                valid_wren     <= 1;
                valid_waddr    <= valid_raddr;
                tag_mem_data_in<= virt_addr_reg[(PAGE_OFFSET_WIDTH+TLB_ADDR_WIDTH) +: ((LEVELS*VPN_LEN)-TLB_ADDR_WIDTH)];
                if     (state == ITER_1) {pa_mem_data_in,dirty_in} <= {pte_ppn2,vpn1,vpn0,pte_d};
        else if(state == ITER_2) {pa_mem_data_in,dirty_in} <= {pte_ppn2,pte_ppn1,vpn0,pte_d};
        else if(state == ITER_3) {pa_mem_data_in,dirty_in} <= {pte_ppn2,pte_ppn1,pte_ppn0,pte_d};
        else             {pa_mem_data_in,dirty_in} <= 0;
         end
         else begin
                pa_mem_wren            <= 0;
                tag_mem_wren           <= 0;
                valid_wren             <= 0;    
             end
    end
    else begin
        pa_mem_wren            <= 0;
                tag_mem_wren           <= 0;
                valid_wren             <= 0;    
    end
    end


    MEMORY  
    #(
        .data_width(PPN_LEN+1),//plus 1 for dirty bit
        .address_width(TLB_ADDR_WIDTH),
        .depth(TLB_DEPTH)
        )
    pa_memory
    (
        .CLK(CLK),
        .PORTA_WREN(pa_mem_wren),
        .PORTA_RADDR(pa_mem_raddr),
        .PORTA_WADDR(pa_mem_waddr),
        .PORTA_DATA_IN({pa_mem_data_in,dirty_in}),
        .PORTA_DATA_OUT({pa_mem_data_out,dirty_out})

        );
    MEMORY  
    #(
        .data_width((LEVELS*VPN_LEN)-TLB_ADDR_WIDTH),
        .address_width(TLB_ADDR_WIDTH),
        .depth(TLB_DEPTH)
        )
    vaddr_tag_memory
    (
        .CLK(CLK),
        .PORTA_WREN(tag_mem_wren),
        .PORTA_RADDR(tag_mem_raddr),
        .PORTA_WADDR(tag_mem_waddr),
        .PORTA_DATA_IN(tag_mem_data_in),
        .PORTA_DATA_OUT(tag_mem_data_out)

        );
    STATE_MEMORY
    #(
        .depth(TLB_DEPTH),
        .address_width(TLB_ADDR_WIDTH )

    )
    valid_mem
    (
        .CLK(CLK),
        .RST(RST),
        .FLUSH(tlb_flush_reg),
        .WREN(valid_wren),
        .WADDR(valid_waddr),
        .RADDR(valid_raddr),
        .STATE(valid_out),
        .DATA(1'b1)  
     );


    wire [TLB_ADDR_WIDTH -1 :0] read_addr_mux_out = tlb_addr_valid_reg? virt_addr_reg[PAGE_OFFSET_WIDTH+:TLB_ADDR_WIDTH]: virt_addr_reg_d1[PAGE_OFFSET_WIDTH+:TLB_ADDR_WIDTH];

    assign pa_mem_raddr   = read_addr_mux_out;
    assign tag_mem_raddr  = read_addr_mux_out;
    assign valid_raddr    = read_addr_mux_out;
    assign CURR_ADDR      = virt_addr_reg;
    reg page_fault_comb_reg;
    reg page_fault_reg_d1;
    always@(posedge CLK) begin
        if(RST) begin
            tlb_addr_valid_reg <= 1'b1;
            page_fault_comb_reg <= 1'b0;
            valid_wren_reg  <= 1'b0;
            page_fault_reg_d1 <= 1'b0;
        end
        else begin
            if(~valid_wren_reg & valid_wren) begin
                
                valid_wren_reg <=1;
            end
            else if(VIRT_ADDR_VALID & CACHE_READY) begin
                valid_wren_reg <= 0;
            end
            if(VIRT_ADDR_VALID & CACHE_READY) begin
                tlb_addr_valid_reg  <=  tlb_addr_valid;
                
            end
            page_fault_comb_reg <= page_fault_comb;
            page_fault_reg_d1 <= page_fault_reg;
        end
    end
   
assign translation_off=off_translation_from_tlb_reg| ((satp_mode == 0) | ((satp_mode == 8) & (curr_prev_reg == mmode) & ~mprv_reg) | ((satp_mode == 8) & (curr_prev_reg == mmode) & mprv_reg & (op_type_reg == 3)) | (mprv_reg & (mpp_reg == mmode)))| (op_type_reg == 0);

    assign tlb_hit        = ((tag_mem_data_out == virt_addr_reg[(PAGE_OFFSET_WIDTH+TLB_ADDR_WIDTH) +: ((3*VPN_LEN)-TLB_ADDR_WIDTH)]) & valid_out);

    assign page_fault_comb= (~translation_off & tlb_hit & (op_type_reg == 2) & ~dirty_out);
    assign PAGE_FAULT     = page_fault_reg_d1 | page_fault_comb_reg;
    assign FAULT_TYPE     = page_fault_comb ? 2: fault_type_reg;

    assign PHY_ADDR       = physical_addr_reg;
    assign tlb_addr_valid = translation_off | tlb_hit |page_fault_reg| page_fault_comb | ACCESS_FAULT;

    assign ADDR_TO_AXIM_VALID     = addr_to_axim_valid_reg;
    assign ADDR_TO_AXIM           = addr_to_axim_reg;
    assign OP_TYPE_OUT            = 3;


    function integer logb2;
        input integer depth;
        for (logb2 = 0; depth > 1; logb2 = logb2 + 1)
            depth = depth >> 1;
    endfunction

endmodule
