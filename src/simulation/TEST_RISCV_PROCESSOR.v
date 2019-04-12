`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Yasas Senevitatne
// 
// Create Date: 03/05/2017 10:37:35 AM
// Design Name: 
// Module Name: Test_RISCV_PROCESSOR
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

module Test_RISCV_PROCESSOR
#(
   parameter  ram_addr_width= 20                                         ,
 localparam ram_depth     = 2**ram_addr_width                            ,
 parameter data_width     = 32                                          ,
 parameter address_width  = 32                                           ,
 parameter block_size     = 8                                           ,
 parameter cache_depth    = 512                                          ,
 parameter l2_delay_read  = 10                                           ,
 localparam line_width    = $clog2(cache_depth)                          ,
 localparam offset_width  = $clog2(data_width*block_size/8 )               ,
 localparam tag_width     = address_width - line_width -  offset_width   ,
 localparam cache_width   = block_size*data_width                        ,
 parameter  C_M00_AXI_TARGET_SLAVE_BASE_ADDR    = 32'h00000000,
           parameter  C_Peripheral_Interface_START_DATA_VALUE              = 32'h00000000,
parameter  C_Peripheral_Interface_TARGET_SLAVE_BASE_ADDR        = 32'h00000000,
parameter integer C_Peripheral_Interface_ADDR_WIDTH             = 32,
parameter integer C_Peripheral_Interface_DATA_WIDTH             = 32,
parameter integer C_Peripheral_Interface_TRANSACTIONS_NUM       = 4,
 parameter integer C_M00_AXI_BURST_LEN    = block_size,
 parameter integer C_M00_AXI_ID_WIDTH    = 1,
 parameter integer C_M00_AXI_ADDR_WIDTH    = 32,
 parameter integer C_M00_AXI_DATA_WIDTH    = 32,
 parameter integer C_M00_AXI_AWUSER_WIDTH    = 0,
 parameter integer C_M00_AXI_ARUSER_WIDTH    = 0,
 parameter integer C_M00_AXI_WUSER_WIDTH    = 0,
 parameter integer C_M00_AXI_RUSER_WIDTH    = 0,
 parameter integer C_M00_AXI_BUSER_WIDTH    = 0,
 parameter integer C_S00_AXI_ID_WIDTH    = 4,
 parameter integer C_S00_AXI_DATA_WIDTH    = 32,
 parameter integer C_S00_AXI_ADDR_WIDTH    = 32,
 parameter integer C_S00_AXI_AWUSER_WIDTH    = 0,
 parameter integer C_S00_AXI_ARUSER_WIDTH    = 0,
 parameter integer C_S00_AXI_WUSER_WIDTH    = 0,
 parameter integer C_S00_AXI_RUSER_WIDTH    = 0,
 parameter integer C_S00_AXI_BUSER_WIDTH    = 0
) ();
    // Fixed parameters
    localparam ADDR_WIDTH        = 32;
    localparam DATA_WIDTH        = 32;
    
    // Primary parameters for processor instantiation

                
    // Constants
    reg TRUE  = 1;
    reg FALSE = 0;    
    
    // Standard inputs    
    reg                           CLK;
    reg                           RSTN;             
             

 
    wire  m00_axi_init_axi_txn;                                
    wire  m00_axi_txn_done;                                    
    wire  m00_axi_error;                                     
    wire  m00_axi_aclk=CLK;                                         
    wire  m00_axi_aresetn=RSTN;                                      
    wire [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_awid;             
    wire [C_M00_AXI_ADDR_WIDTH-1 : 0] m00_axi_awaddr;          
    wire [7 : 0] m00_axi_awlen;                                
    wire [2 : 0] m00_axi_awsize;                               
    wire [1 : 0] m00_axi_awburst;                              
    wire  m00_axi_awlock;                                    
    wire [3 : 0] m00_axi_awcache;                             
    wire [2 : 0] m00_axi_awprot;                               
    wire [3 : 0] m00_axi_awqos;                               
    wire [C_M00_AXI_AWUSER_WIDTH-1 : 0] m00_axi_awuser;        
    wire  m00_axi_awvalid;                                     
    wire  m00_axi_awready;                                      
    wire [C_M00_AXI_DATA_WIDTH-1 : 0] m00_axi_wdata;           
    wire [C_M00_AXI_DATA_WIDTH/8-1 : 0] m00_axi_wstrb;         
    wire  m00_axi_wlast;                                       
    wire [C_M00_AXI_WUSER_WIDTH-1 : 0] m00_axi_wuser;          
    wire  m00_axi_wvalid;                                      
    wire  m00_axi_wready;                                       
    wire [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_bid;                
    wire [1 : 0] m00_axi_bresp;                                 
    wire [C_M00_AXI_BUSER_WIDTH-1 : 0] m00_axi_buser;          
    wire  m00_axi_bvalid;                                       
    wire  m00_axi_bready;                                      
    wire [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_arid;             
    wire [C_M00_AXI_ADDR_WIDTH-1 : 0] m00_axi_araddr;          
    wire [7 : 0] m00_axi_arlen;                                
    wire [2 : 0] m00_axi_arsize;                               
    wire [1 : 0] m00_axi_arburst;                              
    wire  m00_axi_arlock;                                      
    wire [3 : 0] m00_axi_arcache;                              
    wire [2 : 0] m00_axi_arprot;                               
    wire [3 : 0] m00_axi_arqos;                                
    wire [C_M00_AXI_ARUSER_WIDTH-1 : 0] m00_axi_aruser;        
    wire  m00_axi_arvalid;                                     
    wire  m00_axi_arready;                                      
    wire [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_rid;                
    wire [C_M00_AXI_DATA_WIDTH-1 : 0] m00_axi_rdata;            
    wire [1 : 0] m00_axi_rresp;                                 
    wire  m00_axi_rlast;                                        
    wire [C_M00_AXI_RUSER_WIDTH-1 : 0] m00_axi_ruser;           
    wire  m00_axi_rvalid;                                       
    wire  m00_axi_rready;   
    ////////////////////////////////////////////////////////////////////////////////    
       wire  M00_AXI_INIT_AXI_TXN;                                
    wire  M00_AXI_TXN_DONE;                                    
    wire  M00_AXI_ERROR;                                     
    wire  M00_AXI_ACLK=CLK;                                         
    wire  M00_AXI_ARESETN=RSTN;                                      
    wire [C_S00_AXI_ID_WIDTH-1 : 0] M00_AXI_AWID;             
    wire [C_M00_AXI_ADDR_WIDTH-1 : 0] M00_AXI_AWADDR;          
    wire [7 : 0] M00_AXI_AWLEN;                                
    wire [2 : 0] M00_AXI_AWSIZE;                               
    wire [1 : 0] M00_AXI_AWBURST;                              
    wire  M00_AXI_AWLOCK;                                    
    wire [3 : 0] M00_AXI_AWCACHE;                             
    wire [2 : 0] M00_AXI_AWPROT;                               
    wire [3 : 0] M00_AXI_AWQOS;                               
    wire [C_M00_AXI_AWUSER_WIDTH-1 : 0] M00_AXI_AWUSER;        
    wire  M00_AXI_AWVALID;                                     
    wire  M00_AXI_AWREADY;                                      
    wire [C_M00_AXI_DATA_WIDTH-1 : 0] M00_AXI_WDATA;           
    wire [C_M00_AXI_DATA_WIDTH/8-1 : 0] M00_AXI_WSTRB;         
    wire  M00_AXI_WLAST;                                       
    wire [C_M00_AXI_WUSER_WIDTH-1 : 0] M00_AXI_WUSER;          
    wire  M00_AXI_WVALID;                                      
    wire  M00_AXI_WREADY;                                       
    wire [C_S00_AXI_ID_WIDTH-1 : 0] M00_AXI_BID;                
    wire [1 : 0] M00_AXI_BRESP;                                 
    wire [C_M00_AXI_BUSER_WIDTH-1 : 0] M00_AXI_BUSER;          
    wire  M00_AXI_BVALID;                                       
    wire  M00_AXI_BREADY;                                      
    wire [C_S00_AXI_ID_WIDTH-1 : 0] M00_AXI_ARID;             
    wire [C_M00_AXI_ADDR_WIDTH-1 : 0] M00_AXI_ARADDR;          
    wire [7 : 0] M00_AXI_ARLEN;                                
    wire [2 : 0] M00_AXI_ARSIZE;                               
    wire [1 : 0] M00_AXI_ARBURST;                              
    wire  M00_AXI_ARLOCK;                                      
    wire [3 : 0] M00_AXI_ARCACHE;                              
    wire [2 : 0] M00_AXI_ARPROT;                               
    wire [3 : 0] M00_AXI_ARQOS;                                
    wire [C_M00_AXI_ARUSER_WIDTH-1 : 0] M00_AXI_ARUSER;        
    wire  M00_AXI_ARVALID;                                     
    wire  M00_AXI_ARREADY;                                      
    wire [C_S00_AXI_ID_WIDTH-1 : 0] M00_AXI_RID;                
    wire [C_M00_AXI_DATA_WIDTH-1 : 0] M00_AXI_RDATA;            
    wire [1 : 0] M00_AXI_RRESP;                                 
    wire  M00_AXI_RLAST;                                        
    wire [C_M00_AXI_RUSER_WIDTH-1 : 0] M00_AXI_RUSER;           
    wire  M00_AXI_RVALID;                                       
    wire  M00_AXI_RREADY;   
 
 ////////////////////////////////////////////////                                
    wire  m01_axi_init_axi_txn;                                
    wire  m01_axi_txn_done;                                    
    wire  m01_axi_error;                                     
    wire  m01_axi_aclk=CLK;                                         
    wire  m01_axi_aresetn=RSTN;                                      
    wire [C_M00_AXI_ID_WIDTH-1 : 0] m01_axi_awid;             
    wire [C_M00_AXI_ADDR_WIDTH-1 : 0] m01_axi_awaddr;          
    wire [7 : 0] m01_axi_awlen;                                
    wire [2 : 0] m01_axi_awsize;                               
    wire [1 : 0] m01_axi_awburst;                              
    wire  m01_axi_awlock;                                    
    wire [3 : 0] m01_axi_awcache;                             
    wire [2 : 0] m01_axi_awprot;                               
    wire [3 : 0] m01_axi_awqos;                               
    wire [C_M00_AXI_AWUSER_WIDTH-1 : 0] m01_axi_awuser;        
    wire  m01_axi_awvalid;                                     
    wire  m01_axi_awready;                                      
    wire [C_M00_AXI_DATA_WIDTH-1 : 0] m01_axi_wdata;           
    wire [C_M00_AXI_DATA_WIDTH/8-1 : 0] m01_axi_wstrb;         
    wire  m01_axi_wlast;                                       
    wire [C_M00_AXI_WUSER_WIDTH-1 : 0] m01_axi_wuser;          
    wire  m01_axi_wvalid;                                      
    wire  m01_axi_wready;                                       
    wire [C_M00_AXI_ID_WIDTH-1 : 0] m01_axi_bid;                
    wire [1 : 0] m01_axi_bresp;                                 
    wire [C_M00_AXI_BUSER_WIDTH-1 : 0] m01_axi_buser;          
    wire  m01_axi_bvalid;                                       
    wire  m01_axi_bready;                                      
    wire [C_M00_AXI_ID_WIDTH-1 : 0] m01_axi_arid;             
    wire [C_M00_AXI_ADDR_WIDTH-1 : 0] m01_axi_araddr;          
    wire [7 : 0] m01_axi_arlen;                                
    wire [2 : 0] m01_axi_arsize;                               
    wire [1 : 0] m01_axi_arburst;                              
    wire  m01_axi_arlock;                                      
    wire [3 : 0] m01_axi_arcache;                              
    wire [2 : 0] m01_axi_arprot;                               
    wire [3 : 0] m01_axi_arqos;                                
    wire [C_M00_AXI_ARUSER_WIDTH-1 : 0] m01_axi_aruser;        
    wire  m01_axi_arvalid;                                     
    wire  m01_axi_arready;                                      
    wire [C_M00_AXI_ID_WIDTH-1 : 0] m01_axi_rid;                
    wire [C_M00_AXI_DATA_WIDTH-1 : 0] m01_axi_rdata;            
    wire [1 : 0] m01_axi_rresp;                                 
    wire  m01_axi_rlast;                                        
    wire [C_M00_AXI_RUSER_WIDTH-1 : 0] m01_axi_ruser;           
    wire  m01_axi_rvalid;                                       
    wire  m01_axi_rready; 

    //////////////////////////////////////////////////////////////////////////
     wire                                             peripheral_interface_init_axi_txn;       
    wire                                             peripheral_interface_error;             
    wire                                             peripheral_interface_txn_done;           
    wire                                             peripheral_interface_aclk;               
    wire                                             peripheral_interface_aresetn;         
    wire [C_Peripheral_Interface_ADDR_WIDTH-1 : 0]   peripheral_interface_awaddr;             
    wire [2 : 0]                                     peripheral_interface_awprot;             
    wire                                             peripheral_interface_awvalid;            
    wire                                             peripheral_interface_awready;            
    wire [C_Peripheral_Interface_DATA_WIDTH-1 : 0]   peripheral_interface_wdata;              
    wire [C_Peripheral_Interface_DATA_WIDTH/8-1 : 0] peripheral_interface_wstrb;              
    wire                                             peripheral_interface_wvalid;             
    wire                                             peripheral_interface_wready;             
    wire [1 : 0]                                     peripheral_interface_bresp;              
    wire                                             peripheral_interface_bvalid;             
    wire                                             peripheral_interface_bready;             
    wire [C_Peripheral_Interface_ADDR_WIDTH-1 : 0]   peripheral_interface_araddr;             
    wire [2 : 0]                                     peripheral_interface_arprot;             
    wire                                             peripheral_interface_arvalid;            
    wire                                             peripheral_interface_arready;            
    wire [C_Peripheral_Interface_DATA_WIDTH-1 : 0]   peripheral_interface_rdata;            
    wire [1 : 0]                                     peripheral_interface_rresp;              
    wire                                             peripheral_interface_rvalid;             
    wire                                             peripheral_interface_rready; 
    //////////////////////////////////////////////////////////////////////////////////             

axi_interconnect_0_new master_interconnect (
  .INTERCONNECT_ACLK(CLK),        // input wire INTERCONNECT_ACLK
  .INTERCONNECT_ARESETN(RSTN),  // input wire INTERCONNECT_ARESETN
  .S00_AXI_ARESET_OUT_N(m00_axi_areset_out_n),  // output wire S00_AXI_ARESET_OUT_N
  .S00_AXI_ACLK(m00_axi_aclk),                  // input wire S00_AXI_ACLK
  .S00_AXI_AWID(m00_axi_awid),                  // input wire [0 : 0] S00_AXI_AWID
  .S00_AXI_AWADDR(m00_axi_awaddr),              // input wire [31 : 0] S00_AXI_AWADDR
  .S00_AXI_AWLEN(m00_axi_awlen),                // input wire [7 : 0] S00_AXI_AWLEN
  .S00_AXI_AWSIZE(m00_axi_awsize),              // input wire [2 : 0] S00_AXI_AWSIZE
  .S00_AXI_AWBURST(m00_axi_awburst),            // input wire [1 : 0] S00_AXI_AWBURST
  .S00_AXI_AWLOCK(m00_axi_awlock),              // input wire S00_AXI_AWLOCK
  .S00_AXI_AWCACHE(m00_axi_awcache),            // input wire [3 : 0] S00_AXI_AWCACHE
  .S00_AXI_AWPROT(m00_axi_awprot),              // input wire [2 : 0] S00_AXI_AWPROT
  .S00_AXI_AWQOS(m00_axi_awqos),                // input wire [3 : 0] S00_AXI_AWQOS
  .S00_AXI_AWVALID(m00_axi_awvalid),            // input wire S00_AXI_AWVALID
  .S00_AXI_AWREADY(m00_axi_awready),            // output wire S00_AXI_AWREADY
  .S00_AXI_WDATA(m00_axi_wdata),                // input wire [31 : 0] S00_AXI_WDATA
  .S00_AXI_WSTRB(m00_axi_wstrb),                // input wire [3 : 0] S00_AXI_WSTRB
  .S00_AXI_WLAST(m00_axi_wlast),                // input wire S00_AXI_WLAST
  .S00_AXI_WVALID(m00_axi_wvalid),              // input wire S00_AXI_WVALID
  .S00_AXI_WREADY(m00_axi_wready),              // output wire S00_AXI_WREADY
  .S00_AXI_BID(m00_axi_bid),                    // output wire [0 : 0] S00_AXI_BID
  .S00_AXI_BRESP(m00_axi_bresp),                // output wire [1 : 0] S00_AXI_BRESP
  .S00_AXI_BVALID(m00_axi_bvalid),              // output wire S00_AXI_BVALID
  .S00_AXI_BREADY(m00_axi_bready),              // input wire S00_AXI_BREADY
  .S00_AXI_ARID(m00_axi_arid),                  // input wire [0 : 0] S00_AXI_ARID
  .S00_AXI_ARADDR(m00_axi_araddr),              // input wire [31 : 0] S00_AXI_ARADDR
  .S00_AXI_ARLEN(m00_axi_arlen),                // input wire [7 : 0] S00_AXI_ARLEN
  .S00_AXI_ARSIZE(m00_axi_arsize),              // input wire [2 : 0] S00_AXI_ARSIZE
  .S00_AXI_ARBURST(m00_axi_arburst),            // input wire [1 : 0] S00_AXI_ARBURST
  .S00_AXI_ARLOCK(m00_axi_arlock),              // input wire S00_AXI_ARLOCK
  .S00_AXI_ARCACHE(m00_axi_arcache),            // input wire [3 : 0] S00_AXI_ARCACHE
  .S00_AXI_ARPROT(m00_axi_arprot),              // input wire [2 : 0] S00_AXI_ARPROT
  .S00_AXI_ARQOS(m00_axi_arqos),                // input wire [3 : 0] S00_AXI_ARQOS
  .S00_AXI_ARVALID(m00_axi_arvalid),            // input wire S00_AXI_ARVALID
  .S00_AXI_ARREADY(m00_axi_arready),            // output wire S00_AXI_ARREADY
  .S00_AXI_RID(m00_axi_rid),                    // output wire [0 : 0] S00_AXI_RID
  .S00_AXI_RDATA(m00_axi_rdata),                // output wire [31 : 0] S00_AXI_RDATA
  .S00_AXI_RRESP(m00_axi_rresp),                // output wire [1 : 0] S00_AXI_RRESP
  .S00_AXI_RLAST(m00_axi_rlast),                // output wire S00_AXI_RLAST
  .S00_AXI_RVALID(m00_axi_rvalid),              // output wire S00_AXI_RVALID
  .S00_AXI_RREADY(m00_axi_rready),              // input wire S00_AXI_RREADY
  .S01_AXI_ARESET_OUT_N(m01_axi_areset_out_n),  // output wire S01_AXI_ARESET_OUT_N
  .S01_AXI_ACLK(m01_axi_aclk),                  // input wire S01_AXI_ACLK
  .S01_AXI_AWID(m01_axi_awid),                  // input wire [0 : 0] S01_AXI_AWID
  .S01_AXI_AWADDR(m01_axi_awaddr),              // input wire [31 : 0] S01_AXI_AWADDR
  .S01_AXI_AWLEN(m01_axi_awlen),                // input wire [7 : 0] S01_AXI_AWLEN
  .S01_AXI_AWSIZE(m01_axi_awsize),              // input wire [2 : 0] S01_AXI_AWSIZE
  .S01_AXI_AWBURST(m01_axi_awburst),            // input wire [1 : 0] S01_AXI_AWBURST
  .S01_AXI_AWLOCK(m01_axi_awlock),              // input wire S01_AXI_AWLOCK
  .S01_AXI_AWCACHE(m01_axi_awcache),            // input wire [3 : 0] S01_AXI_AWCACHE
  .S01_AXI_AWPROT(m01_axi_awprot),              // input wire [2 : 0] S01_AXI_AWPROT
  .S01_AXI_AWQOS(m01_axi_awqos),                // input wire [3 : 0] S01_AXI_AWQOS
  .S01_AXI_AWVALID(m01_axi_awvalid),            // input wire S01_AXI_AWVALID
  .S01_AXI_AWREADY(m01_axi_awready),            // output wire S01_AXI_AWREADY
  .S01_AXI_WDATA(m01_axi_wdata),                // input wire [31 : 0] S01_AXI_WDATA
  .S01_AXI_WSTRB(m01_axi_wstrb),                // input wire [3 : 0] S01_AXI_WSTRB
  .S01_AXI_WLAST(m01_axi_wlast),                // input wire S01_AXI_WLAST
  .S01_AXI_WVALID(m01_axi_wvalid),              // input wire S01_AXI_WVALID
  .S01_AXI_WREADY(m01_axi_wready),              // output wire S01_AXI_WREADY
  .S01_AXI_BID(m01_axi_bid),                    // output wire [0 : 0] S01_AXI_BID
  .S01_AXI_BRESP(m01_axi_bresp),                // output wire [1 : 0] S01_AXI_BRESP
  .S01_AXI_BVALID(m01_axi_bvalid),              // output wire S01_AXI_BVALID
  .S01_AXI_BREADY(m01_axi_bready),              // input wire S01_AXI_BREADY
  .S01_AXI_ARID(m01_axi_arid),                  // input wire [0 : 0] S01_AXI_ARID
  .S01_AXI_ARADDR(m01_axi_araddr),              // input wire [31 : 0] S01_AXI_ARADDR
  .S01_AXI_ARLEN(m01_axi_arlen),                // input wire [7 : 0] S01_AXI_ARLEN
  .S01_AXI_ARSIZE(m01_axi_arsize),              // input wire [2 : 0] S01_AXI_ARSIZE
  .S01_AXI_ARBURST(m01_axi_arburst),            // input wire [1 : 0] S01_AXI_ARBURST
  .S01_AXI_ARLOCK(m01_axi_arlock),              // input wire S01_AXI_ARLOCK
  .S01_AXI_ARCACHE(m01_axi_arcache),            // input wire [3 : 0] S01_AXI_ARCACHE
  .S01_AXI_ARPROT(m01_axi_arprot),              // input wire [2 : 0] S01_AXI_ARPROT
  .S01_AXI_ARQOS(m01_axi_arqos),                // input wire [3 : 0] S01_AXI_ARQOS
  .S01_AXI_ARVALID(m01_axi_arvalid),            // input wire S01_AXI_ARVALID
  .S01_AXI_ARREADY(m01_axi_arready),            // output wire S01_AXI_ARREADY
  .S01_AXI_RID(m01_axi_rid),                    // output wire [0 : 0] S01_AXI_RID
  .S01_AXI_RDATA(m01_axi_rdata),                // output wire [31 : 0] S01_AXI_RDATA
  .S01_AXI_RRESP(m01_axi_rresp),                // output wire [1 : 0] S01_AXI_RRESP
  .S01_AXI_RLAST(m01_axi_rlast),                // output wire S01_AXI_RLAST
  .S01_AXI_RVALID(m01_axi_rvalid),              // output wire S01_AXI_RVALID
  .S01_AXI_RREADY(m01_axi_rready),              // input wire S01_AXI_RREADY

  .M00_AXI_ARESET_OUT_N(M00_AXI_ARESET_OUT_N),  // output wire M00_AXI_ARESET_OUT_N
  .M00_AXI_ACLK(M00_AXI_ACLK),                  // input wire M00_AXI_ACLK
  .M00_AXI_AWID(M00_AXI_AWID),                  // output wire [3 : 0] M00_AXI_AWID
  .M00_AXI_AWADDR(M00_AXI_AWADDR),              // output wire [31 : 0] M00_AXI_AWADDR
  .M00_AXI_AWLEN(M00_AXI_AWLEN),                // output wire [7 : 0] M00_AXI_AWLEN
  .M00_AXI_AWSIZE(M00_AXI_AWSIZE),              // output wire [2 : 0] M00_AXI_AWSIZE
  .M00_AXI_AWBURST(M00_AXI_AWBURST),            // output wire [1 : 0] M00_AXI_AWBURST
  .M00_AXI_AWLOCK(M00_AXI_AWLOCK),              // output wire M00_AXI_AWLOCK
  .M00_AXI_AWCACHE(M00_AXI_AWCACHE),            // output wire [3 : 0] M00_AXI_AWCACHE
  .M00_AXI_AWPROT(M00_AXI_AWPROT),              // output wire [2 : 0] M00_AXI_AWPROT
  .M00_AXI_AWQOS(M00_AXI_AWQOS),                // output wire [3 : 0] M00_AXI_AWQOS
  .M00_AXI_AWVALID(M00_AXI_AWVALID),            // output wire M00_AXI_AWVALID
  .M00_AXI_AWREADY(M00_AXI_AWREADY),            // input wire M00_AXI_AWREADY
  .M00_AXI_WDATA(M00_AXI_WDATA),                // output wire [31 : 0] M00_AXI_WDATA
  .M00_AXI_WSTRB(M00_AXI_WSTRB),                // output wire [3 : 0] M00_AXI_WSTRB
  .M00_AXI_WLAST(M00_AXI_WLAST),                // output wire M00_AXI_WLAST
  .M00_AXI_WVALID(M00_AXI_WVALID),              // output wire M00_AXI_WVALID
  .M00_AXI_WREADY(M00_AXI_WREADY),              // input wire M00_AXI_WREADY
  .M00_AXI_BID(M00_AXI_BID),                    // input wire [3 : 0] M00_AXI_BID
  .M00_AXI_BRESP(M00_AXI_BRESP),                // input wire [1 : 0] M00_AXI_BRESP
  .M00_AXI_BVALID(M00_AXI_BVALID),              // input wire M00_AXI_BVALID
  .M00_AXI_BREADY(M00_AXI_BREADY),              // output wire M00_AXI_BREADY
  .M00_AXI_ARID(M00_AXI_ARID),                  // output wire [3 : 0] M00_AXI_ARID
  .M00_AXI_ARADDR(M00_AXI_ARADDR),              // output wire [31 : 0] M00_AXI_ARADDR
  .M00_AXI_ARLEN(M00_AXI_ARLEN),                // output wire [7 : 0] M00_AXI_ARLEN
  .M00_AXI_ARSIZE(M00_AXI_ARSIZE),              // output wire [2 : 0] M00_AXI_ARSIZE
  .M00_AXI_ARBURST(M00_AXI_ARBURST),            // output wire [1 : 0] M00_AXI_ARBURST
  .M00_AXI_ARLOCK(M00_AXI_ARLOCK),              // output wire M00_AXI_ARLOCK
  .M00_AXI_ARCACHE(M00_AXI_ARCACHE),            // output wire [3 : 0] M00_AXI_ARCACHE
  .M00_AXI_ARPROT(M00_AXI_ARPROT),              // output wire [2 : 0] M00_AXI_ARPROT
  .M00_AXI_ARQOS(M00_AXI_ARQOS),                // output wire [3 : 0] M00_AXI_ARQOS
  .M00_AXI_ARVALID(M00_AXI_ARVALID),            // output wire M00_AXI_ARVALID
  .M00_AXI_ARREADY(M00_AXI_ARREADY),            // input wire M00_AXI_ARREADY
  .M00_AXI_RID(M00_AXI_RID),                    // input wire [3 : 0] M00_AXI_RID
  .M00_AXI_RDATA(M00_AXI_RDATA),                // input wire [31 : 0] M00_AXI_RDATA
  .M00_AXI_RRESP(M00_AXI_RRESP),                // input wire [1 : 0] M00_AXI_RRESP
  .M00_AXI_RLAST(M00_AXI_RLAST),                // input wire M00_AXI_RLAST
  .M00_AXI_RVALID(M00_AXI_RVALID),              // input wire M00_AXI_RVALID
  .M00_AXI_RREADY(M00_AXI_RREADY)              // output wire M00_AXI_RREADY
);
    wire [7:0] char;
    wire  char_write;
   RISCV_PROCESSOR # (
   ) uut (
       // Standard inputs
       .CLK(CLK),
       .RSTN(m00_axi_areset_out_n),
       .peripheral_interface_aclk(CLK),
       // Output address bus from Instruction Cache to Memory               
       //axi interface
       .m00_axi_aclk(m00_axi_aclk),
       .m00_axi_aresetn(m00_axi_aresetn),
       .m00_axi_awid(m00_axi_awid),
       .m00_axi_awaddr(m00_axi_awaddr),
        .m00_axi_awlen(m00_axi_awlen),
        .m00_axi_awsize(m00_axi_awsize),
        .m00_axi_awburst(m00_axi_awburst),
        .m00_axi_awlock(m00_axi_awlock),
        .m00_axi_awcache(m00_axi_awcache),
        .m00_axi_awprot(m00_axi_awprot),
        .m00_axi_awqos(m00_axi_awqos),
        .m00_axi_awuser(m00_axi_awuser),
        .m00_axi_awvalid(m00_axi_awvalid),
        .m00_axi_awready(m00_axi_awready),
        .m00_axi_wdata(m00_axi_wdata),
        .m00_axi_wstrb(m00_axi_wstrb),
        .m00_axi_wlast(m00_axi_wlast),
        .m00_axi_wuser(m00_axi_wuser),
        .m00_axi_wvalid(m00_axi_wvalid),
        .m00_axi_wready(m00_axi_wready),
        .m00_axi_bid(m00_axi_bid),
        .m00_axi_bresp(m00_axi_bresp),
        .m00_axi_buser(m00_axi_buser),
        .m00_axi_bvalid(m00_axi_bvalid),
        .m00_axi_bready(m00_axi_bready),
        .m00_axi_arid(m00_axi_arid),
        .m00_axi_araddr(m00_axi_araddr),
        .m00_axi_arlen(m00_axi_arlen),
        .m00_axi_arsize(m00_axi_arsize),
        .m00_axi_arburst(m00_axi_arburst),
        .m00_axi_arlock(m00_axi_arlock),
        .m00_axi_arcache(m00_axi_arcache),
        .m00_axi_arprot(m00_axi_arprot),
        .m00_axi_arqos(m00_axi_arqos),
        .m00_axi_aruser(m00_axi_aruser),
        .m00_axi_arvalid(m00_axi_arvalid),
        .m00_axi_arready(m00_axi_arready),
        .m00_axi_rid(m00_axi_rid),
        .m00_axi_rdata(m00_axi_rdata),
        .m00_axi_rresp(m00_axi_rresp),
        .m00_axi_rlast(m00_axi_rlast),
        .m00_axi_ruser(m00_axi_ruser),
        .m00_axi_rvalid(m00_axi_rvalid),
        .m00_axi_rready(m00_axi_rready),
        //////////////////////////////////////////////////////////////
               .m01_axi_aclk(m01_axi_aclk),
       .m01_axi_aresetn(m01_axi_aresetn),
       .m01_axi_awid(m01_axi_awid),
       .m01_axi_awaddr(m01_axi_awaddr),
        .m01_axi_awlen(m01_axi_awlen),
        .m01_axi_awsize(m01_axi_awsize),
        .m01_axi_awburst(m01_axi_awburst),
        .m01_axi_awlock(m01_axi_awlock),
        .m01_axi_awcache(m01_axi_awcache),
        .m01_axi_awprot(m01_axi_awprot),
        .m01_axi_awqos(m01_axi_awqos),
        .m01_axi_awuser(m01_axi_awuser),
        .m01_axi_awvalid(m01_axi_awvalid),
        .m01_axi_awready(m01_axi_awready),
        .m01_axi_wdata(m01_axi_wdata),
        .m01_axi_wstrb(m01_axi_wstrb),
        .m01_axi_wlast(m01_axi_wlast),
        .m01_axi_wuser(m01_axi_wuser),
        .m01_axi_wvalid(m01_axi_wvalid),
        .m01_axi_wready(m01_axi_wready),
        .m01_axi_bid(m01_axi_bid),
        .m01_axi_bresp(m01_axi_bresp),
        .m01_axi_buser(m01_axi_buser),
        .m01_axi_bvalid(m01_axi_bvalid),
        .m01_axi_bready(m01_axi_bready),
        .m01_axi_arid(m01_axi_arid),
        .m01_axi_araddr(m01_axi_araddr),
        .m01_axi_arlen(m01_axi_arlen),
        .m01_axi_arsize(m01_axi_arsize),
        .m01_axi_arburst(m01_axi_arburst),
        .m01_axi_arlock(m01_axi_arlock),
        .m01_axi_arcache(m01_axi_arcache),
        .m01_axi_arprot(m01_axi_arprot),
        .m01_axi_arqos(m01_axi_arqos),
        .m01_axi_aruser(m01_axi_aruser),
        .m01_axi_arvalid(m01_axi_arvalid),
        .m01_axi_arready(m01_axi_arready),
        .m01_axi_rid(m01_axi_rid),
        .m01_axi_rdata(m01_axi_rdata),
        .m01_axi_rresp(m01_axi_rresp),
        .m01_axi_rlast(m01_axi_rlast),
        .m01_axi_ruser(m01_axi_ruser),
        .m01_axi_rvalid(m01_axi_rvalid),
        .m01_axi_rready(m01_axi_rready),
      .peripheral_interface_error    (peripheral_interface_error),   
      .peripheral_interface_txn_done(peripheral_interface_txn_done),
      .peripheral_interface_awaddr  (peripheral_interface_awaddr),  
      .peripheral_interface_awprot  (peripheral_interface_awprot),  
      .peripheral_interface_awvalid(peripheral_interface_awvalid), 
      .peripheral_interface_awready(peripheral_interface_awready), 
      .peripheral_interface_wdata   (peripheral_interface_wdata),   
      .peripheral_interface_wstrb   (peripheral_interface_wstrb),   
      .peripheral_interface_wvalid  (peripheral_interface_wvalid),  
      .peripheral_interface_wready (peripheral_interface_wready),  
      .peripheral_interface_bresp   (peripheral_interface_bresp),   
      .peripheral_interface_bvalid  (peripheral_interface_bvalid),  
      .peripheral_interface_bready  (peripheral_interface_bready),  
      .peripheral_interface_araddr  (peripheral_interface_araddr),  
      .peripheral_interface_arprot  (peripheral_interface_arprot),  
      .peripheral_interface_arvalid (peripheral_interface_arvalid), 
      .peripheral_interface_arready (peripheral_interface_arready), 
      .peripheral_interface_rdata  (peripheral_interface_rdata),   
      .peripheral_interface_rresp   (peripheral_interface_rresp),   
      .peripheral_interface_rvalid  (peripheral_interface_rvalid),  
      .peripheral_interface_rready  (peripheral_interface_rready),
      .char(char),
      .char_write(char_write)

    );
         
    // always@(posedge CLK) begin
    //     if(char_write)
    //         $write("%c",char); 
    // end

    
  
   
   
      
   
    initial begin
        CLK  = 0;
        RSTN = 0;
        #20;
        RSTN = 1;
        

 
    end


    always begin
        #5;
        CLK = !CLK;
    end
    myip_v1_0_S00_AXI # ( 
        .C_S_AXI_ID_WIDTH   (C_S00_AXI_ID_WIDTH),
        .C_S_AXI_DATA_WIDTH (C_S00_AXI_DATA_WIDTH),
        .C_S_AXI_ADDR_WIDTH (C_S00_AXI_ADDR_WIDTH),
        .C_S_AXI_AWUSER_WIDTH(C_S00_AXI_AWUSER_WIDTH),
        .C_S_AXI_ARUSER_WIDTH(C_S00_AXI_ARUSER_WIDTH),
        .C_S_AXI_WUSER_WIDTH(C_S00_AXI_WUSER_WIDTH),
        .C_S_AXI_RUSER_WIDTH(C_S00_AXI_RUSER_WIDTH),
        .C_S_AXI_BUSER_WIDTH(C_S00_AXI_BUSER_WIDTH)
    ) myip_v1_0_S00_AXI_inst (
        .S_AXI_ACLK(M00_AXI_ACLK),
        .S_AXI_ARESETN(M00_AXI_ARESET_OUT_N),
        .S_AXI_AWID(M00_AXI_AWID),
        .S_AXI_AWADDR(M00_AXI_AWADDR-32'h8000_0000),
        .S_AXI_AWLEN(M00_AXI_AWLEN),
        .S_AXI_AWSIZE(M00_AXI_AWSIZE),
        .S_AXI_AWBURST(M00_AXI_AWBURST),
        .S_AXI_AWLOCK(M00_AXI_AWLOCK),
        .S_AXI_AWCACHE(M00_AXI_AWCACHE),
        .S_AXI_AWPROT(M00_AXI_AWPROT),
        .S_AXI_AWQOS(M00_AXI_AWQOS),
        .S_AXI_AWREGION(M00_AXI_AWREGION),
        .S_AXI_AWUSER(M00_AXI_AWUSER),
        .S_AXI_AWVALID(M00_AXI_AWVALID),
        .S_AXI_AWREADY(M00_AXI_AWREADY),
        .S_AXI_WDATA(M00_AXI_WDATA),
        .S_AXI_WSTRB(M00_AXI_WSTRB),
        .S_AXI_WLAST(M00_AXI_WLAST),
        .S_AXI_WUSER(M00_AXI_WUSER),
        .S_AXI_WVALID(M00_AXI_WVALID),
        .S_AXI_WREADY(M00_AXI_WREADY),
        .S_AXI_BID(M00_AXI_BID),
        .S_AXI_BRESP(M00_AXI_BRESP),
        .S_AXI_BUSER(M00_AXI_BUSER),
        .S_AXI_BVALID(M00_AXI_BVALID),
        .S_AXI_BREADY(M00_AXI_BREADY),
        .S_AXI_ARID(M00_AXI_ARID),
        .S_AXI_ARADDR(M00_AXI_ARADDR-32'h8000_0000),
        .S_AXI_ARLEN(M00_AXI_ARLEN),
        .S_AXI_ARSIZE(M00_AXI_ARSIZE),
        .S_AXI_ARBURST(M00_AXI_ARBURST),
        .S_AXI_ARLOCK(M00_AXI_ARLOCK),
        .S_AXI_ARCACHE(M00_AXI_ARCACHE),
        .S_AXI_ARPROT(M00_AXI_ARPROT),
        .S_AXI_ARQOS(M00_AXI_ARQOS),
        .S_AXI_ARREGION(M00_AXI_ARREGION),
        .S_AXI_ARUSER(M00_AXI_ARUSER),
        .S_AXI_ARVALID(M00_AXI_ARVALID),
        .S_AXI_ARREADY(M00_AXI_ARREADY),
        .S_AXI_RID(M00_AXI_RID),
        .S_AXI_RDATA(M00_AXI_RDATA),
        .S_AXI_RRESP(M00_AXI_RRESP),
        .S_AXI_RLAST(M00_AXI_RLAST),
        .S_AXI_RUSER(M00_AXI_RUSER),
        .S_AXI_RVALID(M00_AXI_RVALID),
        .S_AXI_RREADY(M00_AXI_RREADY)
    );
  
    reg [7:0] byte_ram[0: (1<<26)-1][0:3];

    bit [31:0] word_ram[0: (1<<26)-1];

    always@(negedge RSTN)
    begin
        $readmemh("data_hex.txt",word_ram);
        for (int j=0; j < (1<<26); j=j+1)
        begin
            for (int i=0; i<4; i=i+1)
            begin
                byte_ram[j][i]=  word_ram[j][8*i +: 8];
            end
        end
    end
    
    myip11_v1_0_S00_AXI # ( 
            .C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
            .C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
        ) myip11_v1_0_S00_AXI_inst (
            .S_AXI_ACLK(CLK),
            .S_AXI_ARESETN(RSTN),
            .S_AXI_AWADDR(peripheral_interface_awaddr),
            .S_AXI_AWPROT(peripheral_interface_awprot),
            .S_AXI_AWVALID(peripheral_interface_awvalid),
            .S_AXI_AWREADY(peripheral_interface_awready),
            .S_AXI_WDATA(peripheral_interface_wdata),
            .S_AXI_WSTRB(peripheral_interface_wstrb),
            .S_AXI_WVALID(peripheral_interface_wvalid),
            .S_AXI_WREADY(peripheral_interface_wready),
            .S_AXI_BRESP(peripheral_interface_bresp),
            .S_AXI_BVALID(peripheral_interface_bvalid),
            .S_AXI_BREADY(peripheral_interface_bready),
            .S_AXI_ARADDR(peripheral_interface_araddr),
            .S_AXI_ARPROT(peripheral_interface_arprot),
            .S_AXI_ARVALID(peripheral_interface_arvalid),
            .S_AXI_ARREADY(peripheral_interface_arready),
            .S_AXI_RDATA(peripheral_interface_rdata),
            .S_AXI_RRESP(peripheral_interface_rresp),
            .S_AXI_RVALID(peripheral_interface_rvalid),
            .S_AXI_RREADY(peripheral_interface_rready)
        );

endmodule