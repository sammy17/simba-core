///////////////////////////////////////////////
                                               //
wire        [63:0]       comp1              ;  //
wire        [63:0]       comp2              ;  //
wire        [63:0]       c1_mux_final       ;  //
wire        [63:0]       c2_mux_final       ;  //
reg         [63:0]       comp1_id_fb      ;  //
reg         [63:0]       comp2_id_fb      ;  //
reg         [63:0]       comp1_fb_ex      ;  //
reg         [63:0]       comp2_fb_ex      ;  //
wire                     branch_taken       ;  //
reg                      branch_taken_reg ;  //
reg         [3:0]        bubble_counter   ;  //
wire                     stall_enable       ;  //
reg                      stall_enable_id_fb;//
reg                      stall_enable_fb_ex ;  //
reg [63:0]    imm_out_id_fb               ;  //
reg [63:0]    imm_out_fb_ex               ;  //
reg [63:0]    alu_ex_mem1_d               ;  //
reg [2:0]     feed_back_muxa_sel_id_fb    ;  //
reg [2:0]     feed_back_muxb_sel_id_fb    ;  //
reg [2:0]     feed_back_muxa_sel_fb_ex    ;  //
reg [2:0]     feed_back_muxb_sel_fb_ex    ;  //
reg           a_bus_sel_id_fb             ;  //
reg           b_bus_sel_id_fb             ;  //
reg           a_bus_sel_fb_ex             ;  //
reg           b_bus_sel_fb_ex             ;  //
///////////////////////////////////////////////

///////////////////////////////////////////////
                                             //
reg          [63:0]      pc_id_fb         ;//
(* mark_debug = "true" *) reg          [63:0]      pc_fb_ex         ;//
                                             //
///////////////////////////////////////////////

///////////////////////////////////////////////
                                             //
wire        [63:0]       jump_bus1        ;  //
wire        [63:0]       jump_bus2        ;  //
wire        [63:0]       jmux1_final      ;  //
wire        [63:0]       jmux2_final      ;  //
reg         [63:0]       jump1_id_fb      ;  //            
reg         [63:0]       jump2_id_fb      ;  //
reg         [63:0]       jump1_fb_ex      ;  //            
reg         [63:0]       jump2_fb_ex      ;  //
                                             //
///////////////////////////////////////////////

/////////////////////////////////////////////////
                                               //
wire                    jump_w            ;    //
wire                    jumpr_w           ;    //
wire                    cbranch_w         ;    //
reg                     jump_id_fb        ;    //
reg                     jumpr_id_fb       ;    //
reg                     cbranch_id_fb     ;    //
reg                     jump_fb_ex        ;    //
reg                     jumpr_fb_ex       ;    //
reg                     cbranch_fb_ex     ;    //
reg                     fence_id_fb     ;    //
reg                     fence_fb_ex     ;    //
                                               //
/////////////////////////////////////////////////


////////////////////////////////////////////////
wire [63:0]              a_bus            ;   //
wire [63:0]              a_bus_mux_final  ;   //
wire [63:0]              b_bus            ;   //
wire [63:0]              b_bus_mux_final  ;   //
reg  [63:0]              a_bus_id_fb      ;   //
reg  [63:0]              b_bus_id_fb      ;   //
reg  [63:0]              a_bus_fb_ex      ;   //
reg  [63:0]              b_bus_fb_ex      ;   //
                                              //
////////////////////////////////////////////////


/////////////////////////////////////////////////
                                               //
wire [63:0]             alu_out_wire       ;   //
reg  [63:0]             alu_ex_mem1        ;   //
reg  [63:0]             alu_mem1_mem2      ;   //
reg  [63:0]             alu_mem2_mem3      ;   //
reg  [63:0]             alu_mem3_wb        ;    //
reg  [63:0]             alu_ex_mem1_p      ;   //
reg  [63:0]             alu_mem1_mem2_p    ;   //
reg  [63:0]             alu_mem2_mem3_p    ;   //
reg  [63:0]             alu_mem3_wb_p      ;   //
                                               //
/////////////////////////////////////////////////

/////////////////////////////////////////////////
                                               //
wire [3:0]              alu_cnt             ;  //
wire [2:0]              fun3                ;  //
wire [3:0]              csr_cnt             ;  //
wire [4:0]              zimm                ;  //
reg  [3:0]              alu_cnt_id_fb     ;  //
reg  [2:0]              fun3_id_fb        ;  //
reg  [3:0]              csr_cnt_id_fb     ;  //
reg  [4:0]              zimm_id_fb        ;  //
reg  [3:0]              alu_cnt_fb_ex     ;  //
reg  [2:0]              fun3_fb_ex        ;  //
reg  [3:0]              csr_cnt_fb_ex     ;  //
reg  [4:0]              zimm_fb_ex        ;  //
                                               //
/////////////////////////////////////////////////

/////////////////////////////////////////////////
                                               //
wire [1:0]              op_type           ;    //
reg  [1:0]              type_id_fb        ;    //
reg  [1:0]              type_fb_ex        ;    //
reg  [1:0]              type_ex_mem1      ;    //
reg  [1:0]              type_mem1_mem2    ;    //
reg  [1:0]              type_mem2_mem3    ;    //
reg  [1:0]              type_mem3_wb      ;    //
wire [4 :0]             rd_out            ;    //
reg  [4 :0]             rd_id_fb          ;    //
reg  [4 :0]             rd_fb_ex          ;    //
reg  [4 :0]             rd_ex_mem1        ;    //
reg  [4 :0]             rd_mem1_mem2      ;    //
reg  [4 :0]             rd_mem2_mem3      ;    //
reg  [4 :0]             rd_mem3_wb        ;    //
                                               //
/////////////////////////////////////////////////

/////////////////////////////////////////////////     
                                               //
wire [2:0]              feed_back_muxa_sel ;   //
wire [2:0]              feed_back_muxb_sel ;   //
                                               //
                                               //
/////////////////////////////////////////////////

/////////////////////////////////////////////////     
                                               //
wire [2:0]              mux_sel_wires   [0:5] ;//
wire [63:0]             mux_outputs     [0:5] ;//
wire [63:0]             mux_input_direct[0:5] ;//
                                               //
/////////////////////////////////////////////////

/////////////////////////////////////////////////     
                                               //
wire [63:0]            rs1_out          ;      //
wire [63:0]            rs2_out          ;      //
reg  [63:0]            rs1_id_fb      ;      //
reg  [63:0]            rs2_id_fb      ;      //
reg  [63:0]            rs1_fb_ex      ;      //
reg  [63:0]            rs2_fb_ex      ;      //
wire [63:0]            rs1_final        ;      //
wire [63:0]            rs2_final        ;      //
wire                   a_bus_sel        ;      //
wire                   b_bus_sel        ;      //
wire [63:0]            imm_out          ;      //
                                               //
/////////////////////////////////////////////////

wire      [1:0]        data_cache_control_w;
reg       [1:0]        data_cache_control_id_fb;
