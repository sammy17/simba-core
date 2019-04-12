
`timescale 1 ns / 1 ps

	module Test_dcache_PROCESSOR #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Master Bus Interface M00_AXI
		parameter  ram_addr_width= 20                                         ,
	    localparam ram_depth     = 2**ram_addr_width                            ,
	    parameter data_width     = 32                                          ,
	    parameter address_width  = 32                                           ,
	    parameter block_size     = 8                                            ,
	    parameter cache_depth    = 512                                          ,
	    parameter l2_delay_read  = 10                                           ,
	    localparam line_width    = $clog2(cache_depth)                          ,
	    localparam offset_width  = $clog2(data_width*block_size/8 )               ,
	    localparam tag_width     = address_width - line_width -  offset_width   ,
	    localparam cache_width   = block_size*data_width                        ,
		parameter  C_M00_AXI_TARGET_SLAVE_BASE_ADDR	= 32'h00010000,
		parameter integer C_M00_AXI_BURST_LEN	= block_size,
		parameter integer C_M00_AXI_ID_WIDTH	= 1,
		parameter integer C_M00_AXI_ADDR_WIDTH	= 32,
		parameter integer C_M00_AXI_DATA_WIDTH	= 32,
		parameter integer C_M00_AXI_AWUSER_WIDTH	= 0,
		parameter integer C_M00_AXI_ARUSER_WIDTH	= 0,
		parameter integer C_M00_AXI_WUSER_WIDTH	= 0,
		parameter integer C_M00_AXI_RUSER_WIDTH	= 0,
		parameter integer C_M00_AXI_BUSER_WIDTH	= 0,
		parameter integer C_S00_AXI_ID_WIDTH	= 1,
		parameter integer C_S00_AXI_DATA_WIDTH	= 32,
		parameter integer C_S00_AXI_ADDR_WIDTH	= 32,
		parameter integer C_S00_AXI_AWUSER_WIDTH	= 0,
		parameter integer C_S00_AXI_ARUSER_WIDTH	= 0,
		parameter integer C_S00_AXI_WUSER_WIDTH	= 0,
		parameter integer C_S00_AXI_RUSER_WIDTH	= 0,
		parameter integer C_S00_AXI_BUSER_WIDTH	= 0
)
	
	(
		// Users to add ports here

		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Master Bus Interface M00_AXI
		output reg  m00_axi_init_axi_txn,
		output wire  m00_axi_txn_done,
		output wire  m00_axi_error,
		output reg   m00_axi_aclk,
		output reg   m00_axi_aresetn,
		output wire [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_awid,
		output wire [C_M00_AXI_ADDR_WIDTH-1 : 0] m00_axi_awaddr,
		output wire [7 : 0] m00_axi_awlen,
		output wire [2 : 0] m00_axi_awsize,
		output wire [1 : 0] m00_axi_awburst,
		output wire  m00_axi_awlock,
		output wire [3 : 0] m00_axi_awcache,
		output wire [2 : 0] m00_axi_awprot,
		output wire [3 : 0] m00_axi_awqos,
		output wire [C_M00_AXI_AWUSER_WIDTH-1 : 0] m00_axi_awuser,
		output wire  m00_axi_awvalid,
		output wire  m00_axi_awready,
		output wire [C_M00_AXI_DATA_WIDTH-1 : 0] m00_axi_wdata,
		output wire [C_M00_AXI_DATA_WIDTH/8-1 : 0] m00_axi_wstrb,
		output wire  m00_axi_wlast,
		output wire [C_M00_AXI_WUSER_WIDTH-1 : 0] m00_axi_wuser,
		output wire  m00_axi_wvalid,
		output wire  m00_axi_wready,
		output wire [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_bid,
		output wire [1 : 0] m00_axi_bresp,
		output wire [C_M00_AXI_BUSER_WIDTH-1 : 0] m00_axi_buser,
		output wire  m00_axi_bvalid,
		output wire  m00_axi_bready,
		output wire [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_arid,
		output wire [C_M00_AXI_ADDR_WIDTH-1 : 0] m00_axi_araddr,
		output wire [7 : 0] m00_axi_arlen,
		output wire [2 : 0] m00_axi_arsize,
		output wire [1 : 0] m00_axi_arburst,
		output wire  m00_axi_arlock,
		output wire [3 : 0] m00_axi_arcache,
		output wire [2 : 0] m00_axi_arprot,
		output wire [3 : 0] m00_axi_arqos,
		output wire [C_M00_AXI_ARUSER_WIDTH-1 : 0] m00_axi_aruser,
		output wire  m00_axi_arvalid,
		output wire  m00_axi_arready,
		output wire [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_rid,
		output wire [C_M00_AXI_DATA_WIDTH-1 : 0] m00_axi_rdata,
		output wire [1 : 0] m00_axi_rresp,
		output wire  m00_axi_rlast,
		output wire [C_M00_AXI_RUSER_WIDTH-1 : 0] m00_axi_ruser,
		output wire  m00_axi_rvalid,
		output wire  m00_axi_rready
	);
	                
        reg                      flush                           ;
        reg  [address_width-1:0]    addr                            ;
        wire  [address_width-1:0]    addr_out                            ;
        reg  [address_width-1:0]    curr_addr                            ;

        reg                      addr_valid                      ;
        wire [data_width-1:0]    data                            ;
        wire                     cache_ready                     ;
        wire                     addr_to_l2_valid                ;
        wire [cache_width-1:0]  datas                           ;
        wire [address_width-offset_width-1:0]     addr_to_l2       ;
        wire  [cache_width-1:0]   data_from_l2                    ;
        wire  [cache_width-1:0]   data_to_l2                    ;
        wire                      data_from_l2_valid              ;
        wire                      data_to_l2_valid              ;
        wire  [address_width-offset_width-1:0] waddr_to_l2      ;
        wire                      write_done;
// Instantiation of Axi Bus Interface M00_AXI
	myip_v1_0_M00_AXI # ( 
		.C_M_TARGET_SLAVE_BASE_ADDR(C_M00_AXI_TARGET_SLAVE_BASE_ADDR),
		.C_M_AXI_BURST_LEN(C_M00_AXI_BURST_LEN),
		.C_M_AXI_ID_WIDTH(C_M00_AXI_ID_WIDTH),
		.C_M_AXI_ADDR_WIDTH(C_M00_AXI_ADDR_WIDTH),
		.C_M_AXI_DATA_WIDTH(C_M00_AXI_DATA_WIDTH),
		.C_M_AXI_AWUSER_WIDTH(C_M00_AXI_AWUSER_WIDTH),
		.C_M_AXI_ARUSER_WIDTH(C_M00_AXI_ARUSER_WIDTH),
		.C_M_AXI_WUSER_WIDTH(C_M00_AXI_WUSER_WIDTH),
		.C_M_AXI_RUSER_WIDTH(C_M00_AXI_RUSER_WIDTH),
		.C_M_AXI_BUSER_WIDTH(C_M00_AXI_BUSER_WIDTH),
		.cache_width(cache_width)
	) myip_v1_0_M00_AXI_inst (
		.INIT_AXI_TXN(m00_axi_init_axi_txn),
		.TXN_DONE(m00_axi_txn_done),
		.ERROR(m00_axi_error),
		.M_AXI_ACLK(m00_axi_aclk),
		.M_AXI_ARESETN(m00_axi_aresetn),
		.M_AXI_AWID(m00_axi_awid),
		.M_AXI_AWADDR(m00_axi_awaddr),
		.M_AXI_AWLEN(m00_axi_awlen),
		.M_AXI_AWSIZE(m00_axi_awsize),
		.M_AXI_AWBURST(m00_axi_awburst),
		.M_AXI_AWLOCK(m00_axi_awlock),
		.M_AXI_AWCACHE(m00_axi_awcache),
		.M_AXI_AWPROT(m00_axi_awprot),
		.M_AXI_AWQOS(m00_axi_awqos),
		.M_AXI_AWUSER(m00_axi_awuser),
		.M_AXI_AWVALID(m00_axi_awvalid),
		.M_AXI_AWREADY(m00_axi_awready),
		.M_AXI_WDATA(m00_axi_wdata),
		.M_AXI_WSTRB(m00_axi_wstrb),
		.M_AXI_WLAST(m00_axi_wlast),
		.M_AXI_WUSER(m00_axi_wuser),
		.M_AXI_WVALID(m00_axi_wvalid),
		.M_AXI_WREADY(m00_axi_wready),
		.M_AXI_BID(m00_axi_bid),
		.M_AXI_BRESP(m00_axi_bresp),
		.M_AXI_BUSER(m00_axi_buser),
		.M_AXI_BVALID(m00_axi_bvalid),
		.M_AXI_BREADY(m00_axi_bready),
		.M_AXI_ARID(m00_axi_arid),
		.M_AXI_ARADDR(m00_axi_araddr),
		.M_AXI_ARLEN(m00_axi_arlen),
		.M_AXI_ARSIZE(m00_axi_arsize),
		.M_AXI_ARBURST(m00_axi_arburst),
		.M_AXI_ARLOCK(m00_axi_arlock),
		.M_AXI_ARCACHE(m00_axi_arcache),
		.M_AXI_ARPROT(m00_axi_arprot),
		.M_AXI_ARQOS(m00_axi_arqos),
		.M_AXI_ARUSER(m00_axi_aruser),
		.M_AXI_ARVALID(m00_axi_arvalid),
		.M_AXI_ARREADY(m00_axi_arready),
		.M_AXI_RID(m00_axi_rid),
		.M_AXI_RDATA(m00_axi_rdata),
		.M_AXI_RRESP(m00_axi_rresp),
		.M_AXI_RLAST(m00_axi_rlast),
		.M_AXI_RUSER(m00_axi_ruser),
		.M_AXI_RVALID(m00_axi_rvalid),
		.M_AXI_RREADY(m00_axi_rready),
		// user defined ports
		.data_from_l2(data_from_l2)			,
		.addr_to_l2_valid(addr_to_l2_valid)	,
		.addr_to_l2({addr_to_l2,{offset_width{1'b0}}})				,
		.data_from_l2_valid(data_from_l2_valid),
		
		.waddr_to_l2({waddr_to_l2,{offset_width{1'b0}}}),
		.data_to_l2(data_to_l2),
		.data_to_l2_valid(data_to_l2_valid),
		.data_written(write_done)
	);
	myip_v1_0_S00_AXI # ( 
		.C_S_AXI_ID_WIDTH 	(C_S00_AXI_ID_WIDTH),
		.C_S_AXI_DATA_WIDTH (C_S00_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH (C_S00_AXI_ADDR_WIDTH),
		.C_S_AXI_AWUSER_WIDTH(C_S00_AXI_AWUSER_WIDTH),
		.C_S_AXI_ARUSER_WIDTH(C_S00_AXI_ARUSER_WIDTH),
		.C_S_AXI_WUSER_WIDTH(C_S00_AXI_WUSER_WIDTH),
		.C_S_AXI_RUSER_WIDTH(C_S00_AXI_RUSER_WIDTH),
		.C_S_AXI_BUSER_WIDTH(C_S00_AXI_BUSER_WIDTH)
	) myip_v1_0_S00_AXI_inst (
		.S_AXI_ACLK(m00_axi_aclk),
		.S_AXI_ARESETN(m00_axi_aresetn),
		.S_AXI_AWID(m00_axi_awid),
		.S_AXI_AWADDR(m00_axi_awaddr),
		.S_AXI_AWLEN(m00_axi_awlen),
		.S_AXI_AWSIZE(m00_axi_awsize),
		.S_AXI_AWBURST(m00_axi_awburst),
		.S_AXI_AWLOCK(m00_axi_awlock),
		.S_AXI_AWCACHE(m00_axi_awcache),
		.S_AXI_AWPROT(m00_axi_awprot),
		.S_AXI_AWQOS(m00_axi_awqos),
		.S_AXI_AWREGION(m00_axi_awregion),
		.S_AXI_AWUSER(m00_axi_awuser),
		.S_AXI_AWVALID(m00_axi_awvalid),
		.S_AXI_AWREADY(m00_axi_awready),
		.S_AXI_WDATA(m00_axi_wdata),
		.S_AXI_WSTRB(m00_axi_wstrb),
		.S_AXI_WLAST(m00_axi_wlast),
		.S_AXI_WUSER(m00_axi_wuser),
		.S_AXI_WVALID(m00_axi_wvalid),
		.S_AXI_WREADY(m00_axi_wready),
		.S_AXI_BID(m00_axi_bid),
		.S_AXI_BRESP(m00_axi_bresp),
		.S_AXI_BUSER(m00_axi_buser),
		.S_AXI_BVALID(m00_axi_bvalid),
		.S_AXI_BREADY(m00_axi_bready),
		.S_AXI_ARID(m00_axi_arid),
		.S_AXI_ARADDR(m00_axi_araddr),
		.S_AXI_ARLEN(m00_axi_arlen),
		.S_AXI_ARSIZE(m00_axi_arsize),
		.S_AXI_ARBURST(m00_axi_arburst),
		.S_AXI_ARLOCK(m00_axi_arlock),
		.S_AXI_ARCACHE(m00_axi_arcache),
		.S_AXI_ARPROT(m00_axi_arprot),
		.S_AXI_ARQOS(m00_axi_arqos),
		.S_AXI_ARREGION(m00_axi_arregion),
		.S_AXI_ARUSER(m00_axi_aruser),
		.S_AXI_ARVALID(m00_axi_arvalid),
		.S_AXI_ARREADY(m00_axi_arready),
		.S_AXI_RID(m00_axi_rid),
		.S_AXI_RDATA(m00_axi_rdata),
		.S_AXI_RRESP(m00_axi_rresp),
		.S_AXI_RLAST(m00_axi_rlast),
		.S_AXI_RUSER(m00_axi_ruser),
		.S_AXI_RVALID(m00_axi_rvalid),
		.S_AXI_RREADY(m00_axi_rready)
	);
	// Add user logic here

	// User logic ends
	initial begin
		m00_axi_aclk = 0;
	flush =0;
		forever	begin 
			#10 m00_axi_aclk = ~m00_axi_aclk;
		end
	end
	initial begin
		m00_axi_init_axi_txn = 1;
		m00_axi_aresetn =0;
		#100;
		m00_axi_aresetn =1;
	end
//	    Icache
//    #(
//        .data_width     (data_width)                                        ,
//        .address_width  (address_width)                                     ,
//        .block_size     (block_size)                                        ,
//        .cache_depth    ( cache_depth)                                      
        
//        )
//    cache
//    (
//        .CLK(m00_axi_aclk)                                   ,
//        .RST(~m00_axi_aresetn)                                   ,
//        .FLUSH(flush)                               ,
//        .ADDR(addr)                                 ,
//        .ADDR_VALID(addr_valid)                     ,
//        .DATA (data)                                ,
//        .CACHE_READY(cache_ready)                   ,
//        .ADDR_TO_L2_VALID(addr_to_l2_valid)         ,
//        .ADDR_TO_L2 (addr_to_l2)                    ,
//        .DATA_FROM_L2 (data_from_l2)                ,
//        .DATA_FROM_L2_VALID (data_from_l2_valid)     ,
//        .CURR_ADDR(curr_addr)        ,
//        .ADDR_OUT(addr_out)

//    ); 

reg [1:0] control =2'b10;

   Dcache
    #(
        .data_width     (data_width)                                        ,
        .address_width  (address_width)                                     ,
        .block_size     (block_size)                                        ,
        .cache_depth    ( cache_depth)                                      
        
        )
   dcache (
    	   .CLK(m00_axi_aclk)                                   ,
        .RST(~m00_axi_aresetn)                                   ,
        .FLUSH(flush)                               ,
        .ADDR(addr)                                 ,
        .ADDR_VALID(1)                     ,
        .DATA (data)                                ,
        .CACHE_READY(cache_ready)                   ,
        .ADDR_TO_L2_VALID(addr_to_l2_valid)         ,
        .ADDR_TO_L2 (addr_to_l2)                    ,
        .DATA_FROM_L2 (data_from_l2)                ,
        .DATA_FROM_L2_VALID (data_from_l2_valid)    ,
         .CONTROL (control)              			,	
        .WSTRB (4'b1111)                           ,
        .DATA_in(addr),
        .DATA_TO_L2_VALID(data_to_l2_valid)                ,
        .WADDR_TO_L2(waddr_to_l2)    ,
        .WRITE_DONE(write_done),
        .DATA_TO_L2(data_to_l2)

    );
    always@(posedge m00_axi_aclk)
    begin
    	if (~m00_axi_aresetn)
    	begin
    		addr =0;
    		addr_valid =0;
    	end
    	else if(cache_ready) 
    	begin
    		addr_valid =1;
    		addr = addr+4;
    		if(addr==32'h00010000)
    		begin
    		  addr=0;
    		  control = 3 -control;
    		end
    		if(control == 2'b01)
    		begin
    		  $display("data %h",  data );
    		end
    	end
    end

      // initial begin
      	// addr_valid=0;
      	// addr=0;
       //      #1000;
       //      for (int j = 0 ; j<100; j=j+1)
       //      begin
       //          addr_valid=1;
       //           @(posedge  m00_axi_aclk);
  
       //          while (~cache_ready)
       //              @(posedge  m00_axi_aclk);
       //          $display("value is %d %x" ,addr,data);
       //          addr+=4;
       //      end
       //      $finish;

       //  end
           reg [7:0] byte_ram[0: (1<<24)-1][0:3];
   
       reg [31:0] word_ram[0: (1<<24)-1];
   
       initial begin
           $readmemh("data_hex.txt",word_ram);
           for (int j=0; j < (1<<24_); j=j+1)
           begin
               for (int i=0; i<4; i=i+1)
               begin
                   byte_ram[j][i]=  word_ram[j][8*i +: 8];
               end
           end
       end
	endmodule













                                                                                            
                                                                                            
                                                                                            
                                                                                            
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              