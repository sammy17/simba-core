`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:  Vithurson Subasharan
// 
// Create Date: 08/11/2016 09:46:32 PM
// Design Name: 
// Module Name: EXSTAGE
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


module EXSTAGE(
    input                   CLK                     ,
    input                   RST                     ,
    input signed    [63:0]  COMP1                   ,
    input signed    [63:0]  COMP2                   ,
    input           [63:0]  COMP1_U                 ,
    input           [63:0]  COMP2_U                 ,
    input           [63:0]  JUMP_BUS1               ,
    input           [63:0]  JUMP_BUS2               ,  
    (* mark_debug = "true" *)  input           [63:0]  A                       ,
    (* mark_debug = "true" *)  input           [63:0]  B                       ,
    input signed    [63:0]  A_signed                ,
    input signed    [63:0]  B_signed                ,
    input           [63:0]  PC_FB_EX                ,
    input           [ 3:0]  ALU_CNT                 , 
    input                   JUMP                    ,
    input                   JUMPR                   ,
    input                   CBRANCH                 , 
    input           [63:0]  PC_ID_FB                ,
    input                   STALL_ENABLE_EX         ,
    input           [ 1:0]  DATA_CACHE_CONTROL_IN   ,     
    input           [ 2:0]  FUN3                    ,
    input           [ 3:0]  CSR_CNT                 ,
    input           [ 4:0]  ZIMM                    ,
    input                   CACHE_READY             ,
    input           [ 1:0]  TYPE_IN                 ,
     (* mark_debug = "true" *) input                   PROC_IDLE               ,
    
    input                   MEIP                    ,   //machine external interupt pending
    input                   MTIP                    ,   //machine timer interupt pending
    input                   MSIP                    ,   //machine software interupt pending, from external hart
    input           [63:0] emu_wb                   ,
    output                  JUMP_FINAL              ,
    output          [63:0]  WB_DATA                 ,   
    output reg      [63:0]  JUMP_ADDR               ,
    output reg      [63:0]  DATA_ADDRESS            ,
    output          [1 :0]  DATA_CACHE_CONTROL      ,
    output          [1 :0]  TYPE_OUT                ,
    output                  EXSTAGE_STALLED         ,//mstd
    output                  FLUSH_I                 ,
    output reg              FLUSH              ,
    output reg              PREDICTED               ,
    input                   FENCE          ,
    output                  FENCE_OUT             ,
    input        [4:0]      AMO_OP_in,
    output        [4:0]      AMO_OP_out,
   (* mark_debug="true" *) input        [31:0]     INS_FB_EX,
    input                   ILEGAL,
    input                   OPS_32,
    output                  OP_32_out,
    input [2:0] LDST_TYPE,
    input           PAGE_FAULT_INS,
    input           PAGE_FAULT_DAT,
    input           ACCESS_FAULT_INS,
    input           ACCESS_FAULT_DAT,
    input [1:0]     FAULT_TYPE,
    output      [1:0]   MPP,
    output              MPRV,
    output     [1:0]         CURR_PREV,
    output   [63:0]     SATP,
    input [63:0] PC_EX_MEM1,
    (* mark_debug="true" *) input SFENCE_in,
    (* mark_debug="true" *) output SFENCE,
    output LOAD_WORD,
    input CACHE_READY_INS

     
    );
    //     reg        comp_out;
    (* mark_debug = "true" *) wire [63:0] wb_data;

    `include "PipelineParams.vh"
    reg load_mis_al;
    reg store_mis_al;
    reg         jump_reg          ;
    reg         jumpr_reg         ;
    reg  [63:0] alu_ins [0:15]      ;               
    reg  [63:0] pc_ex_ex2           ;  
                 
    wire [63:0] lshift_out          ;           
    wire [63:0] rshift_out          ;           
    wire [63:0] rashift_out         ; 
    
    wire [31:0] rv32m_out           ;
    wire [63:0] rv64m_out           ;
    wire rv32ready;
    wire rv64ready;
    wire        rv32m_ready = rv32ready|rv64ready        ;

    wire [63:0] csr_out             ;
    wire [63:0] priv_jump_add       ; 
    wire        priv_jump           ;
    
    reg         flush_internal    ;
    reg         cache_ready_fb    ;
    reg         cache_ready_ex  ;
    reg         cache_ready_ex2   ;
    reg         cbranch             ;
    
       
    integer j;   
    
    reg         comp_out [0:7]      ;
    reg  [ 3:0] alu_cnt=alu_idle    ;
    reg  [ 2:0] fun3=no_branch      ;
    wire [63:0] jump_addr_for_non_priv_branch = (JUMP_BUS1+JUMP_BUS2);
 
    wire        comp_out_w          ; 
    wire TIME_INT_WAIT              ;
    initial
    begin
        for (j=0; j<=15 ; j = j+1)
        begin
            alu_ins[j]=0;
        end
        for (j=0; j<=7 ; j = j+1)
        begin
            comp_out[j]=0;
        end
    end
      
    Multiplexer #(
        .ORDER(4)       ,
        .WIDTH(64)  
    )alu_mux  (
        .SELECT(alu_cnt),
        .IN({
            alu_ins[15]     ,
            alu_ins[14]     ,
            alu_ins[13]     ,
            alu_ins[12]     ,
            alu_ins[11]     ,
            alu_ins[10]     ,
            alu_ins[9]      ,
            alu_ins[8]      ,
            alu_ins[7]      , 
            alu_ins[6]      ,
            alu_ins[5]      ,
            alu_ins[4]      ,
            alu_ins[3]      ,
            alu_ins[2]      ,
            alu_ins[1]      ,
            alu_ins[0]                     
        }), 
        .OUT(wb_data) 
        );   
        wire [31:0] add32 = A[31:0] + B[31:0];
        wire [31:0] sub32 = B[31:0] +{~A[31:0] + 32'd1} ; 
        wire [31:0] sll32   = B[31:0] << A[4:0] ; 
        wire [31:0] srl32   = B[31:0] >> A[4:0];
        wire [31:0] sra32  = $signed(B_signed[31:0]) >>> A[4:0];               
    always@(*)
    begin
            alu_cnt             <=      ALU_CNT                         ;
            alu_ins[alu_xor ]   <=      A^B                             ;    
            alu_ins[alu_or  ]   <=      B|A                             ;                     
            alu_ins[alu_and ]   <=      A&B                             ;                   
            alu_ins[alu_a   ]   <=      A                               ;                        
            alu_ins[alu_b   ]   <=      B                               ;                       
            alu_ins[alu_slt ]   <=      {63'd0,B_signed < A_signed}     ;
            alu_ins[alu_b4  ]   <=      B+32'd4                         ; 
            alu_ins[alu_idle]   <=      63'b0                           ;
            alu_ins[alu_csr ]   <=      csr_out                         ;  
            alu_ins[alu_sltu]   <=      {63'd0,B<A}                     ;                   
              


        if (!OPS_32)
        begin
            alu_ins[alu_add ]   <=      {A + B}                         ;                   
            alu_ins[alu_sub ]   <=      B +{~A + 32'd1}                 ;                       
            alu_ins[alu_sll ]   <=      B <<A[5:0]                     ;                 
            alu_ins[alu_srl ]   <=      B >> A[5:0]                     ;                     
            alu_ins[alu_sra ]   <=      B_signed >>>A[5:0]              ;                     
         
            alu_ins[alu_mstd]   <=      rv64m_out                       ;
        end   
        else
        begin
            alu_ins[alu_add ]   <=      {{32{add32[31]}},add32}                         ;                   
            alu_ins[alu_sub ]   <=      {{32{sub32[31]}},sub32}                 ;                       
            alu_ins[alu_sll ]   <=       {{32{sll32[31]}},sll32}                      ;                 
            alu_ins[alu_srl ]   <=       {{32{srl32[31]}},srl32}                     ;                     
            alu_ins[alu_sra ]   <=       {{32{sra32[31]}},sra32}              ;                     
            alu_ins[alu_mstd]   <=      {{32{rv32m_out[31]}},rv32m_out}           ;
        end   
    end      
    wire satp_update;  

        
    CSR_FILE csr_file(
        .CLK(CLK),
        .PC(PC_FB_EX),
        .CSR_CNT(CSR_CNT),
        .CSR_ADDRESS(A[11:0]),
        .RS1_DATA(COMP1),
        .ZIMM(ZIMM),
        .OUTPUT_DATA(csr_out),
        .PRIV_JUMP_ADD(priv_jump_add),
        .PROC_IDLE(PROC_IDLE| FENCE| SFENCE_in),
        .PRIV_JUMP(priv_jump),
        .MEIP(MEIP),   
        .MTIP(1'b0),   
        .STIP(MTIP),   
        .MSIP(MSIP)  ,
        .RST(RST)   ,
        .ILL_INS(ILEGAL)   ,
        .INS_ADDR_MISSALIG((cbranch ? comp_out_w :jump_reg|jumpr_reg )? &jump_addr_for_non_priv_branch[1:0]: 0),


        .INS_ACC_FAULT(ACCESS_FAULT_INS),
        .INS_PAGE_FAULT(PAGE_FAULT_INS),



        .LD_ACC_FAULT(ACCESS_FAULT_DAT & (FAULT_TYPE==1)),
        .LD_PAGE_FAULT(PAGE_FAULT_DAT & (FAULT_TYPE==1)),

        .LD_ADDR_MISSALIG(load_mis_al),
        .STORE_ADDR_MISSALIG(store_mis_al),




        .STORE_PAGE_FAULT(PAGE_FAULT_DAT & (FAULT_TYPE==2)),
        .STORE_ACC_FAULT(ACCESS_FAULT_DAT & (FAULT_TYPE==2)),


        .ERR_ADDR(wb_data),
        .MPRV(MPRV),
        .SATP(SATP),
        .CURR_PREV(CURR_PREV),
        .MPP(MPP),
        .PC_EX_MEM1(PC_EX_MEM1),
        .JUMP_ADD(jump_addr_for_non_priv_branch),
        .INS_FB_EX(INS_FB_EX),
        .satp_update(satp_update),
        .TIME_INT_WAIT(TIME_INT_WAIT)

        );
        
    RV32M rv3m(
        .CLK(CLK),
        .STALL(!OPS_32),
         .RST(RST),
        .START((ALU_CNT==alu_mstd)& OPS_32& !flush_internal),
        .M_CNT(FUN3),
        .RS1(B),
        .RS2(A),
        .OUT(rv32m_out),
        .READY(rv32ready) 
        );    
RV32M 
#(.INPUT_WIDTH(64)

)
rv64m
    (
        .CLK(CLK),
        .RST(RST),
        .STALL(OPS_32),
        .START((ALU_CNT==alu_mstd) & !OPS_32 & !flush_internal),
        .M_CNT(FUN3),
        .RS1(B),
        .RS2(A),
        .OUT(rv64m_out),
        .READY(rv64ready) 
        );
        
    
                 
    reg  [1:0]  data_cache_control  ;
    reg         flush_out           ;
    
    reg  [1:0]  type_out            ;
    
    (* keep = "true" *) reg [3:0] counter_1=0;
    (* keep = "true" *) reg [3:0] counter_2=0;  
      
    always@(*)
    begin
        if (1)
        begin
            cbranch             <= CBRANCH                      ;
            fun3                <= FUN3                         ;
            comp_out[beq]       <= COMP1 == COMP2               ; 
            comp_out[bne]       <= COMP1 != COMP2               ;
            comp_out[blt]       <= COMP1 < COMP2                ;
            comp_out[bge]       <= COMP1 >= COMP2               ;
            comp_out[bltu]      <= COMP1_U < COMP2_U            ;
            comp_out[bgeu]      <= COMP1_U >= COMP2_U           ;
            pc_ex_ex2           <= PC_FB_EX                     ;
                   
            data_cache_control  <= DATA_CACHE_CONTROL_IN        ;
            type_out            <= TYPE_IN                      ;
            
            JUMP_ADDR           <= (FENCE|SFENCE_in)? PC_FB_EX+4 : (satp_update?PC_FB_EX :(priv_jump ? priv_jump_add : (JUMP_BUS1+JUMP_BUS2)))    ;  
            jump_reg            <= JUMP                                                 ;          
            jumpr_reg           <= JUMPR                                                ;
            DATA_ADDRESS        <= (A_signed+B_signed)                                  ;
        end
    end
    reg crd;
    Multiplexer #(
        .ORDER(3),
        .WIDTH(1)  
    )comp  (
        .SELECT(fun3),
        .IN({
            comp_out[7],
            comp_out[6],
            comp_out[5],
            comp_out[4],
            2'b0       ,
            comp_out[1],
            comp_out[0]             
           }),
        .OUT(comp_out_w)
        );             
    
    always@(posedge CLK)
    begin
        if(RST)
        begin
            FLUSH <=0;
            flush_internal<=0;
            counter_1<=0;
            counter_2 <=0;
            cache_ready_ex <= 0;
            cache_ready_ex2 <=0;
            

            // flush_out
        end
        else if (CACHE_READY)
        begin

             // cache_ready_fb <= 1                ;
             cache_ready_ex <= 1   ;
             cache_ready_ex2<= cache_ready_ex   ;
             
             if (JUMP_FINAL)
             begin
                flush_internal      <=    (PC_ID_FB!=JUMP_ADDR) | FENCE  | SFENCE_in|satp_update;
             end
             else if (STALL_ENABLE_EX & !flush_internal & cache_ready_ex2)
             begin
                flush_internal      <=    PC_ID_FB!=PC_FB_EX+4;
             end
             else if (counter_2 == 3'd5)
             begin
                flush_internal<=1'b0;
             end
             ////////////////////////////
             if (FLUSH)
             begin
                counter_1    <= counter_1 + 1; 
             end
             else 
             begin
                counter_1 <=3'd0;
             end
             ///////////////////////////////////////////
             if (flush_internal)
             begin
                counter_2    <= counter_2 + 1;
             end
             else 
             begin
                counter_2 <= 3'd0;
             end
             ///////////////////////////////////
             if (JUMP_FINAL)
             begin
                FLUSH               <=    (PC_ID_FB!=JUMP_ADDR) | FENCE| SFENCE_in |satp_update;
             end
             else if (STALL_ENABLE_EX & !flush_internal & cache_ready_ex2)
             begin
                FLUSH               <=    PC_ID_FB!=PC_FB_EX+4;
             end
             else if (counter_1 == 3'd3)
             begin
                FLUSH<=1'b0;
             end
             
             
             
           
        end
      
    end

    always@(*)
    begin
        if (JUMP_FINAL & CACHE_READY & cache_ready_ex2 )
        begin
            PREDICTED=(PC_ID_FB==JUMP_ADDR) & ~FENCE & ~SFENCE_in & ~satp_update;
        end
        else if (STALL_ENABLE_EX & !flush_internal & cache_ready_ex2 & CACHE_READY)
        begin
            PREDICTED=PC_ID_FB==PC_FB_EX+4;
        end 
        else 
        begin
            PREDICTED=1;
        end  

        if( (data_cache_control ) == 2'b01)  begin
            if((LDST_TYPE==load_hword | LDST_TYPE==load_uhword) & (&wb_data[2:0])) begin
                load_mis_al =1'b1;
            end
            else if((LDST_TYPE==load_word | LDST_TYPE==load_uword) & (wb_data[2:0]> 3'b100)) begin
                load_mis_al = 1'b1;
            end
            else if(LDST_TYPE==load_double & (|wb_data[2:0])) begin
                load_mis_al = 1'b1;
            end
            else begin
                load_mis_al =1'b0;
            end
            
        end
        else begin
            load_mis_al =1'b0;
        end
        if( (data_cache_control ) == 2'b10)  begin
            if((LDST_TYPE==store_hword) & (&wb_data[2:0])) begin
                store_mis_al =1'b1;
            end
            else if((LDST_TYPE==store_word) & (wb_data[2:0]> 3'b100)) begin
                store_mis_al = 1'b1;
            end
            else if(LDST_TYPE==store_double & (|wb_data[2:0])) begin
                store_mis_al = 1'b1;
            end
            else begin
                store_mis_al =1'b0;
            end
            
        end
        else begin
            store_mis_al =1'b0;
        end
    end
    
    assign JUMP_FINAL           = ((SFENCE_in|FENCE|satp_update) ? 1:((priv_jump ? priv_jump : (cbranch ? comp_out_w :jump_reg|jumpr_reg )))) & !flush_internal   ; 
    assign WB_DATA              =  wb_data                                                          ;
    assign DATA_CACHE_CONTROL   = data_cache_control & {2{!flush_internal}}   & {2{!priv_jump}}           & {2{!satp_update}}                         ;
    assign TYPE_OUT             = type_out & {2{!flush_internal}} & {2{!priv_jump}}       & {2{!satp_update}}                                   ;
    assign FLUSH_I              = flush_internal                                                                            ;
    assign EXSTAGE_STALLED      = ((ALU_CNT==alu_mstd) & !rv32m_ready ) & !flush_internal      & !satp_update    ;
    assign FENCE_OUT            = (FENCE) & !flush_internal & CACHE_READY_INS;
    assign AMO_OP_out         = AMO_OP_in & {5{!flush_internal}};
    assign OP_32_out       =  OPS_32 & !flush_internal;
    assign SFENCE          = SFENCE_in & !flush_internal;
    assign LOAD_WORD       = (LDST_TYPE!=load_double);
endmodule
