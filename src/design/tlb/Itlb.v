`timescale 1 ps  /  1 ps
module Itlb
    #(
        parameter   DATA_WIDTH        = 32				,
        parameter   ADDR_WIDTH        = 32                              ,
	parameter   MODE_LEN          = 1				,
	parameter   ASID_LEN          = 9				,
	parameter   PPN_LEN           = DATA_WIDTH-MODE_LEN-ASID_LEN	,
	parameter   VPN_LEN           = 10				,
	parameter   PAGE_OFFSET_WIDTH = 12				, 
	parameter   TLB_DEPTH         = 256				,
	parameter   PTESIZE           = 4				,
	parameter   virt_addr_init    = 32'h0001_0000       ,
    parameter   init_op=3             	                                
    ) (
    input                           CLK                             ,
    input 				RST				,
	input 				TLB_FLUSH			,
	/*output reg 			PAGE_FAULT_EXCEPTION		,
	output reg [ADDR_WIDTH-1 : 0]   PAGE_FAULT_ADDR			,*/
	 
	//Signals from Branch Predictor
	input  [ADDR_WIDTH-1 : 0]	VIRT_ADDR			,
	input 				VIRT_ADDR_VALID			,
	output wire [ADDR_WIDTH-1 : 0]	CURR_ADDR			,
	//Signals to I-Cache
	output  reg			PHY_ADDR_VALID			,
	output   [ADDR_WIDTH-1 : 0]	PHY_ADDR			,
	//Signals to/from AXI Master
	output  			ADDR_TO_AXIM_VALID		,
	output     [ADDR_WIDTH-1 : 0]	ADDR_TO_AXIM			,
	input  				DATA_FROM_AXIM_VALID		,
	input      [DATA_WIDTH-1 : 0]	DATA_FROM_AXIM,
	input              CACHE_READY,
    input [1:0] OP_TYPE	,
    output reg PAGE_FAULT,
    output reg ACCESS_FAULT,
    output reg [1:0] FAULT_TYPE,
    input [63:0] SATP,
    input [1:0] MPP,
    input MPRV,
    input CURR_PREV

    );
    localparam TLB_ADDR_WIDTH = logb2(TLB_DEPTH);
    localparam PTESIZE_WIDTH  = logb2(PTESIZE);
    reg [1:0] op_type_d1;
	
    /*reg  [DATA_WIDTH-1:	0]	SATP = {1'b1,9'd00,22'd1000};
    wire [MODE_LEN-1:0] satp_mode;
    wire [ASID_LEN-1:0] satp_asid;
    wire [PPN_LEN-1 :0] satp_ppn;

    assign satp_mode = SATP[DATA_WIDTH-1 -: MODE_LEN];
    assign satp_asid = SATP[PPN_LEN +: ASID_LEN];
    assign satp_ppn  = SATP[PPN_LEN-1 : 0];*/

    //pte_memory signals
    reg  pa_mem_wren;
    wire [TLB_ADDR_WIDTH-1 : 0] pa_mem_raddr;
    reg  [TLB_ADDR_WIDTH-1 : 0] pa_mem_waddr;
    reg  [PPN_LEN-1        : 0] pa_mem_data_in;
    wire [PPN_LEN-1        : 0] pa_mem_data_out;

    //tag memory signals
    reg  tag_mem_wren;
    wire [TLB_ADDR_WIDTH-1 : 0] tag_mem_raddr;
    reg  [TLB_ADDR_WIDTH-1 : 0] tag_mem_waddr;
    reg  [DATA_WIDTH-PAGE_OFFSET_WIDTH-TLB_ADDR_WIDTH-1 : 0] tag_mem_data_in;
    wire [DATA_WIDTH-PAGE_OFFSET_WIDTH-TLB_ADDR_WIDTH-1 : 0] tag_mem_data_out;

    //valid memory signals
    reg  valid_wren;
    reg  [TLB_ADDR_WIDTH-1 : 0] valid_waddr;
    wire [TLB_ADDR_WIDTH-1 : 0] valid_raddr;
    wire valid_out;

    wire tlb_addr_valid;//TLB Hit signal
    reg addr_to_axim_valid;
    reg [ADDR_WIDTH-1 : 0] addr_to_axim;
	
    reg  [ADDR_WIDTH-1 : 0] virt_addr;
    reg  flag;

    MEMORY  
    #(
        .data_width(PPN_LEN),
        .address_width(TLB_ADDR_WIDTH),
        .depth(TLB_DEPTH)
        )
    pa_memory
    (
        .CLK(CLK),
        .PORTA_WREN(pa_mem_wren)           ,
        .PORTA_RADDR(pa_mem_raddr)         ,
        .PORTA_WADDR(pa_mem_waddr)         ,
        .PORTA_DATA_IN(pa_mem_data_in)     ,
        .PORTA_DATA_OUT(pa_mem_data_out)

        );
    MEMORY  
    #(
        .data_width(DATA_WIDTH-PAGE_OFFSET_WIDTH-TLB_ADDR_WIDTH)               ,
        .address_width(TLB_ADDR_WIDTH)              ,
        .depth(TLB_DEPTH)
        )
    vaddr_tag_memory
    (
        .CLK(CLK)                             ,
        .PORTA_WREN(tag_mem_wren)             ,
        .PORTA_RADDR(tag_mem_raddr)           ,
        .PORTA_WADDR(tag_mem_waddr)           ,
        .PORTA_DATA_IN(tag_mem_data_in)       ,
        .PORTA_DATA_OUT(tag_mem_data_out)

        );
    STATE_MEMORY
    #(
        .depth(TLB_DEPTH),
        .address_width(TLB_ADDR_WIDTH)

    )
    valid_mem
    (
        .CLK(CLK)               ,
        .RST(RST)               ,
        .FLUSH(TLB_FLUSH)        ,
        .WREN(valid_wren)       ,
        .WADDR (valid_waddr)    ,
        .RADDR(valid_raddr)     ,
        .STATE(valid_out) ,
        .DATA(1'b1)  
     );

    always@(*)
    begin
        PHY_ADDR_VALID = tlb_addr_valid ;
    end

    always @(posedge CLK) begin
        if (RST) begin
            virt_addr       <=   virt_addr_init;
            op_type_d1      <=init_op;
        end
        else if (tlb_addr_valid & VIRT_ADDR_VALID &  CACHE_READY) begin
	       virt_addr <=   VIRT_ADDR; 
             op_type_d1 <=OP_TYPE;
        end    
    end

    always@(posedge CLK)
    begin
        if (RST)
        begin
            addr_to_axim_valid  <=0;
            addr_to_axim        <=0;
            flag                <=0;
            PAGE_FAULT          <=0;
            ACCESS_FAULT        <=0;
            FAULT_TYPE          <=0;

        end
        else if (~tlb_addr_valid & ~valid_wren )   //check whether cache ready and make sure flag goes 0 one cycle before data get written
        begin
            if(~addr_to_axim_valid & ~flag & (VIRT_ADDR_VALID)) 
            begin
                addr_to_axim_valid    <= 1;
                addr_to_axim          <= virt_addr; // calculate the AXI address here from SATP
                flag                  <= 1;
            end
            else
            begin
                addr_to_axim_valid    <= 0;
            end

        end

        if (RST)
        begin
            valid_wren              <= 0        ;
            tag_mem_wren            <= 0        ;
            pa_mem_wren             <= 0        ;
            pa_mem_waddr            <= 0        ;   
            pa_mem_data_in          <= 0        ;
        end
        else if (DATA_FROM_AXIM_VALID)
        begin
            pa_mem_wren    <= 1                ;
            pa_mem_data_in <= DATA_FROM_AXIM[DATA_WIDTH-1 -:PPN_LEN];
            pa_mem_waddr   <= pa_mem_raddr     ;
            tag_mem_wren   <= 1                ;
            tag_mem_waddr  <= tag_mem_raddr    ;
            valid_wren     <= 1                ; 
            valid_waddr    <= valid_raddr      ;  
            tag_mem_data_in   <= virt_addr[DATA_WIDTH-1:PAGE_OFFSET_WIDTH+TLB_ADDR_WIDTH];
            flag           <= 0           ;       
        end
        else
        begin
            pa_mem_wren      <=  0            ;
            tag_mem_wren     <=  0            ;
            valid_wren       <=  0            ;
        end
    end

    assign PHY_ADDR = {pa_mem_data_out,virt_addr[PAGE_OFFSET_WIDTH-1:0]};
    assign pa_mem_raddr = virt_addr[PAGE_OFFSET_WIDTH+:TLB_ADDR_WIDTH];
    assign tag_mem_raddr= virt_addr[PAGE_OFFSET_WIDTH+:TLB_ADDR_WIDTH];
    assign valid_raddr  = virt_addr[PAGE_OFFSET_WIDTH+:TLB_ADDR_WIDTH];
    assign CURR_ADDR = virt_addr;
    assign tlb_addr_valid =  ((tag_mem_data_out == virt_addr[DATA_WIDTH-1:PAGE_OFFSET_WIDTH+TLB_ADDR_WIDTH]) & valid_out) | (op_type_d1==2'b0);

    assign ADDR_TO_AXIM_VALID     = addr_to_axim_valid;
    assign ADDR_TO_AXIM           = addr_to_axim;

    function integer logb2;
        input integer depth;
        for (logb2 = 0; depth > 1; logb2 = logb2 + 1)
            depth = depth >> 1;
    endfunction

endmodule



