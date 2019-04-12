`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Vithurson Subasharan
// 
// Create Date: 09/25/2017 04:13:22 PM
// Design Name: 
// Module Name: CONTROL_UNIT
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


module CONTROL_UNIT(
    input      [21:12]      INS             ,
    input      [ 6: 0]      INS1            ,
    output reg [ 3: 0]      ALU_CNT         ,
    output reg [ 1: 0]      D_CACHE_CONTROL ,
    output reg [ 2: 0]      FUN3            ,
    output reg [ 3: 0]      CSR_CNT         ,
    output reg              JUMP            ,
    output reg              JUMPR           ,
    output reg              CBRANCH         ,
    output reg [1:0]        TYPE            ,
    output reg              A_BUS_SEL       ,
    output reg              B_BUS_SEL       ,
    output reg              FENCE           ,
    output reg  [4:0]       AMO_OP,
    input  [31:27]          INS2,
    output ILEGAL,
    output reg op_32,
    input [31:25] INS_up,
    output reg SFENCE
    );
    
    `include "PipelineParams.vh"
    
    reg undefined;
    
    always@(*)
    begin
        FUN3            = INS[14:12]                            ;
        D_CACHE_CONTROL = {((INS1[6:0]==store)|(INS1[6:0]==amos)),(INS1[6:0]==load)};     
        JUMP            = INS1[6:0]==jump                       ;
        JUMPR           = INS1[6:0]==jumpr                      ;
        CBRANCH         = INS1[6:0]==cjump                      ;
        undefined =0   ;
        FENCE           = INS1[6:0] == fence                     ;
        AMO_OP          = INS1[6:0] ==amos ? INS2[31:27] : 5       ;
        op_32            = ((INS1[6:0] ==amos) & (INS[14:12]==2)) | (INS1[6:0] ==rops32) | (INS1[6:0] ==iops32);
        SFENCE=(INS_up==7'b0001001) & (INS1[6:0] ==system);
        
        case (INS1[6:0])
        
            lui     : 
            begin
                A_BUS_SEL          = a_bus_imm_sel  ;
                B_BUS_SEL          = b_bus_pc_sel   ;
                ALU_CNT            = alu_a          ;
                CSR_CNT            = sys_idle       ;
                TYPE               = alu            ;
            end  
            auipc   : 
            begin       
                A_BUS_SEL           = a_bus_imm_sel ;
                B_BUS_SEL           = b_bus_pc_sel  ;
                ALU_CNT             = alu_add       ;
                CSR_CNT             = sys_idle      ;
                TYPE                = alu           ;
            end
            jump    : 
            begin      
                A_BUS_SEL           = a_bus_imm_sel ;
                B_BUS_SEL           = b_bus_pc_sel  ;
                ALU_CNT             = alu_b4        ;
                CSR_CNT             = sys_idle      ;
                TYPE                = alu           ;
            end 
            jumpr   : 
            begin    
                A_BUS_SEL           = a_bus_imm_sel ;
                B_BUS_SEL           = b_bus_pc_sel  ;
                ALU_CNT             = alu_b4        ;
                CSR_CNT             = sys_idle      ;
                TYPE                = alu           ;
            end
            cjump   : 
            begin
                A_BUS_SEL           = a_bus_rs2_sel ;
                B_BUS_SEL           = b_bus_rs1_sel ;
                ALU_CNT             = alu_idle      ;
                CSR_CNT             = sys_idle      ;
                TYPE                = idle          ;
            end                                   
            load    : 
            begin             
                A_BUS_SEL           = a_bus_imm_sel ;
                B_BUS_SEL           = b_bus_rs1_sel ;
                ALU_CNT             = alu_add       ;
                CSR_CNT             = sys_idle      ;   
                TYPE                = ld            ;    
            end                                   
            store   : 
            begin       
                A_BUS_SEL           = a_bus_imm_sel ;
                B_BUS_SEL           = b_bus_rs1_sel ;                                
                ALU_CNT             = alu_add       ;
                CSR_CNT             = sys_idle      ;
                TYPE                = idle          ; 
            end
            iops    : 
            begin                 
                A_BUS_SEL           = a_bus_imm_sel ;
                B_BUS_SEL           = b_bus_rs1_sel ;
                CSR_CNT             = sys_idle      ;
                TYPE                = alu           ;
                case({((INS[14:12]==srli)& INS[15]),INS[14:12]})
                    {1'b0,addi }    : ALU_CNT = alu_add ;
                    {1'b0,slli }    : ALU_CNT = alu_sll ;
                    {1'b0,slti }    : ALU_CNT = alu_slt ; 
                    {1'b0,sltiu}    : ALU_CNT = alu_sltu;
                    {1'b0,xori }    : ALU_CNT = alu_xor ;
                    {1'b0,srli }    : ALU_CNT = alu_srl ;
                    {1'b1,srai }    : ALU_CNT = alu_sra ;
                    {1'b0,ori  }    : ALU_CNT = alu_or  ;
                    {1'b0,andi }    : ALU_CNT = alu_and ;
                    default         : 
                    begin
                        undefined= 1'b1     ;
                        ALU_CNT = alu_idle  ;                                            
                    end
                endcase
            end         
            rops    : 
            begin   
                A_BUS_SEL           = a_bus_rs2_sel ;
                B_BUS_SEL           = b_bus_rs1_sel ;
                CSR_CNT             = sys_idle      ;
                TYPE                = alu           ;
                case({INS[16],(((INS[14:12]==srlr) ||(INS[14:12]==addr))& INS[15]),INS[14:12]})
                    {2'b00,addr   }     : ALU_CNT = alu_add     ;
                    {2'b01,subr   }     : ALU_CNT = alu_sub     ;
                    {2'b00,sllr   }     : ALU_CNT = alu_sll     ;
                    {2'b00,sltr   }     : ALU_CNT = alu_slt     ;   
                    {2'b00,sltur  }     : ALU_CNT = alu_sltu    ;
                    {2'b00,xorr   }     : ALU_CNT = alu_xor     ;
                    {2'b00,srlr   }     : ALU_CNT = alu_srl     ;
                    {2'b01,srai   }     : ALU_CNT = alu_sra     ;
                    {2'b00,orr    }     : ALU_CNT = alu_or      ;
                    {2'b00,andr   }     : ALU_CNT = alu_and     ;
                    {2'b10,mul    }     : ALU_CNT = alu_mstd    ;
                    {2'b10,mulh   }     : ALU_CNT = alu_mstd    ;
                    {2'b10,mulhsu }     : ALU_CNT = alu_mstd    ;    
                    {2'b10,mulhu  }     : ALU_CNT = alu_mstd    ;
                    {2'b10,div    }     : ALU_CNT = alu_mstd    ;
                    {2'b10,divu   }     : ALU_CNT = alu_mstd    ;
                    {2'b10,rem    }     : ALU_CNT = alu_mstd    ;
                    {2'b10,remu   }     : ALU_CNT = alu_mstd    ;
                    default         :
                    begin
                        undefined= 1'b1    ;
                        ALU_CNT = alu_idle ;
                    end
                endcase
            end
            iops32    : 
            begin                 
                A_BUS_SEL           = a_bus_imm_sel ;
                B_BUS_SEL           = b_bus_rs1_sel ;
                CSR_CNT             = sys_idle      ;
                TYPE                = alu           ;
                case({((INS[14:12]==srli)& INS[15]),INS[14:12]})
                    {1'b0,addi }    : ALU_CNT = alu_add ;
                    {1'b0,slli }    : ALU_CNT = alu_sll ;
                    {1'b0,slti }    : ALU_CNT = alu_slt ; 
                    {1'b0,sltiu}    : ALU_CNT = alu_sltu;
                    {1'b0,xori }    : ALU_CNT = alu_xor ;
                    {1'b0,srli }    : ALU_CNT = alu_srl ;
                    {1'b1,srai }    : ALU_CNT = alu_sra ;
                    {1'b0,ori  }    : ALU_CNT = alu_or  ;
                    {1'b0,andi }    : ALU_CNT = alu_and ;
                    default         : 
                    begin
                        undefined= 1'b1     ;
                        ALU_CNT = alu_idle  ;                                            
                    end
                endcase
            end         
            rops32    : 
            begin   
                A_BUS_SEL           = a_bus_rs2_sel ;
                B_BUS_SEL           = b_bus_rs1_sel ;
                CSR_CNT             = sys_idle      ;
                TYPE                = alu           ;
                case({INS[16],(((INS[14:12]==srlr) ||(INS[14:12]==addr))& INS[15]),INS[14:12]})
                    {2'b00,addr   }     : ALU_CNT = alu_add     ;
                    {2'b01,subr   }     : ALU_CNT = alu_sub     ;
                    {2'b00,sllr   }     : ALU_CNT = alu_sll     ;
                    {2'b00,sltr   }     : ALU_CNT = alu_slt     ;   
                    {2'b00,sltur  }     : ALU_CNT = alu_sltu    ;
                    {2'b00,xorr   }     : ALU_CNT = alu_xor     ;
                    {2'b00,srlr   }     : ALU_CNT = alu_srl     ;
                    {2'b01,srai   }     : ALU_CNT = alu_sra     ;
                    {2'b00,orr    }     : ALU_CNT = alu_or      ;
                    {2'b00,andr   }     : ALU_CNT = alu_and     ;
                    {2'b10,mul    }     : ALU_CNT = alu_mstd    ;
                    {2'b10,mulh   }     : ALU_CNT = alu_mstd    ;
                    {2'b10,mulhsu }     : ALU_CNT = alu_mstd    ;    
                    {2'b10,mulhu  }     : ALU_CNT = alu_mstd    ;
                    {2'b10,div    }     : ALU_CNT = alu_mstd    ;
                    {2'b10,divu   }     : ALU_CNT = alu_mstd    ;
                    {2'b10,rem    }     : ALU_CNT = alu_mstd    ;
                    {2'b10,remu   }     : ALU_CNT = alu_mstd    ;
                    default         :
                    begin
                        undefined= 1'b1    ;
                        ALU_CNT = alu_idle ;
                    end
                endcase
            end
            system  :   
            begin
                A_BUS_SEL           = a_bus_imm_sel ;
                B_BUS_SEL           = b_bus_pc_sel  ;
                ALU_CNT             = alu_csr       ;
                case({((INS[14:12]==priv)?({INS[21:20],INS[19:17]}):(5'b0)),INS[14:12]})
                    {5'b00000,priv   }   : 
                    begin
                        CSR_CNT = sys_ecall     ;
                        TYPE    = idle          ;
                    end
                    {5'b00001,priv   }   : 
                    begin
                        CSR_CNT = sys_ebreak    ;
                        TYPE    = idle          ;
                    end
                    {5'b00010,priv   }   : 
                    begin
                        CSR_CNT = sys_uret      ;
                        TYPE    = idle          ;
                    end
                    {5'b01010,priv   }   : 
                    begin
                        CSR_CNT = sys_sret      ;
                        TYPE    = idle          ;
                    end
                    {5'b11010,priv   }   : 
                    begin
                        CSR_CNT = sys_mret      ;
                        TYPE    = idle          ;
                    end
                    {5'b01101,priv   }   : 
                    begin
                        CSR_CNT = sys_wfi       ;
                        TYPE    = idle          ;
                    end
                    {5'b00000,csrrw  }   : 
                    begin
                        CSR_CNT = sys_csrrw     ;
                        TYPE    = alu           ;
                    end
                    {5'b00000,csrrs  }   : 
                    begin
                        CSR_CNT = sys_csrrs     ;
                        TYPE    = alu           ;
                    end
                    {5'b00000,csrrc  }   : 
                    begin
                        CSR_CNT = sys_csrrc     ;
                        TYPE    = alu           ;
                    end
                    {5'b00000,csrrwi }   : 
                    begin
                        CSR_CNT = sys_csrrwi    ;
                        TYPE    = alu           ;
                    end
                    {5'b00000,csrrsi }   : 
                    begin
                        CSR_CNT = sys_csrrsi    ;
                        TYPE    = alu           ;
                    end
                    {5'b00000,csrrci }   : 
                    begin
                        CSR_CNT = sys_csrrci    ;
                        TYPE    = alu           ;
                    end
                    default              :
                    begin
                        TYPE        = idle;
                        undefined   = 1'b1      ;
                        CSR_CNT     = sys_idle  ;
                    end
                endcase
            end
           amos :
           begin
                A_BUS_SEL           = a_bus_imm_sel ;
                B_BUS_SEL           = b_bus_rs1_sel ;                                
                ALU_CNT             = alu_b         ;
                CSR_CNT             = sys_idle      ;
                TYPE                = ld              ;  
           end
           default :
            begin
                A_BUS_SEL           = a_bus_imm_sel ;
                B_BUS_SEL           = b_bus_pc_sel  ;
                ALU_CNT             = alu_idle      ;
                CSR_CNT             = sys_idle      ;
                TYPE                = idle          ;
                undefined=1;
            end 
                     
//            mops    :   TYPE=rtype;
//            fence   :   TYPE=ntype;
//            amos    :   TYPE=ntype;
//            default :   TYPE=ntype;
        endcase
    end
    assign ILEGAL = undefined & !FENCE & !SFENCE;
endmodule
