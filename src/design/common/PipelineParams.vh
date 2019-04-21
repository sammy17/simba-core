    //OPCODES  
    localparam lui      = 7'b0110111 ;
    localparam auipc    = 7'b0010111 ;
    localparam jump     = 7'b1101111 ;
    localparam jumpr    = 7'b1100111 ;
    localparam cjump    = 7'b1100011 ;
    localparam load     = 7'b0000011 ;
    localparam store    = 7'b0100011 ;
    localparam iops     = 7'b0010011 ;
    localparam rops     = 7'b0110011 ;
    localparam system   = 7'b1110011 ;  
    localparam fence    = 7'b0001111 ;
    localparam amos     = 7'b0101111 ;
    localparam iops32   = 7'b0011011 ;
    localparam rops32   = 7'b0111011 ;
    
   
    //BRANCHES
    localparam beq         = 3'b000 ;
    localparam bne         = 3'b001 ;
    localparam no_branch   = 3'b010 ;
    localparam blt         = 3'b100 ;
    localparam bge         = 3'b101 ;
    localparam bltu        = 3'b110 ;
    localparam bgeu        = 3'b111 ;
      
     //INTEGER_OPS
    localparam addi    = 3'b000 ;
    localparam slli    = 3'b001 ;
    localparam slti    = 3'b010 ;
    localparam sltiu   = 3'b011 ;
    localparam xori    = 3'b100 ;
    localparam srli    = 3'b101 ;
    localparam srai    = 3'b101 ;
    localparam ori     = 3'b110 ;
    localparam andi    = 3'b111 ;

    //RGISTEROPS
    localparam addr     = 3'b000 ;
    localparam subr     = 3'b000 ;
    localparam sllr     = 3'b001 ;
    localparam sltr     = 3'b010 ;
    localparam sltur    = 3'b011 ;
    localparam xorr     = 3'b100 ;
    localparam srlr     = 3'b101 ;
    localparam srar     = 3'b101 ;
    localparam orr      = 3'b110 ;
    localparam andr     = 3'b111 ;


    //csr OPS
    localparam priv    = 3'b000 ;
    localparam csrrw   = 3'b001 ;
    localparam csrrs   = 3'b010 ;
    localparam csrrc   = 3'b011 ;
    localparam csrrwi  = 3'b101 ;
    localparam csrrsi  = 3'b110 ;
    localparam csrrci  = 3'b111 ;
     
    //mops
    localparam mul    =  3'b000  ;
    localparam mulh   =  3'b001  ;
    localparam mulhsu =  3'b010  ;
    localparam mulhu  =  3'b011  ;
    localparam div    =  3'b100  ;
    localparam divu   =  3'b101  ;
    localparam rem    =  3'b110  ;
    localparam remu   =  3'b111  ;
    
    // INS_TYPE
    localparam rtype       =  3'b000  ;
    localparam itype       =  3'b001  ;
    localparam stype       =  3'b010  ;
    localparam btype       =  3'b011  ;
    localparam utype       =  3'b100  ;
    localparam jtype       =  3'b101  ;
    localparam ntype       =  3'b110  ;

   
    
    //FEED BACK MUX SEL
    
//    localparam  direct = 3'b000  ;
//    localparam  fb     = 3'b001  ;
//    localparam  ex     = 3'b010  ;
//    localparam  mem1   = 3'b011  ;
//    localparam  mem2   = 3'b100  ;
//    localparam  mem3   = 3'b101  ;
//    localparam  wb     = 3'b110  ;
    
    //type of write to be done
    localparam  idle  = 2'b00    ;
    localparam  ld    = 2'b01    ;
    localparam  alu   = 2'b10    ;
    
    //ready not ready
    localparam  ready     = 1'b1       ;
    localparam  not_ready = 1'b0       ;
    
    
    //alu controls
    
    localparam alu_add     = 4'b0000 ;
    localparam alu_sub     = 4'b0001 ;
    localparam alu_sll     = 4'b0010 ;
    localparam alu_sltu    = 4'b0011 ;
    localparam alu_xor     = 4'b0100 ;
    localparam alu_srl     = 4'b0101 ;
    localparam alu_sra     = 4'b0110 ;
    localparam alu_or      = 4'b0111 ;
    localparam alu_and     = 4'b1000 ;
    localparam alu_a       = 4'b1001 ;
    localparam alu_b       = 4'b1010 ;
    localparam alu_slt     = 4'b1011 ;
    localparam alu_b4      = 4'b1100 ;
    localparam alu_idle    = 4'b1101 ;
    localparam alu_csr     = 4'b1110 ;
    localparam alu_mstd    = 4'b1111 ;
    
    
     //csr OPS
    localparam sys_idle    = 4'b0000 ; 
    
    localparam sys_ecall   = 4'b0001 ;
    localparam sys_ebreak  = 4'b0010 ;
    localparam sys_uret    = 4'b0011 ;
    localparam sys_sret    = 4'b0100 ;
    localparam sys_mret    = 4'b0101 ;
    localparam sys_wfi     = 4'b0110 ;
    
    localparam sys_csrrw   = 4'b1001 ;
    localparam sys_csrrs   = 4'b1010 ;
    localparam sys_csrrc   = 4'b1011 ;
    localparam sys_csrrwi  = 4'b1101 ;
    localparam sys_csrrsi  = 4'b1110 ;
    localparam sys_csrrci  = 4'b1111 ;
    
    
    
    //data_cache_cntrol
    localparam cache_idle  = 2'b00   ;
    localparam cache_read  = 2'b01   ;
    localparam cache_write = 2'b10   ;
    localparam cache_flush = 2'b11   ;
    
    //
    localparam a_bus_rs2_sel =2'b1    ;
    localparam a_bus_imm_sel =1'b0    ;
    localparam b_bus_rs1_sel =1'b1    ;
    localparam b_bus_pc_sel  =1'b0    ; 
    
    localparam ex           =3'd0     ;
    localparam ex2          =3'd1     ;
    localparam mem1         =3'd2     ;
    localparam mem2         =3'd3     ;
    localparam mem3         =3'd4     ;
    localparam wb           =3'd5     ;
    localparam wb2          =3'd6     ;
    
    localparam direct        =5'b00001  ;//first three bit mux sel, next bit load operation or alu operation , next bit whether to stall the pipeline or not
    localparam load_ex       =5'b00110  ;
    localparam load_ex2      =5'b01010  ;
    localparam load_mem1     =5'b01110  ;
    localparam load_mem2     =5'b10010  ;
    localparam load_mem3     =5'b10110  ;
    localparam load_wb       =5'b11011  ;
    localparam load_written  =5'b11111  ;
    localparam reg_ex        =5'b00100  ;
    localparam reg_ex2       =5'b01001  ;
    localparam reg_mem1      =5'b01101  ;
    localparam reg_mem2      =5'b10001  ;
    localparam reg_mem3      =5'b10101  ;
    localparam reg_wb        =5'b11001  ;
    localparam reg_written   =5'b11101  ;

    localparam load_byte     = 3'b000;
    localparam load_hword    = 3'b001;
    localparam load_word     = 3'b010;
    localparam load_ubyte    = 3'b100;
    localparam load_uhword   = 3'b101;
    localparam load_uword    = 3'b110;
    localparam load_double    = 3'b11;
    
    localparam store_byte     = 3'b000;
    localparam store_hword    = 3'b001;
    localparam store_word     = 3'b010;
    localparam store_double     = 3'b011;
    
    
    // CSR ADRESS MAPPINGS
    localparam     ustatus        =    12'h000      ;
    localparam     uie            =    12'h004      ;
    localparam     utvec          =    12'h005      ;
    localparam     uscratch       =    12'h040      ;
    localparam     uepc           =    12'h041      ;
    localparam     ucause         =    12'h042      ;
    localparam     utval          =    12'h043      ;
    localparam     uip            =    12'h044      ;
    localparam     fflags         =    12'h001      ;
    localparam     frm            =    12'h002      ;
    localparam     fcsr           =    12'h003      ;
    localparam     cycle          =    12'hC00      ;
    localparam     timer          =    12'hC01      ;
    localparam     instret        =    12'hC02      ;
    localparam     hpmcounter3    =    12'hC03      ;
    localparam     hpmcounter4    =    12'hC04      ;
    localparam     hpmcounter31   =    12'hC1F      ;
    localparam     cycleh         =    12'hC80      ;
    localparam     timeh          =    12'hC81      ;
    localparam     instreth       =    12'hC82      ;
    localparam     hpmcounter3h   =    12'hC83      ;
    localparam     hpmcounter4h   =    12'hC84      ;
    localparam     hpmcounter31h  =    12'hC9F      ;
    localparam     sstatus        =    12'h100      ;
    localparam     sedeleg        =    12'h102      ;
    localparam     sideleg        =    12'h103      ;
    localparam     sie            =    12'h104      ;
    localparam     stvec          =    12'h105      ;
    localparam     scounteren     =    12'h106      ;
    localparam     sscratch       =    12'h140      ;
    localparam     sepc           =    12'h141      ;
    localparam     scause         =    12'h142      ;
    localparam     stval          =    12'h143      ;
    localparam     sip            =    12'h144      ;
    localparam     satp           =    12'h180      ;
    localparam     mvendorid      =    12'hF11      ;
    localparam     marchid        =    12'hF12      ;
    localparam     mimpid         =    12'hF13      ;
    localparam     mhartid        =    12'hF14      ;
    localparam     mstatus        =    12'h300      ;
    localparam     misa           =    12'h301      ;
    localparam     medeleg        =    12'h302      ;
    localparam     mideleg        =    12'h303      ;
    localparam     mie            =    12'h304      ;
    localparam     mtvec          =    12'h305      ;
    localparam     mcounteren     =    12'h306      ;
    localparam     mscratch       =    12'h340      ;
    localparam     mepc           =    12'h341      ;
    localparam     mcause         =    12'h342      ;
    localparam     mtval          =    12'h343      ;
    localparam     mip            =    12'h344      ;
    localparam     pmpcfg0        =    12'h3A0      ;
    localparam     pmpcfg1        =    12'h3A1      ;
    localparam     pmpcfg2        =    12'h3A2      ;
    localparam     pmpcfg3        =    12'h3A3      ;
    localparam     pmpaddr0       =    12'h3B0      ;
    localparam     pmpaddr1       =    12'h3B1      ;
    localparam     pmpaddr2       =    12'h3B2      ;
    localparam     pmpaddr3       =    12'h3B3      ;
    localparam     pmpaddr4       =    12'h3B4      ;
    localparam     pmpaddr5       =    12'h3B5      ;
    localparam     pmpaddr6       =    12'h3B6      ;
    localparam     pmpaddr7       =    12'h3B7      ;
    localparam     mcycle         =    12'hB00      ;
    localparam     minstret       =    12'hB02      ;
    localparam     mhpmcounter3   =    12'hB03      ;
    localparam     mhpmcounter4   =    12'hB04      ;
    localparam     mhpmcounter31  =    12'hB1F      ;
    localparam     mcycleh        =    12'hB80      ;
    localparam     minstreth      =    12'hB82      ;
    localparam     mhpmcounter3h  =    12'hB83      ;
    localparam     mhpmcounter4h  =    12'hB84      ;
    localparam     mhpmcounter31h =    12'hB9F      ;
    localparam     mhpmevent3     =    12'h323      ;
    localparam     mhpmevent4     =    12'h324      ;
    localparam     mhpmevent31    =    12'h33F      ;
    localparam     tselect        =    12'h7A0      ;
    localparam     tdata1         =    12'h7A1      ;
    localparam     tdata2         =    12'h7A2      ;   
    localparam     tdata3         =    12'h7A3      ;
    localparam     dcsr           =    12'h7B0      ;
    localparam     dpc            =    12'h7B1      ;
    localparam     dscratch       =    12'h7B2      ;
    
    //CSR modes
    localparam     mmode          =    2'b11        ;
    localparam     hmode          =    2'b10        ;
    localparam     smode          =    2'b01        ;
    localparam     umode          =    2'b00        ;
   
    localparam amolr    =   5'b00010;
    localparam amosc    =   5'b00011;
    localparam amoswap  =   5'b00001;
    localparam amoadd   =   5'b00000;
    localparam amoxor   =   5'b00100;
    localparam amoand   =   5'b01100;
    localparam amoor    =   5'b01000;
    localparam amomin   =   5'b10000;
    localparam amomax   =   5'b10100;
    localparam amominu  =   5'b11000;
    localparam amomaxu  =   5'b11100;
    localparam amoidle  =   5;


