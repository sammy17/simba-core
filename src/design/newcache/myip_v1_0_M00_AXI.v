
`timescale 1 ns / 1 ps

	module myip_v1_0_M00_AXI #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line

		// Base address of targeted slave
		parameter  C_M_TARGET_SLAVE_BASE_ADDR	= 32'h00010000,
		// Burst Length. Supports 1, 2, 4, 8, 16, 32, 64, 128, 256 burst lengths
		parameter integer C_M_AXI_BURST_LEN	= 8,
		// Thread ID Width
		parameter integer C_M_AXI_ID_WIDTH	= 1,
		// Width of Address Bus
		parameter integer C_M_AXI_ADDR_WIDTH	= 32,
		// Width of Data Bus
		parameter integer C_M_AXI_DATA_WIDTH	= 32,
		// Width of User Write Address Bus
		parameter integer C_M_AXI_AWUSER_WIDTH	= 0,
		// Width of User Read Address Bus
		parameter integer C_M_AXI_ARUSER_WIDTH	= 0,
		// Width of User Write Data Bus
		parameter integer C_M_AXI_WUSER_WIDTH	= 0,
		// Width of User Read Data Bus
		parameter integer C_M_AXI_RUSER_WIDTH	= 0,
		// Width of User Response Bus
		parameter integer C_M_AXI_BUSER_WIDTH	= 0,
		parameter integer cache_width 			= 32*8
	)
	(
		// Users to add ports here

		// User ports ends
		// Do not modify the ports beyond this line

		// Initiate AXI transactions
		input wire  RSTN,
		input wire  INIT_AXI_TXN,
		// Asserts when transaction is complete
		output wire  TXN_DONE,
		// Asserts when ERROR is detected
		output reg  ERROR,
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
		output wire  M_AXI_AWVALID,
		// Write address ready. This signal indicates that
    // the slave is ready to accept an address and associated control signals
		input wire  M_AXI_AWREADY,
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
		output wire  M_AXI_WVALID,
		// Write ready. This signal indicates that the slave
    // can accept the write data.
		input wire  M_AXI_WREADY,
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
		input wire  M_AXI_ARREADY,
		// Read ID tag. This signal is the identification tag
    // for the read data group of signals generated by the slave.
		input wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_RID,
		// Master Read Data
		input wire [C_M_AXI_DATA_WIDTH-1 : 0] M_AXI_RDATA,
		// Read response. This signal indicates the status of the read transfer
		input wire [1 : 0] M_AXI_RRESP,
		// Read last. This signal indicates the last transfer in a read burst
		input wire  M_AXI_RLAST,
		// Optional User-defined signal in the read address channel.
		input wire [C_M_AXI_RUSER_WIDTH-1 : 0] M_AXI_RUSER,
		// Read valid. This signal indicates that the channel
    // is signaling the required read data.
		input wire  M_AXI_RVALID,
		// Read ready. This signal indicates that the master can
    // accept the read data and response information.
		output wire  M_AXI_RREADY,


		//user defined ports
		output reg 		[cache_width-1:0] 			data_from_l2 		,
		input wire   								addr_to_l2_valid	,
		input wire 		[C_M_AXI_ADDR_WIDTH-1:0] 	addr_to_l2 			,
		input wire 		[C_M_AXI_ADDR_WIDTH-1:0] 	waddr_to_l2 		,
		output wire  								data_from_l2_valid	,
		input wire 	 	[cache_width-1:0]			data_to_l2			,
		input wire 									data_to_l2_valid 	,
		output wire 								data_written 		
	);


	// function called clogb2 that returns an integer which has the
	//value of the ceiling of the log base 2

	  // function called clogb2 that returns an integer which has the 
	  // value of the ceiling of the log base 2.                      
	  function integer clogb2 (input integer bit_depth);              
	  begin                                                           
	    for(clogb2=0; bit_depth>0; clogb2=clogb2+1)                   
	      bit_depth = bit_depth >> 1;                                 
	    end                                                           
	  endfunction                                                     

	// C_TRANSACTIONS_NUM is the width of the index counter for 
	// number of write or read transaction.
	 localparam integer C_TRANSACTIONS_NUM = clogb2(C_M_AXI_BURST_LEN-1);

	// Burst length for transactions, in C_M_AXI_DATA_WIDTHs.
	// Non-2^n lengths will eventually cause bursts across 4K address boundaries.
	 localparam integer C_MASTER_LENGTH	= 12;
	// total number of burst transfers is master length divided by burst length and burst size
	 localparam integer C_NO_BURSTS_REQ = C_MASTER_LENGTH-clogb2((C_M_AXI_BURST_LEN*C_M_AXI_DATA_WIDTH/8)-1);
	// Example State machine to initialize counter, initialize write transactions, 
	// initialize read transactions and comparison of read data with the 
	// written data words.


	 reg [1:0] mst_exec_state;

	// AXI4LITE signals
	//AXI4 internal temp signals
	reg [C_M_AXI_ADDR_WIDTH-1 : 0] 	axi_awaddr;
	reg  	axi_awvalid;
	reg [C_M_AXI_DATA_WIDTH-1 : 0] 	axi_wdata;
	reg  	axi_wlast;
	reg  	axi_wvalid;
	reg  	axi_bready;
	reg [C_M_AXI_ADDR_WIDTH-1 : 0] 	axi_araddr;
	reg  	axi_arvalid;
	reg  	axi_rready;
	//write beat count in a burst
	reg [C_TRANSACTIONS_NUM : 0] 	write_index;
	//read beat count in a burst
	reg [C_TRANSACTIONS_NUM : 0] 	read_index;
	//size of C_M_AXI_BURST_LEN length burst in bytes
	wire [C_TRANSACTIONS_NUM+2 : 0] 	burst_size_bytes;
	//The burst counters are used to track the number of burst transfers of C_M_AXI_BURST_LEN burst length needed to transfer 2^C_MASTER_LENGTH bytes of data.


	reg  	start_single_burst_write;
	reg  	start_single_burst_read;
	reg  	writes_done;
	reg  	reads_done;
	reg  	error_reg;
	reg  	compare_done;
	reg  	read_mismatch;
	reg  	burst_write_active;
	reg  	burst_read_active;
	reg [C_M_AXI_DATA_WIDTH-1 : 0] 	expected_rdata;
	//Interface response error flags
	wire  	write_resp_error;
	wire  	read_resp_error;
	wire  	wnext;
	wire  	rnext;
	reg  	init_txn_ff;
	reg  	init_txn_ff2;
	reg  	init_txn_edge;
	wire  	init_txn_pulse;


	// I/O Connections assignments

	//I/O Connections. Write Address (AW)
	assign M_AXI_AWID	= 'b0;
	//The AXI address is a concatenation of the target base address + active offset range
	assign M_AXI_AWADDR	= axi_awaddr-32'h5000_0000;;
	//Burst LENgth is number of transaction beats, minus 1
	assign M_AXI_AWLEN	= C_M_AXI_BURST_LEN - 1;
	//Size should be C_M_AXI_DATA_WIDTH, in 2^SIZE bytes, otherwise narrow bursts are used
	assign M_AXI_AWSIZE	= clogb2((C_M_AXI_DATA_WIDTH/8)-1);
	//INCR burst type is usually used, except for keyhole bursts
	assign M_AXI_AWBURST	= 2'b01;
	assign M_AXI_AWLOCK	= 1'b0;
	//Update value to 4'b0011 if coherent accesses to be used via the Zynq ACP port. Not Allocated, Modifiable, not Bufferable. Not Bufferable since this example is meant to test memory, not intermediate cache. 
	assign M_AXI_AWCACHE	= 4'b0010;
	assign M_AXI_AWPROT	= 3'h0;
	assign M_AXI_AWQOS	= 4'h0;
	assign M_AXI_AWUSER	= 'b1;
	assign M_AXI_AWVALID	= axi_awvalid;
	//Write Data(W)
	assign M_AXI_WDATA	= axi_wdata;
	//All bursts are complete and aligned in this example
	assign M_AXI_WSTRB	= {(C_M_AXI_DATA_WIDTH/8){1'b1}};
	assign M_AXI_WLAST	= axi_wlast;
	assign M_AXI_WUSER	= 'b0;
	assign M_AXI_WVALID	= axi_wvalid;
	//Write Response (B)
	assign M_AXI_BREADY	= axi_bready;
	//Read Address (AR)
	assign M_AXI_ARID	= 'b0;
	assign M_AXI_ARADDR	=  axi_araddr-32'h5000_0000;
	//Burst LENgth is number of transaction beats, minus 1
	assign M_AXI_ARLEN	= C_M_AXI_BURST_LEN - 1;
	//Size should be C_M_AXI_DATA_WIDTH, in 2^n bytes, otherwise narrow bursts are used
	assign M_AXI_ARSIZE	= clogb2((C_M_AXI_DATA_WIDTH/8)-1);
	//INCR burst type is usually used, except for keyhole bursts
	assign M_AXI_ARBURST	= 2'b01;
	assign M_AXI_ARLOCK	= 1'b0;
	//Update value to 4'b0011 if coherent accesses to be used via the Zynq ACP port. Not Allocated, Modifiable, not Bufferable. Not Bufferable since this example is meant to test memory, not intermediate cache. 
	assign M_AXI_ARCACHE	= 4'b0010;
	assign M_AXI_ARPROT	= 3'h0;
	assign M_AXI_ARQOS	= 4'h0;
	assign M_AXI_ARUSER	= 'b1;
	assign M_AXI_ARVALID	= axi_arvalid;
	//Read and Read Response (R)
	assign M_AXI_RREADY	= axi_rready;
	//Example design I/O
	assign TXN_DONE	= compare_done;
	//Burst size in bytes
	assign burst_size_bytes	= C_M_AXI_BURST_LEN * C_M_AXI_DATA_WIDTH/8;
	assign init_txn_pulse	= 0;//(!init_txn_ff2) && init_txn_ff;


	reg 										initiate_write 		;
	reg [cache_width-1:0] 						data_w 				;
	reg [C_M_AXI_ADDR_WIDTH-1:0]			  	addr_w 				;
	always @(posedge M_AXI_ACLK)                                   
	begin                                                                  
		if ((M_AXI_ARESETN == 0 )| (RSTN == 0 ))                                           
		begin
			addr_w  			<=		0				;
		end
		else if (data_to_l2_valid & ~initiate_write)
		begin
			addr_w 				<=		waddr_to_l2		;	
		end
		else 
			addr_w 				<=		addr_w 			;
	end
	always @(posedge M_AXI_ACLK)                                   
	begin                                                                  
		if ((M_AXI_ARESETN == 0 )| (RSTN == 0 ))                                           
		begin
			data_w  			<=		0;
		end
		else if (data_to_l2_valid & ~initiate_write)
		begin
			data_w 				<=		data_to_l2;
		end
		else 
			data_w 				<=		data_w;
	end

	always @(posedge M_AXI_ACLK)                                   
	begin                                                                  
		if ((M_AXI_ARESETN == 0 )| (RSTN == 0 ) )                                           
		begin
			initiate_write  	<=		0;
		end
		else if (data_to_l2_valid & ~initiate_write)
		begin
			initiate_write 		<=		1;
		end
		else if(axi_awvalid)
		begin
			initiate_write 		<=		0;
		end
		else 
			initiate_write 		<=		initiate_write;
	end


	/////---------------------------------------------------------------------
	always @(posedge M_AXI_ACLK)                                   
	begin                           
		                                                           
		if ((M_AXI_ARESETN == 0 )| (RSTN == 0 ) )                                           
		begin                                                            
			axi_awvalid <= 1'b0;                                           
		end                                                              
		// If previously not valid , start next transaction                
		else if (~axi_awvalid  & initiate_write)                 
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
	always @(posedge M_AXI_ACLK)                                         
	begin                                                                
		if ((M_AXI_ARESETN == 0 )| (RSTN == 0 ))                                            
		begin                                                            
			axi_awaddr <= 'b0;                                             
		end                                                              
		else if (~axi_awvalid  & initiate_write)                             
		begin                                                            
			axi_awaddr <= addr_w;                   
		end                                                              
		else                                                               
			axi_awaddr <= axi_awaddr;                                        
	end                                                              



	//Write Data Channel--------------------------------------------

	  assign wnext = M_AXI_WREADY & axi_wvalid;                                   
	                                                                                    
	// WVALID logic, similar to the axi_awvalid always block above                      
	always @(posedge M_AXI_ACLK)                                                      
	begin                                                                             
		if ((M_AXI_ARESETN == 0 )| (RSTN == 0 ) )                                                        
		begin                                                                         
			axi_wvalid <= 1'b0;                                                         
		end                                                                           
		             
		else if (~axi_wvalid && initiate_write)                               
		begin                                                                         
			axi_wvalid <= 1'b1;                                                         
		end                                                                                                        
		else if (wnext && axi_wlast)                                                    
			axi_wvalid <= 1'b0;                                                           
		else                                                                            
			axi_wvalid <= axi_wvalid;                                                     
	end                                                                               
	                                                                                                       
	always @(posedge M_AXI_ACLK)                                                      
	begin                                                                             
		if ((M_AXI_ARESETN == 0 )| (RSTN == 0 ))                                                        
		begin                                                                         
			axi_wlast <= 1'b0;                                                          
		end                                                                          
		else if (((write_index == C_M_AXI_BURST_LEN-2 && C_M_AXI_BURST_LEN >= 2) && wnext) || (C_M_AXI_BURST_LEN == 1 ))
		begin                                                                         
			axi_wlast <= 1'b1;                                                          
		end                                                                                                        
		else if (wnext)                                                                 
			axi_wlast <= 1'b0;                                                            
		else if (axi_wlast && C_M_AXI_BURST_LEN == 1)                                   
			axi_wlast <= 1'b0;                                                            
		else                                                                            
			axi_wlast <= axi_wlast;                                                       
	end                                                                               
	                                                                                                                                   
	always @(posedge M_AXI_ACLK)                                                      
	begin                                                                             
		if (M_AXI_ARESETN == 0 || initiate_write|| (RSTN == 0 ))    
		begin                                                                         
			write_index <= 					0		;  
			axi_wdata   <=                  data_w[0 +: 32]       ;                                                            
		end                                                                           
		else if (wnext && (write_index != C_M_AXI_BURST_LEN-1))                         
		begin                                                                         
			write_index <= write_index + 	1		;     
			axi_wdata <= data_w[(write_index+1)*32 +: 32];                                         
		end                                                                           
		else                                                                            
			write_index <= write_index				;                                                   
	end                                                                               
	                                                                                    
	                                                                                    
	/* Write Data Generator                                                             
	 Data pattern is only a simple incrementing count from 0 for each burst  */         
//	always @(posedge M_AXI_ACLK)                                                      
//	begin                                                                             
//		if (M_AXI_ARESETN == 0 )                                                         
			 
//		else                                                                 
			
	                                                    
//	end                                                                             


	always @(posedge M_AXI_ACLK)                                     
	begin                                                                 
		if ((M_AXI_ARESETN == 0 )| (RSTN == 0 ))                                            
		begin                                                             
			axi_bready <= 1'b0;  
		                                        
		end                                                               
		// accept/acknowledge bresp with axi_bready by the master           
		// when M_AXI_BVALID is asserted by slave                           
		else if (M_AXI_BVALID && ~axi_bready)                               
		begin                                                             
			axi_bready 		<= 1'b1; 
		end                                                               
		// deassert after one clock cycle                                   
		else if (axi_bready)                                                
		begin                                                             
			axi_bready 		<= 1'b0;                                             
		end                                                               
		// retain the previous value                                        
		else                                                                
			axi_bready <= axi_bready;                                         
	end                                                                   
	                                                                        
	reg [C_M_AXI_ADDR_WIDTH-1:0] raddr;
	reg 						 initiate_read;
	always @(posedge M_AXI_ACLK)                                 
	begin                                                              
	                                                             
		if ((M_AXI_ARESETN == 0 )| (RSTN == 0 ))                                         
		begin
			initiate_read  <=0;
		end
		else if(addr_to_l2_valid & ~initiate_read)
		begin
			initiate_read <=1;
		end
		else if  (initiate_read & axi_arvalid)
		begin
			initiate_read <=0;
		end
		else
			initiate_read <= initiate_read;
	end
	always @(posedge M_AXI_ACLK)                                 
	begin                                                                                                                         
		if ((M_AXI_ARESETN == 0 )| (RSTN == 0 ))                                         
		begin
			raddr  <=0;
		end
		else if (addr_to_l2_valid & ~initiate_read)
		begin
			raddr <=addr_to_l2;
		end
		else
			raddr <= raddr;
	end

	always @(posedge M_AXI_ACLK)                                 
	begin                                                              
	                                                             
	if ((M_AXI_ARESETN == 0 )| (RSTN == 0 ) )                                         
	begin                                                          
		axi_arvalid 	<= 1'b0;                                         
	end                                                            
	// If previously not valid , start next transaction              
	else if (~axi_arvalid && initiate_read)                
	begin                                                          
		axi_arvalid 	<= 1'b1;                                         
	end                                                            
	else if (M_AXI_ARREADY && axi_arvalid)                           
	begin                                                          
		axi_arvalid 	<= 1'b0;                                         
	end                                                            
	else                                                             
		axi_arvalid 	<= axi_arvalid;                                    
	end                                                                
	                                                                     
	                                                                     
	// Next address after ARREADY indicates previous address acceptance  
	always @(posedge M_AXI_ACLK)                                       
	begin                                                              
		if ((M_AXI_ARESETN == 0 )| (RSTN == 0 ) )                                          
		begin                                                          
			axi_araddr <= 'b0;                                           
		end                                                            
		else if (~axi_arvalid && initiate_read)                           
		begin                                                          
			axi_araddr <= raddr;                 
		end                                                            
		else                                                             
			axi_araddr <= axi_araddr;                                      
	end                                                                


	assign rnext = M_AXI_RVALID && axi_rready;                            
	
	always @(posedge M_AXI_ACLK)                                          
	begin                                                                 
		if (M_AXI_ARESETN == 0  || initiate_read ||  (RSTN == 0 ))                  
		begin                                                             
			read_index <= 0;                                                
		end                                                               
		else if (rnext && (read_index != C_M_AXI_BURST_LEN-1))              
		begin                                                             
			read_index <= read_index + 1;                                   
		end                                                               
		else                                                                
			read_index <= read_index;                                         
	end                                                                   
	                                                                        
	reg data_valid;                                                      
	always @(posedge M_AXI_ACLK)                                          
	begin                                                                 
		if ((M_AXI_ARESETN == 0 )| (RSTN == 0 ) )                  
		begin                                                             
			axi_rready 							<= 1'b0; 
			data_valid 							<=0;                                            
		end                                                               
		// accept/acknowledge rdata/rresp with axi_rready by the master     
		// when M_AXI_RVALID is asserted by slave                           
		else if (M_AXI_RVALID)                       
		begin                                      
			if (M_AXI_RLAST && axi_rready)          
			begin                                  
				axi_rready <= 1'b0;
				data_from_l2[read_index*32 +: 32]  	<= M_AXI_RDATA; 
				data_valid<=1;            
			end                                    
			else                                    
			begin  
				data_valid 				           <=0;                               
				axi_rready 							<= 1'b1; 
				data_from_l2[read_index*32 +: 32]  	<= M_AXI_RDATA;              
			end                                   
		end 
		else
			data_valid<=0;                                       
	// retain the previous value                 
	end                                            
                                                                     

                                   
	always @(posedge M_AXI_ACLK)                                                                              
	begin                                                                                                     
		if ((M_AXI_ARESETN == 0 )| (RSTN == 0 ))                                                                                 
			burst_write_active <= 1'b0;                                                                           
		else if (initiate_write)                                                                      
			burst_write_active <= 1'b1;                                                                           
		else if (M_AXI_BVALID && axi_bready)                                                                    
			burst_write_active <= 0;                                                                              
	end                                                                                                       
                                                                                                                           
	always @(posedge M_AXI_ACLK)                                                                              
	begin                                                                                                     
		if ((M_AXI_ARESETN == 0 )| (RSTN == 0 ))                                                                                 
			burst_read_active <= 1'b0;                                                                                            
		else if (start_single_burst_read)                                                                       
			burst_read_active <= 1'b1;                                                                            
		else if (M_AXI_RVALID && axi_rready && M_AXI_RLAST)                                                     
			burst_read_active <= 0;                                                                               
	end                                                                                                     

		assign data_written =  axi_bready & M_AXI_BVALID;
		assign data_from_l2_valid= data_valid ;
	endmodule
