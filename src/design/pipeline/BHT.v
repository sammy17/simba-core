`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:        vithurson
// 
// Create Date:     04/14/2017 04:40:31 PM
// Design Name: 
// Module Name:     BHT
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


module BHT #(
        parameter   ADDR_WIDTH      = 64                                ,
        parameter   HISTORY_DEPTH   = 512                              ,
        
        localparam  H_ADDR_WIDTH    = logb2(HISTORY_DEPTH)              ,
        localparam  TAG_WIDTH       = ADDR_WIDTH - H_ADDR_WIDTH - 2       
    ) (
        input                           CLK                             ,
        input   [ADDR_WIDTH - 1 : 0]    PC                              ,
        input                           CACHE_READY_DATA                ,
        input                           CACHE_READY                     ,
        input   [ADDR_WIDTH - 1 : 0]    EX_PC                           ,
        input                           BRANCH                          ,
        input                           BRANCH_TAKEN                    ,
        input                           FLUSH                           ,
        input   [ADDR_WIDTH - 1 : 0]    BRANCH_ADDR                     ,
        input                           RETURN                          ,
        input   [ADDR_WIDTH - 1 : 0]    RETURN_ADDR                     ,
        output reg                      PRD_VALID                       ,
        output reg  [ADDR_WIDTH - 1 : 0]PRD_ADDR                        ,
        input PREDICTED,
        input RST
    );
    
    reg     [ADDR_WIDTH - 1 : 0] target     [0: HISTORY_DEPTH - 1   ]   ;
    reg     [TAG_WIDTH - 1  : 0] tag        [0: HISTORY_DEPTH - 1   ]   ;
    reg     [1              : 0] history    [0: HISTORY_DEPTH - 1   ]   ;
    reg     [HISTORY_DEPTH - 1 : 0  ]                     state         ;
    reg     [HISTORY_DEPTH - 1 : 0  ]                     return_reg        ;

    reg     [ADDR_WIDTH - 1 : 0] prd_addr_reg                           ;
    
    wire    [H_ADDR_WIDTH-1 : 0] pc_line_add  =PC   [H_ADDR_WIDTH+1:2]  ;
    reg     [H_ADDR_WIDTH-1 : 0] ex_line_add                          ;
    reg     [ADDR_WIDTH - 1 : 0] ex_pc                                  ;
    reg     [ADDR_WIDTH - 1 : 0] branch_addr                          ;
    reg                          branch                               ;
    reg                          branch_taken                         ;
    reg                          predicted                            ;
    reg                          return_reg_w                          ;
    reg                          flush                                ;
    
    integer i;
    
//    initial
//    begin
    
        
//        for(i=0;i<HISTORY_DEPTH;i=i+1)                      
//        begin                                               
//            target[i]   <= {ADDR_WIDTH{1'b0}}   ;           
//            tag[i]      <= {TAG_WIDTH{1'b0}}    ;           
//            history[i]  <= 2'b01                ;           
//        end                                                 
//    end                                         
    
    
    
    
    
    
    
  
    reg [31:0] branch_count=0;
    reg [31:0] predicted_count=0;
    always @(posedge CLK)
    begin
        if(RST)
        begin
            branch          <=       0 ;
            branch_count    <=       0 ;
            predicted_count <=       0 ;
            branch_taken    <=       0 ;
            predicted       <=       1 ;
            branch_addr     <=       0 ;
                                      
            ex_line_add     <=       0 ;
            ex_pc           <=       0 ;
            return_reg_w      <=       0 ;
            flush           <=       0 ;
        end
        else if (CACHE_READY & CACHE_READY_DATA)
        begin
            branch          <= BRANCH                               ;
            branch_count    <= branch_count +BRANCH                 ;
            predicted_count <= (PREDICTED&BRANCH) +predicted_count  ;
            branch_taken    <= BRANCH_TAKEN                         ;
            predicted       <= PREDICTED                            ;
            branch_addr     <= BRANCH_ADDR                          ;
    
            ex_line_add     <= EX_PC[H_ADDR_WIDTH+1:2]              ;
            ex_pc           <= EX_PC                                ;
            return_reg_w      <= RETURN                               ;
            flush           <= FLUSH                                ;
        end
        if (RST)
        begin
            prd_addr_reg    <= {ADDR_WIDTH{1'b0}}   ;           
               
            state<=0;                                            
            return_reg<=0;                                           
        end
	    else if (branch & CACHE_READY & CACHE_READY_DATA)
		begin
		   if ( (target[ex_line_add] != branch_addr ) | ~state[ex_line_add]      )                      
		   begin
                target[ex_line_add]  <= branch_addr   ;
                history[ex_line_add] <= 2'b01;
                
                target[ex_line_add]    <= branch_addr                           ;
                state[ex_line_add]     <= 1                                     ;
                tag[ex_line_add]       <= ex_pc[ADDR_WIDTH-1:H_ADDR_WIDTH+2]    ;
                return_reg[ex_line_add]    <= return_reg_w                            ;
	     end
		end
	    
	    if(branch_taken & (tag[ex_line_add]==ex_pc[ADDR_WIDTH-1:H_ADDR_WIDTH+2]) & CACHE_READY_DATA & CACHE_READY & !flush & state[ex_line_add])
	    begin
			case (history[ex_line_add])
				2'b00: history[ex_line_add] <= 2'b01    ;
				2'b01: history[ex_line_add] <= 2'b11    ;
				2'b10: history[ex_line_add] <= 2'b11    ;
				2'b11: history[ex_line_add] <= 2'b11    ;
			endcase
	    end
	    else if ((tag[ex_line_add]==ex_pc[ADDR_WIDTH-1:H_ADDR_WIDTH+2]) & CACHE_READY_DATA & CACHE_READY & !flush &   state[ex_line_add])
	    begin
			case (history[ex_line_add])
				2'b00: history[ex_line_add] <= 2'b00    ;
				2'b01: history[ex_line_add] <= 2'b00    ;
				2'b10: history[ex_line_add] <= 2'b01    ;
				2'b11: history[ex_line_add] <= 2'b10    ;
			endcase
	    end
       
    end
    reg l;
    always @(*)
    begin 
        PRD_VALID   = 1					;
        if (branch_taken & !predicted)

            begin
                PRD_ADDR = branch_addr;
            end

        else  if(!predicted)
        begin
            PRD_ADDR = ex_pc+4 ;
       
        end

        else 
        begin
           PRD_ADDR = ( history[pc_line_add][1] & ( tag[pc_line_add] == PC[ADDR_WIDTH-1:H_ADDR_WIDTH+2]) & state[pc_line_add] ) ?   target[pc_line_add] : PC + 4;
        end
        // l=( history[pc_line_add][1] & ( tag[pc_line_add] == PC[ADDR_WIDTH-1:H_ADDR_WIDTH+2]) & state[pc_line_add] );
    end
    
    function integer logb2;
        input integer depth;
        for (logb2 = 0; depth > 1; logb2 = logb2 + 1)
            depth = depth >> 1;
    endfunction
    
endmodule