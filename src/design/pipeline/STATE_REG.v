`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:         University of moratuwa 
// Engineer:        Vithurson Subasharan
// Create Date: 09/25/2017 09:14:41 AM
// Design Name: 
// Module Name: STATE_REG
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


module STATE_REG(
    input           CLK                 ,
    input           RST                 ,
    input   [ 4:0]  RS1_SEL             ,
    input   [ 4:0]  RS2_SEL             ,
    input   [ 4:0]  RD_IN               ,
    input   [ 1:0]  TYPE_IN             ,
    input           STALL_ENABLE_FB     ,
    input           DATA_CACHE_READY    ,
    input           EXSTAGE_STALLED     ,//mull
    input           FLUSH               ,
    input           INS_CACHE_READY     ,
    output  [ 2:0]  MUX1_SELECT         ,
    output  [ 2:0]  MUX2_SELECT         ,
    output  [ 1:0]  RS1_TYPE            ,
    output  [ 1:0]  RS2_TYPE            ,
    output          STALL_ENABLE 
    );
    
    `include "PipelineParams.vh"
    
    reg  [ 4:0] reg_state [1:31]        ; 
    reg  [ 4:0] data_to_write           ;
    wire [ 4:0] rs1_state               ;     
    wire [ 4:0] rs2_state               ;
      
    integer i;
    
    reg  [      4:0] rs1_state_reg              ;
    reg  [      4:0] rs2_state_reg              ;
 
    reg  [      4:0] next_state         [1:31]  ;
    
    wire [512*5-1:0] state_mux_in       [1:31]  ;
    
    // reg  [      4:0] rd_in =0                   ;
    // reg  [      1:0] type_in =0                 ;

    
    always@(*)
    begin
    case (TYPE_IN)
        ld : data_to_write  = load_ex2;
        alu : data_to_write = reg_ex2;
        default : data_to_write = 5'b0;
    endcase
    end
    
 
 
    always @(*)
    begin
    
        for (i=1; i<=31; i=i+1)
        begin
            if (FLUSH & ( reg_state[i]==load_ex |  reg_state[i]==load_ex2 |  reg_state[i]==reg_ex |  reg_state[i]==reg_ex2| reg_state [i]==load_mem1 | reg_state [i] ==reg_mem1))
                next_state [i] = direct;
            else if ((TYPE_IN !=idle) & RD_IN ==i & STALL_ENABLE_FB  & DATA_CACHE_READY & INS_CACHE_READY &!FLUSH)
                next_state [i] = data_to_write;
            else if (!(DATA_CACHE_READY))
            begin
                next_state [i] = reg_state[i];
            end
            else if (!(STALL_ENABLE_FB)&(reg_state[i]==load_ex2 |  reg_state[i]==reg_ex2 ))
            begin
                next_state [i] = reg_state[i];
            end
            else if (!INS_CACHE_READY && (reg_state [i]==load_ex | reg_state [i]==load_ex2 | reg_state [i] ==reg_ex | reg_state [i] == reg_ex2 | reg_state [i]==load_mem1 | reg_state [i] ==reg_mem1))
            begin
                next_state [i] = reg_state[i];
            end
            else if (reg_state [i]==load_ex)
            begin
                next_state [i] = load_ex2;
            end
            else if (reg_state [i]==load_ex2)
            begin
                next_state [i]  = load_mem1;
            end
            else if (reg_state [i]==load_mem1)
            begin
                next_state [i]  = load_mem2;
            end
            else if (reg_state [i]==load_mem2)
            begin
                next_state [i]  = load_mem3; 
            end
            else if (reg_state [i]==load_mem3)
            begin
                next_state [i]  = load_wb  ;
            end
            else if (reg_state [i]==load_wb)
            begin
                next_state [i]  = load_written  ;
            end
            
            else if (reg_state [i]==reg_ex)
            begin
                next_state [i]  = reg_ex2   ;
            end
            else if (reg_state [i]==reg_ex2)
            begin
                next_state [i]  = reg_mem1  ;
            end
            else if (reg_state [i]==reg_mem1)
            begin
                next_state [i]  = reg_mem2  ;
            end
            else if (reg_state [i]==reg_mem2)
            begin
                next_state [i]  = reg_mem3  ;
            end
            else if (reg_state [i]==reg_mem3)
            begin
                next_state [i] = reg_wb    ;
            end
            else if (reg_state [i]==reg_wb)
            begin
                next_state [i] = reg_written   ;
            end
            else
            begin
                next_state [i]  = direct      ;
            end    
        end
    end

    
    always @(posedge CLK)
    begin
        //feed back mux select
    for(i=1;i<32;i=i+1)
    begin
        if(RST)
            reg_state[i] <= direct;
        else
            reg_state[i] <= next_state[i];      
    end 
    end                                    

    always@(*)
    begin
         rs1_state_reg   = rs1_state        ;
         rs2_state_reg   = rs2_state        ;
    end
    
    assign rs1_state                 = RS1_SEL==5'd0 ? 5'b00001:reg_state[RS1_SEL]                      ;
    assign rs2_state                 = RS2_SEL==5'd0 ? 5'b00001:reg_state[RS2_SEL]                      ;
    assign MUX1_SELECT               = rs1_state[4:2]                                                   ;
    assign MUX2_SELECT               = rs2_state[4:2]                                                   ;
    assign STALL_ENABLE              = (rs1_state[0] & rs2_state[0])|!(DATA_CACHE_READY&INS_CACHE_READY);
    assign RS1_TYPE                  = rs1_state[1:0]                                                   ;
    assign RS2_TYPE                  = rs2_state[1:0]                                                   ;
    
endmodule
