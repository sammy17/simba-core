`timescale 1 ns / 1 ps
module Plic_tb;
    reg     S_AXI_ACLK;
    reg     S_AXI_ARESETN;
    reg[27:0]     S_AXI_AWADDR=0;
    wire     S_AXI_AWPROT=0;
    reg     S_AXI_AWVALID=0;
    wire     S_AXI_AWREADY;
    reg[63:0]     S_AXI_WDATA=0;
    reg[7:0]      S_AXI_WSTRB=0;
    reg      S_AXI_WVALID=0;
    wire     S_AXI_WREADY;
    wire     S_AXI_BRESP;
    wire     S_AXI_BVALID;
    reg     S_AXI_BREADY=0;
    reg [27:0]     S_AXI_ARADDR=0;
   wire      S_AXI_ARPROT;
    reg     S_AXI_ARVALID=0;
    wire     S_AXI_ARREADY;
    wire [63:0]     S_AXI_RDATA;
    wire     S_AXI_RRESP;
    wire     S_AXI_RVALID;
    reg    S_AXI_RREADY=0;
    
    reg           auto_int_in_0=0;
    reg           auto_int_in_1=0;
    reg           auto_int_in_2=0;
    reg           auto_int_in_3=0;
    reg           auto_int_in_4=0;
    reg           auto_int_in_5=0;
    reg           auto_int_in_6=0;
    reg           auto_int_in_7=0;
    reg           auto_int_in_8=0;
    reg           auto_int_in_9=0;
    reg           auto_int_in_10=0;
    reg           auto_int_in_11=0;
    reg           auto_int_in_12=0;
    reg           auto_int_in_13=0;
    reg           auto_int_in_14=0;
    reg           auto_int_in_15=0;
    reg           auto_int_in_16=0;
    reg           auto_int_in_17=0;
    reg           auto_int_in_18=0;
    reg           auto_int_in_19=0;
    reg           auto_int_in_20=0;
    reg           auto_int_in_21=0;
    reg           auto_int_in_22=0;
    reg           auto_int_in_23=0;
    reg           auto_int_in_24=0;
    reg           auto_int_in_25=0;
    reg           auto_int_in_26=0;
    reg           auto_int_in_27=0;
    reg           auto_int_in_28=0;
    reg           auto_int_in_29=0;
    reg           auto_int_in_30=0;
    reg           auto_int_in_31=0;
    wire           auto_int_out_1_0;
    wire           auto_int_out_0_0;
    initial begin
        S_AXI_ACLK = 0;
        forever #5 S_AXI_ACLK = ~S_AXI_ACLK;
    end
    
    initial begin
        S_AXI_ARESETN =0;
        #50;
        S_AXI_ARESETN =1;
        #10;
    for(int i=0; i<17;i=i+1) begin
        S_AXI_AWVALID=1;
        S_AXI_AWADDR = 8*i;
        S_AXI_WVALID = 1;
        S_AXI_WDATA = (3<<32) + 3;
        S_AXI_WSTRB = -1;
        @(posedge S_AXI_BVALID);
        S_AXI_BREADY=1;
        S_AXI_AWVALID=0;
        S_AXI_AWADDR = 0;
        S_AXI_WVALID = 0;
        @(negedge S_AXI_BVALID);
    end
     for(int i=0; i<200;i=i+1) begin
        S_AXI_AWVALID=1;
        S_AXI_AWADDR = 32'h2000+ 8*i;
        S_AXI_WVALID = 1;
        S_AXI_WDATA = -1;
        S_AXI_WSTRB = -1;
        @(posedge S_AXI_BVALID);
        S_AXI_BREADY=1;
        S_AXI_AWVALID=0;
        S_AXI_AWADDR = 0;
        S_AXI_WVALID = 0;
        @(negedge S_AXI_BVALID);
    end
     for(int i=0; i<2;i=i+1) begin
        S_AXI_AWVALID=1;
        S_AXI_AWADDR = 32'h200000 +32'h1000*(i);
        S_AXI_WVALID = 1;
        S_AXI_WDATA = 0;
        S_AXI_WSTRB = -1;
        @(posedge S_AXI_BVALID);
        S_AXI_BREADY=1;
        S_AXI_AWVALID=0;
        S_AXI_AWADDR = 0;
        S_AXI_WVALID = 0;
        @(negedge S_AXI_BVALID);
    end
    #100;
    @(negedge S_AXI_ACLK);
    auto_int_in_14=1;
    
    @(negedge S_AXI_ACLK);
   
    @(negedge S_AXI_ACLK);
    

    
     for(int i=0; i<10; i++) begin
        S_AXI_ARVALID =1;
        S_AXI_ARADDR = 32'h200004;
        @(posedge S_AXI_RVALID);
        S_AXI_RREADY=1;
        S_AXI_ARVALID=0;
        $display("%0lx\n",S_AXI_RDATA);
        @(negedge S_AXI_RVALID)
        S_AXI_RREADY=0;
    end
    @(negedge S_AXI_ACLK);
        S_AXI_AWVALID=1;
        S_AXI_AWADDR = 32'h200000 ;
        S_AXI_WVALID = 1;
        S_AXI_WDATA = 15<<32;
        S_AXI_WSTRB = 8'hf0;
        @(posedge S_AXI_BVALID);
        S_AXI_BREADY=1;
        S_AXI_AWVALID=0;
        S_AXI_AWADDR = 0;
        S_AXI_WVALID = 0;
        @(negedge S_AXI_BVALID);
        

    end 
     PLIC_AXI_wrapper wrapper_inst(
               auto_int_in_0,
               auto_int_in_1,
               auto_int_in_2,
               auto_int_in_3,
               auto_int_in_4,
               auto_int_in_5,
               auto_int_in_6,
               auto_int_in_7,
               auto_int_in_8,
               auto_int_in_9,
               auto_int_in_10,
               auto_int_in_11,
               auto_int_in_12,
               auto_int_in_13,
               auto_int_in_14,
               auto_int_in_15,
               auto_int_in_16,
               auto_int_in_17,
               auto_int_in_18,
               auto_int_in_19,
               auto_int_in_20,
               auto_int_in_21,
               auto_int_in_22,
               auto_int_in_23,
               auto_int_in_24,
               auto_int_in_25,
               auto_int_in_26,
               auto_int_in_27,
               auto_int_in_28,
               auto_int_in_29,
               auto_int_in_30,
               auto_int_in_31,
               auto_int_out_1_0,
               auto_int_out_0_0,
       
         S_AXI_ACLK,
         S_AXI_ARESETN,
         S_AXI_AWADDR,
         S_AXI_AWPROT,
         S_AXI_AWVALID,
         S_AXI_AWREADY,
         S_AXI_WDATA,
         S_AXI_WSTRB,
         S_AXI_WVALID,
         S_AXI_WREADY,
         S_AXI_BRESP,
         S_AXI_BVALID,
         S_AXI_BREADY,
         S_AXI_ARADDR,
         S_AXI_ARPROT,
         S_AXI_ARVALID,
         S_AXI_ARREADY,
         S_AXI_RDATA,
         S_AXI_RRESP,
         S_AXI_RVALID,
         S_AXI_RREADY
     );
endmodule
