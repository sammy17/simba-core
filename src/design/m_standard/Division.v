`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Tharshan based on Patterson and Hennessy's algorithm
// 
// Create Date: 09/09/2017 05:53:25 PM
// Design Name: 
// Module Name: Multiplication
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


module Division #(
        parameter INPUT_WIDTH   =   32
    ) (
        input                                       CLK                                 ,
        input                                       RST                                 ,
        input                                       STALL_DIV                           ,
        input                                       START                               ,
        input                                       SIGN                                ,
        input   [INPUT_WIDTH - 1            :0]     DIVIDEND                            ,
        input   [INPUT_WIDTH - 1            :0]     DIVIDER                             ,
        output  [INPUT_WIDTH - 1            :0]     QUOTIENT_OUT                        ,
        output  [INPUT_WIDTH - 1            :0]     REMAINDER_OUT                       ,
        output                                      READY               
    );

        reg     [INPUT_WIDTH - 1            :0]     quotient                            ;
        reg     [INPUT_WIDTH - 1            :0]     quotient_temp                       ;
        wire     [INPUT_WIDTH - 1            :0]     quotient_shift                      ;
        wire     [INPUT_WIDTH - 1            :0]     quotient_temp_wire                       ;
        reg     [2*INPUT_WIDTH - 1          :0]     dividend_copy                       ;
        reg     [2*INPUT_WIDTH - 1          :0]     divider_copy                        ;
    //    wire     [2*INPUT_WIDTH - 1          :0]     divider_copy_wire                        ;
        wire     [2*INPUT_WIDTH - 1          :0]     diff                                ;
        reg                                         negative_output                     ;
        
        reg     [$clog2(INPUT_WIDTH)        :0]     bit_reg                                 ;

   
        assign  READY = !bit_reg                                                            ;

        initial
        begin
       
        end

        always @( posedge CLK ) 
        begin
            if(RST) begin
                bit_reg         <=0;
                quotient        <= 0                                 ;
                // bit_reg         <= 0                                 ;
                negative_output <= 0                                 ;
            end
            else if(!STALL_DIV)
            begin
                if( START ) 
                begin
                    bit_reg             <= 1 << ( $clog2(INPUT_WIDTH)  ) ;
                    quotient        <= 0;
                    quotient_temp   <= 0;
                    dividend_copy   <= (!SIGN || !DIVIDEND[INPUT_WIDTH - 1]) ? 
                                      {{INPUT_WIDTH{1'b0}},DIVIDEND} : 
                                      {{INPUT_WIDTH{1'b0}},~DIVIDEND + 1'b1};
                                      
                    divider_copy    <= (!SIGN || !DIVIDER[INPUT_WIDTH - 1]) ? 
                                      {1'b0,DIVIDER,{(INPUT_WIDTH-1){1'b0}}} : 
                                      {1'b0,~DIVIDER + 1'b1,{(INPUT_WIDTH-1){1'b0}}};
            
                    negative_output <= SIGN &&
                                      ((DIVIDER[INPUT_WIDTH-1] && !DIVIDEND[INPUT_WIDTH-1]) 
                                    ||(!DIVIDER[INPUT_WIDTH-1] && DIVIDEND[INPUT_WIDTH-1]));
                 end 
                 else if ( bit_reg > 0 ) 
                 begin
                   
            
                    quotient_temp <= quotient_temp_wire;
            
                    if( !diff[2*INPUT_WIDTH-1] ) 
                    begin
                        dividend_copy <= diff;
                    end
            
                    quotient      <= (!negative_output) ? 
                                    quotient_temp_wire : 
                                    ~quotient_temp_wire + 1'b1;
            
                    divider_copy  <= divider_copy >> 1;
                    bit_reg        <= bit_reg - 1'b1;
                 end
            end
        end
        // assign divider_copy_wire = !diff[2*INPUT_WIDTH-1]? diff: divider_copy;
        assign quotient_shift = quotient_temp <<1;
        assign quotient_temp_wire =  !diff[2*INPUT_WIDTH-1]? {quotient_shift[INPUT_WIDTH-1:1],1'b1}: quotient_shift;
        assign diff= dividend_copy - divider_copy;
        assign QUOTIENT_OUT     = ((DIVIDER==0) & SIGN) ? -1: quotient                    ;
        assign REMAINDER_OUT    = (SIGN && DIVIDEND[INPUT_WIDTH-1] ) ? ~dividend_copy[INPUT_WIDTH - 1:0] + 1'b1 : dividend_copy[INPUT_WIDTH - 1:0]  ;

              
endmodule