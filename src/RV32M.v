`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/09/2017 05:53:25 PM
// Design Name: 
// Module Name: RV32M
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


module RV32M #(
        parameter INPUT_WIDTH   = 32                                                                                              
    ) (
        input                                       CLK                                 ,
        input                                       RST                                 ,
        input                                       START                               ,
        input   [2                          :0]     M_CNT                               ,
        input   [INPUT_WIDTH - 1            :0]     RS1                                 ,
        input   [INPUT_WIDTH - 1            :0]     RS2                                 ,
        output  reg [INPUT_WIDTH - 1        :0]     OUT                                 ,
        output                                      READY   ,
        input                                       STALL                               
    );
    
     `include "PipelineParams.vh"
    
        reg     [INPUT_WIDTH - 1            :0]     out_reg                             ;
        reg                                         valid_reg                           ;
        
        reg     [2                          :0]     m_cnt_prev                          ;
        reg     [INPUT_WIDTH - 1            :0]     rs1_prev                            ;
        reg     [INPUT_WIDTH - 1            :0]     rs2_prev                            ;
        reg                                         stable                              ;

        
       
        
        wire    sign1                   = ((M_CNT == mul)|(M_CNT == mulh)) ? 1'b1 : 1'b0                            ;
        wire    sign2                   = ((M_CNT == mul)|(M_CNT == mulh)|(M_CNT == mulhsu)) ? 1'b1 : 1'b0          ;
        wire    sign                    = ((M_CNT == div) | (M_CNT==rem)) ? 1'b1 : 1'b0                             ;
        wire    multiplication_type     = ((M_CNT == mul)|(M_CNT == mulh)|(M_CNT == mulhsu)|(M_CNT == mulhu))&START ;
        wire    division_type           = ((M_CNT == div)|(M_CNT == divu)|(M_CNT == rem)|(M_CNT == remu))&START     ;
        
        wire    [2*INPUT_WIDTH - 1          :0]     mult_out                                                        ;
        wire    [INPUT_WIDTH - 1            :0]     quotient_out                                                    ;
        wire    [INPUT_WIDTH - 1            :0]     remainder_out                                                   ;
       
        wire                                        multiplication_ready                                            ;
        wire                                        division_ready                                                  ;
        wire    ready_internal= ( multiplication_type & multiplication_ready )|( division_type & division_ready )   ;
        
    
//        Multiplication #(
//            .INPUT_WIDTH(INPUT_WIDTH)
//        )multiplication1(
//            .CLK(CLK),
//            .STALL_MUL(!multiplication_type),
//            .START(multiplication_type & !stable),
//            .SIGN1(sign1),
//            .SIGN2(sign2),
//            .MULTIPLIER(RS2),
//            .MULTIPLICAND(RS1),
//            .PRODUCT_OUT(mult_out),
//            .READY(multiplication_ready)
//            );
        mul_top1 
            #(
               .data_width(INPUT_WIDTH)
            )
      multiplication
            (
               .CLK(CLK),
               .RST(RST),
               .MULTIPLIER(RS2),
               .MULTIPLICAND(RS1),
               .START(multiplication_type & !stable & !STALL),
               .RESULT(mult_out),
               .DONE(multiplication_ready),
               .SIGN1(sign1),
                .SIGN2(sign2),
                .STALL_MUL(!multiplication_type| STALL)            //    output  [2*data_width-1:0]  INT_OUT [0:data_width-1]                
                
            );
        Division #(
            .INPUT_WIDTH(INPUT_WIDTH)
        )division(
            .CLK(CLK),
            .RST(RST),
            .STALL_DIV(!division_type  |STALL),
            .START(division_type & !stable & !STALL),
            .SIGN(sign),
            .DIVIDEND(RS1),
            .DIVIDER(RS2),  
            .QUOTIENT_OUT(quotient_out),
            .REMAINDER_OUT(remainder_out),
            .READY(division_ready)
            );
        
        always@(*)
        begin
            case(M_CNT)
            mul: 
                out_reg = mult_out [INPUT_WIDTH - 1 :0];                                              
            mulh:
                out_reg = mult_out [2*INPUT_WIDTH - 1 :INPUT_WIDTH];
            mulhsu: begin
                out_reg = mult_out [2*INPUT_WIDTH - 1 :INPUT_WIDTH];
                
            end
            mulhu: begin
                out_reg = mult_out [2*INPUT_WIDTH - 1 :INPUT_WIDTH];
                // if(READY &START)                                              
                //       $display("%h x %h = %h %h %h %d",RS1,RS2,out_reg,sign1,sign2,$time);
                
            end
            div:
                out_reg = quotient_out;
            divu:
                out_reg = quotient_out;
            rem:
                out_reg = remainder_out;
            remu:   
                out_reg = remainder_out;
           endcase  
        end
         
        always@(*)
        begin 
           if( (m_cnt_prev==M_CNT) & (rs1_prev==RS1) & (rs2_prev==RS2) & !STALL ) 
           begin    
               stable  <= 1'b1                         ;                             
           end
           else
           begin
               stable  <= 1'b0                         ;     
           end                                 
        end
        
        always@(posedge CLK)
        begin
            if(RST) begin
                m_cnt_prev   <=  0                      ;
                rs1_prev     <=  0                        ;
                rs2_prev     <=  0                        ;
                
                OUT         <= 0                      ; 
                valid_reg   <=  1      ;
            end
            if(START)
            begin
                m_cnt_prev   <=  M_CNT                      ;
                rs1_prev     <=  RS1                        ;
                rs2_prev     <=  RS2                        ;
               
                OUT         <= out_reg                      ; 
                valid_reg   <= ready_internal & stable      ;
            end
        end
           
        assign READY    = valid_reg & stable            ;
        
endmodule
