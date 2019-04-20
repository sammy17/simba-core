`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2017 06:01:38 PM
// Design Name: 
// Module Name: INS_TYPE_ROM
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


module INS_TYPE_ROM(
    input           [6:0] INS       ,
    output   reg    [2:0]  TYPE
    );
    
    `include "PipelineParams.vh"

    always@(*)
    begin
        case (INS[6:0])
            lui     :   TYPE=utype;                //jtype {{12{INS[31]}},INS[19:12],INS[20],INS[30:25],INS[24:21],1'b0};
            auipc   :   TYPE=utype;                //utype {INS[31:12],12'd0};                                           
            jump    :   TYPE=jtype;                //itype {{20{INS[31]}},INS[30:20]};                                   
            jumpr   :   TYPE=itype;                //rtype 32'd0;                                                        
            cjump   :   TYPE=btype;                //stype {{20{INS[31]}},INS[30:25],INS[11:7]};                         
            load    :   TYPE=itype;                //btype {{20{INS[31]}},INS[7],INS[30:25],INS[11:8],1'b0};             
            store   :   TYPE=stype;                //ntype 32'd0;                                                        
            iops    :   TYPE=itype;                                                        
            iops32  :   TYPE=itype;                                                        
            rops    :   TYPE=rtype;
            rops32  :   TYPE=rtype;
            system  :   TYPE=itype;
            fence   :   TYPE=ntype;
            amos    :   TYPE=rtype;
            default :   TYPE=ntype;
        endcase
    end
    
endmodule
    
