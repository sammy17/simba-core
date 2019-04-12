`timescale 1 ps  /  1 ps
module STATE_MEMORY         
    #(
        parameter depth          = 512              ,
        parameter address_width  = $clog2(depth)

    )
        (
        input                     CLK       ,
        input                     RST       ,
        input                     FLUSH     ,
        input                     WREN      ,   
        input [address_width-1:0] WADDR     ,
        input [address_width-1:0] RADDR     ,
        output                    STATE     ,
        input                     DATA      ,
        output                    ONE_STATE
     );
    reg [depth-1:0] state_mem;  
    always@(posedge CLK)
    begin
        
        if(RST | FLUSH)
        begin
            state_mem       <=  0       ;
        end
        else if (WREN)
        begin
            state_mem[WADDR] <= DATA      ;
        end
    end
    assign STATE = state_mem[RADDR]     ;
    assign ONE_STATE = |state_mem       ;
endmodule