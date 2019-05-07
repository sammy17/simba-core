module peripheral_master(
(* mark_debug = "true" *)	input		ADDR_TO_PERI_VALID,
(* mark_debug = "true" *)	input [63:0] ADDR_TO_PERI,
	input [63:0] 	DATA_TO_PERI,
	input PERI_WORD_ACCESS,
	output reg DATA_FROM_PERI_READY,
	output reg [63:0]  DATA_FROM_PERI,
	input  			WRITE_TO_PERI,
	input M_AXI_ACLK           ,
	input M_AXI_ARESETN,
	output reg [31:0] M_AXI_AWADDR             ,
	output reg      M_AXI_AWPROT               ,
	output reg   	M_AXI_AWVALID              ,
	input 			M_AXI_AWREADY              ,
	output reg  [31:0] 	M_AXI_WDATA               ,    
	output reg [4:0]     M_AXI_WSTRB                ,
	output reg 			M_AXI_WVALID            ,
	input M_AXI_WREADY                    		,
	input [1:0]      M_AXI_BRESP                ,
	input M_AXI_BVALID                    		,
	output reg M_AXI_BREADY                     ,
	output reg [31:0] M_AXI_ARADDR              ,
	output reg   M_AXI_ARPROT                    ,
	output reg  M_AXI_ARVALID                   ,
	input 	    M_AXI_ARREADY                   ,
	input  [1:0]  M_AXI_RRESP                   ,  
	input M_AXI_RVALID                    		,
	output reg M_AXI_RREADY                    ,
	input [7:0]   WSTRB               ,
	input [31:0] M_AXI_RDATA 		,
	output INTERUPT			
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

reg word_access;
(* mark_debug = "true" *) reg [2:0]  master_state;
(* mark_debug = "true" *) reg [63:0] mtime_reg;
(* mark_debug = "true" *) reg [63:0] mtime_comp_reg;
assign INTERUPT = mtime_reg > mtime_comp_reg;
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
		master_state <=idle;
	end
	else begin
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
							M_AXI_AWADDR <= (ADDR_TO_PERI == 32'he0001030) ? ADDR_TO_PERI: 32'h2800_0000;
							M_AXI_WVALID <= 1;
							M_AXI_WDATA <= ADDR_TO_PERI[2]?  DATA_TO_PERI[63: 32] : DATA_TO_PERI[31: 0] ;
							M_AXI_WSTRB <=  ADDR_TO_PERI[2]? WSTRB[7:4] : WSTRB[3:0] ;

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
						M_AXI_AWADDR <=  (ADDR_TO_PERI == 32'he0001030) ? ADDR_TO_PERI: 32'h2800_0000;
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
		endcase
	end // else if
	end // always
endmodule
