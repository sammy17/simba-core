`timescale 1ns / 1ps
module mul_top1
#(
    parameter data_width = 8
)
(
    input                       CLK     ,
    input                       RST     ,
    input                       SIGN1   ,
    input                       SIGN2   ,
    input                       START   ,
    input [data_width-1:0]      MULTIPLIER    ,
    input [data_width-1  : 0]   MULTIPLICAND    ,
    output[2*data_width-1:0]    RESULT  ,
    input                       STALL_MUL,
    output reg                  DONE    =           0       
//    output  [2*data_width-1:0]  INT_OUT [0:data_width-1]                
    
);
    reg [2*data_width-1:0] int_mem [0:data_width-1];

    reg [data_width-1:0]    A                           ;
    reg [data_width-1:0]    multiplier              ;
    reg [data_width-1:0]    multiplicand               ;
    wire                    q0              =   multiplier[0]   ;
    reg [9:0]               N               =   data_width + 1  ;
    reg [2*data_width-1:0]  A_wire                     ;
    reg                     negative_output;
    reg [data_width-1:0] add  ;
    reg C_wire;
    reg C;
//    assign {C_wire,add} =  (A + multiplicand) ;
    always@(*)
    begin
        case(q0)
            2'b1:  begin
                        {C_wire,add}    = (A + multiplicand);
                        A_wire          =  {   add    ,multiplier}  ;
                    end
            2'b0:  begin 
                        A_wire          =  {A,multiplier}                           ; 
                        {C_wire,add}    = {C,32'b0};
                   end
        endcase
    end
    always @(posedge CLK)
    begin
        if(RST) begin
           N <=data_width+1;
           DONE <=1;
           C <=0;
        end
        else if(!STALL_MUL) begin
            if (START) begin
                multiplier      <=  ((SIGN1 &  MULTIPLIER[data_width-1]) ?      ~MULTIPLIER +1'b1 :  MULTIPLIER )         ;
                multiplicand    <=  ((SIGN2 &  MULTIPLICAND[data_width-1]) ?      ~MULTIPLICAND +1'b1 :  MULTIPLICAND )          ;
                // q_1             <=  1'b0                        ;
                A               <=  0                           ;
                N               <=  data_width                  ;
                negative_output   <= (SIGN1 & MULTIPLIER[data_width - 1]) ^ (SIGN2 & MULTIPLICAND[data_width - 1]);
                DONE            <=1'b0;
            end    
            else if (N!=0) begin
                N                           <=  N - 1                           ;
                {C,A,multiplier}          <=  {C_wire,A_wire[2*data_width-1:0] }  >>1    ;
            end
            else begin
                DONE                <= 1'b1;
            end
        end
        else begin
            DONE        <= 1'b1;
        end
    end
    assign RESULT               =   !negative_output? {A,multiplier}        :  ~{A,multiplier}   +1           ;
endmodule
