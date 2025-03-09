module peripheral_master#(
		parameter  C_M_TARGET_SLAVE_BASE_ADDR	= 32'h00010000,
		parameter integer C_M_AXI_BURST_LEN	= 8,
		parameter integer C_M_AXI_ID_WIDTH	= 1,
		parameter integer C_M_AXI_ADDR_WIDTH	= 32,
		parameter integer C_M_AXI_DATA_WIDTH	= 32,
		parameter integer C_M_AXI_AWUSER_WIDTH	= 0,
		parameter integer C_M_AXI_ARUSER_WIDTH	= 0,
		parameter integer C_M_AXI_WUSER_WIDTH	= 0,
		parameter integer C_M_AXI_RUSER_WIDTH	= 0,
		parameter integer C_M_AXI_BUSER_WIDTH	= 0
	)(

	(* mark_debug = "true" *)	input		ADDR_TO_PERI_VALID,
(* mark_debug = "true" *)	input [63:0] ADDR_TO_PERI,
	input [63:0] 	DATA_TO_PERI,
	input PERI_WORD_ACCESS,
	output reg DATA_FROM_PERI_READY,
	output reg [63:0]  DATA_FROM_PERI,
	input  			WRITE_TO_PERI,
		input wire  INIT_AXI_TXN,
		output wire  TXN_DONE,
		output reg  ERROR,
		input wire  M_AXI_ACLK,
		input wire  M_AXI_ARESETN,
		output reg [C_M_AXI_ADDR_WIDTH-1 : 0] M_AXI_AWADDR,
		output reg [7 : 0] M_AXI_AWLEN=1,
		output reg [2 : 0] M_AXI_AWSIZE,
		output reg [2 : 0] M_AXI_AWPROT=0,
		output reg  M_AXI_AWVALID,
		input  wire  M_AXI_AWREADY,
		output reg [C_M_AXI_DATA_WIDTH-1 : 0] M_AXI_WDATA,
		output reg [C_M_AXI_DATA_WIDTH/8-1 : 0] M_AXI_WSTRB,
		output reg  M_AXI_WLAST,
		output reg  M_AXI_WVALID,
		input wire  M_AXI_WREADY,
		input wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_BID,
		input wire [1 : 0] M_AXI_BRESP,
		input wire  M_AXI_BVALID,
		output reg  M_AXI_BREADY,
		output reg [C_M_AXI_ADDR_WIDTH-1 : 0] M_AXI_ARADDR,
		output reg [2 : 0] M_AXI_ARPROT=0,
		output reg  M_AXI_ARVALID,
		input wire  M_AXI_ARREADY,
		input wire [0: 0] M_AXI_RID,
		input wire [C_M_AXI_DATA_WIDTH-1 : 0] M_AXI_RDATA,
		input wire [1 : 0] M_AXI_RRESP,
		input wire  M_AXI_RLAST,
		input wire [0 : 0] M_AXI_RUSER,
		input wire  M_AXI_RVALID,
		output reg  M_AXI_RREADY,
		output reg INTERUPT,
		input [7:0]   WSTRB               
);
`define CLINT_ADDR 32'h2000000
`define MTIME_ADDR 32'hbff8
`define MTIMECMP_ADDR 32'h4000
localparam integer idle=0;
localparam integer load_word_low =1;
localparam integer load_word_high=2;
localparam integer write_word_low=3;
localparam integer write_word_high=4;
localparam integer mtime_read=5;
localparam integer mcomp_write=6;
localparam integer junk_rw=7;

reg word_access;
(* mark_debug = "true" *) reg [2:0]  master_state;
(* mark_debug = "true" *) reg [63:0] mtime_reg;
(* mark_debug = "true" *) reg [63:0] mtime_comp_reg;

always@(posedge M_AXI_ACLK) begin
	if(~M_AXI_ARESETN) begin
		mtime_reg <=0;
		mtime_comp_reg <= -1;
		DATA_FROM_PERI_READY <=0;
		DATA_FROM_PERI <=0;
		M_AXI_AWADDR <=0;
		M_AXI_AWPROT <=0;
		M_AXI_AWVALID <=0;
		M_AXI_BREADY <=0;
		M_AXI_ARADDR <=0;
		M_AXI_ARPROT <=0;
		M_AXI_ARVALID <=0;
		M_AXI_WVALID <=0;
		M_AXI_WSTRB <=0; 
		M_AXI_WDATA <=0;
		M_AXI_RREADY <=0;
        M_AXI_AWSIZE <=0;
        M_AXI_WLAST <=0;
		master_state <=idle;
        INTERUPT <= 0;
	end
	else begin
        INTERUPT <= mtime_reg > mtime_comp_reg;
		mtime_reg <= mtime_reg+1;
		case(master_state)
			idle: begin
				DATA_FROM_PERI <=0;
				DATA_FROM_PERI_READY <=0;
				if(ADDR_TO_PERI_VALID) begin
					if((ADDR_TO_PERI==(`CLINT_ADDR+`MTIME_ADDR)) & ~WRITE_TO_PERI) begin
						master_state <= mtime_read;
					end
					else if((ADDR_TO_PERI==(`CLINT_ADDR+`MTIMECMP_ADDR)) & WRITE_TO_PERI) begin
						master_state <= mcomp_write;
					end
					else if(ADDR_TO_PERI==`CLINT_ADDR) begin
						master_state <= junk_rw;
					end
					else begin
						word_access <= PERI_WORD_ACCESS;
					 	if(~WRITE_TO_PERI) begin
							master_state <= (load_word_low + ADDR_TO_PERI[2]);
							M_AXI_ARVALID <=1;
							M_AXI_ARADDR  <= ADDR_TO_PERI;

						end
						else begin
							master_state <= (write_word_low + ADDR_TO_PERI[2]);
							M_AXI_AWVALID <=1;
							M_AXI_WVALID <= 1;
							M_AXI_WDATA <= ADDR_TO_PERI[2]?  DATA_TO_PERI[63: 32] : DATA_TO_PERI[31: 0] ;
							M_AXI_WSTRB <=  ADDR_TO_PERI[2]? WSTRB[7:4] : WSTRB[3:0] ;
							case(ADDR_TO_PERI[2]? WSTRB[7:4] : WSTRB[3:0] )
								4'b1111: begin
									M_AXI_AWADDR<=ADDR_TO_PERI;
									M_AXI_AWSIZE <= 2; 
								end	
								4'b0001: begin
									M_AXI_AWADDR<=ADDR_TO_PERI;
									M_AXI_AWSIZE <= 0; 
								end	
								4'b0010: begin
									M_AXI_AWADDR<=ADDR_TO_PERI+1;
									M_AXI_AWSIZE <= 0; 
								end	
								4'b0100: begin
									M_AXI_AWADDR<=ADDR_TO_PERI+2;
									M_AXI_AWSIZE <= 0; 
								end	
								4'b1000: begin
									M_AXI_AWADDR<=ADDR_TO_PERI+3;
									M_AXI_AWSIZE <= 0; 
								end	
								4'b0011: begin
									M_AXI_AWADDR<=ADDR_TO_PERI;
									M_AXI_AWSIZE <= 1; 
								end	
								4'b1100: begin
									M_AXI_AWADDR<=ADDR_TO_PERI+2;
									M_AXI_AWSIZE <= 1; 
								end	
							endcase

							M_AXI_WLAST <= 1;

						end
					end
				end
			end
			load_word_low: begin
				if(M_AXI_ARREADY & M_AXI_ARVALID) begin
					M_AXI_ARVALID <=0;
				end
				if(M_AXI_RVALID & ~M_AXI_RREADY) begin
					M_AXI_RREADY <=1;
					DATA_FROM_PERI[31:0] <= M_AXI_RDATA;
				end
				else if(M_AXI_RREADY) begin
					M_AXI_RREADY <=0;
					if(word_access) begin
						master_state <= idle;
						DATA_FROM_PERI_READY <=1;
					end
					else begin
						master_state <= load_word_high;
						M_AXI_ARVALID <=1;
						M_AXI_ARADDR  <= ADDR_TO_PERI| 32'b100;
					end
				end
			end
			load_word_high: begin
				if(M_AXI_ARREADY & M_AXI_ARVALID) begin
                     M_AXI_ARVALID <=0;
                 end
                 if(M_AXI_RVALID & ~M_AXI_RREADY) begin
                     M_AXI_RREADY <=1;
                     DATA_FROM_PERI[63:32] <= M_AXI_RDATA;
                 end
                 else if(M_AXI_RREADY) begin
                     M_AXI_RREADY <=0;
					 master_state <= idle;
					 DATA_FROM_PERI_READY <=1;
               	 end			
			end
			write_word_low: begin
				if(M_AXI_AWREADY & M_AXI_AWVALID) begin
					M_AXI_AWVALID <=0;
				end
				if(M_AXI_WVALID & M_AXI_WREADY) begin
					M_AXI_WVALID <=0;
					M_AXI_WLAST <=0;
				end
				if(M_AXI_BVALID  & ~M_AXI_BREADY) begin
					M_AXI_BREADY <=1;
				end
				else if (M_AXI_BREADY) begin
					M_AXI_BREADY <= 0;
					if(word_access) begin
						master_state <=idle;
						DATA_FROM_PERI_READY <= 1;
					end
					else begin
						master_state <= write_word_high;
						M_AXI_AWVALID <=1;
						M_AXI_AWADDR <=   ADDR_TO_PERI|32'b100; 
						M_AXI_WVALID <= 1;
						M_AXI_WDATA <= DATA_TO_PERI[63: 32];
						M_AXI_WSTRB <=  WSTRB[7:4];
					end
				end//BREADY
			end//case write low
			write_word_high: begin
				if(M_AXI_AWREADY & M_AXI_AWVALID) begin
					M_AXI_AWVALID <=0;
				end
				if(M_AXI_WVALID & M_AXI_WREADY) begin
					M_AXI_WVALID <=0;
					M_AXI_WLAST <=0;
				end
				if(M_AXI_BVALID  & ~M_AXI_BREADY) begin
					M_AXI_BREADY <=1;
				end
				else if (M_AXI_BREADY) begin
					M_AXI_BREADY <= 0;
					master_state <=idle;
					DATA_FROM_PERI_READY <= 1;
				end//BREADY
			end//case write low	
			mtime_read: begin
				DATA_FROM_PERI <= mtime_reg>>3;
				DATA_FROM_PERI_READY <= 1;
				master_state <= idle;
			end
			mcomp_write: begin
				DATA_FROM_PERI_READY <=1;
				mtime_comp_reg <= DATA_TO_PERI<<3;
				master_state <= idle;
			end
			junk_rw: begin
				DATA_FROM_PERI <= 0;
				DATA_FROM_PERI_READY <= 1;
				master_state <= idle;
			end
		endcase
	end // else if
	end // always
endmodule
