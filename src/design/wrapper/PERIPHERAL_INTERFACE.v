`timescale 1 ns / 1 ps
    
module PERIPHERAL_INTERFACE #
    (
    // Users to add parameters here
    
    // User parameters ends
    // Do not modify the parameters beyond this line
    // The master requires a target slave base address.
    parameter  C_M_TARGET_SLAVE_BASE_ADDR	= 32'h00000000,
    // Width of M_AXI address bus. 
    // The master generates the read and write addresses of width specified as C_M_AXI_ADDR_WIDTH.
    parameter integer C_M_AXI_ADDR_WIDTH	= 32,
    // Width of M_AXI data bus. 
    // The master issues write data and accept read data where the width of the data bus is C_M_AXI_DATA_WIDTH
    parameter integer C_M_AXI_DATA_WIDTH	= 32
    )
    (
    // Users to add ports here
    input   [31:0]      dout_wa,
    input               valid_wa,
    output reg          ready_wa,

    input   [31:0]      dout_wd,
    
    input   [31:0]      dout_ra,
    input               valid_ra,
    output              ready_ra,
    
    output  [31:0]      dout,
    output              valid_rd,
    input               ready_rd,
    
    
    output              ack,

    // Users to add ports here

    // User ports ends
    // Do not modify the ports beyond this line

    // Initiate AXI transactions
    input wire  INIT_AXI_TXN,
    // Asserts when ERROR is detected
    output reg  ERROR,
    // Asserts when AXI transactions is complete
    output wire  TXN_DONE,
    // AXI clock signal
    input wire  M_AXI_ACLK,
    // AXI active low reset signal
    input wire  M_AXI_ARESETN,
    // Master Interface Write Address Channel ports. Write address (issued by master)
    output wire [C_M_AXI_ADDR_WIDTH-1 : 0] M_AXI_AWADDR,
    // Write channel Protection type.
    // This signal indicates the privilege and security level of the transaction,
    // and whether the transaction is a data access or an instruction access.
    output wire [2 : 0] M_AXI_AWPROT,
    // Write address valid. 
    // This signal indicates that the master signaling valid write address and control information.
    output wire  M_AXI_AWVALID,
    // Write address ready. 
    // This signal indicates that the slave is ready to accept an address and associated control signals.
    input wire  M_AXI_AWREADY,
    // Master Interface Write Data Channel ports. Write data (issued by master)
    output wire [C_M_AXI_DATA_WIDTH-1 : 0] M_AXI_WDATA,
    // Write strobes. 
    // This signal indicates which byte lanes hold valid data.
    // There is one write strobe bit for each eight bits of the write data bus.
    output wire [/*C_M_AXI_DATA_WIDTH/8-1 */3: 0] M_AXI_WSTRB,
    // Write valid. This signal indicates that valid write data and strobes are available.
    output wire  M_AXI_WVALID,
    // Write ready. This signal indicates that the slave can accept the write data.
    input wire  M_AXI_WREADY,
    // Master Interface Write Response Channel ports. 
    // This signal indicates the status of the write transaction.
    input wire [1 : 0] M_AXI_BRESP,
    // Write response valid. 
    // This signal indicates that the channel is signaling a valid write response
    input wire  M_AXI_BVALID,
    // Response ready. This signal indicates that the master can accept a write response.
    output wire  M_AXI_BREADY,
    // Master Interface Read Address Channel ports. Read address (issued by master)
    output wire [C_M_AXI_ADDR_WIDTH-1 : 0] M_AXI_ARADDR,
    // Protection type. 
    // This signal indicates the privilege and security level of the transaction, 
    // and whether the transaction is a data access or an instruction access.
    output wire [2 : 0] M_AXI_ARPROT,
    // Read address valid. 
    // This signal indicates that the channel is signaling valid read address and control information.
    output wire  M_AXI_ARVALID,
    // Read address ready. 
    // This signal indicates that the slave is ready to accept an address and associated control signals.
    input wire  M_AXI_ARREADY,
    // Master Interface Read Data Channel ports. Read data (issued by slave)
    input wire [C_M_AXI_DATA_WIDTH-1 : 0] M_AXI_RDATA,
    // Read response. This signal indicates the status of the read transfer.
    input wire [1 : 0] M_AXI_RRESP,
    // Read valid. This signal indicates that the channel is signaling the required read data.
    input wire  M_AXI_RVALID,
    // Read ready. This signal indicates that the master can accept the read data and response information.
    output wire  M_AXI_RREADY,
    
    input   [3:0]       wstrb
    );

    // function called clogb2 that returns an integer which has the
    // value of the ceiling of the log base 2

     function integer clogb2 (input integer bit_depth);
         begin
         for(clogb2=0; bit_depth>0; clogb2=clogb2+1)
             bit_depth = bit_depth >> 1;
         end
     endfunction

    // AXI4LITE signals
    //write address valid
    reg      axi_awvalid;
    //write data valid
    reg      axi_wvalid;
    //read address valid
    reg      axi_arvalid;
    //read data acceptance
    reg      axi_rready;
    //write response acceptance
    reg      axi_bready;
    //write address
    reg [C_M_AXI_ADDR_WIDTH-1 : 0]     axi_awaddr;
    //write data
    reg [C_M_AXI_DATA_WIDTH-1 : 0]     axi_wdata;
    //read addresss
    reg [C_M_AXI_ADDR_WIDTH-1 : 0]     axi_araddr;
    //Asserts when there is a write response error
    wire      write_resp_error;
    //Asserts when there is a read response error
    wire      read_resp_error;
    //The error register is asserted when any of the write response error, read response error or the data mismatch flags are asserted.
    reg      error_reg;
    
    wire      init_axi_txn;

    reg                             ready_wd                = 0;
    //reg                             ready_wa                = 0;
    reg                             valid_wd                = 0;
    reg                             addr_transaction_done   = 0;
    reg                             transaction_done        = 1;
    reg                             transaction_done_read   = 1;
    reg         [3:0]               axi_wstrb;

    // I/O Connections assignments

    //Adding the offset address to the base addr of the slave
    assign M_AXI_AWADDR    = C_M_TARGET_SLAVE_BASE_ADDR + axi_awaddr;
    //AXI 4 write data
    assign M_AXI_WDATA    = axi_wdata;
    assign M_AXI_AWPROT    = 3'b000;
    assign M_AXI_AWVALID    = axi_awvalid;
    //Write Data(W)
    assign M_AXI_WVALID    = axi_wvalid;
    //Set all byte strobes in this example
    assign M_AXI_WSTRB    = axi_wstrb;
    //Write Response (B)
    assign M_AXI_BREADY    = axi_bready;
    //Read Address (AR)
    assign M_AXI_ARADDR    = axi_araddr;
    assign M_AXI_ARVALID    = axi_arvalid;
    assign M_AXI_ARPROT    = 3'b001;
    //Read and Read Response (R)
    assign M_AXI_RREADY    = axi_rready;
    
    assign init_axi_txn    = INIT_AXI_TXN;
    
    assign valid_rd         = M_AXI_RREADY && M_AXI_RVALID;
    //assign ready_wc         = (addr_transaction_done && ready_wd) || (~addr_transaction_done && ready_wa);
    //assign valid_wd         = addr_transaction_done && valid_wc;
    //assign valid_wa         = ~addr_transaction_done && valid_wc;
    
    assign dout             = M_AXI_RDATA;
    
    //assign ack              = (transaction_done) || (transaction_done_read);
    assign ack              = (M_AXI_RVALID && axi_rready) || (M_AXI_BREADY && M_AXI_BVALID);

    //--------------------
    //Write Address Channel
    //--------------------

    // The purpose of the write address channel is to request the address and 
    // command information for the entire transaction.  It is a single beat
    // of information.

    // Note for this example the axi_awvalid/axi_wvalid are asserted at the same
    // time, and then each is deasserted independent from each other.
    // This is a lower-performance, but simplier control scheme.

    // AXI VALID signals must be held active until accepted by the partner.

    // A data transfer is accepted by the slave when a master has
    // VALID data and the slave acknoledges it is also READY. While the master
    // is allowed to generated multiple, back-to-back requests by not 
    // deasserting VALID, this design will add rest cycle for
    // simplicity.

    // Since only one outstanding transaction is issued by the user design,
    // there will not be a collision between a new request and an accepted
    // request on the same clock cycle. 
    // ready_wa circuit
      always @(posedge M_AXI_ACLK) 
      begin                                                                 
          if (M_AXI_ARESETN == 0 || init_axi_txn == 0)                                            
          begin                                                             
             ready_wa <= 1'b0;                                             
          end
          else if(transaction_done && valid_wa)  //Changed
          begin
             ready_wa <= 1'b1;
          end
          else
          begin
             ready_wa <= 1'b0;
          end
      end
    
      always @(posedge M_AXI_ACLK)                                   
      begin                                                                                                                                  
        if (M_AXI_ARESETN == 0 || init_axi_txn == 0)                                           
        begin                                                            
            axi_awvalid <= 1'b0;                                           
        end                                                              
        else if (ready_wa && valid_wa)                 
        begin                                                            
            axi_awvalid <= 1'b1;                                           
        end                                                                                     
        else if (M_AXI_AWREADY && axi_awvalid)                             
        begin                                                            
            axi_awvalid <= 1'b0;                                           
        end
        else
        begin                                                               
          axi_awvalid <= axi_awvalid;
        end
     end 

     //Write Addresses                                        
      always @(posedge M_AXI_ACLK)                                  
      begin                                                     
        if (M_AXI_ARESETN == 0  || init_axi_txn == 1'b0)                                
          begin                                                 
            axi_awaddr <= 0;                                    
          end                                                                             
        else if (ready_wa && valid_wa)                  
          begin                                                 
            axi_awaddr <= dout_wa;                                                              
          end
      	else 
      	begin
      		axi_awaddr <= axi_awaddr;                                                   	
       	end                                                   
      end
      
    //Write Addresses                                        
      always @(posedge M_AXI_ACLK)                                  
      begin                                                     
        if (M_AXI_ARESETN == 0  || init_axi_txn == 1'b0)                                
          begin                                                 
            axi_wstrb <= 0;                                    
          end                                                                             
        else if (ready_wa && valid_wa)                  
          begin                                                 
            axi_wstrb <= wstrb;                                                              
          end
      	else 
      	begin
      		axi_wstrb <= axi_wstrb;                                                   	
       	end                                                   
      end

      always@(posedge M_AXI_ACLK)
      begin
       	if (M_AXI_ARESETN == 0  || init_axi_txn == 1'b0)                                
          begin                                                 
            addr_transaction_done <= 0;                                    
          end
       	else if (axi_awvalid && M_AXI_AWREADY)                  
          begin                                                 
            addr_transaction_done <= 1;                                                              
          end
      	else if (addr_transaction_done && axi_wvalid)
      	begin
      		addr_transaction_done <= 0;
      	end
      	else 
      	begin
      		addr_transaction_done <= addr_transaction_done;	
      	end

       end 


	
    //--------------------
    //Write Data Channel
    //--------------------                                                                      

    always @(posedge M_AXI_ACLK)                                                      
	  begin                                                                             
	    if (M_AXI_ARESETN == 0 || init_axi_txn == 0)                                                        
	      begin                                                                         
	        ready_wd <= 1'b0;                                                         
	      end                                                                           
	    // If previously not valid, start next transaction                              
	    else begin
			ready_wd <= /*addr_transaction_done &&*/ ((M_AXI_WVALID && M_AXI_WREADY) || ~M_AXI_WVALID);  /*addr_transaction_done && ((M_AXI_WVALID && M_AXI_WREADY && ~wlast_valid) || ~M_AXI_WVALID);*/       
		end
	  end

	  always@(posedge M_AXI_ACLK)
	  begin
	  	if (M_AXI_ARESETN == 0 || init_axi_txn == 0)                                                        
	      begin                                                                         
	        valid_wd <= 1'b0;                                                         
	      end
	    else if(valid_wa && ready_wa)
	    begin
	    	valid_wd <= 1'b1;
	   	end
	   	else if(valid_wd && ready_wd)
	   	begin
	   		valid_wd <= 1'b0;
	   	end
	  end



     always @(posedge M_AXI_ACLK)                                   
      begin                                                                                                                                  
        if (M_AXI_ARESETN == 0 || init_axi_txn == 0)                                           
        begin                                                            
            axi_wvalid <= 1'b0;                                           
        end                                                              
        else if (valid_wd && ready_wd)                 
        begin                                                            
            axi_wvalid <= 1'b1;                                           
        end                                                              
        else if (M_AXI_WREADY && M_AXI_WVALID)
            axi_wvalid <= 1'b0;                                                              
        else
        begin                                                               
          axi_wvalid <= axi_wvalid;
        end
     end

     // Write data generation                                      
      always @(posedge M_AXI_ACLK)                                  
      begin                                                     
        if (M_AXI_ARESETN == 0 || init_axi_txn == 1'b0)                                
          begin                                                 
            axi_wdata <= 'b0;                  
          end                                                                              
        else if (valid_wd)                    
          begin                                                 
            axi_wdata <= dout_wd;    
          end                                                   
        end



    //----------------------------
    //Write Response (B) Channel
    //----------------------------

    //The write response channel provides feedback that the write has committed
    //to memory. BREADY will occur after both the data and the write address
    //has arrived and been accepted by the slave, and can guarantee that no
    //other accesses launched afterwards will be able to be reordered before it.

    //The BRESP bit [1] is used indicate any errors from the interconnect or
    //slave for the entire write burst. This example will capture the error.

    //While not necessary per spec, it is advisable to reset READY signals in
    //case of differing reset latencies between master/slave.

      always @(posedge M_AXI_ACLK)                                     
      begin                                                                 
        if (M_AXI_ARESETN == 0 || init_axi_txn == 0)                                            
          begin                                                             
            axi_bready <= 1'b0;                                             
          end                                                               
        // accept/acknowledge bresp with axi_bready by the master           
        // when M_AXI_BVALID is asserted by slave                           
        else if (M_AXI_BVALID && ~M_AXI_BREADY)                               
          begin                                                             
            axi_bready <= 1'b1;                                             
          end                                                               
        // deassert after one clock cycle                                   
        else if (M_AXI_BREADY)                                                
          begin                                                             
            axi_bready <= 1'b0;                                             
          end                                                               
        // retain the previous value                                        
        else                                                                
          axi_bready <= axi_bready;                                         
      end     
                                                             
        // transaction_done
      always @(posedge M_AXI_ACLK)                                     
      begin                                                                 
        if (M_AXI_ARESETN == 0 || init_axi_txn == 0)                                            
        begin                                                             
            transaction_done <= 1'b1;                                             
        end                                                               
       // accept/acknowledge bresp with axi_bready by the master           
       // when M_AXI_BVALID is asserted by slave                           
       else if (M_AXI_BVALID && ~M_AXI_BREADY)                               
         begin                                                             
           transaction_done <= 1'b1;                                             
         end                                                               
       // deassert after one clock cycle                                   
       else if (valid_wa && transaction_done)                                                
         begin                                                             
           transaction_done <= 1'b0;                                             
         end                                                               
       // retain the previous value                                        
       else                                                                
         transaction_done <= transaction_done;                                         
     end                                                                   
                                                                 
    //Flag any write response errors                                        
      assign write_resp_error = axi_bready & M_AXI_BVALID & M_AXI_BRESP[1]; 

    //----------------------------
    //Read Address Channel
    //----------------------------
                                                                           
      // A new axi_arvalid is asserted when there is a valid read address              
      // available by the master. start_single_read triggers a new read                
      // transaction                                                                   
      always @(posedge M_AXI_ACLK) 
      begin                                                                                                                             
      if (M_AXI_ARESETN == 0 || init_axi_txn == 0)                                         
        begin                                                          
          axi_arvalid <= 1'b0;                                         
        end                                                            
      // If previously not valid , start next transaction              
      else if (valid_ra)                
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


    //--------------------------------
    //Read Data (and Response) Channel
    //--------------------------------

    //The Read Data channel returns the results of the read request 
    //The master will accept the read data by asserting axi_rready
    //when there is a valid read data available.
    //While not necessary per spec, it is advisable to reset READY signals in
    //case of differing reset latencies between master/slave.

      always @(posedge M_AXI_ACLK)                                    
      begin                                                                 
        if (M_AXI_ARESETN == 0 || init_axi_txn == 1'b0)                                            
          begin                                                             
            axi_rready <= 1'b0;                                             
          end                                                               
        // accept/acknowledge rdata/rresp with axi_rready by the master     
        // when M_AXI_RVALID is asserted by slave                           
        else if (M_AXI_RVALID && ~axi_rready) //&& ready_rd)                               
          begin                                                             
            axi_rready <= 1'b1;                                             
          end                                                               
        // deassert after one clock cycle                                   
        else if (axi_rready)                                                
          begin                                                             
            axi_rready <= 1'b0;                                             
          end                                                               
        // retain the previous value                                        
      end                                                                   
                                                                            
    //Flag write errors                                                     
    assign read_resp_error = (axi_rready & M_AXI_RVALID & M_AXI_RRESP[1]);  


    //--------------------------------
    //User Logic
    //--------------------------------

    //Address/Data Stimulus

    //Address/data pairs for this example. The read and write values should
    //match.
    //Modify these as desired for different address patterns.
    
    // ready_ra circuit;
    reg ready_ra_reg = 1;
     
     assign ready_ra = ready_ra_reg ;
     
    always @(posedge M_AXI_ACLK) 
    begin                                                                 
    if (M_AXI_ARESETN == 0 || init_axi_txn == 0) 
    begin                                                             
        ready_ra_reg <= 1'b0;                                             
    end
    else if(~ready_ra_reg && valid_ra && transaction_done_read ) 
    begin
         ready_ra_reg <= 1'b1;
    end
    else if(ready_ra && transaction_done_read) 
    begin //***********
        ready_ra_reg <= 1'b0;
    end
    else begin
        ready_ra_reg <= ready_ra_reg;
    end
    end
                                                          
                                                                    
                                                           
                                                                    
      //Read Addresses                                              
      always @(posedge M_AXI_ACLK)                                  
      begin                                                     
        if (M_AXI_ARESETN == 0  || init_axi_txn == 1'b0)                                
          begin                                                 
            axi_araddr <= 0;                                    
          end                                                   
          // Signals a new write address/ write data is         
          // available by user logic                            
        else if (valid_ra)                  
          begin                                                 
            axi_araddr <= dout_ra;            
          end                                                   
      end                                                                                                                                                                                                                                                                                        
                                                                                                                                                                
    // Register and hold any data mismatches, or read/write interface errors            
      always @(posedge M_AXI_ACLK)                                                      
      begin                                                                             
        if (M_AXI_ARESETN == 0  || init_axi_txn == 1'b0)                                                         
          error_reg <= 1'b0;                                                                                                                                     
        //Capture any error types                                                       
        else if (write_resp_error || read_resp_error)                  
          error_reg <= 1'b1;                                                            
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
     else if (M_AXI_RVALID && M_AXI_RREADY)                               
       begin                                                             
         transaction_done_read <= 1'b1;                                             
       end                                                               
     // deassert after one clock cycle                                   
     else if (valid_ra && transaction_done_read)                                                
       begin                                                             
         transaction_done_read <= 1'b0;                                             
       end                                                               
     // retain the previous value                                        
     else                                                                
       transaction_done_read <= transaction_done_read;                                         
    end  
endmodule