`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.01.2018 23:51:04
// Design Name: 
// Module Name: Peripheral
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


module Peripheral(
    
    input                           CLK,
    input                           RSTN,
    input                           START,
    input           [31:0]          ADDRESS,
    input                           WRITE,
    input           [31:0]          DATA_IN,
    output reg      [31:0]          DATA_OUT,
    output reg                      DONE,
    input           [3 :0]          WSTRB,
    output reg      [31:0]          RD_ADDR_TO_PERI,
    output reg                      RD_ADDR_TO_PERI_VALID,
    input                           RD_ADDR_TO_PERI_READY,
    output reg      [31:0]          WR_ADDR_TO_PERI,
    output reg                      WR_TO_PERI_VALID,
    input                           WR_TO_PERI_READY,
    output reg      [31:0]          DATA_TO_PERI,
    input           [31:0]          DATA_FROM_PERI,
    output reg                      DATA_FROM_PERI_READY,
    input                           DATA_FROM_PERI_VALID,
    input                           TRANSACTION_COMPLETE_PERI,
    input                           CACHE_READY_DAT,
    output reg      [3 :0]          WSTRB_OUT
    );
    
    wire ready_wa;
    wire ready_ra;
    wire    [31:0]  din;
    //reg  valid_rd;
    wire valid_rd;
    
    assign ready_wa = WR_TO_PERI_READY;
    assign ready_ra = RD_ADDR_TO_PERI_READY;
    assign din = DATA_FROM_PERI;
    assign valid_rd = DATA_FROM_PERI_VALID;
    
    
    // initial
    // begin
    //     DONE = 0;
    //     //DATA_OUT = 'b0;
    //     RD_ADDR_TO_PERI = 'b0;
    //     RD_ADDR_TO_PERI_VALID = 'b0;
    //     WR_ADDR_TO_PERI = 'b0;
    //     WR_TO_PERI_VALID = 'b0;
    //     DATA_TO_PERI = 'b0;
    //     DATA_FROM_PERI_READY = 'b0;
    // end
    
    always@(posedge CLK)
    begin
        if(~RSTN)
        begin
           
            DATA_TO_PERI <=0;
            DATA_FROM_PERI_READY <=0;
            DATA_TO_PERI <=0;
           
            RD_ADDR_TO_PERI_VALID <= 0;
        end
        else if(START & !DONE)
            begin
            if (WRITE)
            begin
                WR_ADDR_TO_PERI <= ADDRESS;
                DATA_TO_PERI <= DATA_IN;
                WR_TO_PERI_VALID <= 1;
                WSTRB_OUT <= WSTRB;
            end
            else if (RD_ADDR_TO_PERI_VALID && ready_ra)
                RD_ADDR_TO_PERI_VALID <= 0;
            else if (DATA_FROM_PERI_READY && valid_rd)
                DATA_FROM_PERI_READY <= 0;
            else if (WR_TO_PERI_VALID && ready_wa)
                WR_TO_PERI_VALID <= 0;

            else
            begin
                RD_ADDR_TO_PERI <= ADDRESS;
                RD_ADDR_TO_PERI_VALID <= 1;
                DATA_FROM_PERI_READY <= 1;
            end
        end
        if (valid_rd)
            DATA_OUT <= DATA_FROM_PERI;
        if(RST) begin
             DONE<=0;
        end
        else if(TRANSACTION_COMPLETE_PERI & !DONE) begin
            DONE <=1;
        end
        else if (DONE & CACHE_READY_DAT) begin
            DONE <=0;
        end
      

       
        
            
    //valid_rd <= DATA_FROM_PERI_VALID;
        
    end
    
endmodule
