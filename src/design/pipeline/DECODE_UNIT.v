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
module DECODE_UNIT(
    input               CLK                     ,
    input               RST                     ,
    input       [ 1:0]  TYPE_MEM3_WB            ,
    input               DATA_CACHE_READY        ,
    input               INS_CACHE_READY         ,
    input               FLUSH                   ,
    input               STALL_ENABLE_FB         ,
    input       [31:0]  INSTRUCTION             ,
    input       [63:0]  WB_DATA                 ,
    input       [ 4:0]  WB_DES                  ,
    input               EXSTAGE_STALLED         ,//mul
    output reg  [ 2:0]  FEED_BACK_MUX1_SEL   ,
    output reg  [ 2:0]  FEED_BACK_MUX2_SEL   ,
    output reg  [ 3:0]  ALU_CNT              , 
    output reg  [ 1:0]  D_CACHE_CONTROL      , 
    output reg  [ 2:0]  FUN3                 ,
    output reg  [ 3:0]  CSR_CNT              ,
    output reg  [ 4:0]  ZIMM                 ,
    output reg          JUMP                 ,
    output reg          JUMPR                ,
    output reg          CBRANCH              ,
    output reg  [63:0]  IMM_OUT              ,
    output reg  [63:0]  RS1_OUT              ,
    output reg  [63:0]  RS2_OUT              ,
    output reg          A_BUS_SEL            ,
    output reg          B_BUS_SEL            ,
    output reg          STALL_ENABLE       ,
    output reg  [ 1:0]  OP_TYPE              ,  
    output reg  [ 4:0]  RD_OUT                  ,
    output      [ 1:0]  RS1_TYPE                ,
    output      [ 1:0]  RS2_TYPE                ,
    output reg          FENCE                   ,
    output reg   [4:0]  AMO_OP    ,
    output              ILEGAL    ,
    output              op_32   ,
    output SFENCE       
    );
    
    `include "PipelineParams.vh"
    
    wire [ 2:0]     feed_back_mux1_sel      ;
    wire [ 2:0]     feed_back_mux2_sel      ;
    wire [ 3:0]     alu_cnt                 ;
    wire [ 1:0]     d_cache_control         ;
    wire [ 2:0]     fun3                    ;
    wire [ 3:0]     csr_cnt                 ;
    wire            jump_w                  ;
    wire            jumpr_w                 ;
    wire            cbranch                 ;
    wire [63:0]     imm_out                 ;
    wire [63:0]     rs1_out                 ;
    wire [63:0]     rs2_out                 ;
    wire            a_bus_sel               ;
    wire            b_bus_sel               ;
    wire            stall_enable            ;
    wire [ 1:0]     op_type                 ;    
    wire [ 4:0]     rd_out                  ;      
   
    wire [ 4:0]     amo_op                 ;
    wire [ 4:0]     rs1_sel                 ;
    wire [ 4:0]     rs2_sel                 ;
    wire [ 2:0]     type_w                    ;
    wire            fence_w                 ;

    INS_TYPE_ROM ins_rom( 
        .INS(INSTRUCTION[6:0]) ,
        .TYPE(type_w)
        );
        
    IMM_EXT imm_ext( 
        .INS(INSTRUCTION[31:7]),
        .TYPE(type_w),
        .OUTPUT(imm_out)
        );
        
    REG_ARRAY reg_array (   
        .DATA_IN             (WB_DATA)              ,
        .RS1_SEL             (rs1_sel)              ,
        .RS2_SEL             (rs2_sel)              ,
        .CLK                 (CLK)                  ,
        .RD_WB_VALID_MEM3_WB (TYPE_MEM3_WB!=idle)   ,
        .RD_WB_MEM3_WB       (WB_DES)               ,         
        .RS1_DATAOUT         (rs1_out)              ,
        .RS2_DATAOUT         (rs2_out)              ,
        .RST                 (RST)
        );
           
     STATE_REG  state_reg(   
        .CLK                (CLK)                   ,
        .RST                (RST)                   ,
        .RS1_SEL            (rs1_sel)               ,
        .RS2_SEL            (rs2_sel)               ,
        .RD_IN              (INSTRUCTION[11: 7])    ,
        .TYPE_IN            (op_type)               ,
        .MUX1_SELECT        (feed_back_mux1_sel)    ,  
        .MUX2_SELECT        (feed_back_mux2_sel)    ,
        .DATA_CACHE_READY   (DATA_CACHE_READY)      ,
        .INS_CACHE_READY    (INS_CACHE_READY)       ,
        .EXSTAGE_STALLED    (EXSTAGE_STALLED)       ,
        .STALL_ENABLE       (stall_enable)          ,
        .FLUSH              (FLUSH)                 ,
        .STALL_ENABLE_FB    (STALL_ENABLE_FB)       ,
        .RS1_TYPE           (RS1_TYPE)              ,
        .RS2_TYPE           (RS2_TYPE)
        );
    
     CONTROL_UNIT control_unit(
        .INS                ({INSTRUCTION[29:28],INSTRUCTION[22:20],INSTRUCTION[25],INSTRUCTION[30],INSTRUCTION[14:12]})  ,
        .INS1               (INSTRUCTION[6:0])                                      ,
        .ALU_CNT            (alu_cnt)                                               ,
        .D_CACHE_CONTROL    (d_cache_control)                                       ,
        .FUN3               (fun3)                                                  ,
        .CSR_CNT            (csr_cnt)                                               ,
        .JUMP               (jump_w)                                                ,
        .JUMPR              (jumpr_w)                                               ,
        .CBRANCH            (cbranch)                                               ,
        .TYPE               (op_type)                                               ,
        .A_BUS_SEL          (a_bus_sel)                                             ,
        .B_BUS_SEL          (b_bus_sel)                                             ,
        .FENCE              (fence_w )                                              ,
        .INS2               (INSTRUCTION[31:27])                                    ,
        .AMO_OP             (amo_op)                ,
        .ILEGAL(ILEGAL),
        .op_32(op_32),
        .INS_up(INSTRUCTION[31:25]),
        .SFENCE(SFENCE)
        );
               
    Multiplexer #(
        .ORDER(3),
        .WIDTH(5)  
        )rs1_sel_mux (
        .SELECT(type_w)           ,
        .IN({
            20'd0               ,
            INSTRUCTION[19:15]  ,
            INSTRUCTION[19:15]  ,
            INSTRUCTION[19:15]  ,
            INSTRUCTION[19:15]
        }),
        .OUT(rs1_sel)
    );
            
    Multiplexer #(
        .ORDER(3),
        .WIDTH(5) 
        )rs2_sel_mux (
        .SELECT(type_w),
        .IN({    
            20'd0,
            INSTRUCTION[24:20] , 
            INSTRUCTION[24:20] ,
            5'd0, 
            INSTRUCTION[24:20]    
        }),
        .OUT(rs2_sel)
        );

       
    always @(*)
    begin
        // if (1DATA_CACHE_READY & STALL_ENABLE)
        // begin                                    
            FEED_BACK_MUX1_SEL        =    feed_back_mux1_sel     ;         
            FEED_BACK_MUX2_SEL        =    feed_back_mux2_sel     ;         
            ALU_CNT                   =    alu_cnt                ;                    
            D_CACHE_CONTROL           =    d_cache_control        ;    
            FUN3                      =    fun3                   ;
            ZIMM                      =    rs1_sel                ;
            CSR_CNT                   =    csr_cnt                ;  
            JUMP                      =    jump_w                 ;  
            JUMPR                     =    jumpr_w                ;  
            CBRANCH                   =    cbranch                ;    
            IMM_OUT                   =    imm_out                ;    
            RS1_OUT                   =    rs1_out                ;    
            RS2_OUT                   =    rs2_out                ;    
            A_BUS_SEL                 =    a_bus_sel              ;    
            B_BUS_SEL                 =    b_bus_sel              ;    
            OP_TYPE                   =    op_type                ;         
            RD_OUT                    =    INSTRUCTION[11: 7]     ;   
            FENCE                     =    fence_w                ; 
            AMO_OP                    =    amo_op                 ;    
        // end
    end  
                                
    always@(*)  
    begin            
        STALL_ENABLE              =    stall_enable           ;   
    end
    

endmodule
