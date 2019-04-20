`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:     09/02/2017 02:47:55 PM
// Design Name: 
// Module Name:     CSR_FILE
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

// `define CSR_DEBUG
`define PC_PRINT
module CSR_FILE (
    input               CLK             ,
    input               RST             ,
    input       [63:0]  PC              ,
    input       [63:0]  ERR_ADDR              ,
    input       [ 3:0]  CSR_CNT         ,
    input       [11:0]  CSR_ADDRESS     ,
    input       [63:0]  RS1_DATA        ,
    input       [ 4:0]  ZIMM            ,
    output reg  [63:0]  OUTPUT_DATA     ,
    (*mark_debug = "true" *)  output reg  [63:0]  PRIV_JUMP_ADD   ,
    
    input               PROC_IDLE       ,
    (*mark_debug = "true" *)  output              PRIV_JUMP       ,
    
    //external interupts >> software interupts >> timer interupts >> synchornous traps
    
    input               MEIP            ,   //machine external interupt pending
    input               MTIP            ,   //machine timer interupt pending
    input               MSIP            ,   //machine software interupt pending, from external hart
    
    input               SEIP            ,   //supervisor external interupt pending
     (*mark_debug = "true" *) input               STIP            ,   //supervisor timer interupt pending
    input               SSIP            ,   //supervisor software interupt pending, from external hart
    
    input               UEIP            ,   //user external interupt pending
    input               UTIP            ,   //user timer interupt pending
    input               USIP            ,   //user software interupt pending, from external hart
    
     
    
    //exceptions
    input               INS_ADDR_MISSALIG  , //instruction address missaligned
    input               INS_ACC_FAULT      , //instruction access fault
    input               ILL_INS            , //illegal instruction
    //input             BREAK              , //break point
    input               LD_ADDR_MISSALIG   , //load address misalignment
    input               LD_ACC_FAULT       , //load access fault
    input               STORE_ADDR_MISSALIG, //store/amo address misalignmnt
    input               STORE_ACC_FAULT    , //store/amo access fault

    input               INS_PAGE_FAULT     , //instructioin page fault
    input               LD_PAGE_FAULT      , //load page fault
    input               STORE_PAGE_FAULT   , //store/amo page fault
    
    
    
    output reg          TSR             ,
    output reg          TVM             ,
    output reg          TW              ,
    output      [1:0]   MPP,
    output              MPRV,
    output   [1:0]           CURR_PREV,
    output   [63:0]     SATP,
    input [63:0]   PC_EX_MEM1,
    input [63:0]   JUMP_ADD,
    input [31:0] INS_FB_EX,
    output reg satp_update,
    output TIME_INT_WAIT
                      
    );  
    
    `include "PipelineParams.vh"
    
    //machine mode specific
    reg stip;
    reg     heip,seip,ueip,htip,utip,hsip,ssip,usip                ;
    reg     meie,heie,seie,ueie,mtie,htie,stie,utie,msie,hsie,ssie,usie ;
    reg mxr,sum,mprv,spp,mpie,spie,upie,m_ie,s_ie,u_ie           ;
    reg     [1      :0]     mpp                                         ;
    reg     [61     :0]     mt_base                            ;
    reg     [1      :0]     mt_mode                            ;
    reg     [63     :0]     medeleg_reg                        ;
    reg     [63     :0]     mideleg_reg                        ;
    reg     [63     :0]     mcycle_reg                         ;
    reg     [63     :0]     minsret_reg                        ;
    reg                     mir,mtm,mcy                        ;
    reg     [63     :0]     mscratch_reg                       ;
    reg     [63     :0]     mepc_reg                           ;
    reg     [63     :0]     misa_reg                           ;
    reg     [63     :0]     mtval_reg                          ;
    reg     [62     :0]     mecode_reg                         ;
    reg                     minterrupt                         ;
    reg     [62     :0]     ecode_reg                      ;
    reg                     interrupt                      ;
    
    //supervisor mode specific
    reg     [61     :0]     st_base                            ;
    reg     [1      :0]     st_mode                            ;
    reg     [63     :0]     sedeleg_reg                        ;
    reg     [63     :0]     sideleg_reg                        ;
    reg     [63     :0]     sinsret_reg                        ;
    reg                     sir,stm,scy                        ;
    reg     [63     :0]     sscratch_reg                       ;
    reg     [63     :0]     sepc_reg                           ;
    reg     [63     :0]     stval_reg                          ;
    reg     [62     :0]     secode_reg                         ;
    reg                     sinterrupt                         ;
    reg     [3:0]             smode_reg                          ;
    reg     [15      :0]     asid                               ;
    reg     [43     :0]     ppn                                ;
    
    // user mode specific
    reg     [61     :0]     ut_base                            ;
    reg     [1      :0]     ut_mode                            ;
    reg     [63     :0]     ucycle_reg                         ;
    reg     [63     :0]     uinsret_reg                        ;
    reg     [63     :0]     uscratch_reg                       ;
    reg     [63     :0]     uepc_reg                           ;
    reg     [63     :0]     utval_reg                          ;
    reg     [62     :0]     uecode_reg                         ;
    reg                     uinterrupt                         ;
    reg                     umode_reg                          ;
    //reg     [63     :0]     timer_reg                          ; 
    reg [1:0] sxl,uxl,xs,fs;
    wire sd=(fs==2'b11);
    // machine mode wires
    wire    [63 : 0] mip_r       = {52'b0,MEIP,1'b0,seip,ueip,MTIP,1'b0,stip,utip,MSIP,1'b0,ssip,usip}                          ;  //hardwired 0 for hypervisor specs
    wire    [63 : 0] mie_r       = {52'b0,meie,1'b0,seie,ueie,mtie,1'b0,stie,utie,msie,1'b0,ssie,usie}                          ;  
    wire    [63 : 0] mstatus_r   = {sd,27'b0,sxl,uxl,9'b0,TSR,TW,TVM,mxr,sum,mprv,2'b0,fs,mpp,2'b0,spp,mpie,1'b0,spie,upie,m_ie,1'b0,s_ie,u_ie}  ;
    wire    [63 : 0] mtvec_r     = {mt_base,mt_mode}                                                                            ;
    wire    [63 : 0] medeleg_r   = medeleg_reg                                                                                  ;
    wire    [63 : 0] mideleg_r   = mideleg_reg                                                                                  ;
    wire    [63 : 0] mscratch_r  = mscratch_reg                                                                                 ;
    wire    [63 : 0] mepc_r      = mepc_reg                                                                                     ;
    wire    [63 : 0] mcycle_r    = mcycle_reg;                                                                         
    // wire    [31 : 0] mcycleh_r   = mcycle_reg[63 : 32]                                                                          ;
    wire    [63 : 0] mcounteren_r= {61'b0,mir,mtm,mcy}                                                                          ;
    wire    [63 : 0] mcause_r    = {minterrupt,mecode_reg}                                                                      ;
    wire    [63 : 0] mtval_r     = mtval_reg                                                                                    ;   
    wire    [63 : 0] minstret_r  = minsret_reg                                                                        ;
    // wire    [31 : 0] minstreth_r = minsret_reg [63 : 32]                                                                        ;
    wire    [63 : 0] mvendorid_r = 32'd0                                                                                        ;
    wire    [63 : 0] mhartid_r   = 32'd0                                                                                        ;
    wire    [63 : 0] marchid_r   = 32'd0                                                                                        ;
    wire    [63 : 0] mimpid_r    = 32'd0                                                                                        ;
    wire    [63 : 0] misa_r      = misa_reg                                                         ;  //I M U S extentions enabled
    reg [63:0] pmpaddr0_r; 
    reg [63:0] pmpaddr1_r; 
    reg [63:0] pmpaddr2_r; 
    reg [63:0] pmpaddr3_r; 
    reg [63:0] pmpaddr4_r; 
    reg [63:0] pmpaddr5_r; 
    reg [63:0] pmpaddr6_r; 
    reg [63:0] pmpaddr7_r; 
    reg [63:0] pmpcfg0_r;
    reg [63:0] pmpcfg1_r;
    reg [63:0] pmpcfg2_r;
    reg [63:0] pmpcfg3_r;
    // supervisor mode wires
    wire    [63 : 0] sstatus_r   =  {sd,29'b0,uxl,12'b0,mxr,sum,1'b0,2'b0,fs,2'b0,2'b0,spp,1'b0,1'b0,spie,upie,1'b0,1'b0,s_ie,u_ie}  ;    
    wire    [63 : 0] stvec_r     = {st_base,st_mode}                                            ;
    wire    [63 : 0] sip_r       = {52'b0,2'b0,1'b0,seip,ueip,1'b0,1'b0,STIP,utip,1'b0,1'b0,ssip,usip}               ;  //hardwired 0 for hypervisor specs
    wire    [63 : 0] sie_r       = {52'b0,1'b0,1'b0,seie,ueie,1'b0,1'b0,stie,utie,1'b0,1'b0,ssie,usie}               ;  
    wire    [63 : 0] sedeleg_r   = sedeleg_reg                                                  ;
    wire    [63 : 0] sideleg_r   = sideleg_reg                                                  ;
    wire    [63 : 0] sscratch_r  = sscratch_reg                                                 ;
    wire    [63 : 0] sepc_r      = sepc_reg                                                     ;
    wire    [63 : 0] scounteren_r= {61'b0,sir,stm,scy}                                          ;
    wire    [63 : 0] scause_r    = {sinterrupt,secode_reg}                                      ;
    wire    [63 : 0] stval_r     = stval_reg                                                    ;
    wire    [63 : 0] satp_r      = {smode_reg,asid,ppn}                                         ;
   
    // user mode wires 
    wire    [63 : 0] ustatus_r   = {58'b0,upie,3'b0,u_ie}               ;
    wire    [63 : 0] utvec_r     = {ut_base,ut_mode}                    ;
    wire    [63 : 0] uip_r       = { 55'b0,ueip,3'b0,utip,3'b0,usip}    ;  //hardwired 0 for hypervisor specs
    wire    [63 : 0] uie_r       = { 55'b0,ueie,3'b0,utie,3'b0,usie}    ;    
    wire    [63 : 0] uscratch_r  = uscratch_reg                         ;
    wire    [63 : 0] uepc_r      = uepc_reg                             ;
    wire    [63 : 0] ucause_r    = {uinterrupt,uecode_reg}              ;
    wire    [63 : 0] utval_r     = utval_reg                            ;
    wire    [63 : 0] cycle_r     = mcycle_reg          ;

    wire    [63 : 0] instret_r   = minsret_reg                ;

    
    reg     [1  : 0] curr_prev                                                              ;
    
    
    reg     [63 : 0] input_data_final                             ;
    reg exception;
      
    reg              interrupt_final;
    reg     [1:0]    handling_priviledge;
    wire real_exception= exception & !PROC_IDLE;
    wire [3:0] real_csr_cnt = {4{!PROC_IDLE}}& CSR_CNT;
    //Create final write data
     reg illegal_access;
    reg csr_op;
    reg [63:0] err_addr;
    reg         fault_while_idle ;
    reg [63:0] err_addr_while_idle ;
    reg [63:0] pc_while_idle ;
    reg [6:0] ecode_while_idle;
    `ifdef CSR_DEBUG
   
    always@(posedge CLK) 
    begin
        if(!PROC_IDLE)
         case (CSR_CNT)
            sys_csrrw   : begin    
                                $display("csrrw add %h val %h",CSR_ADDRESS,input_data_final);

                          end
            sys_csrrs   : begin
                                $display("csrrs add %h val %h",CSR_ADDRESS,input_data_final);
                          end
            sys_csrrc   : begin
                                $display("csrrc add %h val %h",CSR_ADDRESS,input_data_final);
                          end
            sys_csrrwi  :   begin
                            end
            sys_csrrsi  :   begin
                                $display("csrrsi add %h val %h",CSR_ADDRESS,input_data_final);
                            end
            sys_csrrci  :   begin
                                $display("csrrci add %h val %h",CSR_ADDRESS,input_data_final);
                            end   
         endcase 
    end
    `endif
    always @(*)
    begin
        case (CSR_CNT)
            sys_csrrw   : begin    
                            input_data_final =  RS1_DATA                   ;   //Write CSR    '
                           csr_op = 1'b1;

                          end
            sys_csrrs   : begin
                             input_data_final =  RS1_DATA | OUTPUT_DATA     ;   //Set bits in CSR
                             csr_op = 1'b1;
                             
                          end
            sys_csrrc   : begin
                             input_data_final = ~RS1_DATA & OUTPUT_DATA     ;   //Clear bits in CSR
                             csr_op = 1'b1;
                          end
            sys_csrrwi  :   begin
                                input_data_final =  {59'b0,ZIMM}               ;   //Write imm CSR 
                                csr_op = 1'b1;
                            end
            sys_csrrsi  :   begin
                                input_data_final =  {59'b0,ZIMM} | OUTPUT_DATA ;   //Set imm bits in CSR'
                                csr_op = 1'b1;
                            end
            sys_csrrci  :   begin
                                input_data_final = ~{59'b0,ZIMM} & OUTPUT_DATA ;   //Cleariimm bits in CSR 
                                 csr_op = 1'b1;
                            end

            default     :   begin 
                                input_data_final =   OUTPUT_DATA                     ; 
                                csr_op =1'b0; 
                            end

        endcase
        if(csr_op & !(PROC_IDLE)) begin
            if (curr_prev<CSR_ADDRESS[9:8]) begin
                illegal_access = 1'b1;
            end
            else if((CSR_ADDRESS[11:10] == 2'b11) & ((ZIMM!=5'b0)| (CSR_CNT==sys_csrrwi) | (CSR_CNT==sys_csrrw))) begin
                illegal_access = 1'b1;
            end
            else begin
                illegal_access = 1'b0;
            end
        end
        else begin
            illegal_access = 1'b0;
        end

    end
    
    always@(posedge CLK) begin
        if(RST) begin
            satp_update <=0;
        end
        else if(!PROC_IDLE & csr_op & (CSR_ADDRESS==satp)) begin
            satp_update <= 1;
        end
        else if (!(PROC_IDLE)) begin
            satp_update <=0;
        end
    end
    //Handling Privilage System instruction and Read from CSR Registers
    always@(*)
    begin
       
        
        
        
        case ( CSR_ADDRESS )
            ustatus        :    OUTPUT_DATA =  ustatus_r     ;
            uie            :    OUTPUT_DATA =  uie_r         ;
            utvec          :    OUTPUT_DATA =  utvec_r       ;
            uscratch       :    OUTPUT_DATA =  uscratch_r    ;
            uepc           :    OUTPUT_DATA =  uepc_r        ;
            ucause         :    OUTPUT_DATA =  ucause_r      ;
            utval          :    OUTPUT_DATA =  utval_r       ;
            uip            :    OUTPUT_DATA =  uip_r         ;
/*          fflags         :    OUTPUT_DATA =  fflags_r      ;
            frm            :    OUTPUT_DATA =  frm_r         ;
            fcsr           :    OUTPUT_DATA =  fcsr_r        ;     */
            cycle          :    OUTPUT_DATA =  cycle_r       ;
            timer          :    OUTPUT_DATA =  cycle_r       ;
            instret        :    OUTPUT_DATA =  instret_r     ;
/*          hpmcounter3    :    OUTPUT_DATA =  hpmcounter3_r ;
            hpmcounter4    :    OUTPUT_DATA =  hpmcounter4_r ;
            hpmcounter31   :    OUTPUT_DATA =  hpmcounter31_r;      */
//             cycleh         :    OUTPUT_DATA =  cycleh_r      ;
// //            timeh          :    OUTPUT_DATA =  timerh_r      ;
//             instreth       :    OUTPUT_DATA =  instreth_r    ;
/*          hpmcounter3h   :    OUTPUT_DATA =  hpmcounter3h_r;
            hpmcounter4h   :    OUTPUT_DATA =  hpmcounter4h_r;
            hpmcounter31h  :    OUTPUT_DATA =  hpmcounter31h_r; */
            sstatus        :    OUTPUT_DATA =  sstatus_r     ;
            sedeleg        :    OUTPUT_DATA =  sedeleg_r     ;
            sideleg        :    OUTPUT_DATA =  sideleg_r     ;
            sie            :    OUTPUT_DATA =  sie_r         ;
            stvec          :    OUTPUT_DATA =  stvec_r       ;
            scounteren     :    OUTPUT_DATA =  scounteren_r  ;
            sscratch       :    OUTPUT_DATA =  sscratch_r    ;
            sepc           :    OUTPUT_DATA =  sepc_r        ;
            scause         :    OUTPUT_DATA =  scause_r      ;
            stval          :    OUTPUT_DATA =  stval_r       ;
            sip            :    OUTPUT_DATA =  sip_r         ;
            satp           :    OUTPUT_DATA =  satp_r        ;
            mvendorid      :    OUTPUT_DATA =  mvendorid_r   ;
            marchid        :    OUTPUT_DATA =  marchid_r     ;
            mimpid         :    OUTPUT_DATA =  mimpid_r      ;
            mhartid        :    OUTPUT_DATA =  mhartid_r     ;
            mstatus        :    OUTPUT_DATA =  mstatus_r     ;
            misa           :    OUTPUT_DATA =  misa_r        ;
            medeleg        :    OUTPUT_DATA =  medeleg_r     ;
            mideleg        :    OUTPUT_DATA =  mideleg_r     ;
            mie            :    OUTPUT_DATA =  mie_r         ;
            mtvec          :    OUTPUT_DATA =  mtvec_r       ;
            mcounteren     :    OUTPUT_DATA =  mcounteren_r  ;
            mscratch       :    OUTPUT_DATA =  mscratch_r    ;
            mepc           :    OUTPUT_DATA =  mepc_r        ;
            mcause         :    OUTPUT_DATA =  mcause_r      ;
            mtval          :    OUTPUT_DATA =  mtval_r       ;
            mip            :    OUTPUT_DATA =  mip_r         ;
            pmpcfg0        :    OUTPUT_DATA =  pmpcfg0_r     ;
            pmpcfg1        :    OUTPUT_DATA =  pmpcfg1_r     ;
            pmpcfg2        :    OUTPUT_DATA =  pmpcfg2_r     ;
            pmpcfg3        :    OUTPUT_DATA =  pmpcfg3_r     ;
            pmpaddr0       :    OUTPUT_DATA =  pmpaddr0_r    ;
            pmpaddr1       :    OUTPUT_DATA =  pmpaddr1_r    ;
            pmpaddr2       :    OUTPUT_DATA =  pmpaddr2_r    ;
            pmpaddr3       :    OUTPUT_DATA =  pmpaddr3_r    ;
            pmpaddr4       :    OUTPUT_DATA =  pmpaddr4_r    ;
            pmpaddr5       :    OUTPUT_DATA =  pmpaddr5_r    ;
            pmpaddr6       :    OUTPUT_DATA =  pmpaddr6_r    ;
            pmpaddr7       :    OUTPUT_DATA =  pmpaddr7_r    ;  
            mcycle         :    OUTPUT_DATA =  mcycle_r      ;
            minstret       :    OUTPUT_DATA =  minstret_r    ;
/*          mhpmcounter3   :    OUTPUT_DATA =  mhpmcounter3_r;
            mhpmcounter4   :    OUTPUT_DATA =  mhpmcounter4_r;
            mhpmcounter31  :    OUTPUT_DATA =  mhpmcounter31_r; */
         
         // minstreth      :    OUTPUT_DATA =  minstreth_r   ;
/*          mhpmcounter3h  :    OUTPUT_DATA =  mhpmcounter3h_r;
            mhpmcounter4h  :    OUTPUT_DATA =  mhpmcounter4h_r;
            mhpmcounter31h :    OUTPUT_DATA =  mhpmcounter31h_r;
            mhpmevent3     :    OUTPUT_DATA =  mhpmevent3_r   ;
            mhpmevent4     :    OUTPUT_DATA =  mhpmeven5t4_r   ;
            mhpmevent31    :    OUTPUT_DATA =  mhpmevent31_r  ;
            tselect        :    OUTPUT_DATA =  tselect_r      ;
            tdata1         :    OUTPUT_DATA =  tdata1_r       ;
            tdata2         :    OUTPUT_DATA =  tdata2_r       ;
            tdata3         :    OUTPUT_DATA =  tdata3_r       ;
            dcsr           :    OUTPUT_DATA =  dcsr_r         ;
            dpc            :    OUTPUT_DATA =  dpc_r          ;
            dscratch       :    OUTPUT_DATA =  dscratch_r     ;  */
            default        :    OUTPUT_DATA =  32'b0          ;
        endcase
        
        
        
        //exception/interupt finding combo
        if(fault_while_idle) begin
            ecode_reg     =   ecode_while_idle    ;
            interrupt     =   1'b0     ;
            exception     =   1'b1     ;
        end
        else if(LD_ACC_FAULT) begin
            ecode_reg     =   31'd5    ;
            interrupt     =   1'b0     ;
            exception     =   1'b1     ;
        end
        
        else if(STORE_ACC_FAULT) begin 
            ecode_reg     =   31'd7    ;
            interrupt     =   1'b0     ;
            exception     =   1'b1     ;
        end

        else if(LD_PAGE_FAULT) begin 
            ecode_reg     =   31'd13    ;
            interrupt     =   1'b0     ;
            exception     =   1'b1     ; 
        end
        else if(STORE_PAGE_FAULT) begin
            ecode_reg     =   31'd15    ;
            interrupt     =   1'b0     ;
            exception     =   1'b1     ; 
        end
        else if( meie & MEIP) begin
            ecode_reg     =   31'd11   ;
            interrupt     =   1'b1     ;    
            exception     =   1'b0     ;
        end
        else if( mtie & MTIP & m_ie) begin
            ecode_reg     =   31'd7    ;
            interrupt     =   1'b1     ;
            exception     =   1'b0     ;

        end
        else if( msie & MSIP) begin
            ecode_reg     =   31'd3    ;
            interrupt     =   1'b1     ;
            exception     =   1'b0     ; 
        end
        else if(seie & SEIP) begin
            ecode_reg     =   31'd9   ;
            interrupt     =   1'b1     ;
            exception     =   1'b0     ;    
        end
        else if( stie & STIP & s_ie) begin
            ecode_reg     =   31'd5    ;
            interrupt     =   1'b1     ;
            exception     =   1'b0     ; 
        end
        else if(ssie & SSIP) begin
            ecode_reg     =   31'd2    ;
            interrupt     =   1'b1     ;
            exception     =   1'b0     ; 
        end
        else if(ueie & UEIP) begin
            ecode_reg     =   31'd8   ;
            interrupt     =   1'b1     ;
            exception     =   1'b0     ;    
        end
        else if( utie & UTIP) begin
            ecode_reg     =   31'd4   ;
            interrupt     =   1'b1     ;
            exception     =   1'b0     ; 
        end
        else if( usie & USIP) begin
            ecode_reg     =   31'd0    ;
            interrupt     =   1'b1     ;
            exception     =   1'b0     ; 
        end
        
        else if(INS_PAGE_FAULT) begin
            ecode_reg     =   31'd12    ;
            interrupt     =   1'b0     ; 
            exception     =   1'b1     ; 
        end
        else if(INS_ACC_FAULT) begin
            ecode_reg     =   31'd1    ;
            interrupt     =   1'b0     ;
            exception     =   1'b1     ; 
        end
        
        
        else if(CSR_CNT == sys_ecall  && curr_prev == mmode) begin
            ecode_reg     =   31'd11   ;
            interrupt     =   1'b0     ;
            exception     =   1'b1     ; 
        end
        else if(CSR_CNT == sys_ecall  && curr_prev == smode) begin
            ecode_reg     =   31'd9    ;
            interrupt     =   1'b0     ;
            exception     =   1'b1     ; 
        end
        else if(CSR_CNT == sys_ecall  && curr_prev == umode) begin
            ecode_reg     =   31'd8    ;
            interrupt     =   1'b0     ;
            exception     =   1'b1     ; 
        end
        else if (ILL_INS|illegal_access) begin
            ecode_reg     =   31'd2    ;
            interrupt     =   1'b0     ;
            exception     =   1'b1     ;        
        end
        else if(CSR_CNT == sys_ebreak) begin
            ecode_reg     =   31'd3    ;
            interrupt     =   1'b0     ;
            exception     =   1'b1     ; 
        end
        else if(INS_ADDR_MISSALIG) begin
            ecode_reg     =   31'd0    ;
            interrupt     =   1'b0     ;
            exception     =   1'b1     ; 
        end
        else if (LD_ADDR_MISSALIG) begin
            ecode_reg     =   31'd4    ;
            interrupt     =   1'b0     ;
            exception     =   1'b1     ; 
        end
        else if(STORE_ADDR_MISSALIG) begin
            ecode_reg     =   31'd6    ;
            interrupt     =   1'b0     ;
            exception     =   1'b1     ; 
        end

        else begin
            ecode_reg     =   31'd0     ;     //Must think of default ecode value
            interrupt     =   1'b0     ; 
            exception     =   1'b0     ;
        end
        if(interrupt) begin
            if(curr_prev==mmode) begin
                if(m_ie) begin
                    interrupt_final     =1'b1   ;
                    handling_priviledge =mmode  ;
                end
                else begin
                    handling_priviledge = mmode ;
                    interrupt_final     =1'b0   ;
                end
            end
            else if (curr_prev==smode) begin
                if(mideleg_reg[ecode_reg]) begin
                    if( s_ie) begin
                        interrupt_final = 1'b1          ;
                        handling_priviledge = smode     ;
                    end
                    else begin
                        interrupt_final = 1'b0          ;
                        handling_priviledge = smode     ;
                    end
                end

                else begin
                    if(m_ie) begin
                        interrupt_final          =1'b1   ;
                        handling_priviledge     =mmode  ;
                    end
                    else begin
                        handling_priviledge = mmode ;
                        interrupt_final     =1'b0   ;
                    end
                end
            end
            else begin //umode
                if(mideleg_reg[ecode_reg]) begin
                    if(sideleg_reg[ecode_reg]) begin
                        if( u_ie) begin
                            interrupt_final = 1'b1          ;
                            handling_priviledge = umode     ;
                        end
                        else begin
                            interrupt_final = 1'b0          ;
                            handling_priviledge = umode     ;
                        end
                    end

                    else begin
                        if(s_ie) begin
                            interrupt_final          =1'b1   ;
                            handling_priviledge     =smode  ;
                        end
                        else begin
                            handling_priviledge = smode ;
                            interrupt_final     =1'b0   ;
                        end
                    end                 

                end

                else begin
                    if(m_ie) begin
                        interrupt_final          =1'b1   ;
                        handling_priviledge     =mmode  ;
                    end
                    else begin
                        handling_priviledge = mmode ;
                        interrupt_final     =1'b0   ;
                    end
                end
            end
        end
        else begin
            if(curr_prev==mmode) begin
                
                handling_priviledge = mmode ;
                interrupt_final     =1'b0   ;
                
            end
            else if (curr_prev==smode) begin
                if(medeleg_reg[ecode_reg]) begin

                    interrupt_final = 1'b0          ;
                    handling_priviledge = smode     ;
                end
                else begin
                    handling_priviledge = mmode ;
                    interrupt_final     =1'b0   ;
                end
            end
            else begin //umode
                if(medeleg_reg[ecode_reg]) begin
                    if(sedeleg_reg[ecode_reg]) begin
                        interrupt_final = 1'b0          ;
                        handling_priviledge = umode     ;
                    end
                    else begin
                        handling_priviledge = smode ;
                        interrupt_final     =1'b0   ;
                    end                 

                end

                else begin

                    handling_priviledge = mmode ;
                    interrupt_final     =1'b0   ;
                end
            end
            
        end
        if(interrupt_final)  begin
            if(handling_priviledge==mmode) begin
                if (mt_mode==2'b1) begin
                    PRIV_JUMP_ADD = {mt_base,2'b0}+4*ecode_reg;
                end
                else begin
                    PRIV_JUMP_ADD = {mt_base,2'b0};
                end

            end
            else if(handling_priviledge==smode) begin
                if (st_mode==2'b1) begin
                    PRIV_JUMP_ADD = {st_base,2'b0}+4*ecode_reg;
                end
                else begin
                    PRIV_JUMP_ADD = {st_base,2'b0};
                end
            end
            else begin
                if (ut_mode==2'b1) begin
                    PRIV_JUMP_ADD = {ut_base,2'b0}+4*ecode_reg;
                end
                else begin
                    PRIV_JUMP_ADD = {ut_base,2'b0};
                end
            end

        end
        else if(exception)
        begin
            if(handling_priviledge==mmode) begin
                PRIV_JUMP_ADD = {mt_base,2'b0};
            end
            else if(handling_priviledge==smode) begin
                PRIV_JUMP_ADD = {st_base,2'b0};
            end
            else begin
                PRIV_JUMP_ADD = {ut_base,2'b0};
            end
        end
        else if( CSR_CNT==sys_mret) begin
            PRIV_JUMP_ADD = mepc_reg;
        end
        else if( CSR_CNT==sys_sret) begin
            PRIV_JUMP_ADD = sepc_reg;
        end
        else begin
            PRIV_JUMP_ADD = uepc_reg;
        end

    end
    integer dump_file;
    initial dump_file=$fopen("rtllog.log","w");
    //Write to CSR Registers and Increment counters
    always@(posedge CLK)
    begin 
        if(RST) begin
             mcycle_reg <=0;  
        end  
        // else if(!PROC_IDLE & (CSR_ADDRESS==mcycle) & !(interrupt_final | exception) & csr_op) begin
        //      mcycle_reg   <= input_data_final        ;
        // end
        else begin
             mcycle_reg   <= mcycle_reg + 1'b1       ;
        end
        if(RST) begin
            fault_while_idle <=0;
            err_addr_while_idle <=0;
        end
        else if (PROC_IDLE) begin
			if( LD_PAGE_FAULT|STORE_PAGE_FAULT|LD_ACC_FAULT|STORE_ACC_FAULT) begin

           		fault_while_idle <=1;
            	err_addr_while_idle <= err_addr;
            	pc_while_idle <= PC_EX_MEM1;
            	ecode_while_idle <= ecode_reg;
			end
            // if(LD_PAGE_FAULT|STORE_PAGE_FAULT|LD_ACC_FAULT|STORE_ACC_FAULT) begin
            //     $display("idle page fault");
            // end
        end
        else begin
            fault_while_idle <=0;
        end
        
        if(RST)
        begin
            minsret_reg <= 0;
            TSR            <= 0     ;                                                                                             
            TVM            <= 0     ;                                                                                             
            TW             <= 0     ;                                                                                             
             fs <=1'b1;   
             uxl<=2'b10;
             sxl<=2'b0;                                                                                                                                                                                                    
            {mxr,sum,mprv,mpp,spp,mpie,spie,upie,m_ie,s_ie,u_ie}           <= 32'b110        ;                        
            {heip,seip,ueip,htip,stip,utip,hsip,ssip,usip}                    <= 9'd0                    ;                        
            {meie,heie,seie,ueie,mtie,htie,stie,utie,msie,hsie,ssie,usie}     <= 12'd0                   ;                        
            mpp             <=2'b0                      ;                                                                    
            mt_base       <=0                            ;    
            mt_mode       <=0                            ;    
            medeleg_reg   <=0                            ;    
            mideleg_reg   <=0                                ;
            mcycle_reg    <=0                            ;    
            minsret_reg   <=0                            ;    
            {mir,mtm,mcy}   <=0                            ;    
            mscratch_reg  <=0                            ;    
            mepc_reg      <=0                            ;    
            mtval_reg     <=0                            ;    
            mecode_reg    <=0                            ;    
            minterrupt    <=0                            ;    
                  {smode_reg,asid,ppn}  <=0;                            
                                                
            st_base       <=0                            ;    
            st_mode       <=0                            ;    
            sedeleg_reg   <=0                            ;    
            sideleg_reg   <=0                            ;    
            sinsret_reg   <=0                            ;    
            {sir,stm,scy}   <=0                            ;    
            sscratch_reg  <=0                            ;    
            sepc_reg      <=0                            ;    
            stval_reg     <=0                            ;    
            secode_reg    <=0                            ;    
            sinterrupt    <=0                            ;    
            curr_prev     <=mmode                           ;    
            uinterrupt <=0;
            uecode_reg <=0;
            ut_mode <=0;
            ut_base <=0;
            uinsret_reg <=0;
            misa_reg<= (64'b101000001000100000001 | (1<<63)); 
             err_addr <= 0;  
             uepc_reg <=0;                                                                                                       
                                                                                                                
            pmpaddr0_r <=0;
            pmpaddr1_r <=0;
            pmpaddr2_r <=0;
            pmpaddr3_r <=0;
            pmpaddr4_r <=0;
            pmpaddr5_r <=0;
            pmpaddr7_r <=0;
            pmpaddr6_r <=0;
                                                                                                                              

        end
        else if (!PROC_IDLE) begin
      
            //external interupts >> software interupts >> timer interupts >> synchornous trapsL:
             
            
            err_addr <=ERR_ADDR;
            minsret_reg <= minsret_reg + 1'b1   ;
            if(minsret_reg%100000==0) begin
                $display(minsret_reg, " %h %h",PC,INS_FB_EX);
            end
                    if(exception) begin 
                        if (ecode_reg == 9) begin
                  //          $fatal("system call : %h " ,PC);
                        end
                    end
            if(interrupt_final|exception) begin
                if(handling_priviledge==mmode) begin
                    mpp <= curr_prev;
                    mpie <= m_ie;
                    mecode_reg<=ecode_reg;
                    m_ie <=0;
                    curr_prev <= mmode;
                    minterrupt <= interrupt_final;
                    if(fault_while_idle) begin
                        mepc_reg <= pc_while_idle;
                        mtval_reg <= err_addr;
                    end
                    else if(LD_ACC_FAULT|LD_PAGE_FAULT| STORE_PAGE_FAULT| STORE_ACC_FAULT) begin
                        mepc_reg <= PC_EX_MEM1;
                        mtval_reg <= err_addr;

                    end
                    else if(STORE_ADDR_MISSALIG | LD_ADDR_MISSALIG ) begin
                        mtval_reg <= ERR_ADDR;
                        mepc_reg <= PC;

                    end
                    else if(INS_ACC_FAULT|INS_PAGE_FAULT) begin
                        mtval_reg<=PC;
                        mepc_reg <=PC;

                    end
                    else if(INS_ADDR_MISSALIG) begin
                        mtval_reg <= JUMP_ADD;
                        mepc_reg <= PC;

                    end
                    else if(ILL_INS|illegal_access) begin
                        mtval_reg <=INS_FB_EX;
                        mepc_reg <= PC;

                    end
                    else begin
                        mtval_reg<=0;
                        mepc_reg <=PC;

                    end


                end
                else if (handling_priviledge==smode) begin
                    spp <= curr_prev;
                    spie <= s_ie;
                    sepc_reg <= PC;
                    s_ie <=0;
                    curr_prev <= smode;
                    sinterrupt <= interrupt_final;
                    secode_reg <= ecode_reg;

                    if(fault_while_idle) begin
                        sepc_reg <= pc_while_idle;
                        stval_reg <= err_addr_while_idle;
                        // $finish;
                    end
                    else if((LD_ACC_FAULT|LD_PAGE_FAULT| STORE_PAGE_FAULT| STORE_ACC_FAULT)) begin
                        sepc_reg <= PC_EX_MEM1;
                        stval_reg <= err_addr;

                    end
                    else if(STORE_ADDR_MISSALIG | LD_ADDR_MISSALIG) begin
                        stval_reg <= ERR_ADDR;
                        sepc_reg <= PC;

                    end
                    else if(INS_ACC_FAULT|INS_PAGE_FAULT) begin
                        stval_reg<=PC;
                        sepc_reg <=PC;

                    end
                    else if(INS_ADDR_MISSALIG) begin
                        stval_reg <= JUMP_ADD;
                        sepc_reg <= PC;

                    end
                    else if(ILL_INS|illegal_access) begin
                        stval_reg <=INS_FB_EX;
                        sepc_reg <= PC;

                    end
                    else begin
                        stval_reg<=0;
                        sepc_reg <=PC;

                    end
                   
                    
                        
                 
                end   
                else begin
                    upie <= u_ie;
                    uepc_reg <= PC;
                    u_ie <=0;
                    curr_prev <= umode;
                    sinterrupt <= interrupt_final;
                    uecode_reg <= ecode_reg ;

                    if(fault_while_idle) begin
                        uepc_reg <= pc_while_idle;
                        utval_reg <= err_addr_while_idle;
                    end
                    else if((LD_ACC_FAULT|LD_PAGE_FAULT| STORE_PAGE_FAULT| STORE_ACC_FAULT)) begin
                        uepc_reg <= PC_EX_MEM1;
                        utval_reg <= err_addr;

                    end
                    else if(STORE_ADDR_MISSALIG | LD_ADDR_MISSALIG) begin
                        utval_reg <= ERR_ADDR;
                        uepc_reg <= PC;

                    end
                    else if(INS_ACC_FAULT|INS_PAGE_FAULT) begin
                       utval_reg<=PC;
                        uepc_reg <=PC;

                    end
                    else if(INS_ADDR_MISSALIG) begin
                        utval_reg <= JUMP_ADD;
                        uepc_reg <= PC;

                    end
                    else if(ILL_INS|illegal_access) begin
                        utval_reg <=INS_FB_EX;
                        uepc_reg <= PC;

                    end
                    else begin
                        utval_reg<=0;
                        uepc_reg <=PC;

                    end

                end
            end
            else if( CSR_CNT == sys_mret) begin
                curr_prev <= mpp;
                mpie     <= 1'b1;
                m_ie     <= mpie;

            end
            else if( CSR_CNT == sys_sret) begin
                curr_prev <= spp;
                spie     <= 1'b1;
                s_ie     <= spie;
            

            end
            else if( CSR_CNT == sys_uret) begin
                curr_prev <= umode;
                upie     <= 1'b1;
                u_ie     <= upie;

            end
            else if (csr_op)begin
                case (CSR_ADDRESS)
                    ustatus         :   {upie,u_ie}         <=  {
                                                                input_data_final[4]         ,
                                                                input_data_final[0]
                                                                }                           ;
                    uie            :    {ueie,utie,usie}    <=  {
                                                                input_data_final[8]         ,
                                                                input_data_final[4]         ,
                                                                input_data_final[0]
                                                                }                           ;
                    utvec          :    {ut_base,ut_mode}   <=  input_data_final            ;   
                    uscratch       :    uscratch_reg        <=  input_data_final            ;
                    uepc           :    uepc_reg            <=  input_data_final            ;
                    ucause         :    {uinterrupt,
                                               uecode_reg}  <=  input_data_final            ;
                    utval          :    utval_reg           <=  input_data_final            ;
                    uip            :    {ueip,utip,usip}    <=  {
                                                                input_data_final[8]         ,
                                                                input_data_final[4]         ,
                                                                input_data_final[0]
                                                                }                           ;
                    sstatus        :    {fs,uxl,mxr,sum,spp,spie,
                                        upie,s_ie,u_ie}     <=  {
                                                                input_data_final[14:13] ,
                                                                input_data_final[33:32] ,
                                                                input_data_final[19:18]     ,
                                                                input_data_final[8]         ,
                                                                input_data_final[5:4]       ,
                                                                input_data_final[1:0]
                                                                }                           ;
                    sedeleg        :    sedeleg_reg         <=  input_data_final            ;
                    sideleg        :    sideleg_reg         <=  input_data_final            ;
                    sie            :    {seie,ueie,stie,
                                        utie,ssie,usie}     <=  {
                                                                input_data_final[9:8]       ,
                                                                input_data_final[5:4]       ,
                                                                input_data_final[1:0]
                                                                }                           ;
                    stvec          :    {st_base,st_mode}   <=  input_data_final            ;
                    scounteren     :    {sir,stm,scy}       <=  input_data_final[2:0]       ;
                    sscratch       :    sscratch_reg        <=  input_data_final            ;
                    sepc           :    sepc_reg            <=  input_data_final            ;
                    scause         :    {sinterrupt,
                                         secode_reg}        <=  input_data_final            ;
                    stval          :    stval_reg           <=  input_data_final            ;
                    sip            :    {seip,ueip,stip,
                                         utip,ssip,usip}    <=  {
                                                                input_data_final[9:8]       ,
                                                                input_data_final[5:4]       ,
                                                                input_data_final[1:0]
                                                                }                           ;
                    satp           :    begin
                                             {   smode_reg,asid,ppn}          <=  input_data_final            ;

                                             
                                        end
                    mstatus        :    {sxl,uxl,TSR,TW,TVM,
                                        mxr,sum,mprv,fs,mpp,
                                        spp,mpie,spie,
                                        upie,m_ie,
                                        s_ie,u_ie}          <={ input_data_final[35:32]     ,
                                                                input_data_final[22:17]     ,
                                                              
                                                                input_data_final[14:11]     ,
                                                                input_data_final[8:7]       ,
                                                                input_data_final[5:3]       ,
                                                                input_data_final[1:0]
                                                                }                           ;
                    medeleg        :    medeleg_reg         <=  input_data_final            ;
                    mideleg        :    mideleg_reg         <=  input_data_final            ;
                    mie            :    {meie,seie,ueie,
                                        mtie,stie,utie,
                                        msie,ssie,usie}     <=  {
                                                                input_data_final[11]        ,
                                                                input_data_final[9:7]       ,
                                                                input_data_final[5:3]       ,
                                                                input_data_final[1:0]
                                                                }                           ;
                    pmpcfg0        :    pmpcfg0_r            <= input_data_final            ;
                    pmpcfg1        :    pmpcfg1_r            <= input_data_final            ;
                    pmpcfg2        :    pmpcfg2_r            <= input_data_final            ;
                    pmpcfg3        :    pmpcfg3_r            <= input_data_final            ;
                    pmpaddr0       :    pmpaddr0_r          <= input_data_final             ;
                    pmpaddr1       :    pmpaddr1_r          <= input_data_final             ;
                    pmpaddr2       :    pmpaddr2_r          <= input_data_final             ;
                    pmpaddr3       :    pmpaddr3_r          <= input_data_final             ;
                    pmpaddr4       :    pmpaddr4_r          <= input_data_final             ;
                    pmpaddr5       :    pmpaddr5_r          <= input_data_final             ;
                    pmpaddr6       :    pmpaddr6_r          <= input_data_final             ;
                    pmpaddr7       :    pmpaddr7_r          <= input_data_final             ;
                    mtvec          :    {mt_base,mt_mode}   <=  input_data_final            ;
                    mcounteren     :    {mir,mtm,mcy}       <=  input_data_final[2:0]       ;
                    mscratch       :    mscratch_reg        <=  input_data_final            ;
                    mepc           :    mepc_reg            <=  input_data_final            ;
                    mcause         :    {minterrupt,
                                        mecode_reg}         <=  input_data_final            ;
                    mtval          :    mtval_reg           <=  input_data_final            ;
                    mip            :    {seip,ueip,stip,
                                        utip,ssip,usip}     <=  {
                                                                input_data_final[9:8]       ,
                                                                input_data_final[5:4]       ,
                                                                input_data_final[1:0]
                                                                }                           ;
                    // mcycle         :    mcycle_reg          <=  input_data_final            ;
                    minstret       :    minsret_reg         <=  input_data_final            ;
                    misa           :    misa_reg            <= input_data_final             ;
                   
                    default        :    ; 
                endcase
            end
        end
        
        
     
    end
    
    assign  PRIV_JUMP       = exception | (CSR_CNT==sys_uret) | (CSR_CNT==sys_sret) | (CSR_CNT==sys_mret) | (interrupt_final)  ;
    assign TIME_INT_WAIT    = STIP & stie & s_ie;
    assign  MPP             =mpp;
    assign  CURR_PREV       =curr_prev;
    assign SATP = satp_r;
    assign MPRV = mprv;
endmodule

                     
