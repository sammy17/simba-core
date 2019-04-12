`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:        Ashen Ekanayake
// 
// Create Date:     22/10/2018 09:13:31 AM
// Design Name: 
// Module Name:     iTLB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module iTLB_asha #(
        parameter   DATA_WIDTH        = 32				,
        parameter   ADDR_WIDTH        = 32                              ,
	parameter   MODE_LEN          = 1				,
	parameter   ASID_LEN          = 9				,
	parameter   PPN_LEN           = DATA_WIDTH-MODE_LEN-ASID_LEN	,
	parameter   VPN_LEN           = 10				,
	parameter   PAGE_OFFSET_WIDTH = 12				, 
	parameter   TLB_DEPTH         = 256				,
	parameter   PTESIZE           = 4	                                
    ) (
        input                           CLK                             ,
        input 				RST				,
	input 				TLB_FLUSH			,
	output reg 			PAGE_FAULT_EXCEPTION		,
	output reg [ADDR_WIDTH-1 : 0]   PAGE_FAULT_ADDR			,	 
	//Signals from Branch Predictor
	input  [ADDR_WIDTH-1 : 0]	VIRT_ADDR			,
	input 				VIRT_ADDR_VALID			,
	//Signals to I-Cache
	output reg 			PHY_ADDR_VALID			,
	output reg [ADDR_WIDTH-1 : 0]	PHY_ADDR			,
	//Signals to/from AXI Master
	output reg 			ADDR_TO_AXIM_VALID		,
	output reg [ADDR_WIDTH-1 : 0]	ADDR_TO_AXIM			,
	input  				DATA_FROM_AXIM_VALID		,
	input      [DATA_WIDTH-1 : 0]	DATA_FROM_AXIM				
			
    );
    localparam TLB_ADDR_WIDTH = logb2(TLB_DEPTH);
    localparam PTESIZE_WIDTH  = logb2(PTESIZE);
	
    reg  [DATA_WIDTH-1:	0]	SATP = {1'b1,9'd00,22'd1000};
    wire [MODE_LEN-1:0] satp_mode;
    wire [ASID_LEN-1:0] satp_asid;
    wire [PPN_LEN-1 :0] satp_ppn;

    assign satp_mode = SATP[DATA_WIDTH-1 -: MODE_LEN];
    assign satp_asid = SATP[PPN_LEN +: ASID_LEN];
    assign satp_ppn  = SATP[PPN_LEN-1 : 0];

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

    assign pa_mem_raddr = VIRT_ADDR[PAGE_OFFSET_WIDTH+:TLB_ADDR_WIDTH];
    assign tag_mem_raddr= VIRT_ADDR[PAGE_OFFSET_WIDTH+:TLB_ADDR_WIDTH];
    assign valid_raddr  = VIRT_ADDR[PAGE_OFFSET_WIDTH+:TLB_ADDR_WIDTH];
 
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
        .CLK(CLK)                               ,
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

    reg [1:0] state = 0;
    reg [ADDR_WIDTH-1 : 0] temp_virt_addr = 0;
	
    always@(posedge CLK)begin
	if(RST)begin
	    PHY_ADDR       <= 0;
	    PHY_ADDR_VALID <= 0;
            ADDR_TO_AXIM_VALID <= 0;
            ADDR_TO_AXIM   <= 0;
	    state <= 0;
	    PAGE_FAULT_EXCEPTION <= 0;
	    PAGE_FAULT_ADDR <= 0;
	    temp_virt_addr <= 0;
       	    pa_mem_wren <= 0;
	    tag_mem_wren <= 0;
	    valid_wren <= 0;		
	end
	else if (VIRT_ADDR_VALID | state!= 0)begin
	if(!satp_mode)begin
	    PHY_ADDR <= VIRT_ADDR;
	    PHY_ADDR_VALID <= 1;
	    ADDR_TO_AXIM_VALID <= 0;
	    state <= 0;
	    PAGE_FAULT_EXCEPTION <= 0;
       	    pa_mem_wren <= 0;
	    tag_mem_wren <= 0;
	    valid_wren <= 0;	  
	end
	else begin
	    if((tag_mem_data_out== VIRT_ADDR[DATA_WIDTH-1:PAGE_OFFSET_WIDTH+TLB_ADDR_WIDTH]) & valid_out )begin //TLB Hit
		PHY_ADDR <= {pa_mem_data_out,VIRT_ADDR[PAGE_OFFSET_WIDTH-1:0]};
	        PHY_ADDR_VALID <= 1;
	        state <= 0;
		PAGE_FAULT_EXCEPTION <= 0;
		pa_mem_wren <= 0;
		tag_mem_wren <= 0;
		valid_wren <= 0;
	    end
	    else begin
		case(state)
			0:begin
				PHY_ADDR_VALID <= 0;
				state <= 1;
				ADDR_TO_AXIM_VALID <= 1;        // calculation in the standard
            			ADDR_TO_AXIM   <= (satp_ppn << PAGE_OFFSET_WIDTH) + (VIRT_ADDR[DATA_WIDTH-1 -: VPN_LEN] << PTESIZE_WIDTH);
				PAGE_FAULT_EXCEPTION <= 0;
				temp_virt_addr <=  VIRT_ADDR;
				pa_mem_wren <= 0;
				tag_mem_wren <= 0;
				valid_wren <= 0;
			end
			1:begin
				if(DATA_FROM_AXIM_VALID)begin
					if((DATA_FROM_AXIM[0]==0) | (DATA_FROM_AXIM[1]==0 & DATA_FROM_AXIM[2]==1)) begin // V bit and R W bits check
						PAGE_FAULT_EXCEPTION <= 1; // Page Fault
						PAGE_FAULT_ADDR <= temp_virt_addr;
						state <=0;
					end
					else if (DATA_FROM_AXIM[1]==1 | DATA_FROM_AXIM[3]==1) state <= 0;//Super Page Found
					else begin // Pointer to next PTE
						state <= 2;
						ADDR_TO_AXIM_VALID <= 1;        // calculation in the standard
            					ADDR_TO_AXIM   <= (DATA_FROM_AXIM[DATA_WIDTH-1 -:PPN_LEN] << PAGE_OFFSET_WIDTH) + (temp_virt_addr[PAGE_OFFSET_WIDTH +: VPN_LEN] << PTESIZE_WIDTH);					
					end
				end
				else begin
				   ADDR_TO_AXIM_VALID <= 0;
				end
			end
			2:begin
				if(DATA_FROM_AXIM_VALID)begin
					if((DATA_FROM_AXIM[0]==0) | (DATA_FROM_AXIM[1]==0 & DATA_FROM_AXIM[2]==1)) begin // V bit and R W bits check
						PAGE_FAULT_EXCEPTION <= 1; // Page Fault
						PAGE_FAULT_ADDR <= temp_virt_addr;
						state <=0;
					end
					else if (DATA_FROM_AXIM[1]==1 | DATA_FROM_AXIM[3]==1) begin
						if(DATA_FROM_AXIM[6]==0)begin // A bit check
							state <= 0;
							PAGE_FAULT_EXCEPTION <= 1; //Page Fault
							PAGE_FAULT_ADDR <= temp_virt_addr;	
						end
						else begin
							state <= 0;
							PHY_ADDR <= {DATA_FROM_AXIM[DATA_WIDTH-1 -:PPN_LEN],temp_virt_addr[PAGE_OFFSET_WIDTH-1:0]};
	        					PHY_ADDR_VALID <= 1;

							pa_mem_wren <= 1;
							tag_mem_wren <= 1;
							valid_wren <= 1;

							pa_mem_waddr <= temp_virt_addr[PAGE_OFFSET_WIDTH +: TLB_ADDR_WIDTH];
							tag_mem_waddr <= temp_virt_addr[PAGE_OFFSET_WIDTH +: TLB_ADDR_WIDTH];
							valid_waddr <= temp_virt_addr[PAGE_OFFSET_WIDTH +: TLB_ADDR_WIDTH];

							pa_mem_data_in <= DATA_FROM_AXIM[DATA_WIDTH-1 -:PPN_LEN];
							tag_mem_data_in <= temp_virt_addr[DATA_WIDTH-1 : PAGE_OFFSET_WIDTH+TLB_ADDR_WIDTH];				
						end
					end
					else begin
						state <= 0;
						PAGE_FAULT_EXCEPTION <= 1; //Page Fault
						PAGE_FAULT_ADDR <= temp_virt_addr;						
					end
				end
				else begin
				   ADDR_TO_AXIM_VALID <= 0;
				end
			end

		endcase
	    end
	end
	end
	else begin
	    PHY_ADDR       <= 0;
	    PHY_ADDR_VALID <= 0;
            ADDR_TO_AXIM_VALID <= 0;
            ADDR_TO_AXIM   <= 0;
	    state <= 0;
	    PAGE_FAULT_EXCEPTION <= 0;
	    PAGE_FAULT_ADDR <= 0;
	    pa_mem_wren <= 0;
	    tag_mem_wren <= 0;
	    valid_wren <= 0;
	end

    end

    function integer logb2;
        input integer depth;
        for (logb2 = 0; depth > 1; logb2 = logb2 + 1)
            depth = depth >> 1;
    endfunction
endmodule
