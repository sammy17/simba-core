 `timescale 1 ps  /  1 ps
module Dcache
    #(
        parameter data_width    = 64                                            ,
        parameter address_width = 64                                            ,
        parameter block_size    = 4                                             ,
        parameter cache_depth   = 256                                           ,
        localparam line_width   = $clog2(cache_depth)                           ,
        localparam offset_width = $clog2(data_width*block_size  /8)               ,
        localparam tag_width    = address_width - line_width -  offset_width    ,
        localparam cache_width  = block_size*data_width

        )
    (
        input                    CLK                             ,
        input   [1:0]			 CONTROL               			,	
        input   [data_width/8-1: 0]	 WSTRB              ,
        input                    RST                             ,
        input                    FLUSH                           ,
        input  [address_width-1:0] ADDR                              ,
        input                    ADDR_VALID                      ,
        output  [data_width-1:0]  DATA                            ,
        input      [data_width-1:0]  DATA_in                            ,
        output     reg           CACHE_READY                     ,
        output                   ADDR_TO_L2_VALID                ,
        output [address_width - offset_width-1:0]   ADDR_TO_L2                      ,
        input   [cache_width-1:0] DATA_FROM_L2                    ,
        input                   DATA_FROM_L2_VALID              ,
        output reg    [cache_width-1:0]          DATA_TO_L2,
        output reg                    DATA_TO_L2_VALID                ,
        output reg  [address_width - offset_width-1:0] WADDR_TO_L2    ,
        input                         WRITE_DONE ,
        input           [4:0]         AMO,
        input OP32,
        input PAGE_FAULT,
        input ACCESS_FAULT,
        output DCACHE_flusing,
        input [address_width-1:0] VIRT_ADDR,
		input LOAD_WORD,
		input  PERI_ACCESS,
		output reg ADDR_TO_PERI_VALID,
		output reg [address_width-1:0] ADDR_TO_PERI,
		output reg [data_width -1:0] DATA_TO_PERI,
		output reg WRITE_TO_PERI,
		input [data_width-1:0] DATA_FROM_PERI ,
		output reg  PERI_WORD_ACCESS,
		input DATA_FROM_PERI_READY,
		output reg [7:0]  WSTRB_TO_PERI

    );
    `include "PipelineParams.vh"
	wire cache_hit;
	reg cache_hit_reg;
    reg  [address_width-1:0] addr_d0             ;
    reg  [address_width-1:0] addr_d1             ;
    reg  [address_width-1:0] addr_d2             ;
    reg  [address_width-1:0] addr_d3             ;
    reg  [address_width-1:0] addr_d4             ; 
    reg  [address_width-1:0] addr_d5             ; 
	reg 					 load_word_d0	     ;
	reg 					 load_word_d1	     ;
	reg 					 load_word_d2	     ;
	reg 					 load_word_d3	     ;
	reg 					 peri_access_d1      ;
	reg 					 peri_access_d2      ;
	reg 					 peri_access_d3      ;


    reg  [address_width-1:0] vaddr_d0             ;
    reg  [address_width-1:0] vaddr_d1             ;
    reg  [address_width-1:0] vaddr_d2             ;
    reg  [address_width-1:0] vaddr_d3             ;
    reg  [address_width-1:0] vaddr_d4             ;
    reg op32_d0;
    reg op32_d1;
    reg op32_d2;
    reg op32_d3;
   reg page_fault_d2;
    reg page_fault_d3;
    reg page_fault_d4;

    reg access_fault_d2;
    reg access_fault_d3;
    reg access_fault_d4;
    wire [1:0] fault_type;

    reg  [address_width- offset_width -1:0] addr_reg             ;
    reg  [1:0]               control_d0          ;
    reg  [1:0]               control_d1          ;
    reg  [1:0]               control_d2          ;
    reg  [1:0]               control_d3          ;
    reg                      state_wdata;
    reg  [4:0]               amo_d0;
    reg  [4:0]               amo_d1;
    reg  [4:0]               amo_d2;
    reg  [4:0]               amo_d3;

    reg  [data_width/8-1:0]               wstrb_d0          ;
    reg  [data_width/8-1:0]               wstrb_d1          ;
    reg  [data_width/8-1:0]               wstrb_d2          ;
    reg  [data_width/8-1:0]               wstrb_d3          ;

    reg [data_width-1:0]  data_d0;
    reg [data_width-1:0]  data_d1;
    reg [data_width-1:0]  data_d2;
    reg [data_width-1:0]  data_d3;
    reg                   flush_d0;
    reg                   flush_d1;
    reg                   flush_d2;
    reg                   flush_d3;

    reg                     flag                ;
    reg                     addr_to_l2_valid    ;
    reg [address_width- offset_width -1:0] addr_to_l2          ;
    reg                     cache_porta_wren    ;
    reg  [line_width-1:0]   cache_porta_waddr   ;
    wire  [line_width-1:0]   cache_porta_raddr   ;
    reg   [line_width-1:0]   cache_porta_raddr_d1   ;
    reg  [cache_width-1:0]  cache_porta_data_in ;
    reg  [cache_width-1:0]  cache_porta_data_in_d1 ;
    reg  [cache_width-1:0]  cache_porta_data_in_int ;
    wire  [cache_width-1:0]  cache_porta_data_out ;
    reg  [cache_width-1:0]  cache_porta_data_out_reg ;
    reg  [cache_width-1:0]  cache_porta_data_out_i ;
    wire  [cache_width-1:0]  cache_porta_data_out_i_wire ;


    reg                     tag_porta_wren      ;
    reg  [line_width-1:0]   tag_porta_waddr     ;
    wire  [line_width-1:0]   tag_porta_raddr     ;
    reg  [tag_width-1:0]    tag_porta_data_in   ;
    reg  [tag_width-1:0]    tag_porta_data_out   ;
    wire  [tag_width-1:0]    tag_porta_data_out_wire   ;
    wire [tag_width-1:0]    tag_addr            ;

    reg  [line_width-1:0]   state_waddr         ;
    wire  [line_width-1:0]  state_rdata         ;
    wire  [line_width-1:0]  state_raddr         ;
    reg                     state_wren          ;
    reg                    state               ;
    wire                    state_wire               ;
    reg                     state_wren_d1;

    reg  [line_width-1:0]   dirty_waddr         ;
    wire  [line_width-1:0]  dirty_rdata         ;
    wire  [line_width-1:0]  dirty_raddr         ;
    reg                     dirty_wren          ;
    reg                     dirty_wren_d1          ;
    reg                     dirty               ;
    wire                     dirty_wire               ;
    reg                     dirty_din           ;
    reg                     dirty_reg           ;
    wire                    cache_ready;
    reg                     writing ;
    wire       [data_width-1:0]            data ;
    reg                   full_state;
    wire                   full_state_wire;
    reg [line_width-1:0]   flush_addr   ;
    reg                     reservation;
    reg        [address_width-1:0] reserved_address;
    reg write_reserve;
    reg clear_reserve;
    reg write_allowed;


        MEMORY  
    #(
        .data_width(cache_width ),
        .address_width(line_width),
        .depth(cache_depth)
        )
    cache_memory
    (
        .CLK(CLK),
        .PORTA_WREN(cache_porta_wren)           ,
        .PORTA_RADDR(cache_porta_raddr)         ,
        .PORTA_WADDR(cache_porta_waddr)         ,
        .PORTA_DATA_IN(cache_porta_data_in)     ,
        .PORTA_DATA_OUT(cache_porta_data_out_i_wire)

        );
    MEMORY  
    #(
        .data_width(tag_width   )               ,
        .address_width(line_width)              ,
        .depth(cache_depth)
        )
    tag_memory
    (
        .CLK(CLK)                               ,
        .PORTA_WREN(tag_porta_wren)             ,
        .PORTA_RADDR(tag_porta_raddr)           ,
        .PORTA_WADDR(tag_porta_waddr)           ,
        .PORTA_DATA_IN(tag_porta_data_in)       ,
        .PORTA_DATA_OUT(tag_porta_data_out_wire)

        );
    STATE_MEMORY
    #(
        .depth(cache_depth),
        .address_width(line_width)

    )
    state_memory_inst
    (
        .CLK(CLK)               ,
        .RST(RST)               ,
        .FLUSH(0)               ,
        .WREN(state_wren)       ,
        .WADDR (state_waddr)    ,
        .RADDR(state_raddr)     ,
        .STATE(state_wire)   ,
        .DATA(state_wdata)             ,
        .ONE_STATE(full_state_wire)
     );
     
    STATE_MEMORY
    #(
        .depth(cache_depth),
        .address_width(line_width)

    )
    dirty_memory_inst
    (
        .CLK(CLK)               ,
        .RST(RST)               ,
        .FLUSH(0)           ,
        .WREN(dirty_wren)       ,
        .WADDR (dirty_waddr)    ,
        .RADDR(dirty_raddr)     ,
        .STATE(dirty_wire)   ,
        .DATA(dirty_din)
     );
	always@(posedge CLK) begin
		if(RST) begin
			dirty <=0;
			state <= 0;
			full_state <= 0;
		end begin
			dirty <= dirty_wire;
			state <= state_wire;
			tag_porta_data_out <= tag_porta_data_out_wire;
			cache_porta_data_out_i <= cache_porta_data_out_i_wire;
			full_state <= full_state_wire;
            cache_porta_raddr_d1 <= cache_porta_raddr;
		end
	end
     
    always@(*)
    begin
        CACHE_READY = cache_ready;
    end
    always@(posedge CLK) begin
        if(RST) begin
            state_wren_d1 <= 0;
        end
        else begin
            state_wren_d1 <= state_wren;
        end
    end


  //  always@(posedge CLK) begin
  //      if(cache_ready) begin
  //         if(control_d3==2) begin
  //             $display("addr %h padr %h amo %h wdata %h, wstrb %b, DATA %h" , vaddr_d3, addr_d3, amo_d3,  data_d3,wstrb_d3,DATA,$time );
  //         end
  //         else if ( control_d3==1) begin
  //             $display("addr %h padr %h rdata %h" , vaddr_d3, addr_d3,  DATA,$time);
  //         end
  //     end
  //  end
    always @(posedge CLK) begin
    	// if(CONTROL==2) begin
    	// 	$display("%h %h",ADDR,DATA_in);
    	// end
        if (RST) begin
            addr_d0 <=0;
            addr_d1 <=   0;
            addr_d2 <=   0;
            addr_d3 <=   0;    
            addr_d4 <=   0;    

            vaddr_d0 <=0;
            vaddr_d1 <=   0;
            vaddr_d2 <=   0;
            vaddr_d3 <=   0;
            vaddr_d4 <=   0;

            control_d0 <= 0;    
            control_d1 <=0;
            control_d2 <=0;
            control_d3 <=0;
            data_d0 <=0;
            data_d1   <=0;
            data_d2  <=0;
            data_d3 <=0;

            flush_d0 <=0;
            flush_d1 <=0;
            flush_d2 <=0;
            flush_d3 <=0;

            amo_d0 <= amoidle;
            amo_d1 <= amoidle;
            amo_d2 <= amoidle;
            amo_d3 <= amoidle;
            op32_d1 <=0;
            op32_d2 <=0;
            op32_d3 <=0;
            op32_d0 <=0;
			load_word_d0 <=0;
			load_word_d1 <=0;
			load_word_d2 <=0;
			load_word_d3 <=0;
			peri_access_d1 <=0;
			peri_access_d2 <=0;
			peri_access_d3 <=0;
        end
		else if (cache_ready & ADDR_VALID) begin
            addr_d0  <= ADDR;
            addr_d1  <= ADDR;
            addr_d2  <= addr_d1 ;
            addr_d3  <= addr_d2 ;
            addr_d4 <= addr_d3;

            vaddr_d0  <= VIRT_ADDR;
            vaddr_d1  <= VIRT_ADDR;
            vaddr_d2  <= vaddr_d1 ;
            vaddr_d3  <= vaddr_d2 ;
            vaddr_d4 <=  vaddr_d3;

            control_d0 <= CONTROL;
            control_d1 <= CONTROL;
            control_d2 <= control_d1;
            control_d3 <= control_d2;

            data_d0    <= DATA_in;
            data_d1    <= DATA_in;
            data_d2    <= data_d1;
            data_d3    <= data_d2;
            
            wstrb_d0   <= WSTRB;
            wstrb_d1   <= WSTRB;
            wstrb_d2   <= wstrb_d1;
            wstrb_d3   <= wstrb_d2;

            flush_d0   <= FLUSH;
            flush_d1   <= FLUSH;
            flush_d2   <= flush_d1;
            flush_d3   <= flush_d2;

            amo_d0     <= AMO;
            amo_d1     <= AMO;
            amo_d2     <= amo_d1;
            amo_d3     <= amo_d2;

            op32_d0 <= OP32;
            op32_d1 <=OP32;
            op32_d2 <= op32_d1;
            op32_d3 <= op32_d2;

            access_fault_d2 <= ACCESS_FAULT;
            access_fault_d3 <= access_fault_d2;
            access_fault_d4 <= access_fault_d3;

            page_fault_d2 <= PAGE_FAULT;
            page_fault_d3 <= page_fault_d2;
            page_fault_d4 <= page_fault_d3;
			
			load_word_d1 <= LOAD_WORD;
			load_word_d2 <= load_word_d1;
			load_word_d3 <= load_word_d2;

			peri_access_d1 <= (CONTROL==0?0: PERI_ACCESS);
			peri_access_d2 <= peri_access_d1;
			peri_access_d3 <= peri_access_d2;

        end
    
    
    end
    
     assign   DATA    = clear_reserve?!write_allowed: (DATA_FROM_PERI_READY ? DATA_FROM_PERI : data) ;
 
     reg re32;
     reg peri_busy;
    always@(posedge CLK) 
    begin

        if (RST)
        begin
            addr_to_l2_valid  <=0;
            addr_to_l2        <=0;
            flag              <=0;
		
            
        end
        else if (~cache_ready  & ~peri_access_d3)
        begin
            if(~addr_to_l2_valid & ~flag & ~dirty_reg  & ~state_wren & ~state_wren_d1 & ~writing & ~flush_d3)
            begin
                addr_to_l2_valid    <= 1        ;
                addr_to_l2          <= addr_d3[address_width  -1 : offset_width] ;
                flag                <= 1        ;
            end
            else if (dirty_reg )
            begin
                WADDR_TO_L2         <= addr_reg;
                DATA_TO_L2_VALID  <= 1;
                DATA_TO_L2        <= cache_porta_data_out_reg;
            end
            else 
            begin
                addr_to_l2_valid    <= 0        ;
                DATA_TO_L2_VALID  <= 0;
                DATA_TO_L2_VALID  <= 0;
            end

        end
		
        if (RST) begin
            ADDR_TO_PERI_VALID <=0;
            ADDR_TO_PERI <=0;
            PERI_WORD_ACCESS <=0;
            DATA_TO_L2_VALID <=0;
            peri_busy <=0;
            WSTRB_TO_PERI <= 0;
        end
        else if (~cache_ready & peri_access_d3 & ~peri_busy ) begin
            ADDR_TO_PERI_VALID <=1;
            ADDR_TO_PERI       <= addr_d3;
            PERI_WORD_ACCESS   <= load_word_d3;
            DATA_TO_PERI       <= data_d3;
            WRITE_TO_PERI      <= (control_d3 ==2'b10);
            WSTRB_TO_PERI      <= wstrb_d3;
            peri_busy          <=1;
        end
        else if(DATA_FROM_PERI_READY) begin
            peri_busy <=0;
            WRITE_TO_PERI      <=0;
            ADDR_TO_PERI_VALID <=0;
        end
        else begin
            WRITE_TO_PERI      <=0;
            ADDR_TO_PERI_VALID <=0;
        end

        if(RST)
        begin
            writing <= 0;
        end
        else if (dirty_reg)
        begin
            writing <= 1;
        end
        else if (WRITE_DONE)
        begin
            writing <= 0;
        end
  		     
        if (RST)
        begin

            dirty_reg               <= 0        ;
            dirty_wren              <= 0        ;
            dirty_waddr             <= 0        ;
            state_wren              <= 0        ;
            tag_porta_wren          <= 0        ;
            cache_porta_wren        <= 0        ;
            cache_porta_waddr       <= 0        ;   
            cache_porta_data_in     <= 0        ;
            flush_addr              <= -1       ;
        end
        else if (cache_ready & control_d3 == 2'b10 &ADDR_VALID & ~peri_access_d3 & !access_fault_d4 & !page_fault_d4)
        begin
            cache_porta_wren     <= 1;
            cache_porta_data_in  <=  cache_porta_data_in_int;
            cache_porta_waddr    <= cache_porta_raddr_d1;
            dirty_wren           <= 1;
            dirty_waddr          <= cache_porta_raddr_d1;
            dirty_din            <= 1;
        end
        else if (DATA_FROM_L2_VALID)
        begin
            begin
                cache_porta_wren    <= 1                ;
                cache_porta_data_in <= control_d3 == 2'b10 ? cache_porta_data_in_int  : DATA_FROM_L2     ;
                cache_porta_waddr   <= cache_porta_raddr;
                tag_porta_wren      <= 1                ;
                tag_porta_waddr     <= tag_porta_raddr  ;
                state_wren          <= 1                ; 
                state_waddr         <= state_raddr      ;  
                tag_porta_data_in   <= tag_addr         ;
                flag                <= 0                ; 
                dirty_reg           <= dirty            ;
                dirty_wren          <= 1    ;
                cache_porta_data_out_reg <= cache_porta_data_out_i;
                dirty_din          <=   control_d3 == 2'b10 ;
                dirty_waddr        <= dirty_raddr;
                addr_reg            <= {tag_porta_data_out,addr_d3[address_width-tag_width-1 : offset_width]};
                state_wdata        <=1;
            end      

        end
        else if ((flush_d3 & full_state_wire & ~dirty_reg & ~writing))
        begin
                flush_addr          <=   flush_addr +1;
                cache_porta_wren    <= 0                ;
                state_wren          <= 1                ; 
                state_waddr         <= state_raddr      ;  
                flag                <= 0                ; 
                dirty_reg           <= dirty_wire            ;
                dirty_wren          <= 1    ;
                cache_porta_data_out_reg <= cache_porta_data_out_i_wire;
                dirty_din          <=   0 ;
                dirty_waddr        <= dirty_raddr;
                addr_reg            <=  {tag_porta_data_out_wire,flush_addr} ;
                state_wdata        <=0; 
                tag_porta_wren     <=1;                                                           
        end

        else
        begin
            cache_porta_wren   <=  0            ;
            tag_porta_wren     <=  0            ;
            state_wren         <=  0            ;
            dirty_wren         <=  0            ;
            dirty_din          <=  0            ;
            dirty_reg          <=  0            ;
        if (~dirty_reg & ~writing)
            flush_addr         <=  -1           ;
        end
        if (RST) begin
	       reservation<=0;
           re32 <=0; reserved_address <=0;
        end

        else if(write_reserve & (control_d3 ==2'b10))
        begin
            reserved_address <= vaddr_d3;
            reservation     <=1;
            re32 <=op32_d3;
        end
        else if(clear_reserve & (control_d3 ==2'b10))
        begin
            reservation<=0;
            re32 <=0;
        end
    end

    



    reg [data_width-1:0] data_to_be_writen;
    integer i;
    wire [31:0] add_up= data_d3[63:32] + data[63:32];
    wire [31:0] add_dwn= data_d3[31:0] + data[31:0];
    wire [31:0] max_up = $signed(data_d3[63:32]) > $signed(data[63:32]) ? data_d3[63:32] : data[63:32];
    wire [31:0] max_dwn = $signed(data_d3[31:0]) > $signed(data[31:0]) ? data_d3[31:0] : data[31:0];   

    wire [31:0] min_up = $signed(data_d3[63:32]) > $signed(data[63:32]) ? data[63:32] : data_d3[63:32];
    wire [31:0] min_dwn = $signed(data_d3[31:0]) > $signed(data[31:0]) ? data[31:0] : data_d3[31:0];
    
    wire [31:0] maxu_up = (data_d3[63:32]) > (data[63:32]) ? data_d3[63:32] : data[63:32];
    wire [31:0] maxu_dwn = (data_d3[31:0]) > (data[31:0]) ? data_d3[31:0] : data[31:0];

    wire [31:0] minu_up = (data_d3[63:32]) > (data[63:32]) ? data[63:32] : data_d3[63:32];
    wire [31:0] minu_dwn = (data_d3[31:0]) > (data[31:0]) ? data[31:0] : data_d3[31:0];
    
   always@(*)  
   begin
      write_reserve=0;
      clear_reserve=0;
      write_allowed=1;
      if(cache_ready)
      begin
       case(amo_d3)
           amolr:
           begin
                data_to_be_writen= data ;
                write_reserve=1;
           end
           amosc:
           begin
                if ((reservation & (vaddr_d3==reserved_address)) & (re32==op32_d3)) begin
                    if(op32_d3) begin
                        if(addr_d3[2]) begin
                            data_to_be_writen= {data_d3[63:32],data[31:0]};
                        end
                        else begin
                            data_to_be_writen = {data[63:32],data_d3[31:0]};
                        end
                    end
                    else begin
                        data_to_be_writen = data_d3;
                    end
                end
                else begin
                    data_to_be_writen = data;
                end
                // =  (reservation & (addr_d3==reserved_address))? data_d3: data;
                write_allowed  = (reservation & (vaddr_d3==reserved_address)) & (re32==op32_d3);
                clear_reserve    = 1;
                    
           end
           amoidle:
           begin
               for (i=0;i<data_width/8;i=i+1)
               begin
                   if(wstrb_d3[i])
                   begin
                       data_to_be_writen[i*8 +: 8] = data_d3[i*8 +: 8];
                   end
                   else begin
                       data_to_be_writen[i*8 +: 8] = data[i*8 +: 8];
                   end
               end
            end
            amoswap:
            begin
                if(op32_d3) begin
                    if(addr_d3[2]) begin
                        data_to_be_writen= {data_d3[63:32],data[31:0]} ;
                    end
                    else begin
                        data_to_be_writen= {data[63:32],data_d3[31:0]} ;
                    end
                end
                else begin
                    data_to_be_writen= data_d3 ;
                end
            end
            amoxor:
            begin
                if(op32_d3) begin
                    if(addr_d3[2]) begin
                        data_to_be_writen= {data_d3[63:32]^data[63:32],data[31:0]} ;
                    end
                    else begin
                        data_to_be_writen= {data[63:32],data_d3[31:0]^data[31:0]} ;
                    end
                end
                else begin
                    data_to_be_writen= data_d3 ^ data ;
                end
            end
            amoor:
            begin
                if(op32_d3) begin
                    if(addr_d3[2]) begin
                        data_to_be_writen= {data_d3[63:32]|data[63:32],data[31:0]} ;
                    end
                    else begin
                        data_to_be_writen= {data[63:32],data_d3[31:0]|data[31:0]} ;
                    end
                end
                else begin
                    data_to_be_writen= data_d3 | data ;
                end
            end
            amoadd:
            begin
                if(op32_d3) begin
                    if(addr_d3[2]) begin
                        data_to_be_writen= {add_up,data[31:0]} ;
                    end
                    else begin
                        data_to_be_writen= {data[63:32],add_dwn} ;
                    end
                end
                else begin
                    data_to_be_writen= data_d3 + data ;
                end
            end
            amoand:
            begin
                if(op32_d3) begin
                    if(addr_d3[2]) begin
                        data_to_be_writen= {data_d3[63:32]&data[63:32],data[31:0]} ;
                    end
                    else begin
                        data_to_be_writen= {data[63:32],data_d3[31:0]&data[31:0]} ;
                    end
                end
                else begin
                    data_to_be_writen= data_d3 & data ;
                end
            end
            amomin:
            begin
                if(op32_d3) begin
                    if(addr_d3[2]) begin
                        data_to_be_writen= {min_up,data[31:0]} ;
                    end
                    else begin
                        data_to_be_writen= {data[63:32],min_dwn} ;
                    end
                end
                else begin
                    data_to_be_writen= $signed(data_d3) > $signed(data) ? data : data_d3 ;
                end
            end
            amomax:
            begin
                if(op32_d3) begin
                    if(addr_d3[2]) begin
                        data_to_be_writen= {max_up,data[31:0]} ;
                    end
                    else begin
                        data_to_be_writen= {data[63:32],max_dwn} ;
                    end
                end
                else begin
                    data_to_be_writen= $signed(data_d3) > $signed(data) ? data_d3 : data ;
                end
            end
            
            amomaxu:
            begin
                if(op32_d3) begin
                    if(addr_d3[2]) begin
                        data_to_be_writen= {maxu_up,data[31:0]} ;
                    end
                    else begin
                        data_to_be_writen= {data[63:32],maxu_dwn} ;
                    end
                end
                else begin
                    data_to_be_writen= (data_d3) > (data) ? data_d3 : data ;
                
                end
            end
            amominu:
            begin
                if(op32_d3) begin
                    if(addr_d3[2]) begin
                        data_to_be_writen= {minu_up,data[31:0]} ;
                    end
                    else begin
                        data_to_be_writen= {data[63:32],minu_dwn} ;
                    end
                end
                else begin
                    data_to_be_writen= (data_d3) > (data) ? data : data_d3 ;
                    
                end
            end
            default:
                data_to_be_writen = data;


        endcase
       end
       else
       begin
            data_to_be_writen = data;
       end
       for (i = 0; i<cache_width ;i=i+data_width)
       begin
           if (i== {addr_d3[offset_width-1:3],3'b0}*8 )
           begin
            cache_porta_data_in_int[i +:data_width]                = data_to_be_writen;
           end
           else
           begin
            cache_porta_data_in_int[i +:data_width]                 =  cache_porta_data_out[i +:data_width]       ;
           end      
      end

   end
    generate
    if (offset_width>2)
        assign data                 = cache_porta_data_out[{addr_d3[offset_width-1:3],3'b0}*8 +:data_width];
    else begin
        assign data                 = cache_porta_data_out                                                        ;
    end
    endgenerate
	always@(posedge CLK) begin
		if(RST) begin
			cache_hit_reg <= 1;
		end
		else begin
			cache_hit_reg <= cache_hit;
		end
	end
    always@(posedge CLK) begin
        if(RST) begin
            dirty_wren_d1<= 0;    
        end
        else begin
            dirty_wren_d1 <= dirty_wren;
            cache_porta_data_in_d1 <= cache_porta_data_in;
            addr_d5 <= addr_d4;
        end
    end
	wire [offset_width+line_width-1:offset_width] read_addr_mux_out = cache_ready?addr_d2[offset_width+line_width-1:offset_width]: addr_d3[offset_width+line_width-1:offset_width];
		
    assign cache_porta_data_out = DATA_FROM_L2_VALID ? DATA_FROM_L2 :  (((dirty_wren & addr_d3[offset_width+line_width-1:offset_width]==addr_d4[offset_width+line_width-1:offset_width]))? cache_porta_data_in:((dirty_wren_d1 & addr_d3[offset_width+line_width-1:offset_width]==addr_d5[offset_width+line_width-1:offset_width])? cache_porta_data_in_d1: cache_porta_data_out_i));

    assign cache_porta_raddr    = ~flush_d3? read_addr_mux_out: flush_addr           ;
    assign dirty_raddr          = cache_porta_raddr                                         ;
    assign tag_porta_raddr      = cache_porta_raddr                                         ;
    assign state_raddr          = cache_porta_raddr                                         ;
    assign tag_addr             = cache_ready?addr_d2[address_width-1:offset_width+line_width]:addr_d3[address_width-1:offset_width+line_width]          ;
	assign cache_hit 			= (tag_porta_data_out_wire == tag_addr) & state_wire;
    assign cache_ready          =  ((((( cache_hit_reg & ~writing )|DATA_FROM_PERI_READY) | (control_d3!==2'b01 & control_d3!==2'b10)|access_fault_d4|page_fault_d4 )) & (~flush_d3| ~full_state)  & ~writing ) ;
    assign ADDR_TO_L2_VALID     = addr_to_l2_valid                                          ;
    assign ADDR_TO_L2           = addr_to_l2                                                ;
    
    assign DCACHE_flusing= flush_d0|flush_d1|FLUSH|flush_d3|flush_d2;

endmodule





