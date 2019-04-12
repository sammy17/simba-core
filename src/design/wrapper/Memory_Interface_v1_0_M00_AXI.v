`timescale 1 ns / 1 ps

module MEMORY_INTERFACE #
(
    // Users to add parameters here
    parameter PROCESSOR_DATA_WIDTH = 32,
    // User parameters ends
    // Do not modify the parameters beyond this line

    // Base address of targeted slave
    parameter  C_M_TARGET_SLAVE_BASE_ADDR   = 32'h00000000,
    // Burst Length. Supports 1, 2, 4, 8, 16, 32, 64, 128, 256 burst lengths
    parameter integer C_M_AXI_BURST_LEN = 4,
    // Thread ID Width
    parameter integer C_M_AXI_ID_WIDTH  = 1,
    // Width of Address Bus
    parameter integer C_M_AXI_ADDR_WIDTH    = 32,
    // Width of Data Bus
    parameter integer C_M_AXI_DATA_WIDTH    = 32,
    // Width of User Write Address Bus
    parameter integer C_M_AXI_AWUSER_WIDTH  = 0,
    // Width of User Read Address Bus
    parameter integer C_M_AXI_ARUSER_WIDTH  = 0,
    // Width of User Write Data Bus
    parameter integer C_M_AXI_WUSER_WIDTH   = 0,
    // Width of User Read Data Bus
    parameter integer C_M_AXI_RUSER_WIDTH   = 0,
    // Width of User Response Bus
    parameter integer C_M_AXI_BUSER_WIDTH   = 0
)
(
    // Users to add ports here
    input [C_M_AXI_ADDR_WIDTH - 3 : 0] dout_ra,
    input valid_ra,        
    output ready_ra,
    
    input [C_M_AXI_ADDR_WIDTH - 3 : 0] dout_wa,
    input valid_wc,        
    output ready_wc,
    
    input [C_M_AXI_DATA_WIDTH - 1 : 0] dout_wd,
            
    output [C_M_AXI_DATA_WIDTH - 1 : 0] din_rd,
    input ready_rd,        
    output valid_rd,
    output ack,
    
    // User ports ends
    // Do not modify the ports beyond this line

    // Initiate AXI transactions
    input wire  INIT_AXI_TXN,
    // Asserts when transaction is complete
    output wire  TXN_DONE,
    // Asserts when ERROR is detected
    output wire  ERROR,
    // Global Clock Signal.
    input wire  M_AXI_ACLK,
    // Global Reset Singal. This Signal is Active Low
    input wire  M_AXI_ARESETN,
    // Master Interface Write Address ID
    output wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_AWID,
    // Master Interface Write Address
    output wire [C_M_AXI_ADDR_WIDTH-1 : 0] M_AXI_AWADDR,
    // Burst length. The burst length gives the exact number of transfers in a burst
    output wire [7 : 0] M_AXI_AWLEN,
    // Burst size. This signal indicates the size of each transfer in the burst
    output wire [2 : 0] M_AXI_AWSIZE,
    // Burst type. The burst type and the size information, 
// determine how the address for each transfer within the burst is calculated.
    output wire [1 : 0] M_AXI_AWBURST,
    // Lock type. Provides additional information about the
// atomic characteristics of the transfer.
    output wire  M_AXI_AWLOCK,
    // Memory type. This signal indicates how transactions
// are required to progress through a system.
    output wire [3 : 0] M_AXI_AWCACHE,
    // Protection type. This signal indicates the privilege
// and security level of the transaction, and whether
// the transaction is a data access or an instruction access.
    output wire [2 : 0] M_AXI_AWPROT,
    // Quality of Service, QoS identifier sent for each write transaction.
    output wire [3 : 0] M_AXI_AWQOS,
    // Optional User-defined signal in the write address channel.
    output wire [C_M_AXI_AWUSER_WIDTH-1 : 0] M_AXI_AWUSER,
    // Write address valid. This signal indicates that
// the channel is signaling valid write address and control information.
   (* mark_debug *) output wire  M_AXI_AWVALID,
    // Write address ready. This signal indicates that
// the slave is ready to accept an address and associated control signals
   (* mark_debug *) input wire  M_AXI_AWREADY,
    // Master Interface Write Data.
    output wire [C_M_AXI_DATA_WIDTH-1 : 0] M_AXI_WDATA,
    // Write strobes. This signal indicates which byte
// lanes hold valid data. There is one write strobe
// bit for each eight bits of the write data bus.
    output wire [C_M_AXI_DATA_WIDTH/8-1 : 0] M_AXI_WSTRB,
    // Write last. This signal indicates the last transfer in a write burst.
    output wire  M_AXI_WLAST,
    // Optional User-defined signal in the write data channel.
    output wire [C_M_AXI_WUSER_WIDTH-1 : 0] M_AXI_WUSER,
    // Write valid. This signal indicates that valid write
// data and strobes are available
    (* mark_debug *) output wire  M_AXI_WVALID,
    // Write ready. This signal indicates that the slave
// can accept the write data.
    (* mark_debug *) input wire  M_AXI_WREADY,
    // Master Interface Write Response.
    input wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_BID,
    // Write response. This signal indicates the status of the write transaction.
    input wire [1 : 0] M_AXI_BRESP,
    // Optional User-defined signal in the write response channel
    input wire [C_M_AXI_BUSER_WIDTH-1 : 0] M_AXI_BUSER,
    // Write response valid. This signal indicates that the
// channel is signaling a valid write response.
    input wire  M_AXI_BVALID,
    // Response ready. This signal indicates that the master
// can accept a write response.
    output wire  M_AXI_BREADY,
    // Master Interface Read Address.
    output wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_ARID,
    // Read address. This signal indicates the initial
// address of a read burst transaction.
    output wire [C_M_AXI_ADDR_WIDTH-1 : 0] M_AXI_ARADDR,
    // Burst length. The burst length gives the exact number of transfers in a burst
    output wire [7 : 0] M_AXI_ARLEN,
    // Burst size. This signal indicates the size of each transfer in the burst
    output wire [2 : 0] M_AXI_ARSIZE,
    // Burst type. The burst type and the size information, 
// determine how the address for each transfer within the burst is calculated.
    output wire [1 : 0] M_AXI_ARBURST,
    // Lock type. Provides additional information about the
// atomic characteristics of the transfer.
    output wire  M_AXI_ARLOCK,
    // Memory type. This signal indicates how transactions
// are required to progress through a system.
    output wire [3 : 0] M_AXI_ARCACHE,
    // Protection type. This signal indicates the privilege
// and security level of the transaction, and whether
// the transaction is a data access or an instruction access.
    output wire [2 : 0] M_AXI_ARPROT,
    // Quality of Service, QoS identifier sent for each read transaction
    output wire [3 : 0] M_AXI_ARQOS,
    // Optional User-defined signal in the read address channel.
    output wire [C_M_AXI_ARUSER_WIDTH-1 : 0] M_AXI_ARUSER,
    // Write address valid. This signal indicates that
// the channel is signaling valid read address and control information
    output wire  M_AXI_ARVALID,
    // Read address ready. This signal indicates that
// the slave is ready to accept an address and associated control signals
   (* mark_debug *) input wire  M_AXI_ARREADY,
    // Read ID tag. This signal is the identification tag
// for the read data group of signals generated by the slave.
    input wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_RID,
    // Master Read Data
    input wire [C_M_AXI_DATA_WIDTH-1 : 0] M_AXI_RDATA,
    // Read response. This signal indicates the status of the read transfer
    input wire [1 : 0] M_AXI_RRESP,
    // Read last. This signal indicates the last transfer in a read burst
    (* mark_debug *) input wire  M_AXI_RLAST,
    // Optional User-defined signal in the read address channel.
    input wire [C_M_AXI_RUSER_WIDTH-1 : 0] M_AXI_RUSER,
    // Read valid. This signal indicates that the channel
// is signaling the required read data.
    input wire  M_AXI_RVALID,
    // Read ready. This signal indicates that the master can
// accept the read data and response information.
    output wire  M_AXI_RREADY
);


    // function called clogb2 that returns an integer which has the
    //value of the ceiling of the log base 2
      function integer clogb2 (input integer bit_depth);              
      begin                                                           
        for(clogb2=0; bit_depth>0; clogb2=clogb2+1)                   
          bit_depth = bit_depth >> 1;                                 
        end                                                           
      endfunction                                                     
    
    // C_TRANSACTIONS_NUM is the width of the index counter for 
    // number of write or read transaction.
     localparam integer C_TRANSACTIONS_NUM  = clogb2(C_M_AXI_BURST_LEN-1);
    
    // Burst length for transactions, in C_M_AXI_DATA_WIDTHs.
    // Non-2^n lengths will eventually cause bursts across 4K address boundaries.
     localparam integer C_MASTER_LENGTH     = 12;
    // total number of burst transfers is master length divided by burst length and burst size
     localparam integer C_NO_BURSTS_REQ     = C_MASTER_LENGTH-clogb2((C_M_AXI_BURST_LEN*C_M_AXI_DATA_WIDTH/8)-1);
     //address LSB widths
     localparam integer ADDR_NULL_BIT_WIDTH         = clogb2(C_M_AXI_DATA_WIDTH/PROCESSOR_DATA_WIDTH) + clogb2(PROCESSOR_DATA_WIDTH/8)-2;
     localparam integer ADDR_LSB_WIDTH              = clogb2(C_M_AXI_DATA_WIDTH/PROCESSOR_DATA_WIDTH)-1;
     localparam integer ADDR_NULL_BIT_WIDTH_ARADDR  = clogb2(C_M_AXI_DATA_WIDTH/PROCESSOR_DATA_WIDTH) + clogb2(PROCESSOR_DATA_WIDTH/8)-1;
    
    // AXI4LITE signals
    //AXI4 internal temp signals
    (* mark_debug *) reg [C_M_AXI_ADDR_WIDTH-1 : 0]  axi_awaddr          = {C_M_AXI_ADDR_WIDTH{1'b0}};
    (* mark_debug *) reg [C_M_AXI_DATA_WIDTH-1 : 0]  dout_wd_buffer      = {C_M_AXI_DATA_WIDTH{1'b0}};
    (* mark_debug *) reg                            axi_awvalid         = 0;
    reg [C_M_AXI_DATA_WIDTH-1 : 0]  axi_wdata           = {C_M_AXI_DATA_WIDTH{1'b0}};
    (* mark_debug *) reg                            axi_wlast           = 0;
    (* mark_debug *) reg                            axi_wvalid          = 0;
    reg                             axi_bready          = 0;
    (* mark_debug *) reg [C_M_AXI_ADDR_WIDTH-1 : 0]     axi_araddr          = {C_M_AXI_DATA_WIDTH{1'b0}};
    reg                             axi_arvalid         = 0;
    (* mark_debug *) reg                            axi_rready          = 0;
    reg [7 : 0]                     write_index         = 0;        //write beat count in a burst
    reg [C_TRANSACTIONS_NUM : 0]    read_index          = 0;        //read beat count in a burst
    wire [C_TRANSACTIONS_NUM+2 : 0] burst_size_bytes;
    reg                             error_reg           = 0;
    //Interface response error flags
    wire                            write_resp_error;
    (* mark_debug *) wire                           read_resp_error;
    wire                            init_txn_pulse  =!init_axi_txn;
    (* mark_debug *) wire                            valid_wd;
    (* mark_debug *) wire                            valid_wa;
    (* mark_debug *) reg                             ready_wa                = 0;
    (* mark_debug *) reg                             ready_wd                = 0;
    (* mark_debug *) reg                             transaction_done        = 1;
    (* mark_debug *) reg                             transaction_done_read   = 1;
    (* mark_debug *) reg                             addr_transaction_done   = 0;
    
    // I/O Connections assignments
    //I/O Connections. Write Address (AW)
    assign M_AXI_AWID       = 'b0;
    //The AXI address is a concatenation of the target base address + active offset range
    assign M_AXI_AWADDR     = axi_awaddr+C_M_TARGET_SLAVE_BASE_ADDR;
    //Burst LENgth is number of transaction beats, minus 1
    assign M_AXI_AWLEN      = C_M_AXI_BURST_LEN - 1;
    //Size should be C_M_AXI_DATA_WIDTH, in 2^SIZE bytes, otherwise narrow bursts are used
    //*****cannot change burst size(M_AXI_AWSIZE). If burst size to be more than the bus width, then some places in code must be changed ****// 
    assign M_AXI_AWSIZE     = clogb2((C_M_AXI_DATA_WIDTH/8)-1);
    //INCR burst type is usually used, except for keyhole bursts
    assign M_AXI_AWBURST    = 2'b01;
    assign M_AXI_AWLOCK     = 1'b0;
    //Update value to 4'b0011 if coherent accesses to be used via the Zynq ACP port. Not Allocated, Modifiable, not Bufferable. Not Bufferable since this example is meant to test memory, not intermediate cache. 
    assign M_AXI_AWCACHE    = 4'b0011;
    assign M_AXI_AWPROT     = 3'h0;
    assign M_AXI_AWQOS      = 4'h0;
    assign M_AXI_AWUSER     = 'b1;
    assign M_AXI_AWVALID    = axi_awvalid;
    //Write Data(W)
    assign M_AXI_WDATA      = buffer_reg_dat[write_index];
    //All bursts are complete and aligned in this example
    assign M_AXI_WSTRB      = {(C_M_AXI_DATA_WIDTH/8){1'b1}};
    assign M_AXI_WLAST      = axi_wlast;
    assign M_AXI_WUSER      = 'b0;
    assign M_AXI_WVALID     = axi_wvalid;
    //Write Response (B)
    assign M_AXI_BREADY     = axi_bready;
    //Read Address (AR)
    assign M_AXI_ARID       = 'b0;
    assign M_AXI_ARADDR     = axi_araddr+C_M_TARGET_SLAVE_BASE_ADDR;
    //Burst LENgth is number of transaction beats, minus 1
    assign M_AXI_ARLEN      = C_M_AXI_BURST_LEN - 1;
    //Size should be C_M_AXI_DATA_WIDTH, in 2^n bytes, otherwise narrow bursts are used
    assign M_AXI_ARSIZE     = clogb2((C_M_AXI_DATA_WIDTH/8)-1);
    //INCR burst type is usually used, except for keyhole bursts
    assign M_AXI_ARBURST    = 2'b10;
    assign M_AXI_ARLOCK     = 1'b0;
    //Update value to 4'b0011 if coherent accesses to be used via the Zynq ACP port. Not Allocated, Modifiable, not Bufferable. Not Bufferable since this example is meant to test memory, not intermediate cache. 
    assign M_AXI_ARCACHE    = 4'b0011;
    assign M_AXI_ARPROT     = 3'h0;
    assign M_AXI_ARQOS      = 4'h0;
    assign M_AXI_ARUSER     = 'b1;
    (* mark_debug *) assign M_AXI_ARVALID   = axi_arvalid;
    //Read and Read Response (R)
    //
    //assign M_AXI_RREADY       = axi_rready;
    //Example design I/O
    assign TXN_DONE         = 1'b0;//compare_done;
    assign ERROR            = error_reg;
    //Burst size in bytes
    assign burst_size_bytes = C_M_AXI_BURST_LEN * C_M_AXI_DATA_WIDTH/8;
    assign init_axi_txn     = INIT_AXI_TXN; 
    
    //assign din_rd           = M_AXI_RDATA;
   reg ready_reg                            =                   1'b1;
    //assign ready_wc         = (addr_transaction_done && ready_wd) || (~addr_transaction_done && ready_wa);
    assign ready_wc         = valid_wc & ready_reg; 
    //assign valid_wd         = addr_transaction_done && valid_wc;
    //assign valid_wa         = ~addr_transaction_done && valid_wc;
     localparam sections    = C_M_AXI_BURST_LEN-1;

    assign ack              = start_single_burst_write;//M_AXI_BREADY && M_AXI_BVALID;
    reg  [1:0] curr_section     =       0;

    reg [127:0] buffer_reg  [0:sections]     ;
    assign din_rd           = buffer_reg [curr_section] ;
    reg  [1:0] section_counter =        0;
    reg    valid_reg            =       0;
    assign valid_rd         = valid_reg;//M_AXI_RREADY && M_AXI_RVALID; 
    
    reg  [1:0] curr_section_wr              =                0;
    reg  [1:0] section_counter_wr           =                0;
    reg  start_single_burst_write          = 1'b0;

    reg [127:0] buffer_reg_dat  [0:sections]     ;
    reg [31:0] address_reg=0;
    reg write_begins        =0;
    always @(posedge M_AXI_ACLK)                                   
     begin                                                                                                                                  
        if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1 )                                           
        begin                                                            
            ready_reg                   <= 1'b1;
            start_single_burst_write    <= 1'b0;
            write_begins                <= 1'b0;
        end   
        else if (valid_wc & ready_reg)
        begin
            section_counter_wr                  <= section_counter_wr +1;
            buffer_reg_dat[section_counter_wr]  <= dout_wd;
            start_single_burst_write            <= (section_counter_wr==2'd2);
            ready_reg                           <= section_counter_wr !=2'd3;
            axi_awaddr                          <= {dout_wa,2'b00};
            write_begins                        <=1'b1;

        end
        else if (M_AXI_BREADY & M_AXI_BVALID)
        begin
            write_begins                        <= 1'b0;
            ready_reg                           <= 1'b1;
        end

    end

  always @(posedge M_AXI_ACLK)                                   
      begin                                                                
                                                                           
        if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1 )                                           
          begin                                                            
            axi_awvalid <= 1'b0;                                           
          end                                                              
        // If previously not valid , start next transaction                
        else if (~axi_awvalid && start_single_burst_write)                 
          begin                                                            
            axi_awvalid <= 1'b1;                                           
          end                                                              
        /* Once asserted, VALIDs cannot be deasserted, so axi_awvalid      
        must wait until transaction is accepted */                         
        else if (M_AXI_AWREADY && axi_awvalid)                             
          begin                                                            
            axi_awvalid <= 1'b0;                                           
          end                                                              
        else                                                               
          axi_awvalid <= axi_awvalid;                                      
        end                                                                
                                                                           
                                                                           
    // Next address after AWREADY indicates previous address acceptance    
      // always @(posedge M_AXI_ACLK)                                         
      // begin                                                                
      //   if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1)                                            
      //     begin                                                            
      //       axi_awaddr <= 'b0;                                             
      //     end                                                              
      //   else if (~M_AXI_AWREADY && axi_awvalid)                             
      //     begin                                                            
      //       axi_awaddr <= address_reg;                   
      //     end                                                              
      //   else                                                               
      //     axi_awaddr <= axi_awaddr;                                        
      //   end                                                                


    //--------------------
    //Write Data Channel
    //--------------------

    //The write data will continually try to push write data across the interface.

    //The amount of data accepted will depend on the AXI slave and the AXI
    //Interconnect settings, such as if there are FIFOs enabled in interconnect.

    //Note that there is no explicit timing relationship to the write address channel.
    //The write channel has its own throttling flag, separate from the AW channel.

    //Synchronization between the channels must be determined by the user.

    //The simpliest but lowest performance would be to only issue one address write
    //and write data burst at a time.

    //In this example they are kept in sync by using the same address increment
    //and burst sizes. Then the AW and W channels have their transactions measured
    //with threshold counters as part of the user logic, to make sure neither 
    //channel gets too far ahead of each other.

    //Forward movement occurs when the write channel is valid and ready

      assign wnext = M_AXI_WREADY & axi_wvalid;                                   
                                                                                        
    // WVALID logic, similar to the axi_awvalid always block above                      
      always @(posedge M_AXI_ACLK)                                                      
      begin                                                                             
        if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1 )                                                        
          begin                                                                         
            axi_wvalid <= 1'b0;                                                         
          end                                                                           
        // If previously not valid, start next transaction                              
        else if (~axi_wvalid && start_single_burst_write)                               
          begin                                                                         
            axi_wvalid <= 1'b1;                                                         
          end                                                                           
        /* If WREADY and too many writes, throttle WVALID                               
        Once asserted, VALIDs cannot be deasserted, so WVALID                           
        must wait until burst is complete with WLAST */                                 
        else if (wnext && axi_wlast)                                                    
          axi_wvalid <= 1'b0;                                                           
        else                                                                            
          axi_wvalid <= axi_wvalid;                                                     
      end                                                                               
                                                                                        
                                                                                        
    //WLAST generation on the MSB of a counter underflow                                
    // WVALID logic, similar to the axi_awvalid always block above                      
      always @(posedge M_AXI_ACLK)                                                      
      begin                                                                             
        if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1 )                                                        
          begin                                                                         
            axi_wlast <= 1'b0;                                                          
          end                                                                           
        // axi_wlast is asserted when the write index                                   
        // count reaches the penultimate count to synchronize                           
        // with the last write data when write_index is b1111                           
        // else if (&(write_index[C_TRANSACTIONS_NUM-1:1])&& ~write_index[0] && wnext)  
        else if (((write_index == C_M_AXI_BURST_LEN-2 && C_M_AXI_BURST_LEN >= 2) && wnext) || (C_M_AXI_BURST_LEN == 1 ))
          begin                                                                         
            axi_wlast <= 1'b1;                                                          
          end                                                                           
        // Deassrt axi_wlast when the last write data has been                          
        // accepted by the slave with a valid response                                  
        else if (wnext)                                                                 
          axi_wlast <= 1'b0;                                                            
        else if (axi_wlast && C_M_AXI_BURST_LEN == 1)                                   
          axi_wlast <= 1'b0;                                                            
        else                                                                            
          axi_wlast <= axi_wlast;                                                       
      end                                                                               
                                                                                        
                                                                                        
    /* Burst length counter. Uses extra counter register bit to indicate terminal       
     count to reduce decode logic */                                                    
      always @(posedge M_AXI_ACLK)                                                      
      begin                                                                             
        if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1 || start_single_burst_write == 1'b1)    
          begin                                                                         
            write_index <= 0;                                                           
          end                                                                           
        else if (wnext && (write_index != C_M_AXI_BURST_LEN-1))                         
          begin                                                                         
            write_index <= write_index + 1;                                             
          end                                                                           
        else                                                                            
          write_index <= write_index;                                                   
      end                                                                               
                                                                                        
                                                                                        
    /* Write Data Generator                                                             
     // Data pattern is only a simple incrementing count from 0 for each burst  */         
     //  always @(posedge M_AXI_ACLK)                                                      
     //  begin                                                                             
     //    if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1)                                                         
     //      axi_wdata <= 'b1;                                                             
     //    //else if (wnext && axi_wlast)                                                  
     //    //  axi_wdata <= 'b0;                                                           
     //    else if (wnext)                                                                 
                                                         
     //    else                                                                            
     //      axi_wdata <= axi_wdata;                                                       
     //    end                                                                             


    //----------------------------
    //Write Response (B) Channel
    //----------------------------

    //The write response channel provides feedback that the write has committed
    //to memory. BREADY will occur when all of the data and the write address
    //has arrived and been accepted by the slave.

    //The write issuance (number of outstanding write addresses) is started by 
    //the Address Write transfer, and is completed by a BREADY/BRESP.

    //While negating BREADY will eventually throttle the AWREADY signal, 
    //it is best not to throttle the whole data channel this way.

    //The BRESP bit [1] is used indicate any errors from the interconnect or
    //slave for the entire write burst. This example will capture the error 
    //into the ERROR output. 

      always @(posedge M_AXI_ACLK)                                     
      begin                                                                 
        if (M_AXI_ARESETN == 0 || init_txn_pulse == 1'b1 )                                            
          begin                                                             
            axi_bready <= 1'b0;                                             
          end                                                               
        // accept/acknowledge bresp with axi_bready by the master           
        // when M_AXI_BVALID is asserted by slave                           
        else if (M_AXI_BVALID && ~axi_bready)                               
          begin                                                             
            axi_bready <= 1'b1;                                             
          end                                                               
        // deassert after one clock cycle                                   
        else if (axi_bready)                                                
          begin                                                             
            axi_bready <= 1'b0;                                             
          end                                                               
        // retain the previous value                                        
        else                                                                
          axi_bready <= axi_bready;                                         
      end                                                                   
                                                                            
                                                                            
    //Flag any write response errors                                        
      assign write_resp_error = axi_bready & M_AXI_BVALID & M_AXI_BRESP[1]; 


//----------------------------
//Read Address Channel
//----------------------------

//The Read Address Channel (AW) provides a similar function to the
//Write Address channel- to provide the tranfer qualifiers for the burst.
// localparam delay= 10;
 // ready_ra circuit;
 (* mark_debug *) reg ready_ra_reg = 1;
 reg [3:0] delay_reg =0;
 assign ready_ra = ready_ra_reg;
 
  always @(posedge M_AXI_ACLK) begin                                                                 
     if (M_AXI_ARESETN == 0 || init_axi_txn == 0) begin                                                             
        ready_ra_reg <= 1'b0;                                             
     end
     else if(~ready_ra_reg && valid_ra && transaction_done_read  & !valid_reg/*& !write_begins & !valid_wc*/ ) begin
             // delay_reg  <= delay_reg+1;
             ready_ra_reg <=1;
          end
     else if(ready_ra && valid_ra) begin
        ready_ra_reg <= 1'b0;
        delay_reg <=0;
     end
     
     else begin
        ready_ra_reg <= ready_ra_reg;
     end
  end


  always @(posedge M_AXI_ACLK) begin                                                                                                                             
    if (M_AXI_ARESETN == 0 || init_axi_txn == 0)                                         
      begin                                                          
        axi_arvalid <= 1'b0;                                         
      end                                                            
    // If previously not valid , start next transaction              
    else if (ready_ra && valid_ra)                
      begin                                                          
        axi_arvalid <= 1'b1;                                         
      end                                                            
    else if (M_AXI_ARREADY && axi_arvalid)                           
      begin                                                          
        axi_arvalid <= 1'b0;                                         
      end                                                            
    else                                                             
      axi_arvalid <= axi_arvalid;                                    
  end                                                                
                                                                                                                                     
  // Next address after ARREADY indicates previous address acceptance  
  always @(posedge M_AXI_ACLK)                                       
  begin                                                              
    if (M_AXI_ARESETN == 0 || init_axi_txn == 0)                                          
      begin                                                          
        axi_araddr <= 0;                                           
      end                                                            
    else if (~ready_ra_reg && valid_ra && transaction_done_read)                           
      begin
        //axi_araddr <= {dout_ra[29:0],{2{1'b0}}};                                                       
        //axi_araddr <= {dout_ra[C_M_AXI_ADDR_WIDTH-3-:(C_M_AXI_ADDR_WIDTH-2-ADDR_LSB_WIDTH)],{ADDR_NULL_BIT_WIDTH{1'b0}}};
        if (1)
        begin      
         axi_araddr <= {dout_ra[29:3],5'b0000};      
        end       
      end                          //                                  
    else                                                             
      axi_araddr <= axi_araddr;                                      
  end                                                              


//--------------------------------
//Read Data (and Response) Channel
//--------------------------------

 /*The Read Data channel returns the results of the read request                              
 In this example the data checker is always able to accept              
 more data, so no need to throttle the RREADY signal*/ 
 reg [3:0] delay_counter=0;
 assign M_AXI_RREADY          = M_AXI_RVALID;

                                                        
 always @(posedge M_AXI_ACLK)                                          
 begin                                                                 
   if (M_AXI_ARESETN == 0 || init_axi_txn == 0)                  
     begin                                                             
       valid_reg        <= 1'b0;      
       section_counter      <= 1'b0;    
       curr_section    <=1'b0;                             
     end                                                               
   // accept/acknowledge rdata/rresp with axi_rready by the master     
   // when M_AXI_RVALID is asserted by slave                           
   else if (M_AXI_RVALID )                       
     begin                                      
        section_counter  <= section_counter + 1;
        buffer_reg  [section_counter]   <= M_AXI_RDATA  ;     
        valid_reg <= section_counter==2'b11;              
     end    
     else if (valid_reg & ready_rd)           
     begin
        curr_section     <= curr_section + 1;
        valid_reg        <= curr_section !=2'b11;                       
     end                         
   // retain the previous value                 
 end                                            
                                                                        
//Flag any read response errors                                         
  assign read_resp_error = axi_rready & M_AXI_RVALID & M_AXI_RRESP[1];  


  always @(posedge M_AXI_ACLK)                                 
  begin                                                              
    if (M_AXI_ARESETN == 0 || init_axi_txn == 0)                                          
      begin                                                          
        error_reg <= 1'b0;                                           
      end                                                            
    else if (write_resp_error || read_resp_error)   
      begin                                                          
        error_reg <= 1'b1;                                           
      end                                                            
    else                                                             
      error_reg <= error_reg;                                        
  end                                                                

  // transaction_done_read
  always @(posedge M_AXI_ACLK)                                     
  begin                                                                 
    if (M_AXI_ARESETN == 0 || init_axi_txn == 0)                                            
    begin                                                             
        transaction_done_read <= 1'b1;                                             
    end                                                               
   // accept/acknowledge bresp with axif_bready by the master           
   // when M_AXI_BVALID is asserted by slave                           
   else if (M_AXI_RVALID && M_AXI_RREADY && M_AXI_RLAST)                               
     begin                                                             
       transaction_done_read <= 1'b1;                                             
     end                                                               
   // deassert after one clock cycle                                   
   else if (valid_ra && !valid_reg && transaction_done_read  /*& !write_begins & !valid_wc*/)                                                
     begin                                                             
       transaction_done_read <= 1'b0;                                            
     end                                                               
   // retain the previous value                                        
   else                                                                
     transaction_done_read <= transaction_done_read;                                         
 end                                                                   
      
endmodule