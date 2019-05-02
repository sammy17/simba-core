`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:         RISC-V FYP Group
// Engineer:        Ravi Tharaka
// 
// Create Date:     07/29/2016 02:03:35 PM
// Design Name:     
// Module Name:     Multiplexer
// Project Name:    RISC-V Base ISA 
// Target Devices:  Any
// Tool Versions: 
// Description:     Parameterized depth and width multiplexer
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Multiplexer #(
        // Primary parameters
        parameter ORDER = 5,                            // 2^ORDER to 1 multiplexer will be created
        parameter WIDTH = 2,                            // Width of the multplexer
        
        // Calculated parameters
        localparam NO_OF_INPUT_BUSES = 1 << ORDER            
    ) (
        // Inputs
        input [WIDTH * NO_OF_INPUT_BUSES - 1 : 0] IN,
        input [ORDER - 1 : 0] SELECT,
        
        // Outputs
        output [WIDTH - 1 : 0] OUT
    );
     
    // Temporary wires
    wire [NO_OF_INPUT_BUSES - 1 : 0] in_group [0 : WIDTH - 1];
    
    // Generation and coding variables
    genvar i, j;
       
    generate 
        for (i = 0; i < NO_OF_INPUT_BUSES; i = i + 1) begin
            for (j = 0; j < WIDTH; j = j + 1) begin 
                assign in_group[j][i] = IN[i * WIDTH + j];
            end
        end
        
        for (i = 0; i < WIDTH; i = i + 1) begin
            Bit_Multiplexer #(
                .ORDER(ORDER)
            ) bit_mux (
                .IN(in_group[i]),
                .SELECT(SELECT),
                .OUT(OUT[i])            
            );
        end
    endgenerate
endmodule

module Bit_Multiplexer #(
        // Primary parameters
        parameter ORDER = 1,                 // 2^ORDER to 1 multiplexer will be created
        
        // Calculated parameters
        localparam NO_OF_INPUTS = 1 << ORDER            
    ) (
        // Inputs
        input [NO_OF_INPUTS - 1 : 0] IN,
        input [ORDER - 1 : 0] SELECT,
        
        // Outputs
        output OUT
    );
    
    assign OUT = IN[SELECT];    
    
endmodule

/*
Multiplexer #(
    .ORDER(),
    .WIDTH()
) your_instance_name (
    .SELECT(),
    .IN(),
    .OUT()
);
*/
