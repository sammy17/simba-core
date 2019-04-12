`timescale 1ns / 1ps
/////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2017 08:24:33 PM
// Design Name: 
// Module Name: RISCV_PROCESSOR
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

module RISCV_PROCESSOR#(
    parameter instruction_width     = 32                                          ,
    parameter address_width         = 64                                           ,
    parameter block_size            = 4                                           ,
    parameter cache_depth           = 256                                          ,
    parameter block_size_dat        = 2,
    parameter l2_delay_read         = 10                                           ,
    localparam line_width           = $clog2(cache_depth)                          ,
    localparam offset_width         = $clog2(instruction_width*block_size/8 )               ,
    localparam offset_width_dat     = $clog2(64*block_size_dat/8 )               ,
    localparam tag_width            = address_width - line_width -  offset_width   ,
    localparam cache_width          = block_size*instruction_width                        ,
    parameter  C_M00_AXI_TARGET_SLAVE_BASE_ADDR    = 32'h00000000,
    parameter data_width =64,
    parameter integer C_M00_AXI_BURST_LEN    = block_size,
    parameter integer C_M00_AXI_ID_WIDTH    = 1,
    parameter integer C_M00_AXI_ADDR_WIDTH    = 32,
    parameter integer C_M00_AXI_DATA_WIDTH    = 32,
    parameter integer C_M00_AXI_AWUSER_WIDTH    = 0,
    parameter integer C_M00_AXI_ARUSER_WIDTH    = 0,
    parameter integer C_M00_AXI_WUSER_WIDTH    = 0,
    parameter integer C_M00_AXI_RUSER_WIDTH    = 0,
    parameter integer C_M00_AXI_BUSER_WIDTH    = 0,
    parameter integer C_S00_AXI_ID_WIDTH    = 1,
    parameter integer C_S00_AXI_DATA_WIDTH    = 32,
    parameter integer C_S00_AXI_ADDR_WIDTH    = 32,
    parameter integer C_S00_AXI_AWUSER_WIDTH    = 0,
    parameter integer C_S00_AXI_ARUSER_WIDTH    = 0,
    parameter integer C_S00_AXI_WUSER_WIDTH    = 0,
    parameter integer C_S00_AXI_RUSER_WIDTH    = 0,
    parameter integer C_S00_AXI_BUSER_WIDTH    = 0,
    parameter  C_Peripheral_Interface_START_DATA_VALUE              = 32'h00000000,
    parameter  C_Peripheral_Interface_TARGET_SLAVE_BASE_ADDR        = 32'h00000000,
    parameter integer C_Peripheral_Interface_ADDR_WIDTH             = 32,
    parameter integer C_Peripheral_Interface_DATA_WIDTH             = 32,
    parameter integer C_Peripheral_Interface_TRANSACTIONS_NUM       = 4,
	parameter RAM_HIGH_ADDR  = 32'h9000_0000,
	parameter RAM_LOW_ADDR   = 32'h8000_0000,
        // Fixed parameters
        localparam ADDR_WIDTH           = 64,
        localparam DATA_WIDTH           = 64,
        localparam EXT_FIFO_ADDRESS     = 32'he0001030,
   //     localparam EXT_FIFO_ADDRESS     = 32'h10150,
        parameter  PERIPHERAL_BASE_ADDR = 32'h10000000,
                              // Delay of the second level of cache
        parameter HISTORY_DEPTH         = 32
    ) (
        // Standard inputs
        input                               CLK,
        input                               RSTN,
        input                                           MEIP                            ,   //machine external interupt pending
        input                                           MTIP                            ,   //machine timer interupt pending
        input                                           MSIP                   ,
        input wire  m00_axi_init_axi_txn,
        output wire  m00_axi_txn_done,
        output wire  m00_axi_error,
        input wire  m00_axi_aclk,
        input wire  m00_axi_aresetn,
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
        input wire  m00_axi_awready,
        output wire [C_M00_AXI_DATA_WIDTH-1 : 0] m00_axi_wdata,
        output wire [C_M00_AXI_DATA_WIDTH/8-1 : 0] m00_axi_wstrb,
        output wire  m00_axi_wlast,
        output wire [C_M00_AXI_WUSER_WIDTH-1 : 0] m00_axi_wuser,
        output wire  m00_axi_wvalid,
        input wire  m00_axi_wready,
        input wire [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_bid,
        input wire [1 : 0] m00_axi_bresp,
        input wire [C_M00_AXI_BUSER_WIDTH-1 : 0] m00_axi_buser,
        input wire  m00_axi_bvalid,
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
        input wire  m00_axi_arready,
        input wire [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_rid,
        input wire [C_M00_AXI_DATA_WIDTH-1 : 0] m00_axi_rdata,
        input wire [1 : 0] m00_axi_rresp,
        input wire  m00_axi_rlast,
        input wire [C_M00_AXI_RUSER_WIDTH-1 : 0] m00_axi_ruser,
        input wire  m00_axi_rvalid,
        output wire  m00_axi_rready,


        input wire  m01_axi_init_axi_txn,
        output wire  m01_axi_txn_done,
        output wire  m01_axi_error,
        input wire  m01_axi_aclk,
        input wire  m01_axi_aresetn,
        output wire [C_M00_AXI_ID_WIDTH-1 : 0] m01_axi_awid,
        output wire [C_M00_AXI_ADDR_WIDTH-1 : 0] m01_axi_awaddr,
        output wire [7 : 0] m01_axi_awlen,
        output wire [2 : 0] m01_axi_awsize,
        output wire [1 : 0] m01_axi_awburst,
        output wire  m01_axi_awlock,
        output wire [3 : 0] m01_axi_awcache,
        output wire [2 : 0] m01_axi_awprot,
        output wire [3 : 0] m01_axi_awqos,
        output wire [C_M00_AXI_AWUSER_WIDTH-1 : 0] m01_axi_awuser,
        output wire  m01_axi_awvalid,
        input wire  m01_axi_awready,
        output wire [C_M00_AXI_DATA_WIDTH-1 : 0] m01_axi_wdata,
        output wire [C_M00_AXI_DATA_WIDTH/8-1 : 0] m01_axi_wstrb,
        output wire  m01_axi_wlast,
        output wire [C_M00_AXI_WUSER_WIDTH-1 : 0] m01_axi_wuser,
        output wire  m01_axi_wvalid,
        input wire  m01_axi_wready,
        input wire [C_M00_AXI_ID_WIDTH-1 : 0] m01_axi_bid,
        input wire [1 : 0] m01_axi_bresp,
        input wire [C_M00_AXI_BUSER_WIDTH-1 : 0] m01_axi_buser,
        input wire  m01_axi_bvalid,
        output wire  m01_axi_bready,
        output wire [C_M00_AXI_ID_WIDTH-1 : 0] m01_axi_arid,
        output wire [C_M00_AXI_ADDR_WIDTH-1 : 0] m01_axi_araddr,
        output wire [7 : 0] m01_axi_arlen,
        output wire [2 : 0] m01_axi_arsize,
        output wire [1 : 0] m01_axi_arburst,
        output wire  m01_axi_arlock,
        output wire [3 : 0] m01_axi_arcache,
        output wire [2 : 0] m01_axi_arprot,
        output wire [3 : 0] m01_axi_arqos,
        output wire [C_M00_AXI_ARUSER_WIDTH-1 : 0] m01_axi_aruser,
        output wire  m01_axi_arvalid,
        input wire  m01_axi_arready,
        input wire [C_M00_AXI_ID_WIDTH-1 : 0] m01_axi_rid,
        input wire [C_M00_AXI_DATA_WIDTH-1 : 0] m01_axi_rdata,
        input wire [1 : 0] m01_axi_rresp,
        input wire  m01_axi_rlast,
        input wire [C_M00_AXI_RUSER_WIDTH-1 : 0] m01_axi_ruser,
        input wire  m01_axi_rvalid,
        output wire  m01_axi_rready,
        input  wire                                             peripheral_interface_init_axi_txn,
        output wire                                             peripheral_interface_error,
        output wire                                             peripheral_interface_txn_done,
        input  wire                                             peripheral_interface_aclk,
        input  wire                                             peripheral_interface_aresetn,
        output wire [C_Peripheral_Interface_ADDR_WIDTH-1 : 0]   peripheral_interface_awaddr,
        output wire [2 : 0]                                     peripheral_interface_awprot,
        output wire                                             peripheral_interface_awvalid,
        input  wire                                             peripheral_interface_awready,
        output wire [C_Peripheral_Interface_DATA_WIDTH-1 : 0]   peripheral_interface_wdata,
        output wire [C_Peripheral_Interface_DATA_WIDTH/8-1 : 0] peripheral_interface_wstrb,
        output wire                                             peripheral_interface_wvalid,
        input  wire                                             peripheral_interface_wready,
        input  wire [1 : 0]                                     peripheral_interface_bresp,
        input  wire                                             peripheral_interface_bvalid,
        output wire                                             peripheral_interface_bready,
        output wire [C_Peripheral_Interface_ADDR_WIDTH-1 : 0]   peripheral_interface_araddr,
        output wire [2 : 0]                                     peripheral_interface_arprot,
        output wire                                             peripheral_interface_arvalid,
        input  wire                                             peripheral_interface_arready,
        input  wire [C_Peripheral_Interface_DATA_WIDTH-1 : 0]   peripheral_interface_rdata,
        input  wire [1 : 0]                                     peripheral_interface_rresp,
        input  wire                                             peripheral_interface_rvalid,
        output wire                                             peripheral_interface_rready ,
        output reg [7:0] char,
        output reg char_write






        
        
    );
    
    reg                 dtlb_ready_d2;   
    reg                 dtlb_ready_d3;   
    reg                 dtlb_ready_d4;   
    wire                DCACHE_flusing;
    wire      [1:0]   MPP;
    wire              MPRV;
    wire   [1:0]          CURR_PREV;
    wire   [DATA_WIDTH-1 :0]     SATP;
    wire page_fault_ins;
    wire page_fault_dat;
    wire access_fault_dat;
    wire access_fault_ins;
    wire [1:0] fault_type;
    wire page_fault_to_proc_ins;
    wire access_fault_to_proc_ins;
    reg off_translation_for_itlb_request;
    reg [address_width-1:0] addr_to_dcache_from_itlb;
    reg [1:0] control_to_dcache_from_itlb;

    wire [3:0]                      wstrb;
     // Peripheral signals
     reg                                p_flag ;
     wire                               tlb_ready;
     reg                                tlb_ready_d1;
     reg                                tlb_ready_d2;
     reg                                tlb_ready_d3;
     reg                                stop_dat_cache ;
     reg                                stop_ins_cache ;
     integer                            counter ;
     reg                                peri_start;
     reg        [31:0]                  addr_to_peri;
     reg                                control_to_peri;
     reg        [31:0]                  data_to_peri;
     wire       [31:0]                  data_from_peri;
     wire                               peri_complete;
     reg                                peri_done ;
     reg        [3 :0]                  wstrb_to_peri;
     wire       [4:0]                   amo_op;
     wire  [address_width-1: 0]           vaddr_to_dcache;
	 wire lword_to_dtlb;
	 wire lword_to_dcache;

             
        wire fence;
     // Status signals between processor and instruction cache
    wire                               proc_ready_ins;
    wire                               cache_ready_ins;

    // Input address bus from the processor to instruction cache
    wire         branch_taken                      ;
    wire   [ADDR_WIDTH - 1 : 0]        branch_address;
       
    // Output data bus from instruction cache to the processor
    wire   [instruction_width - 1 : 0]        instruction_from_icache;
    wire   [ADDR_WIDTH - 1 : 0]        pc_to_proc_ins;


    //Status signals between processor and data cache
    wire                               cache_ready_dat;

    //Input address bus from the processor to data cache     
    wire   [2          - 1 : 0]        control_from_proc_dat;
    wire   [ADDR_WIDTH - 1 : 0]        addr_from_proc_dat;
    wire   [DATA_WIDTH - 1 : 0]        data_from_proc_dat;
    wire   [8         - 1 : 0]         byte_enb_proc;
    wire   [8			-1 :0]         wstrb_to_dcache_from_dtlb;
           
    //Output data from data cache to processor
    wire   [DATA_WIDTH - 1 : 0]        data_to_proc_dat;
    /////////////////////////////////////////////////////////
    wire                                sfence_wire;
    wire                                predicted;
    wire [DATA_WIDTH-1:0] pc;
    wire [DATA_WIDTH-1:0] ex_pc;
    wire branch;
    wire prd_valid;
    wire [DATA_WIDTH-1:0] prd_addr;
    wire flush_w;
    wire [DATA_WIDTH-1:0] return_addr;
    wire  return_w;
    wire [31:0]                 ins_id_ex;
    reg                         flush                           ;
    reg   [address_width-1:0]    addr                            ;
    wire  [address_width-1:0]   addr_out                            ;
    wire  [address_width-1:0]   curr_addr                            ;

    reg                      addr_valid                      ;
    wire                     cache_ready                     ;
    wire                     addr_to_l2_valid                ;
    wire [cache_width-1:0]  datas                           ;
    wire [address_width-offset_width-1:0]     addr_to_l2       ;
    wire  [cache_width-1:0]   data_from_l2                    ;
    wire                      data_from_l2_valid              ;        

    wire [address_width-5-1:0]     addr_to_l2_dat       ;
    wire  [block_size_dat*64-1:0]   data_from_l2_dat                    ;
    wire                      data_from_l2_valid_dat              ;
    wire                      data_to_l2_valid              ;
    wire  [address_width-5-1:0] waddr_to_l2      ;
    wire                      write_done;
    wire  [block_size_dat*64-1:0]   data_to_l2                    ;
    wire addr_to_l2_valid_dat;
    reg  DATA_FROM_AXIM_VALID;
    reg DATA_FROM_AXIM_VALID_DAT;
    reg [DATA_WIDTH-1:0] DATA_FROM_AXIM;
    reg [DATA_WIDTH-1:0] DATA_FROM_AXIM_DAT;
    wire [DATA_WIDTH-1:0] PHY_ADDR,ADDR_TO_AXIM,ADDR_TO_AXIM_DAT;
    wire itlb_ready,ADDR_TO_AXIM_VALID,ADDR_TO_AXIM_VALID_DAT;

    wire [3:0] WSTRB_OUT;
    wire [4:0] amo_to_dcache_from_dtlb;
    wire op32_to_dcache_from_dtlb;
    wire flush_to_dcache_from_dtlb;
       reg dcache_control_overide_with_dtlb;
       reg [DATA_WIDTH-1:0]    addr_to_dcache_from_dtlb;
       reg [DATA_WIDTH-1:0]    control_to_dcache_from_dtlb;
       
       
           wire dtlb_ready;
     //reg [63:0]     mtime;
     //reg [63:0]     mtimecmp;
     //reg            timer_interrupt;
     //reg            reg_done = 0;
     //reg [31:0]     data_from_reg;
     //reg            reg_flag = 0;
     
    ///////////////////////////////////////////////////// 
    
    //Simulation

     
    wire    exstage_stalled ;
     

    wire op32;
 PIPELINE pipeline(
    .CLK(CLK),
    .RST(~RSTN),
    // Towards instruction cache
    .CACHE_READY(cache_ready_ins & !exstage_stalled  & !stop_ins_cache & dtlb_ready & itlb_ready & tlb_ready_d3),
    .PIPELINE_STALL(proc_ready_ins),
    .BRANCH_TAKEN(branch_taken),
    .BYTE_ENB_TO_CACHE( byte_enb_proc),
    .BRANCH_ADDRESS(branch_address),
    .PC_IF_ID(pc_to_proc_ins), 
    .INS_IF_ID(instruction_from_icache),
    //Data cache busses
    .CONTROL_DATA_CACHE(control_from_proc_dat), 
    .ADDR_TO_DATA_CACHE(addr_from_proc_dat),
    .DATA_TO_DATA_CACHE(data_from_proc_dat),
    .DATA_TO_PROC((p_flag)? data_from_peri: data_to_proc_dat),
    .CACHE_READY_DATA(cache_ready_dat & !stop_dat_cache & dtlb_ready_d4),
    .EX_PC(ex_pc),
    .BRANCH(branch),
    .FLUSH(flush_w),
    .RETURN_ADDR(return_addr),
    .RETURN(return_w),
    .PREDICTED(predicted),
    .EXSTAGE_STALLED(exstage_stalled),
    .INS_ID_EX(ins_id_ex),
    .MEIP(MEIP),
    .MSIP(MSIP),
    .MTIP(MTIP),
    .FENCE(fence),
    .AMO_TO_CACHE(amo_op),
    .OP_32_out(op32),
    .PAGE_FAULT_DAT(page_fault_dat),
    .PAGE_FAULT_INS(page_fault_to_proc_ins),
    .FAULT_TYPE(fault_type),
    .ACCESS_FAULT_INS(access_fault_to_proc_ins),
    .ACCESS_FAULT_DAT(access_fault_dat),
    .MPRV(MPRV),
    .SATP(SATP),
    .CURR_PREV(CURR_PREV),
    .MPP(MPP),
    .SFENCE(sfence_wire),
    .LOAD_WORD(lword_to_dtlb)
    );
    

    
    
    BHT bht (
    .CLK(CLK)                              ,
    .RST(~RSTN)                            ,
    .PC(pc)                                ,
    .EX_PC(ex_pc)                          ,
    .BRANCH(branch)                        ,
    .BRANCH_TAKEN(branch_taken)            ,
    .BRANCH_ADDR (branch_address)          ,
    .PRD_VALID (prd_valid)                 ,
    .PRD_ADDR  (prd_addr)                  ,
    .FLUSH(flush_w)                          ,
    .CACHE_READY(cache_ready_ins & !exstage_stalled  & !stop_ins_cache & dtlb_ready & itlb_ready & tlb_ready_d3)          ,
    .CACHE_READY_DATA(cache_ready_dat & !stop_dat_cache & dtlb_ready_d4),
    .RETURN_ADDR(return_addr),
    .RETURN(return_w),
    .PREDICTED(predicted)
    );
    
    // Peripheral peripheral
    // (
    // .CLK(CLK),
    // .RSTN(RSTN),
    // .START(peri_start),
    // .ADDRESS(addr_to_peri),
    // .WRITE(control_to_peri),
    // .DATA_IN(data_to_peri),
    // .DATA_OUT(data_from_peri),
    // .DONE(peri_complete),
    // .WSTRB(wstrb_to_peri),
    // .RD_ADDR_TO_PERI(RD_ADDR_TO_PERI),
    // .RD_ADDR_TO_PERI_VALID(RD_ADDR_TO_PERI_VALID),
    // .RD_ADDR_TO_PERI_READY(RD_ADDR_TO_PERI_READY),
    // .WR_ADDR_TO_PERI(WR_ADDR_TO_PERI),
    // .WR_TO_PERI_VALID(WR_TO_PERI_VALID),
    // .WR_TO_PERI_READY(WR_TO_PERI_READY),
    // .DATA_TO_PERI(DATA_TO_PERI),
    // .DATA_FROM_PERI(DATA_FROM_PERI),
    // .DATA_FROM_PERI_READY(DATA_FROM_PERI_READY),
    // .DATA_FROM_PERI_VALID(DATA_FROM_PERI_VALID),
    // .TRANSACTION_COMPLETE_PERI(TRANSACTION_COMPLETE_PERI),
    // .CACHE_READY_DAT(cache_ready_dat &dtlb_ready_d4),
    // .WSTRB_OUT(WSTRB_OUT)
    // );
    
    
    // Intercepting and extracting certain data writes
    reg [2          - 1 : 0] control;
    reg [ADDR_WIDTH - 1 : 0] address;

    
    always@(posedge CLK)
    begin
        if (~RSTN)
        begin
            peri_start<=0;
            control_to_peri <=0;
            counter <=0;
            stop_ins_cache<=0;
            stop_dat_cache<=0;
            peri_done <=0;
            p_flag <=0;
            counter <=0;

            
        end
    end
    always@(posedge CLK) begin
        if((control_from_proc_dat ==2 )& (addr_from_proc_dat== EXT_FIFO_ADDRESS) & dtlb_ready & cache_ready_ins & cache_ready_ins & dtlb_ready & dtlb_ready_d4) begin
            char_write  <= 1;
            char <=data_from_proc_dat[7:0];
        end
        else begin
            char <=0;
            char_write<=0;
        end
    end
    //     else if  ((addr_from_proc_dat ==EXT_FIFO_ADDRESS | addr_from_proc_dat==32'he000102c)&&  control_from_proc_dat != 0 && dtlb_ready && !stop_dat_cache && cache_ready_ins 
    //&& cache_ready_dat & dtlb_ready_d4 && counter==0 )
    //     begin
    //         data_to_peri <= data_from_proc_dat;
    //         addr_to_peri <= addr_from_proc_dat;
    //         control_to_peri <= (control_from_proc_dat == 2) ? 1'b1:1'b0;
    //         wstrb_to_peri <= byte_enb_proc;
    //         peri_start <=1;
    //         stop_ins_cache <=1;
    //         counter <= counter +1;
    //         peri_done <= 0;
    //     end
    //     else if (cache_ready_dat & dtlb_ready_d4 && counter>0)
    //     begin
    //         if(peri_complete)
    //         begin
    //             peri_done <= 1;
    //         end
                        
    //         if (counter == 3 && !peri_done)
    //         begin
    //             stop_dat_cache <=1;
    //             p_flag         <=0;
    //             stop_ins_cache <=0;     
    //         end
    //         else if (counter == 3 && peri_done)
    //         begin
    //             stop_ins_cache <=0;  
    //             p_flag         <=1;

    //             counter        <=0;
    //             stop_dat_cache <=0;
    //         end
    //         else if (counter!=0)
    //         begin
    //             counter       <=counter + 1;
    //             peri_start    <=0;
    //         end    
    //     end
        
    //     if (p_flag && peri_done & peri_start)
    //     begin
    //         peri_start <=0;
    //     end
    //     if (p_flag & cache_ready_dat & dtlb_ready_d4 & !stop_dat_cache)
    //     begin
    //         p_flag <= 0;
    //     end
    // end
    

    function integer logb2;
        input integer depth;
        for (logb2 = 0; depth > 1; logb2 = logb2 + 1)
            depth = depth >> 1;
    endfunction
    

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
        .RSTN(RSTN),
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
        .data_from_l2(data_from_l2)         ,
        .addr_to_l2_valid(addr_to_l2_valid) ,
        .addr_to_l2({addr_to_l2,{offset_width{1'b0}}})              ,
        .data_from_l2_valid(data_from_l2_valid)
 
    );
myip_v1_0_M00_AXI # ( 

    .C_M_TARGET_SLAVE_BASE_ADDR(C_M00_AXI_TARGET_SLAVE_BASE_ADDR),
        .C_M_AXI_BURST_LEN(block_size_dat*2),
        .C_M_AXI_ID_WIDTH(C_M00_AXI_ID_WIDTH),
        .C_M_AXI_ADDR_WIDTH(C_M00_AXI_ADDR_WIDTH),
        .C_M_AXI_DATA_WIDTH(C_M00_AXI_DATA_WIDTH),
        .C_M_AXI_AWUSER_WIDTH(C_M00_AXI_AWUSER_WIDTH),
        .C_M_AXI_ARUSER_WIDTH(C_M00_AXI_ARUSER_WIDTH),
        .C_M_AXI_WUSER_WIDTH(C_M00_AXI_WUSER_WIDTH),
        .C_M_AXI_RUSER_WIDTH(C_M00_AXI_RUSER_WIDTH),
        .C_M_AXI_BUSER_WIDTH(C_M00_AXI_BUSER_WIDTH),
        .cache_width(block_size_dat*64)
    ) myip_v1_0_M01_AXI_inst (
        .RSTN(RSTN),
        .INIT_AXI_TXN(m01_axi_init_axi_txn),
        .TXN_DONE(m01_axi_txn_done),
        .ERROR(m01_axi_error),
        .M_AXI_ACLK(m01_axi_aclk),
        .M_AXI_ARESETN(m01_axi_aresetn),
        .M_AXI_AWID(m01_axi_awid),
        .M_AXI_AWADDR(m01_axi_awaddr),
        .M_AXI_AWLEN(m01_axi_awlen),
        .M_AXI_AWSIZE(m01_axi_awsize),
        .M_AXI_AWBURST(m01_axi_awburst),
        .M_AXI_AWLOCK(m01_axi_awlock),
        .M_AXI_AWCACHE(m01_axi_awcache),
        .M_AXI_AWPROT(m01_axi_awprot),
        .M_AXI_AWQOS(m01_axi_awqos),
        .M_AXI_AWUSER(m01_axi_awuser),
        .M_AXI_AWVALID(m01_axi_awvalid),
        .M_AXI_AWREADY(m01_axi_awready),
        .M_AXI_WDATA(m01_axi_wdata),
        .M_AXI_WSTRB(m01_axi_wstrb),
        .M_AXI_WLAST(m01_axi_wlast),
        .M_AXI_WUSER(m01_axi_wuser),
        .M_AXI_WVALID(m01_axi_wvalid),
        .M_AXI_WREADY(m01_axi_wready),
        .M_AXI_BID(m01_axi_bid),
        .M_AXI_BRESP(m01_axi_bresp),
        .M_AXI_BUSER(m01_axi_buser),
        .M_AXI_BVALID(m01_axi_bvalid),
        .M_AXI_BREADY(m01_axi_bready),
        .M_AXI_ARID(m01_axi_arid),
        .M_AXI_ARADDR(m01_axi_araddr),
        .M_AXI_ARLEN(m01_axi_arlen),
        .M_AXI_ARSIZE(m01_axi_arsize),
        .M_AXI_ARBURST(m01_axi_arburst),
        .M_AXI_ARLOCK(m01_axi_arlock),
        .M_AXI_ARCACHE(m01_axi_arcache),
        .M_AXI_ARPROT(m01_axi_arprot),
        .M_AXI_ARQOS(m01_axi_arqos),
        .M_AXI_ARUSER(m01_axi_aruser),
        .M_AXI_ARVALID(m01_axi_arvalid),
        .M_AXI_ARREADY(m01_axi_arready),
        .M_AXI_RID(m01_axi_rid),
        .M_AXI_RDATA(m01_axi_rdata),
        .M_AXI_RRESP(m01_axi_rresp),
        .M_AXI_RLAST(m01_axi_rlast),
        .M_AXI_RUSER(m01_axi_ruser),
        .M_AXI_RVALID(m01_axi_rvalid),
        .M_AXI_RREADY(m01_axi_rready),
        // user defined ports
        .data_from_l2(data_from_l2_dat)         ,
        .addr_to_l2_valid(addr_to_l2_valid_dat) ,
        .addr_to_l2({addr_to_l2_dat,{offset_width_dat{1'b0}}})              ,

        .data_from_l2_valid(data_from_l2_valid_dat),
        
        .waddr_to_l2({waddr_to_l2,{offset_width_dat{1'b0}}}),
        .data_to_l2(data_to_l2),
        .data_to_l2_valid(data_to_l2_valid),
        .data_written(write_done)
    );

   wire [1:0] final_dcache_control= (off_translation_for_itlb_request? control_to_dcache_from_itlb : ((cache_ready_ins & itlb_ready & tlb_ready_d3)? control_from_proc_dat : 2'b0)  ) ;

        Icache
    #(
        .data_width     (instruction_width)                                         ,
        .address_width  (address_width)                                     ,
        .block_size     (block_size)                                        ,
        .cache_depth    ( cache_depth)                                      
        
        )
    cache
    (
        .CLK(CLK)                                   ,
        .RST(~RSTN)                                   ,
        .FLUSH(fence)                               ,
        .ADDR(PHY_ADDR)                                 ,
        .ADDR_vir(pc)                             ,
        .ADDR_VALID(itlb_ready& proc_ready_ins & !exstage_stalled  & !stop_ins_cache & dtlb_ready)                     ,
        .DATA (instruction_from_icache)                                ,
        .CACHE_READY(cache_ready_ins )                   ,
        .ADDR_TO_L2_VALID(addr_to_l2_valid)         ,
        .ADDR_TO_L2 (addr_to_l2)                    ,
        .DATA_FROM_L2 (data_from_l2)                ,
        .DATA_FROM_L2_VALID (data_from_l2_valid)     ,
//        .CURR_ADDR(pc)        ,
        .ADDR_OUT(pc_to_proc_ins),
        .ACCESS_FAULT(access_fault_ins),
        .PAGE_FAULT(page_fault_ins),
        .PAGE_FAULT_OUT(page_fault_to_proc_ins),
        .ACCESS_FAULT_OUT(access_fault_to_proc_ins),
        .DCACHE_flusing(DCACHE_flusing)
        

    ); 

    wire [55:0] addr_to_dat_cache_from_tlb; 
    wire [1:0] control_dcache_from_dtlb;
	wire [63:0] data_to_dcache_from_dtlb;

    always@(posedge CLK) begin
        if(~RSTN) begin
            dtlb_ready_d2 <=0; 
            dtlb_ready_d3 <=0; 
            dtlb_ready_d4 <=0; 
        end
        if(cache_ready_dat) begin
            dtlb_ready_d2 <= dtlb_ready;     
            dtlb_ready_d3 <= dtlb_ready_d2;     
            dtlb_ready_d4 <= dtlb_ready_d3;     
        end
    end 
    DTLB
    #(.virt_addr_init(32'h0000_0000),
        .init_op(0))                                                      
    dtlb (
    .CLK(CLK),
    .RST(~RSTN),
    .TLB_FLUSH(sfence_wire),
    .VIRT_ADDR(off_translation_for_itlb_request? addr_to_dcache_from_itlb :  addr_from_proc_dat),
    .VIRT_ADDR_VALID(1),
    .PHY_ADDR_VALID(dtlb_ready),
    .PHY_ADDR(addr_to_dat_cache_from_tlb),
    .ADDR_TO_AXIM_VALID(ADDR_TO_AXIM_VALID_DAT),
    .ADDR_TO_AXIM(ADDR_TO_AXIM_DAT),
    .DATA_FROM_AXIM_VALID(DATA_FROM_AXIM_VALID_DAT),
    .DATA_FROM_AXIM(DATA_FROM_AXIM_DAT),
    .CACHE_READY(cache_ready_dat),
    .OP_TYPE(final_dcache_control),
    .FAULT_TYPE(fault_type),
    .PAGE_FAULT(page_fault_dat),
    .ACCESS_FAULT(access_fault_dat),
    .MPRV(MPRV),
    .SATP(SATP),
    .CURR_PREV(CURR_PREV),
    .MPP(MPP) ,
    .OFF_TRANSLATION_FROM_TLB(off_translation_for_itlb_request) ,
    .OP_TYPE_OUT(control_dcache_from_dtlb)          ,
	.DATA_IN(data_from_proc_dat),
	.DATA_OUT(data_to_dcache_from_dtlb),
	.WSTRB_IN(byte_enb_proc),
	.WSTRB_OUT(wstrb_to_dcache_from_dtlb),
	.AMO_IN(amo_op),
	.OP32_IN(op32),
	.FLUSH_IN(fence),
	.FLUSH_OUT(flush_to_dcache_from_dtlb),
	.OP32_OUT(op32_to_dcache_from_dtlb),
	.AMO_OUT(amo_to_dcache_from_dtlb),
    .VIRT_ADDR_OUT(vaddr_to_dcache),
	.LWORD_IN(lword_to_dtlb),
	.LWORD_OUT(lword_to_dcache)
    );

ITLB
    #(.virt_addr_init(32'h8000_0000) ,
        .init_op(3))                                                      
   itlb (
    .CLK(CLK),
    .RST(~RSTN),
    .TLB_FLUSH(sfence_wire),
    .VIRT_ADDR(prd_addr),
    .VIRT_ADDR_VALID(proc_ready_ins & !exstage_stalled  & !stop_ins_cache & dtlb_ready),
    .CURR_ADDR(pc),
    .PHY_ADDR_VALID(itlb_ready),
    .PHY_ADDR(PHY_ADDR),
    .ADDR_TO_AXIM_VALID(ADDR_TO_AXIM_VALID),
    .ADDR_TO_AXIM(ADDR_TO_AXIM),
    .DATA_FROM_AXIM_VALID(DATA_FROM_AXIM_VALID),
    .DATA_FROM_AXIM(DATA_FROM_AXIM),
    .CACHE_READY(cache_ready_ins & dtlb_ready),
    .OP_TYPE(2'b11),
    .PAGE_FAULT(page_fault_ins),
    .ACCESS_FAULT(access_fault_ins),
    .MPRV(MPRV),
    .SATP(SATP),
    .CURR_PREV(CURR_PREV),
    .MPP(MPP),
    .OFF_TRANSLATION_FROM_TLB(1'b0)
            
            
    );
	wire peri_access;
	assign peri_access = ((addr_to_dat_cache_from_tlb< RAM_LOW_ADDR) | (addr_to_dat_cache_from_tlb>RAM_HIGH_ADDR)) & dtlb_ready ;
	wire   ADDR_TO_PERI_VALID;
	wire    [address_width-1:0] ADDR_TO_PERI;
	wire    [data_width -1:0] DATA_TO_PERI;
	wire     WRITE_TO_PERI;
	wire    [data_width-1:0] DATA_FROM_PERI;
	wire        PERI_WORD_ACCESS;
	wire     DATA_FROM_PERI_READY;
	wire [7:0] WSTRB_TO_PERI;
   Dcache
    #(
        .data_width     (64)                                        ,
        .address_width  (64)                                     ,
        .block_size     (block_size_dat)                                        ,
        .cache_depth    ( cache_depth)                                      
        
        )
   dcache (
        .CLK(CLK)                                   ,
        .RST(~RSTN)                                   ,
        .FLUSH(flush_to_dcache_from_dtlb)                               ,
        .ADDR(dcache_control_overide_with_dtlb? addr_to_dcache_from_dtlb : addr_to_dat_cache_from_tlb)                                 ,
        .ADDR_VALID(1)                     ,
        .DATA (data_to_proc_dat)                                ,
        .CACHE_READY(cache_ready_dat)                   ,
        .ADDR_TO_L2_VALID(addr_to_l2_valid_dat)         ,
        .ADDR_TO_L2 (addr_to_l2_dat)                    ,
        .DATA_FROM_L2 (data_from_l2_dat)                ,
        .DATA_FROM_L2_VALID (data_from_l2_valid_dat)    ,
        .CONTROL  (dcache_control_overide_with_dtlb? control_to_dcache_from_dtlb :  control_dcache_from_dtlb)                     ,   
        .WSTRB (wstrb_to_dcache_from_dtlb)                           ,
        .DATA_in(data_to_dcache_from_dtlb),
        .DATA_TO_L2_VALID(data_to_l2_valid)                ,
        .WADDR_TO_L2(waddr_to_l2)    ,
        .WRITE_DONE(write_done),
        .DATA_TO_L2(data_to_l2),
        .AMO(amo_to_dcache_from_dtlb),
        .OP32(op32_to_dcache_from_dtlb),
        .PAGE_FAULT(page_fault_dat),
        .ACCESS_FAULT(access_fault_dat),
        .DCACHE_flusing(DCACHE_flusing),
        .VIRT_ADDR(vaddr_to_dcache),
		.LOAD_WORD(lword_to_dcache),
		.PERI_ACCESS(peri_access),
		.ADDR_TO_PERI_VALID(ADDR_TO_PERI_VALID),
		.ADDR_TO_PERI(ADDR_TO_PERI),
		.DATA_TO_PERI(DATA_TO_PERI),
		.PERI_WORD_ACCESS(PERI_WORD_ACCESS),
		.DATA_FROM_PERI(DATA_FROM_PERI),
		.DATA_FROM_PERI_READY(DATA_FROM_PERI_READY),
		.DATA_TO_PERI(DATA_TO_PERI),
		.WRITE_TO_PERI(WRITE_TO_PERI),
		.PERI_WORD_ACCESS(PERI_WORD_ACCESS),
		.WSTRB_TO_PERI(WSTRB_TO_PERI )
    );
   
	peripheral_master peripheral_master_inst(
		
		.ADDR_TO_PERI_VALID(ADDR_TO_PERI_VALID),
		.ADDR_TO_PERI(ADDR_TO_PERI),
		.DATA_TO_PERI(DATA_TO_PERI),
		.PERI_WORD_ACCESS(PERI_WORD_ACCESS),
		.WRITE_TO_PERI(WRITE_TO_PERI),
		.PERI_WORD_ACCESS(PERI_WORD_ACCESS),
		.DATA_FROM_PERI(DATA_FROM_PERI),
		.DATA_FROM_PERI_READY(DATA_FROM_PERI_READY),
       .M_AXI_ACLK                      (peripheral_interface_aclk)             ,
       .M_AXI_ARESETN                   (RSTN)             ,
       .M_AXI_AWADDR                    (peripheral_interface_awaddr)               ,
       .M_AXI_AWPROT                    (peripheral_interface_awprot)               ,
       .M_AXI_AWVALID                   (peripheral_interface_awvalid)              ,
       .M_AXI_AWREADY                   (peripheral_interface_awready)              ,
       .M_AXI_WDATA                     (peripheral_interface_wdata),
       .M_AXI_WSTRB                     (peripheral_interface_wstrb),
       .M_AXI_WVALID                    (peripheral_interface_wvalid),
       .M_AXI_WREADY                    (peripheral_interface_wready),
       .M_AXI_BRESP                     (peripheral_interface_bresp),
       .M_AXI_BVALID                    (peripheral_interface_bvalid),
       .M_AXI_BREADY                    (peripheral_interface_bready),
       .M_AXI_ARADDR                    (peripheral_interface_araddr),
       .M_AXI_ARPROT                    (peripheral_interface_arprot),
       .M_AXI_ARVALID                   (peripheral_interface_arvalid),
       .M_AXI_ARREADY                   (peripheral_interface_arready),
       .M_AXI_RDATA                     (peripheral_interface_rdata),
       .M_AXI_RRESP                     (peripheral_interface_rresp),
       .M_AXI_RVALID                    (peripheral_interface_rvalid),
       .M_AXI_RREADY                    (peripheral_interface_rready),
	   .WSTRB(WSTRB_TO_PERI )
		
	);

    reg [2:0] itlb_data_counter;
    reg [2:0] dtlb_data_counter;
    always@(posedge CLK)
    begin
        if(~RSTN)
        begin
            tlb_ready_d1    <=0;
            tlb_ready_d2    <=0;
            tlb_ready_d3    <=0;
        end
        else if(cache_ready_ins & !exstage_stalled  & !stop_ins_cache & dtlb_ready & itlb_ready )
        begin
			tlb_ready_d1  <=1;
			tlb_ready_d2  <= tlb_ready_d1;
			tlb_ready_d3  <= tlb_ready_d2;
        end
    end
    always@(posedge CLK) begin
        if(~RSTN) begin
            dcache_control_overide_with_dtlb <= 0;
            addr_to_dcache_from_dtlb<=0;
            control_to_dcache_from_dtlb <=0;
            DATA_FROM_AXIM_VALID_DAT <=0;
            DATA_FROM_AXIM_DAT <=0;
            dtlb_data_counter <=0;
        end
        else if( ADDR_TO_AXIM_VALID_DAT ) begin
            addr_to_dcache_from_dtlb <= ADDR_TO_AXIM_DAT;
            dcache_control_overide_with_dtlb <= 1;
            control_to_dcache_from_dtlb <= 1;
            dtlb_data_counter <= 1;
            DATA_FROM_AXIM_VALID_DAT <= 0;
            DATA_FROM_AXIM_DAT <= 0;
        end
        else if(cache_ready_dat ) begin
            dcache_control_overide_with_dtlb <=0;
            control_to_dcache_from_dtlb <= 0;
            if(dtlb_data_counter==4) begin
                dtlb_data_counter <=0;
                DATA_FROM_AXIM_VALID_DAT<=1;
                DATA_FROM_AXIM_DAT<=data_to_proc_dat;
            end
            else if(dtlb_data_counter!=0) begin
                dtlb_data_counter <= dtlb_data_counter +1;
                DATA_FROM_AXIM_VALID_DAT <=0;
                DATA_FROM_AXIM_DAT <=0;
            end
            else begin
                DATA_FROM_AXIM_VALID_DAT<=0;
                DATA_FROM_AXIM_DAT <=0;
             end
        end
        else begin
            DATA_FROM_AXIM_VALID_DAT <=0;
            DATA_FROM_AXIM_DAT <=0;
        end

                

            
        
    end
    always@(posedge CLK) begin
        if(~RSTN) begin
            off_translation_for_itlb_request <=0;
            addr_to_dcache_from_itlb    <= 0;
            control_to_dcache_from_itlb <=0;
            itlb_data_counter <=0;
            DATA_FROM_AXIM_VALID <=0;
            DATA_FROM_AXIM <=0;
        end
        else if(ADDR_TO_AXIM_VALID) begin
            off_translation_for_itlb_request <= 1;
            addr_to_dcache_from_itlb    <= ADDR_TO_AXIM;
            control_to_dcache_from_itlb <=1; // 1 for load 2 for store
            itlb_data_counter <=1;
            DATA_FROM_AXIM_VALID <=0;
            DATA_FROM_AXIM <=0;
        end
        else if(cache_ready_dat & dtlb_ready_d4 & dtlb_ready) begin
             off_translation_for_itlb_request <= 0;
             control_to_dcache_from_itlb <=0;
             if(itlb_data_counter==5) begin
                 itlb_data_counter <=0;

                 DATA_FROM_AXIM_VALID <=1;
                 DATA_FROM_AXIM <=data_to_proc_dat;
             end
             else if(itlb_data_counter!=0 ) begin
                itlb_data_counter <= itlb_data_counter +1;
                DATA_FROM_AXIM_VALID <=0;
                DATA_FROM_AXIM <=0;
             end
             else begin
                DATA_FROM_AXIM_VALID <=0;
                DATA_FROM_AXIM <=0;
             end
        end
        else begin
            DATA_FROM_AXIM_VALID <=0;
            DATA_FROM_AXIM <=0;
        end

     end //posedge clk

endmodule
