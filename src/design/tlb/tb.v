module tb;

logic CLK,RST,TLB_FLUSH,VIRT_ADDR_VALID,DATA_FROM_AXIM_VALID;
logic [31:0] VIRT_ADDR,DATA_FROM_AXIM;
wire [31:0] CURR_ADDR,PHY_ADDR,ADDR_TO_AXIM;
wire PHY_ADDR_VALID,ADDR_TO_AXIM_VALID;

 Itlb
    #(.virt_addr_init(32'h0000_0000) )                   	                                
    dut (
        .CLK(CLK),
        .RST(RST),
	.TLB_FLUSH(TLB_FLUSH),
	.VIRT_ADDR(VIRT_ADDR),
	.VIRT_ADDR_VALID(VIRT_ADDR_VALID),
	.CURR_ADDR(CURR_ADDR),
	.PHY_ADDR_VALID(PHY_ADDR_VALID),
	.PHY_ADDR(PHY_ADDR),
	.ADDR_TO_AXIM_VALID(ADDR_TO_AXIM_VALID),
	.ADDR_TO_AXIM(ADDR_TO_AXIM),
	.DATA_FROM_AXIM_VALID(DATA_FROM_AXIM_VALID),
	.DATA_FROM_AXIM(DATA_FROM_AXIM)				
			
    );

initial begin 
RST=1;
CLK=0;
VIRT_ADDR_VALID = 1;
TLB_FLUSH = 0;
repeat  (100) #5 CLK = ~CLK;
#1 $finish;
end

initial #11 RST = 0; 
reg [31:0] count = 0;
always @(posedge CLK) begin
	count <= count + 1;
	if(ADDR_TO_AXIM_VALID)begin
		DATA_FROM_AXIM_VALID <= 1;
		DATA_FROM_AXIM       <= ADDR_TO_AXIM >> 2;
	end
	else DATA_FROM_AXIM_VALID <= 0;
end

always@(*)begin
	if (count < 20) VIRT_ADDR = (PHY_ADDR_VALID)? CURR_ADDR + 4 : VIRT_ADDR;
	else if (count == 20)VIRT_ADDR = (PHY_ADDR_VALID)?  32'h1001_0000 : VIRT_ADDR;
	else VIRT_ADDR = (PHY_ADDR_VALID)? CURR_ADDR + 4 : VIRT_ADDR;
end



endmodule

