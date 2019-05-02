`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Yasas Sneviratne
// 
// Create Date: 09/09/2016 08:56:17 PM
// Design Name: 
// Module Name: REG_ARRAY
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


module REG_ARRAY(
    input [63:0] DATA_IN,
    input [4:0] RS1_SEL,
    input [4:0] RS2_SEL,
    input CLK,
    input RST,
    input RD_WB_VALID_MEM3_WB,
    input [4:0] RD_WB_MEM3_WB,         // register which is written back to 
    output [63:0] RS1_DATAOUT,
    output [63:0] RS2_DATAOUT
    );
    (* ram_style = "distributed" *)
   
    reg [63:0] REGISTER [1:31];
     // to check wether t1he register write back is still in pipeline
    reg [63:0] RS1_DATAOUT_L;
    reg [63:0] RS2_DATAOUT_L;
 
    integer i;
 

    
    always@(posedge CLK)
    begin
        if(RST)
        begin
             for(i=1;i<32;i=i+1)
             begin
             if(i==2)
                 REGISTER[i] <= 64'h10000;
             else
                 REGISTER[i] <= 64'd0;
             end
        end
        else if(RD_WB_VALID_MEM3_WB)
        begin
            REGISTER[RD_WB_MEM3_WB] <= DATA_IN;
        end
    end
    assign RS1_DATAOUT = RS1_SEL== 5'd0 ? 64'd0 : REGISTER[RS1_SEL]; 
    assign RS2_DATAOUT = RS2_SEL== 5'd0 ? 64'd0 : REGISTER[RS2_SEL]; 

                 
   
endmodule
