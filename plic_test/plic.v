
`timescale 1 ns / 1 ps
module LevelGateway(
  input   clock,
  input   reset,
  input   io_interrupt,
  output  io_plic_valid,
  input   io_plic_ready,
  input   io_plic_complete
);


  reg  inFlight; // @[Plic.scala 33:21]
  wire  _GEN_0 = io_interrupt & io_plic_ready | inFlight; // @[Plic.scala 33:21 34:{40,51}]
  assign io_plic_valid = io_interrupt & ~inFlight; // @[Plic.scala 36:33]
  always @(posedge clock) begin
    if (reset) begin // @[Plic.scala 33:21]
      inFlight <= 1'h0; // @[Plic.scala 33:21]
    end else if (io_plic_complete) begin // @[Plic.scala 35:27]
      inFlight <= 1'h0; // @[Plic.scala 35:38]
    end else begin
      inFlight <= _GEN_0;
    end
  end

endmodule
module PLICFanIn(
  input  [2:0]  io_prio_0,
  input  [2:0]  io_prio_1,
  input  [2:0]  io_prio_2,
  input  [2:0]  io_prio_3,
  input  [2:0]  io_prio_4,
  input  [2:0]  io_prio_5,
  input  [2:0]  io_prio_6,
  input  [2:0]  io_prio_7,
  input  [2:0]  io_prio_8,
  input  [2:0]  io_prio_9,
  input  [2:0]  io_prio_10,
  input  [2:0]  io_prio_11,
  input  [2:0]  io_prio_12,
  input  [2:0]  io_prio_13,
  input  [2:0]  io_prio_14,
  input  [2:0]  io_prio_15,
  input  [2:0]  io_prio_16,
  input  [2:0]  io_prio_17,
  input  [2:0]  io_prio_18,
  input  [2:0]  io_prio_19,
  input  [2:0]  io_prio_20,
  input  [2:0]  io_prio_21,
  input  [2:0]  io_prio_22,
  input  [2:0]  io_prio_23,
  input  [2:0]  io_prio_24,
  input  [2:0]  io_prio_25,
  input  [2:0]  io_prio_26,
  input  [2:0]  io_prio_27,
  input  [2:0]  io_prio_28,
  input  [2:0]  io_prio_29,
  input  [2:0]  io_prio_30,
  input  [2:0]  io_prio_31,
  input  [31:0] io_ip,
  output [5:0]  io_dev,
  output [2:0]  io_max
);
  wire [3:0] effectivePriority_1 = {io_ip[0],io_prio_0}; // @[Cat.scala 31:58]
  wire [3:0] effectivePriority_2 = {io_ip[1],io_prio_1}; // @[Cat.scala 31:58]
  wire [3:0] effectivePriority_3 = {io_ip[2],io_prio_2}; // @[Cat.scala 31:58]
  wire [3:0] effectivePriority_4 = {io_ip[3],io_prio_3}; // @[Cat.scala 31:58]
  wire [3:0] effectivePriority_5 = {io_ip[4],io_prio_4}; // @[Cat.scala 31:58]
  wire [3:0] effectivePriority_6 = {io_ip[5],io_prio_5}; // @[Cat.scala 31:58]
  wire [3:0] effectivePriority_7 = {io_ip[6],io_prio_6}; // @[Cat.scala 31:58]
  wire [3:0] effectivePriority_8 = {io_ip[7],io_prio_7}; // @[Cat.scala 31:58]
  wire [3:0] effectivePriority_9 = {io_ip[8],io_prio_8}; // @[Cat.scala 31:58]
  wire [3:0] effectivePriority_10 = {io_ip[9],io_prio_9}; // @[Cat.scala 31:58]
  wire [3:0] effectivePriority_11 = {io_ip[10],io_prio_10}; // @[Cat.scala 31:58]
  wire [3:0] effectivePriority_12 = {io_ip[11],io_prio_11}; // @[Cat.scala 31:58]
  wire [3:0] effectivePriority_13 = {io_ip[12],io_prio_12}; // @[Cat.scala 31:58]
  wire [3:0] effectivePriority_14 = {io_ip[13],io_prio_13}; // @[Cat.scala 31:58]
  wire [3:0] effectivePriority_15 = {io_ip[14],io_prio_14}; // @[Cat.scala 31:58]
  wire [3:0] effectivePriority_16 = {io_ip[15],io_prio_15}; // @[Cat.scala 31:58]
  wire [3:0] effectivePriority_17 = {io_ip[16],io_prio_16}; // @[Cat.scala 31:58]
  wire [3:0] effectivePriority_18 = {io_ip[17],io_prio_17}; // @[Cat.scala 31:58]
  wire [3:0] effectivePriority_19 = {io_ip[18],io_prio_18}; // @[Cat.scala 31:58]
  wire [3:0] effectivePriority_20 = {io_ip[19],io_prio_19}; // @[Cat.scala 31:58]
  wire [3:0] effectivePriority_21 = {io_ip[20],io_prio_20}; // @[Cat.scala 31:58]
  wire [3:0] effectivePriority_22 = {io_ip[21],io_prio_21}; // @[Cat.scala 31:58]
  wire [3:0] effectivePriority_23 = {io_ip[22],io_prio_22}; // @[Cat.scala 31:58]
  wire [3:0] effectivePriority_24 = {io_ip[23],io_prio_23}; // @[Cat.scala 31:58]
  wire [3:0] effectivePriority_25 = {io_ip[24],io_prio_24}; // @[Cat.scala 31:58]
  wire [3:0] effectivePriority_26 = {io_ip[25],io_prio_25}; // @[Cat.scala 31:58]
  wire [3:0] effectivePriority_27 = {io_ip[26],io_prio_26}; // @[Cat.scala 31:58]
  wire [3:0] effectivePriority_28 = {io_ip[27],io_prio_27}; // @[Cat.scala 31:58]
  wire [3:0] effectivePriority_29 = {io_ip[28],io_prio_28}; // @[Cat.scala 31:58]
  wire [3:0] effectivePriority_30 = {io_ip[29],io_prio_29}; // @[Cat.scala 31:58]
  wire [3:0] effectivePriority_31 = {io_ip[30],io_prio_30}; // @[Cat.scala 31:58]
  wire [3:0] effectivePriority_32 = {io_ip[31],io_prio_31}; // @[Cat.scala 31:58]
  wire  _T = 4'h8 >= effectivePriority_1; // @[Plic.scala 344:20]
  wire [3:0] _T_2 = _T ? 4'h8 : effectivePriority_1; // @[Misc.scala 34:9]
  wire  _T_3 = _T ? 1'h0 : 1'h1; // @[Misc.scala 34:36]
  wire  _T_4 = effectivePriority_2 >= effectivePriority_3; // @[Plic.scala 344:20]
  wire [3:0] _T_6 = _T_4 ? effectivePriority_2 : effectivePriority_3; // @[Misc.scala 34:9]
  wire  _T_7 = _T_4 ? 1'h0 : 1'h1; // @[Misc.scala 34:36]
  wire  _T_8 = _T_2 >= _T_6; // @[Plic.scala 344:20]
  wire [1:0] _GEN_0 = {{1'd0}, _T_7}; // @[Plic.scala 344:61]
  wire [1:0] _T_9 = 2'h2 | _GEN_0; // @[Plic.scala 344:61]
  wire [3:0] _T_10 = _T_8 ? _T_2 : _T_6; // @[Misc.scala 34:9]
  wire [1:0] _T_11 = _T_8 ? {{1'd0}, _T_3} : _T_9; // @[Misc.scala 34:36]
  wire  _T_12 = effectivePriority_4 >= effectivePriority_5; // @[Plic.scala 344:20]
  wire [3:0] _T_14 = _T_12 ? effectivePriority_4 : effectivePriority_5; // @[Misc.scala 34:9]
  wire  _T_15 = _T_12 ? 1'h0 : 1'h1; // @[Misc.scala 34:36]
  wire  _T_16 = effectivePriority_6 >= effectivePriority_7; // @[Plic.scala 344:20]
  wire [3:0] _T_18 = _T_16 ? effectivePriority_6 : effectivePriority_7; // @[Misc.scala 34:9]
  wire  _T_19 = _T_16 ? 1'h0 : 1'h1; // @[Misc.scala 34:36]
  wire  _T_20 = _T_14 >= _T_18; // @[Plic.scala 344:20]
  wire [1:0] _GEN_1 = {{1'd0}, _T_19}; // @[Plic.scala 344:61]
  wire [1:0] _T_21 = 2'h2 | _GEN_1; // @[Plic.scala 344:61]
  wire [3:0] _T_22 = _T_20 ? _T_14 : _T_18; // @[Misc.scala 34:9]
  wire [1:0] _T_23 = _T_20 ? {{1'd0}, _T_15} : _T_21; // @[Misc.scala 34:36]
  wire  _T_24 = _T_10 >= _T_22; // @[Plic.scala 344:20]
  wire [2:0] _GEN_2 = {{1'd0}, _T_23}; // @[Plic.scala 344:61]
  wire [2:0] _T_25 = 3'h4 | _GEN_2; // @[Plic.scala 344:61]
  wire [3:0] _T_26 = _T_24 ? _T_10 : _T_22; // @[Misc.scala 34:9]
  wire [2:0] _T_27 = _T_24 ? {{1'd0}, _T_11} : _T_25; // @[Misc.scala 34:36]
  wire  _T_28 = effectivePriority_8 >= effectivePriority_9; // @[Plic.scala 344:20]
  wire [3:0] _T_30 = _T_28 ? effectivePriority_8 : effectivePriority_9; // @[Misc.scala 34:9]
  wire  _T_31 = _T_28 ? 1'h0 : 1'h1; // @[Misc.scala 34:36]
  wire  _T_32 = effectivePriority_10 >= effectivePriority_11; // @[Plic.scala 344:20]
  wire [3:0] _T_34 = _T_32 ? effectivePriority_10 : effectivePriority_11; // @[Misc.scala 34:9]
  wire  _T_35 = _T_32 ? 1'h0 : 1'h1; // @[Misc.scala 34:36]
  wire  _T_36 = _T_30 >= _T_34; // @[Plic.scala 344:20]
  wire [1:0] _GEN_3 = {{1'd0}, _T_35}; // @[Plic.scala 344:61]
  wire [1:0] _T_37 = 2'h2 | _GEN_3; // @[Plic.scala 344:61]
  wire [3:0] _T_38 = _T_36 ? _T_30 : _T_34; // @[Misc.scala 34:9]
  wire [1:0] _T_39 = _T_36 ? {{1'd0}, _T_31} : _T_37; // @[Misc.scala 34:36]
  wire  _T_40 = effectivePriority_12 >= effectivePriority_13; // @[Plic.scala 344:20]
  wire [3:0] _T_42 = _T_40 ? effectivePriority_12 : effectivePriority_13; // @[Misc.scala 34:9]
  wire  _T_43 = _T_40 ? 1'h0 : 1'h1; // @[Misc.scala 34:36]
  wire  _T_44 = effectivePriority_14 >= effectivePriority_15; // @[Plic.scala 344:20]
  wire [3:0] _T_46 = _T_44 ? effectivePriority_14 : effectivePriority_15; // @[Misc.scala 34:9]
  wire  _T_47 = _T_44 ? 1'h0 : 1'h1; // @[Misc.scala 34:36]
  wire  _T_48 = _T_42 >= _T_46; // @[Plic.scala 344:20]
  wire [1:0] _GEN_4 = {{1'd0}, _T_47}; // @[Plic.scala 344:61]
  wire [1:0] _T_49 = 2'h2 | _GEN_4; // @[Plic.scala 344:61]
  wire [3:0] _T_50 = _T_48 ? _T_42 : _T_46; // @[Misc.scala 34:9]
  wire [1:0] _T_51 = _T_48 ? {{1'd0}, _T_43} : _T_49; // @[Misc.scala 34:36]
  wire  _T_52 = _T_38 >= _T_50; // @[Plic.scala 344:20]
  wire [2:0] _GEN_5 = {{1'd0}, _T_51}; // @[Plic.scala 344:61]
  wire [2:0] _T_53 = 3'h4 | _GEN_5; // @[Plic.scala 344:61]
  wire [3:0] _T_54 = _T_52 ? _T_38 : _T_50; // @[Misc.scala 34:9]
  wire [2:0] _T_55 = _T_52 ? {{1'd0}, _T_39} : _T_53; // @[Misc.scala 34:36]
  wire  _T_56 = _T_26 >= _T_54; // @[Plic.scala 344:20]
  wire [3:0] _GEN_6 = {{1'd0}, _T_55}; // @[Plic.scala 344:61]
  wire [3:0] _T_57 = 4'h8 | _GEN_6; // @[Plic.scala 344:61]
  wire [3:0] _T_58 = _T_56 ? _T_26 : _T_54; // @[Misc.scala 34:9]
  wire [3:0] _T_59 = _T_56 ? {{1'd0}, _T_27} : _T_57; // @[Misc.scala 34:36]
  wire  _T_60 = effectivePriority_16 >= effectivePriority_17; // @[Plic.scala 344:20]
  wire [3:0] _T_62 = _T_60 ? effectivePriority_16 : effectivePriority_17; // @[Misc.scala 34:9]
  wire  _T_63 = _T_60 ? 1'h0 : 1'h1; // @[Misc.scala 34:36]
  wire  _T_64 = effectivePriority_18 >= effectivePriority_19; // @[Plic.scala 344:20]
  wire [3:0] _T_66 = _T_64 ? effectivePriority_18 : effectivePriority_19; // @[Misc.scala 34:9]
  wire  _T_67 = _T_64 ? 1'h0 : 1'h1; // @[Misc.scala 34:36]
  wire  _T_68 = _T_62 >= _T_66; // @[Plic.scala 344:20]
  wire [1:0] _GEN_7 = {{1'd0}, _T_67}; // @[Plic.scala 344:61]
  wire [1:0] _T_69 = 2'h2 | _GEN_7; // @[Plic.scala 344:61]
  wire [3:0] _T_70 = _T_68 ? _T_62 : _T_66; // @[Misc.scala 34:9]
  wire [1:0] _T_71 = _T_68 ? {{1'd0}, _T_63} : _T_69; // @[Misc.scala 34:36]
  wire  _T_72 = effectivePriority_20 >= effectivePriority_21; // @[Plic.scala 344:20]
  wire [3:0] _T_74 = _T_72 ? effectivePriority_20 : effectivePriority_21; // @[Misc.scala 34:9]
  wire  _T_75 = _T_72 ? 1'h0 : 1'h1; // @[Misc.scala 34:36]
  wire  _T_76 = effectivePriority_22 >= effectivePriority_23; // @[Plic.scala 344:20]
  wire [3:0] _T_78 = _T_76 ? effectivePriority_22 : effectivePriority_23; // @[Misc.scala 34:9]
  wire  _T_79 = _T_76 ? 1'h0 : 1'h1; // @[Misc.scala 34:36]
  wire  _T_80 = _T_74 >= _T_78; // @[Plic.scala 344:20]
  wire [1:0] _GEN_8 = {{1'd0}, _T_79}; // @[Plic.scala 344:61]
  wire [1:0] _T_81 = 2'h2 | _GEN_8; // @[Plic.scala 344:61]
  wire [3:0] _T_82 = _T_80 ? _T_74 : _T_78; // @[Misc.scala 34:9]
  wire [1:0] _T_83 = _T_80 ? {{1'd0}, _T_75} : _T_81; // @[Misc.scala 34:36]
  wire  _T_84 = _T_70 >= _T_82; // @[Plic.scala 344:20]
  wire [2:0] _GEN_9 = {{1'd0}, _T_83}; // @[Plic.scala 344:61]
  wire [2:0] _T_85 = 3'h4 | _GEN_9; // @[Plic.scala 344:61]
  wire [3:0] _T_86 = _T_84 ? _T_70 : _T_82; // @[Misc.scala 34:9]
  wire [2:0] _T_87 = _T_84 ? {{1'd0}, _T_71} : _T_85; // @[Misc.scala 34:36]
  wire  _T_88 = effectivePriority_24 >= effectivePriority_25; // @[Plic.scala 344:20]
  wire [3:0] _T_90 = _T_88 ? effectivePriority_24 : effectivePriority_25; // @[Misc.scala 34:9]
  wire  _T_91 = _T_88 ? 1'h0 : 1'h1; // @[Misc.scala 34:36]
  wire  _T_92 = effectivePriority_26 >= effectivePriority_27; // @[Plic.scala 344:20]
  wire [3:0] _T_94 = _T_92 ? effectivePriority_26 : effectivePriority_27; // @[Misc.scala 34:9]
  wire  _T_95 = _T_92 ? 1'h0 : 1'h1; // @[Misc.scala 34:36]
  wire  _T_96 = _T_90 >= _T_94; // @[Plic.scala 344:20]
  wire [1:0] _GEN_10 = {{1'd0}, _T_95}; // @[Plic.scala 344:61]
  wire [1:0] _T_97 = 2'h2 | _GEN_10; // @[Plic.scala 344:61]
  wire [3:0] _T_98 = _T_96 ? _T_90 : _T_94; // @[Misc.scala 34:9]
  wire [1:0] _T_99 = _T_96 ? {{1'd0}, _T_91} : _T_97; // @[Misc.scala 34:36]
  wire  _T_100 = effectivePriority_28 >= effectivePriority_29; // @[Plic.scala 344:20]
  wire [3:0] _T_102 = _T_100 ? effectivePriority_28 : effectivePriority_29; // @[Misc.scala 34:9]
  wire  _T_103 = _T_100 ? 1'h0 : 1'h1; // @[Misc.scala 34:36]
  wire  _T_104 = effectivePriority_30 >= effectivePriority_31; // @[Plic.scala 344:20]
  wire [3:0] _T_106 = _T_104 ? effectivePriority_30 : effectivePriority_31; // @[Misc.scala 34:9]
  wire  _T_107 = _T_104 ? 1'h0 : 1'h1; // @[Misc.scala 34:36]
  wire  _T_108 = _T_102 >= _T_106; // @[Plic.scala 344:20]
  wire [1:0] _GEN_11 = {{1'd0}, _T_107}; // @[Plic.scala 344:61]
  wire [1:0] _T_109 = 2'h2 | _GEN_11; // @[Plic.scala 344:61]
  wire [3:0] _T_110 = _T_108 ? _T_102 : _T_106; // @[Misc.scala 34:9]
  wire [1:0] _T_111 = _T_108 ? {{1'd0}, _T_103} : _T_109; // @[Misc.scala 34:36]
  wire  _T_112 = _T_98 >= _T_110; // @[Plic.scala 344:20]
  wire [2:0] _GEN_12 = {{1'd0}, _T_111}; // @[Plic.scala 344:61]
  wire [2:0] _T_113 = 3'h4 | _GEN_12; // @[Plic.scala 344:61]
  wire [3:0] _T_114 = _T_112 ? _T_98 : _T_110; // @[Misc.scala 34:9]
  wire [2:0] _T_115 = _T_112 ? {{1'd0}, _T_99} : _T_113; // @[Misc.scala 34:36]
  wire  _T_116 = _T_86 >= _T_114; // @[Plic.scala 344:20]
  wire [3:0] _GEN_13 = {{1'd0}, _T_115}; // @[Plic.scala 344:61]
  wire [3:0] _T_117 = 4'h8 | _GEN_13; // @[Plic.scala 344:61]
  wire [3:0] _T_118 = _T_116 ? _T_86 : _T_114; // @[Misc.scala 34:9]
  wire [3:0] _T_119 = _T_116 ? {{1'd0}, _T_87} : _T_117; // @[Misc.scala 34:36]
  wire  _T_120 = _T_58 >= _T_118; // @[Plic.scala 344:20]
  wire [4:0] _GEN_14 = {{1'd0}, _T_119}; // @[Plic.scala 344:61]
  wire [4:0] _T_121 = 5'h10 | _GEN_14; // @[Plic.scala 344:61]
  wire [3:0] _T_122 = _T_120 ? _T_58 : _T_118; // @[Misc.scala 34:9]
  wire [4:0] _T_123 = _T_120 ? {{1'd0}, _T_59} : _T_121; // @[Misc.scala 34:36]
  wire  _T_124 = _T_122 >= effectivePriority_32; // @[Plic.scala 344:20]
  wire [3:0] maxPri = _T_124 ? _T_122 : effectivePriority_32; // @[Misc.scala 34:9]
  assign io_dev = _T_124 ? {{1'd0}, _T_123} : 6'h20; // @[Misc.scala 34:36]
  assign io_max = maxPri[2:0]; // @[Plic.scala 350:10]
endmodule
module TLPLIC(
  input         clock,
  input         reset,
  input         auto_int_in_0,
  input         auto_int_in_1,
  input         auto_int_in_2,
  input         auto_int_in_3,
  input         auto_int_in_4,
  input         auto_int_in_5,
  input         auto_int_in_6,
  input         auto_int_in_7,
  input         auto_int_in_8,
  input         auto_int_in_9,
  input         auto_int_in_10,
  input         auto_int_in_11,
  input         auto_int_in_12,
  input         auto_int_in_13,
  input         auto_int_in_14,
  input         auto_int_in_15,
  input         auto_int_in_16,
  input         auto_int_in_17,
  input         auto_int_in_18,
  input         auto_int_in_19,
  input         auto_int_in_20,
  input         auto_int_in_21,
  input         auto_int_in_22,
  input         auto_int_in_23,
  input         auto_int_in_24,
  input         auto_int_in_25,
  input         auto_int_in_26,
  input         auto_int_in_27,
  input         auto_int_in_28,
  input         auto_int_in_29,
  input         auto_int_in_30,
  input         auto_int_in_31,
  output        auto_int_out_1_0,
  output        auto_int_out_0_0,
  output        auto_in_a_ready,
  input         auto_in_a_valid,
  input  [2:0]  auto_in_a_bits_opcode,
  input  [2:0]  auto_in_a_bits_param,
  input  [1:0]  auto_in_a_bits_size,
  input  [8:0]  auto_in_a_bits_source,
  input  [27:0] auto_in_a_bits_address,
  input  [7:0]  auto_in_a_bits_mask,
  input  [63:0] auto_in_a_bits_data,
  input         auto_in_a_bits_corrupt,
  input         auto_in_d_ready,
  output        auto_in_d_valid,
  output [2:0]  auto_in_d_bits_opcode,
  output [1:0]  auto_in_d_bits_size,
  output [8:0]  auto_in_d_bits_source,
  output [63:0] auto_in_d_bits_data
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_63;
  reg [31:0] _RAND_64;
  reg [31:0] _RAND_65;
  reg [31:0] _RAND_66;
  reg [31:0] _RAND_67;
  reg [31:0] _RAND_68;
  reg [31:0] _RAND_69;
  reg [31:0] _RAND_70;
  reg [31:0] _RAND_71;
  reg [31:0] _RAND_72;
  reg [31:0] _RAND_73;
  reg [31:0] _RAND_74;
  reg [31:0] _RAND_75;
  reg [31:0] _RAND_76;
  reg [31:0] _RAND_77;
  reg [31:0] _RAND_78;
  reg [31:0] _RAND_79;
`endif // RANDOMIZE_REG_INIT
  wire  monitor_clock; // @[Nodes.scala 24:25]
  wire  monitor_reset; // @[Nodes.scala 24:25]
  wire  monitor_io_in_a_ready; // @[Nodes.scala 24:25]
  wire  monitor_io_in_a_valid; // @[Nodes.scala 24:25]
  wire [2:0] monitor_io_in_a_bits_opcode; // @[Nodes.scala 24:25]
  wire [2:0] monitor_io_in_a_bits_param; // @[Nodes.scala 24:25]
  wire [1:0] monitor_io_in_a_bits_size; // @[Nodes.scala 24:25]
  wire [8:0] monitor_io_in_a_bits_source; // @[Nodes.scala 24:25]
  wire [27:0] monitor_io_in_a_bits_address; // @[Nodes.scala 24:25]
  wire [7:0] monitor_io_in_a_bits_mask; // @[Nodes.scala 24:25]
  wire  monitor_io_in_a_bits_corrupt; // @[Nodes.scala 24:25]
  wire  monitor_io_in_d_ready; // @[Nodes.scala 24:25]
  wire  monitor_io_in_d_valid; // @[Nodes.scala 24:25]
  wire [2:0] monitor_io_in_d_bits_opcode; // @[Nodes.scala 24:25]
  wire [1:0] monitor_io_in_d_bits_size; // @[Nodes.scala 24:25]
  wire [8:0] monitor_io_in_d_bits_source; // @[Nodes.scala 24:25]
  wire  gateways_gateway_clock; // @[Plic.scala 155:27]
  wire  gateways_gateway_reset; // @[Plic.scala 155:27]
  wire  gateways_gateway_io_interrupt; // @[Plic.scala 155:27]
  wire  gateways_gateway_io_plic_valid; // @[Plic.scala 155:27]
  wire  gateways_gateway_io_plic_ready; // @[Plic.scala 155:27]
  wire  gateways_gateway_io_plic_complete; // @[Plic.scala 155:27]
  wire  gateways_gateway_1_clock; // @[Plic.scala 155:27]
  wire  gateways_gateway_1_reset; // @[Plic.scala 155:27]
  wire  gateways_gateway_1_io_interrupt; // @[Plic.scala 155:27]
  wire  gateways_gateway_1_io_plic_valid; // @[Plic.scala 155:27]
  wire  gateways_gateway_1_io_plic_ready; // @[Plic.scala 155:27]
  wire  gateways_gateway_1_io_plic_complete; // @[Plic.scala 155:27]
  wire  gateways_gateway_2_clock; // @[Plic.scala 155:27]
  wire  gateways_gateway_2_reset; // @[Plic.scala 155:27]
  wire  gateways_gateway_2_io_interrupt; // @[Plic.scala 155:27]
  wire  gateways_gateway_2_io_plic_valid; // @[Plic.scala 155:27]
  wire  gateways_gateway_2_io_plic_ready; // @[Plic.scala 155:27]
  wire  gateways_gateway_2_io_plic_complete; // @[Plic.scala 155:27]
  wire  gateways_gateway_3_clock; // @[Plic.scala 155:27]
  wire  gateways_gateway_3_reset; // @[Plic.scala 155:27]
  wire  gateways_gateway_3_io_interrupt; // @[Plic.scala 155:27]
  wire  gateways_gateway_3_io_plic_valid; // @[Plic.scala 155:27]
  wire  gateways_gateway_3_io_plic_ready; // @[Plic.scala 155:27]
  wire  gateways_gateway_3_io_plic_complete; // @[Plic.scala 155:27]
  wire  gateways_gateway_4_clock; // @[Plic.scala 155:27]
  wire  gateways_gateway_4_reset; // @[Plic.scala 155:27]
  wire  gateways_gateway_4_io_interrupt; // @[Plic.scala 155:27]
  wire  gateways_gateway_4_io_plic_valid; // @[Plic.scala 155:27]
  wire  gateways_gateway_4_io_plic_ready; // @[Plic.scala 155:27]
  wire  gateways_gateway_4_io_plic_complete; // @[Plic.scala 155:27]
  wire  gateways_gateway_5_clock; // @[Plic.scala 155:27]
  wire  gateways_gateway_5_reset; // @[Plic.scala 155:27]
  wire  gateways_gateway_5_io_interrupt; // @[Plic.scala 155:27]
  wire  gateways_gateway_5_io_plic_valid; // @[Plic.scala 155:27]
  wire  gateways_gateway_5_io_plic_ready; // @[Plic.scala 155:27]
  wire  gateways_gateway_5_io_plic_complete; // @[Plic.scala 155:27]
  wire  gateways_gateway_6_clock; // @[Plic.scala 155:27]
  wire  gateways_gateway_6_reset; // @[Plic.scala 155:27]
  wire  gateways_gateway_6_io_interrupt; // @[Plic.scala 155:27]
  wire  gateways_gateway_6_io_plic_valid; // @[Plic.scala 155:27]
  wire  gateways_gateway_6_io_plic_ready; // @[Plic.scala 155:27]
  wire  gateways_gateway_6_io_plic_complete; // @[Plic.scala 155:27]
  wire  gateways_gateway_7_clock; // @[Plic.scala 155:27]
  wire  gateways_gateway_7_reset; // @[Plic.scala 155:27]
  wire  gateways_gateway_7_io_interrupt; // @[Plic.scala 155:27]
  wire  gateways_gateway_7_io_plic_valid; // @[Plic.scala 155:27]
  wire  gateways_gateway_7_io_plic_ready; // @[Plic.scala 155:27]
  wire  gateways_gateway_7_io_plic_complete; // @[Plic.scala 155:27]
  wire  gateways_gateway_8_clock; // @[Plic.scala 155:27]
  wire  gateways_gateway_8_reset; // @[Plic.scala 155:27]
  wire  gateways_gateway_8_io_interrupt; // @[Plic.scala 155:27]
  wire  gateways_gateway_8_io_plic_valid; // @[Plic.scala 155:27]
  wire  gateways_gateway_8_io_plic_ready; // @[Plic.scala 155:27]
  wire  gateways_gateway_8_io_plic_complete; // @[Plic.scala 155:27]
  wire  gateways_gateway_9_clock; // @[Plic.scala 155:27]
  wire  gateways_gateway_9_reset; // @[Plic.scala 155:27]
  wire  gateways_gateway_9_io_interrupt; // @[Plic.scala 155:27]
  wire  gateways_gateway_9_io_plic_valid; // @[Plic.scala 155:27]
  wire  gateways_gateway_9_io_plic_ready; // @[Plic.scala 155:27]
  wire  gateways_gateway_9_io_plic_complete; // @[Plic.scala 155:27]
  wire  gateways_gateway_10_clock; // @[Plic.scala 155:27]
  wire  gateways_gateway_10_reset; // @[Plic.scala 155:27]
  wire  gateways_gateway_10_io_interrupt; // @[Plic.scala 155:27]
  wire  gateways_gateway_10_io_plic_valid; // @[Plic.scala 155:27]
  wire  gateways_gateway_10_io_plic_ready; // @[Plic.scala 155:27]
  wire  gateways_gateway_10_io_plic_complete; // @[Plic.scala 155:27]
  wire  gateways_gateway_11_clock; // @[Plic.scala 155:27]
  wire  gateways_gateway_11_reset; // @[Plic.scala 155:27]
  wire  gateways_gateway_11_io_interrupt; // @[Plic.scala 155:27]
  wire  gateways_gateway_11_io_plic_valid; // @[Plic.scala 155:27]
  wire  gateways_gateway_11_io_plic_ready; // @[Plic.scala 155:27]
  wire  gateways_gateway_11_io_plic_complete; // @[Plic.scala 155:27]
  wire  gateways_gateway_12_clock; // @[Plic.scala 155:27]
  wire  gateways_gateway_12_reset; // @[Plic.scala 155:27]
  wire  gateways_gateway_12_io_interrupt; // @[Plic.scala 155:27]
  wire  gateways_gateway_12_io_plic_valid; // @[Plic.scala 155:27]
  wire  gateways_gateway_12_io_plic_ready; // @[Plic.scala 155:27]
  wire  gateways_gateway_12_io_plic_complete; // @[Plic.scala 155:27]
  wire  gateways_gateway_13_clock; // @[Plic.scala 155:27]
  wire  gateways_gateway_13_reset; // @[Plic.scala 155:27]
  wire  gateways_gateway_13_io_interrupt; // @[Plic.scala 155:27]
  wire  gateways_gateway_13_io_plic_valid; // @[Plic.scala 155:27]
  wire  gateways_gateway_13_io_plic_ready; // @[Plic.scala 155:27]
  wire  gateways_gateway_13_io_plic_complete; // @[Plic.scala 155:27]
  wire  gateways_gateway_14_clock; // @[Plic.scala 155:27]
  wire  gateways_gateway_14_reset; // @[Plic.scala 155:27]
  wire  gateways_gateway_14_io_interrupt; // @[Plic.scala 155:27]
  wire  gateways_gateway_14_io_plic_valid; // @[Plic.scala 155:27]
  wire  gateways_gateway_14_io_plic_ready; // @[Plic.scala 155:27]
  wire  gateways_gateway_14_io_plic_complete; // @[Plic.scala 155:27]
  wire  gateways_gateway_15_clock; // @[Plic.scala 155:27]
  wire  gateways_gateway_15_reset; // @[Plic.scala 155:27]
  wire  gateways_gateway_15_io_interrupt; // @[Plic.scala 155:27]
  wire  gateways_gateway_15_io_plic_valid; // @[Plic.scala 155:27]
  wire  gateways_gateway_15_io_plic_ready; // @[Plic.scala 155:27]
  wire  gateways_gateway_15_io_plic_complete; // @[Plic.scala 155:27]
  wire  gateways_gateway_16_clock; // @[Plic.scala 155:27]
  wire  gateways_gateway_16_reset; // @[Plic.scala 155:27]
  wire  gateways_gateway_16_io_interrupt; // @[Plic.scala 155:27]
  wire  gateways_gateway_16_io_plic_valid; // @[Plic.scala 155:27]
  wire  gateways_gateway_16_io_plic_ready; // @[Plic.scala 155:27]
  wire  gateways_gateway_16_io_plic_complete; // @[Plic.scala 155:27]
  wire  gateways_gateway_17_clock; // @[Plic.scala 155:27]
  wire  gateways_gateway_17_reset; // @[Plic.scala 155:27]
  wire  gateways_gateway_17_io_interrupt; // @[Plic.scala 155:27]
  wire  gateways_gateway_17_io_plic_valid; // @[Plic.scala 155:27]
  wire  gateways_gateway_17_io_plic_ready; // @[Plic.scala 155:27]
  wire  gateways_gateway_17_io_plic_complete; // @[Plic.scala 155:27]
  wire  gateways_gateway_18_clock; // @[Plic.scala 155:27]
  wire  gateways_gateway_18_reset; // @[Plic.scala 155:27]
  wire  gateways_gateway_18_io_interrupt; // @[Plic.scala 155:27]
  wire  gateways_gateway_18_io_plic_valid; // @[Plic.scala 155:27]
  wire  gateways_gateway_18_io_plic_ready; // @[Plic.scala 155:27]
  wire  gateways_gateway_18_io_plic_complete; // @[Plic.scala 155:27]
  wire  gateways_gateway_19_clock; // @[Plic.scala 155:27]
  wire  gateways_gateway_19_reset; // @[Plic.scala 155:27]
  wire  gateways_gateway_19_io_interrupt; // @[Plic.scala 155:27]
  wire  gateways_gateway_19_io_plic_valid; // @[Plic.scala 155:27]
  wire  gateways_gateway_19_io_plic_ready; // @[Plic.scala 155:27]
  wire  gateways_gateway_19_io_plic_complete; // @[Plic.scala 155:27]
  wire  gateways_gateway_20_clock; // @[Plic.scala 155:27]
  wire  gateways_gateway_20_reset; // @[Plic.scala 155:27]
  wire  gateways_gateway_20_io_interrupt; // @[Plic.scala 155:27]
  wire  gateways_gateway_20_io_plic_valid; // @[Plic.scala 155:27]
  wire  gateways_gateway_20_io_plic_ready; // @[Plic.scala 155:27]
  wire  gateways_gateway_20_io_plic_complete; // @[Plic.scala 155:27]
  wire  gateways_gateway_21_clock; // @[Plic.scala 155:27]
  wire  gateways_gateway_21_reset; // @[Plic.scala 155:27]
  wire  gateways_gateway_21_io_interrupt; // @[Plic.scala 155:27]
  wire  gateways_gateway_21_io_plic_valid; // @[Plic.scala 155:27]
  wire  gateways_gateway_21_io_plic_ready; // @[Plic.scala 155:27]
  wire  gateways_gateway_21_io_plic_complete; // @[Plic.scala 155:27]
  wire  gateways_gateway_22_clock; // @[Plic.scala 155:27]
  wire  gateways_gateway_22_reset; // @[Plic.scala 155:27]
  wire  gateways_gateway_22_io_interrupt; // @[Plic.scala 155:27]
  wire  gateways_gateway_22_io_plic_valid; // @[Plic.scala 155:27]
  wire  gateways_gateway_22_io_plic_ready; // @[Plic.scala 155:27]
  wire  gateways_gateway_22_io_plic_complete; // @[Plic.scala 155:27]
  wire  gateways_gateway_23_clock; // @[Plic.scala 155:27]
  wire  gateways_gateway_23_reset; // @[Plic.scala 155:27]
  wire  gateways_gateway_23_io_interrupt; // @[Plic.scala 155:27]
  wire  gateways_gateway_23_io_plic_valid; // @[Plic.scala 155:27]
  wire  gateways_gateway_23_io_plic_ready; // @[Plic.scala 155:27]
  wire  gateways_gateway_23_io_plic_complete; // @[Plic.scala 155:27]
  wire  gateways_gateway_24_clock; // @[Plic.scala 155:27]
  wire  gateways_gateway_24_reset; // @[Plic.scala 155:27]
  wire  gateways_gateway_24_io_interrupt; // @[Plic.scala 155:27]
  wire  gateways_gateway_24_io_plic_valid; // @[Plic.scala 155:27]
  wire  gateways_gateway_24_io_plic_ready; // @[Plic.scala 155:27]
  wire  gateways_gateway_24_io_plic_complete; // @[Plic.scala 155:27]
  wire  gateways_gateway_25_clock; // @[Plic.scala 155:27]
  wire  gateways_gateway_25_reset; // @[Plic.scala 155:27]
  wire  gateways_gateway_25_io_interrupt; // @[Plic.scala 155:27]
  wire  gateways_gateway_25_io_plic_valid; // @[Plic.scala 155:27]
  wire  gateways_gateway_25_io_plic_ready; // @[Plic.scala 155:27]
  wire  gateways_gateway_25_io_plic_complete; // @[Plic.scala 155:27]
  wire  gateways_gateway_26_clock; // @[Plic.scala 155:27]
  wire  gateways_gateway_26_reset; // @[Plic.scala 155:27]
  wire  gateways_gateway_26_io_interrupt; // @[Plic.scala 155:27]
  wire  gateways_gateway_26_io_plic_valid; // @[Plic.scala 155:27]
  wire  gateways_gateway_26_io_plic_ready; // @[Plic.scala 155:27]
  wire  gateways_gateway_26_io_plic_complete; // @[Plic.scala 155:27]
  wire  gateways_gateway_27_clock; // @[Plic.scala 155:27]
  wire  gateways_gateway_27_reset; // @[Plic.scala 155:27]
  wire  gateways_gateway_27_io_interrupt; // @[Plic.scala 155:27]
  wire  gateways_gateway_27_io_plic_valid; // @[Plic.scala 155:27]
  wire  gateways_gateway_27_io_plic_ready; // @[Plic.scala 155:27]
  wire  gateways_gateway_27_io_plic_complete; // @[Plic.scala 155:27]
  wire  gateways_gateway_28_clock; // @[Plic.scala 155:27]
  wire  gateways_gateway_28_reset; // @[Plic.scala 155:27]
  wire  gateways_gateway_28_io_interrupt; // @[Plic.scala 155:27]
  wire  gateways_gateway_28_io_plic_valid; // @[Plic.scala 155:27]
  wire  gateways_gateway_28_io_plic_ready; // @[Plic.scala 155:27]
  wire  gateways_gateway_28_io_plic_complete; // @[Plic.scala 155:27]
  wire  gateways_gateway_29_clock; // @[Plic.scala 155:27]
  wire  gateways_gateway_29_reset; // @[Plic.scala 155:27]
  wire  gateways_gateway_29_io_interrupt; // @[Plic.scala 155:27]
  wire  gateways_gateway_29_io_plic_valid; // @[Plic.scala 155:27]
  wire  gateways_gateway_29_io_plic_ready; // @[Plic.scala 155:27]
  wire  gateways_gateway_29_io_plic_complete; // @[Plic.scala 155:27]
  wire  gateways_gateway_30_clock; // @[Plic.scala 155:27]
  wire  gateways_gateway_30_reset; // @[Plic.scala 155:27]
  wire  gateways_gateway_30_io_interrupt; // @[Plic.scala 155:27]
  wire  gateways_gateway_30_io_plic_valid; // @[Plic.scala 155:27]
  wire  gateways_gateway_30_io_plic_ready; // @[Plic.scala 155:27]
  wire  gateways_gateway_30_io_plic_complete; // @[Plic.scala 155:27]
  wire  gateways_gateway_31_clock; // @[Plic.scala 155:27]
  wire  gateways_gateway_31_reset; // @[Plic.scala 155:27]
  wire  gateways_gateway_31_io_interrupt; // @[Plic.scala 155:27]
  wire  gateways_gateway_31_io_plic_valid; // @[Plic.scala 155:27]
  wire  gateways_gateway_31_io_plic_ready; // @[Plic.scala 155:27]
  wire  gateways_gateway_31_io_plic_complete; // @[Plic.scala 155:27]
  wire [2:0] fanin_io_prio_0; // @[Plic.scala 183:25]
  wire [2:0] fanin_io_prio_1; // @[Plic.scala 183:25]
  wire [2:0] fanin_io_prio_2; // @[Plic.scala 183:25]
  wire [2:0] fanin_io_prio_3; // @[Plic.scala 183:25]
  wire [2:0] fanin_io_prio_4; // @[Plic.scala 183:25]
  wire [2:0] fanin_io_prio_5; // @[Plic.scala 183:25]
  wire [2:0] fanin_io_prio_6; // @[Plic.scala 183:25]
  wire [2:0] fanin_io_prio_7; // @[Plic.scala 183:25]
  wire [2:0] fanin_io_prio_8; // @[Plic.scala 183:25]
  wire [2:0] fanin_io_prio_9; // @[Plic.scala 183:25]
  wire [2:0] fanin_io_prio_10; // @[Plic.scala 183:25]
  wire [2:0] fanin_io_prio_11; // @[Plic.scala 183:25]
  wire [2:0] fanin_io_prio_12; // @[Plic.scala 183:25]
  wire [2:0] fanin_io_prio_13; // @[Plic.scala 183:25]
  wire [2:0] fanin_io_prio_14; // @[Plic.scala 183:25]
  wire [2:0] fanin_io_prio_15; // @[Plic.scala 183:25]
  wire [2:0] fanin_io_prio_16; // @[Plic.scala 183:25]
  wire [2:0] fanin_io_prio_17; // @[Plic.scala 183:25]
  wire [2:0] fanin_io_prio_18; // @[Plic.scala 183:25]
  wire [2:0] fanin_io_prio_19; // @[Plic.scala 183:25]
  wire [2:0] fanin_io_prio_20; // @[Plic.scala 183:25]
  wire [2:0] fanin_io_prio_21; // @[Plic.scala 183:25]
  wire [2:0] fanin_io_prio_22; // @[Plic.scala 183:25]
  wire [2:0] fanin_io_prio_23; // @[Plic.scala 183:25]
  wire [2:0] fanin_io_prio_24; // @[Plic.scala 183:25]
  wire [2:0] fanin_io_prio_25; // @[Plic.scala 183:25]
  wire [2:0] fanin_io_prio_26; // @[Plic.scala 183:25]
  wire [2:0] fanin_io_prio_27; // @[Plic.scala 183:25]
  wire [2:0] fanin_io_prio_28; // @[Plic.scala 183:25]
  wire [2:0] fanin_io_prio_29; // @[Plic.scala 183:25]
  wire [2:0] fanin_io_prio_30; // @[Plic.scala 183:25]
  wire [2:0] fanin_io_prio_31; // @[Plic.scala 183:25]
  wire [31:0] fanin_io_ip; // @[Plic.scala 183:25]
  wire [5:0] fanin_io_dev; // @[Plic.scala 183:25]
  wire [2:0] fanin_io_max; // @[Plic.scala 183:25]
  wire [2:0] fanin_1_io_prio_0; // @[Plic.scala 183:25]
  wire [2:0] fanin_1_io_prio_1; // @[Plic.scala 183:25]
  wire [2:0] fanin_1_io_prio_2; // @[Plic.scala 183:25]
  wire [2:0] fanin_1_io_prio_3; // @[Plic.scala 183:25]
  wire [2:0] fanin_1_io_prio_4; // @[Plic.scala 183:25]
  wire [2:0] fanin_1_io_prio_5; // @[Plic.scala 183:25]
  wire [2:0] fanin_1_io_prio_6; // @[Plic.scala 183:25]
  wire [2:0] fanin_1_io_prio_7; // @[Plic.scala 183:25]
  wire [2:0] fanin_1_io_prio_8; // @[Plic.scala 183:25]
  wire [2:0] fanin_1_io_prio_9; // @[Plic.scala 183:25]
  wire [2:0] fanin_1_io_prio_10; // @[Plic.scala 183:25]
  wire [2:0] fanin_1_io_prio_11; // @[Plic.scala 183:25]
  wire [2:0] fanin_1_io_prio_12; // @[Plic.scala 183:25]
  wire [2:0] fanin_1_io_prio_13; // @[Plic.scala 183:25]
  wire [2:0] fanin_1_io_prio_14; // @[Plic.scala 183:25]
  wire [2:0] fanin_1_io_prio_15; // @[Plic.scala 183:25]
  wire [2:0] fanin_1_io_prio_16; // @[Plic.scala 183:25]
  wire [2:0] fanin_1_io_prio_17; // @[Plic.scala 183:25]
  wire [2:0] fanin_1_io_prio_18; // @[Plic.scala 183:25]
  wire [2:0] fanin_1_io_prio_19; // @[Plic.scala 183:25]
  wire [2:0] fanin_1_io_prio_20; // @[Plic.scala 183:25]
  wire [2:0] fanin_1_io_prio_21; // @[Plic.scala 183:25]
  wire [2:0] fanin_1_io_prio_22; // @[Plic.scala 183:25]
  wire [2:0] fanin_1_io_prio_23; // @[Plic.scala 183:25]
  wire [2:0] fanin_1_io_prio_24; // @[Plic.scala 183:25]
  wire [2:0] fanin_1_io_prio_25; // @[Plic.scala 183:25]
  wire [2:0] fanin_1_io_prio_26; // @[Plic.scala 183:25]
  wire [2:0] fanin_1_io_prio_27; // @[Plic.scala 183:25]
  wire [2:0] fanin_1_io_prio_28; // @[Plic.scala 183:25]
  wire [2:0] fanin_1_io_prio_29; // @[Plic.scala 183:25]
  wire [2:0] fanin_1_io_prio_30; // @[Plic.scala 183:25]
  wire [2:0] fanin_1_io_prio_31; // @[Plic.scala 183:25]
  wire [31:0] fanin_1_io_ip; // @[Plic.scala 183:25]
  wire [5:0] fanin_1_io_dev; // @[Plic.scala 183:25]
  wire [2:0] fanin_1_io_max; // @[Plic.scala 183:25]
  wire  out_back_clock; // @[Decoupled.scala 361:21]
  wire  out_back_reset; // @[Decoupled.scala 361:21]
  wire  out_back_io_enq_ready; // @[Decoupled.scala 361:21]
  wire  out_back_io_enq_valid; // @[Decoupled.scala 361:21]
  wire  out_back_io_enq_bits_read; // @[Decoupled.scala 361:21]
  wire [22:0] out_back_io_enq_bits_index; // @[Decoupled.scala 361:21]
  wire [63:0] out_back_io_enq_bits_data; // @[Decoupled.scala 361:21]
  wire [7:0] out_back_io_enq_bits_mask; // @[Decoupled.scala 361:21]
  wire [8:0] out_back_io_enq_bits_extra_tlrr_extra_source; // @[Decoupled.scala 361:21]
  wire [1:0] out_back_io_enq_bits_extra_tlrr_extra_size; // @[Decoupled.scala 361:21]
  wire  out_back_io_deq_ready; // @[Decoupled.scala 361:21]
  wire  out_back_io_deq_valid; // @[Decoupled.scala 361:21]
  wire  out_back_io_deq_bits_read; // @[Decoupled.scala 361:21]
  wire [22:0] out_back_io_deq_bits_index; // @[Decoupled.scala 361:21]
  wire [63:0] out_back_io_deq_bits_data; // @[Decoupled.scala 361:21]
  wire [7:0] out_back_io_deq_bits_mask; // @[Decoupled.scala 361:21]
  wire [8:0] out_back_io_deq_bits_extra_tlrr_extra_source; // @[Decoupled.scala 361:21]
  wire [1:0] out_back_io_deq_bits_extra_tlrr_extra_size; // @[Decoupled.scala 361:21]
  reg [2:0] priority_0; // @[Plic.scala 162:31]
  reg [2:0] priority_1; // @[Plic.scala 162:31]
  reg [2:0] priority_2; // @[Plic.scala 162:31]
  reg [2:0] priority_3; // @[Plic.scala 162:31]
  reg [2:0] priority_4; // @[Plic.scala 162:31]
  reg [2:0] priority_5; // @[Plic.scala 162:31]
  reg [2:0] priority_6; // @[Plic.scala 162:31]
  reg [2:0] priority_7; // @[Plic.scala 162:31]
  reg [2:0] priority_8; // @[Plic.scala 162:31]
  reg [2:0] priority_9; // @[Plic.scala 162:31]
  reg [2:0] priority_10; // @[Plic.scala 162:31]
  reg [2:0] priority_11; // @[Plic.scala 162:31]
  reg [2:0] priority_12; // @[Plic.scala 162:31]
  reg [2:0] priority_13; // @[Plic.scala 162:31]
  reg [2:0] priority_14; // @[Plic.scala 162:31]
  reg [2:0] priority_15; // @[Plic.scala 162:31]
  reg [2:0] priority_16; // @[Plic.scala 162:31]
  reg [2:0] priority_17; // @[Plic.scala 162:31]
  reg [2:0] priority_18; // @[Plic.scala 162:31]
  reg [2:0] priority_19; // @[Plic.scala 162:31]
  reg [2:0] priority_20; // @[Plic.scala 162:31]
  reg [2:0] priority_21; // @[Plic.scala 162:31]
  reg [2:0] priority_22; // @[Plic.scala 162:31]
  reg [2:0] priority_23; // @[Plic.scala 162:31]
  reg [2:0] priority_24; // @[Plic.scala 162:31]
  reg [2:0] priority_25; // @[Plic.scala 162:31]
  reg [2:0] priority_26; // @[Plic.scala 162:31]
  reg [2:0] priority_27; // @[Plic.scala 162:31]
  reg [2:0] priority_28; // @[Plic.scala 162:31]
  reg [2:0] priority_29; // @[Plic.scala 162:31]
  reg [2:0] priority_30; // @[Plic.scala 162:31]
  reg [2:0] priority_31; // @[Plic.scala 162:31]
  reg [2:0] threshold_0; // @[Plic.scala 165:31]
  reg [2:0] threshold_1; // @[Plic.scala 165:31]
  reg  pending_0; // @[Plic.scala 167:22]
  reg  pending_1; // @[Plic.scala 167:22]
  reg  pending_2; // @[Plic.scala 167:22]
  reg  pending_3; // @[Plic.scala 167:22]
  reg  pending_4; // @[Plic.scala 167:22]
  reg  pending_5; // @[Plic.scala 167:22]
  reg  pending_6; // @[Plic.scala 167:22]
  reg  pending_7; // @[Plic.scala 167:22]
  reg  pending_8; // @[Plic.scala 167:22]
  reg  pending_9; // @[Plic.scala 167:22]
  reg  pending_10; // @[Plic.scala 167:22]
  reg  pending_11; // @[Plic.scala 167:22]
  reg  pending_12; // @[Plic.scala 167:22]
  reg  pending_13; // @[Plic.scala 167:22]
  reg  pending_14; // @[Plic.scala 167:22]
  reg  pending_15; // @[Plic.scala 167:22]
  reg  pending_16; // @[Plic.scala 167:22]
  reg  pending_17; // @[Plic.scala 167:22]
  reg  pending_18; // @[Plic.scala 167:22]
  reg  pending_19; // @[Plic.scala 167:22]
  reg  pending_20; // @[Plic.scala 167:22]
  reg  pending_21; // @[Plic.scala 167:22]
  reg  pending_22; // @[Plic.scala 167:22]
  reg  pending_23; // @[Plic.scala 167:22]
  reg  pending_24; // @[Plic.scala 167:22]
  reg  pending_25; // @[Plic.scala 167:22]
  reg  pending_26; // @[Plic.scala 167:22]
  reg  pending_27; // @[Plic.scala 167:22]
  reg  pending_28; // @[Plic.scala 167:22]
  reg  pending_29; // @[Plic.scala 167:22]
  reg  pending_30; // @[Plic.scala 167:22]
  reg  pending_31; // @[Plic.scala 167:22]
  reg [6:0] enables_0_0; // @[Plic.scala 173:26]
  reg [7:0] enables_0_1; // @[Plic.scala 174:50]
  reg [7:0] enables_0_2; // @[Plic.scala 174:50]
  reg [7:0] enables_0_3; // @[Plic.scala 174:50]
  reg  enables_0_4; // @[Plic.scala 175:51]
  reg [6:0] enables_1_0; // @[Plic.scala 173:26]
  reg [7:0] enables_1_1; // @[Plic.scala 174:50]
  reg [7:0] enables_1_2; // @[Plic.scala 174:50]
  reg [7:0] enables_1_3; // @[Plic.scala 174:50]
  reg  enables_1_4; // @[Plic.scala 175:51]
  wire [31:0] enableVec_0 = {enables_0_4,enables_0_3,enables_0_2,enables_0_1,enables_0_0}; // @[Cat.scala 31:58]
  wire [31:0] enableVec_1 = {enables_1_4,enables_1_3,enables_1_2,enables_1_1,enables_1_0}; // @[Cat.scala 31:58]
  wire [32:0] enableVec0_0 = {enables_0_4,enables_0_3,enables_0_2,enables_0_1,enables_0_0,1'h0}; // @[Cat.scala 31:58]
  wire [32:0] enableVec0_1 = {enables_1_4,enables_1_3,enables_1_2,enables_1_1,enables_1_0,1'h0}; // @[Cat.scala 31:58]
  reg [5:0] maxDevs_0; // @[Plic.scala 180:22]
  reg [5:0] maxDevs_1; // @[Plic.scala 180:22]
  wire [7:0] pendingUInt_lo_lo = {pending_7,pending_6,pending_5,pending_4,pending_3,pending_2,pending_1,pending_0}; // @[Cat.scala 31:58]
  wire [15:0] pendingUInt_lo = {pending_15,pending_14,pending_13,pending_12,pending_11,pending_10,pending_9,pending_8,
    pendingUInt_lo_lo}; // @[Cat.scala 31:58]
  wire [7:0] pendingUInt_hi_lo = {pending_23,pending_22,pending_21,pending_20,pending_19,pending_18,pending_17,
    pending_16}; // @[Cat.scala 31:58]
  wire [31:0] pendingUInt = {pending_31,pending_30,pending_29,pending_28,pending_27,pending_26,pending_25,pending_24,
    pendingUInt_hi_lo,pendingUInt_lo}; // @[Cat.scala 31:58]
  reg [2:0] bundleOut_0_0_REG; // @[Plic.scala 187:41]
  reg [2:0] bundleOut_1_0_REG; // @[Plic.scala 187:41]
  wire [7:0] out_oindex = {out_back_io_deq_bits_index[18],out_back_io_deq_bits_index[10],out_back_io_deq_bits_index[9],
    out_back_io_deq_bits_index[4],out_back_io_deq_bits_index[3],out_back_io_deq_bits_index[2],out_back_io_deq_bits_index
    [1],out_back_io_deq_bits_index[0]}; // @[Cat.scala 31:58]
  wire [255:0] _out_backSel_T = 256'h1 << out_oindex; // @[OneHot.scala 57:35]
  wire  out_backSel_160 = _out_backSel_T[160]; // @[RegisterRouter.scala 82:24]
  wire [22:0] out_bindex = out_back_io_deq_bits_index & 23'h7bf9e0; // @[RegisterRouter.scala 82:24]
  wire  _out_T_25 = out_bindex == 23'h0; // @[RegisterRouter.scala 82:24]
  wire  out_roready_64 = out_back_io_deq_valid & auto_in_d_ready & out_back_io_deq_bits_read & out_backSel_160 &
    out_bindex == 23'h0; // @[RegisterRouter.scala 82:24]
  wire [7:0] _out_backMask_T_23 = out_back_io_deq_bits_mask[7] ? 8'hff : 8'h0; // @[Bitwise.scala 74:12]
  wire [7:0] _out_backMask_T_21 = out_back_io_deq_bits_mask[6] ? 8'hff : 8'h0; // @[Bitwise.scala 74:12]
  wire [7:0] _out_backMask_T_19 = out_back_io_deq_bits_mask[5] ? 8'hff : 8'h0; // @[Bitwise.scala 74:12]
  wire [7:0] _out_backMask_T_17 = out_back_io_deq_bits_mask[4] ? 8'hff : 8'h0; // @[Bitwise.scala 74:12]
  wire [7:0] _out_backMask_T_15 = out_back_io_deq_bits_mask[3] ? 8'hff : 8'h0; // @[Bitwise.scala 74:12]
  wire [7:0] _out_backMask_T_13 = out_back_io_deq_bits_mask[2] ? 8'hff : 8'h0; // @[Bitwise.scala 74:12]
  wire [7:0] _out_backMask_T_11 = out_back_io_deq_bits_mask[1] ? 8'hff : 8'h0; // @[Bitwise.scala 74:12]
  wire [7:0] _out_backMask_T_9 = out_back_io_deq_bits_mask[0] ? 8'hff : 8'h0; // @[Bitwise.scala 74:12]
  wire [63:0] out_backMask = {_out_backMask_T_23,_out_backMask_T_21,_out_backMask_T_19,_out_backMask_T_17,
    _out_backMask_T_15,_out_backMask_T_13,_out_backMask_T_11,_out_backMask_T_9}; // @[Cat.scala 31:58]
  wire  out_romask_64 = |out_backMask[63:32]; // @[RegisterRouter.scala 82:24]
  wire  out_f_roready_64 = out_roready_64 & out_romask_64; // @[RegisterRouter.scala 82:24]
  wire  out_backSel_128 = _out_backSel_T[128]; // @[RegisterRouter.scala 82:24]
  wire  out_roready_74 = out_back_io_deq_valid & auto_in_d_ready & out_back_io_deq_bits_read & out_backSel_128 &
    out_bindex == 23'h0; // @[RegisterRouter.scala 82:24]
  wire  out_f_roready_74 = out_roready_74 & out_romask_64; // @[RegisterRouter.scala 82:24]
  wire [1:0] _T = {out_f_roready_64,out_f_roready_74}; // @[Plic.scala 244:21]
  wire [1:0] _T_3 = _T - 2'h1; // @[Plic.scala 244:46]
  wire [1:0] _T_4 = _T & _T_3; // @[Plic.scala 244:28]
  wire  _T_7 = ~reset; // @[Plic.scala 244:11]
  wire [5:0] _claiming_T = out_f_roready_74 ? maxDevs_0 : 6'h0; // @[Plic.scala 245:49]
  wire [5:0] _claiming_T_1 = out_f_roready_64 ? maxDevs_1 : 6'h0; // @[Plic.scala 245:49]
  wire [5:0] claiming = _claiming_T | _claiming_T_1; // @[Plic.scala 245:96]
  wire [63:0] _claimedDevs_T = 64'h1 << claiming; // @[OneHot.scala 64:12]
  wire  claimedDevs_1 = _claimedDevs_T[1]; // @[Plic.scala 246:58]
  wire  claimedDevs_2 = _claimedDevs_T[2]; // @[Plic.scala 246:58]
  wire  claimedDevs_3 = _claimedDevs_T[3]; // @[Plic.scala 246:58]
  wire  claimedDevs_4 = _claimedDevs_T[4]; // @[Plic.scala 246:58]
  wire  claimedDevs_5 = _claimedDevs_T[5]; // @[Plic.scala 246:58]
  wire  claimedDevs_6 = _claimedDevs_T[6]; // @[Plic.scala 246:58]
  wire  claimedDevs_7 = _claimedDevs_T[7]; // @[Plic.scala 246:58]
  wire  claimedDevs_8 = _claimedDevs_T[8]; // @[Plic.scala 246:58]
  wire  claimedDevs_9 = _claimedDevs_T[9]; // @[Plic.scala 246:58]
  wire  claimedDevs_10 = _claimedDevs_T[10]; // @[Plic.scala 246:58]
  wire  claimedDevs_11 = _claimedDevs_T[11]; // @[Plic.scala 246:58]
  wire  claimedDevs_12 = _claimedDevs_T[12]; // @[Plic.scala 246:58]
  wire  claimedDevs_13 = _claimedDevs_T[13]; // @[Plic.scala 246:58]
  wire  claimedDevs_14 = _claimedDevs_T[14]; // @[Plic.scala 246:58]
  wire  claimedDevs_15 = _claimedDevs_T[15]; // @[Plic.scala 246:58]
  wire  claimedDevs_16 = _claimedDevs_T[16]; // @[Plic.scala 246:58]
  wire  claimedDevs_17 = _claimedDevs_T[17]; // @[Plic.scala 246:58]
  wire  claimedDevs_18 = _claimedDevs_T[18]; // @[Plic.scala 246:58]
  wire  claimedDevs_19 = _claimedDevs_T[19]; // @[Plic.scala 246:58]
  wire  claimedDevs_20 = _claimedDevs_T[20]; // @[Plic.scala 246:58]
  wire  claimedDevs_21 = _claimedDevs_T[21]; // @[Plic.scala 246:58]
  wire  claimedDevs_22 = _claimedDevs_T[22]; // @[Plic.scala 246:58]
  wire  claimedDevs_23 = _claimedDevs_T[23]; // @[Plic.scala 246:58]
  wire  claimedDevs_24 = _claimedDevs_T[24]; // @[Plic.scala 246:58]
  wire  claimedDevs_25 = _claimedDevs_T[25]; // @[Plic.scala 246:58]
  wire  claimedDevs_26 = _claimedDevs_T[26]; // @[Plic.scala 246:58]
  wire  claimedDevs_27 = _claimedDevs_T[27]; // @[Plic.scala 246:58]
  wire  claimedDevs_28 = _claimedDevs_T[28]; // @[Plic.scala 246:58]
  wire  claimedDevs_29 = _claimedDevs_T[29]; // @[Plic.scala 246:58]
  wire  claimedDevs_30 = _claimedDevs_T[30]; // @[Plic.scala 246:58]
  wire  claimedDevs_31 = _claimedDevs_T[31]; // @[Plic.scala 246:58]
  wire  claimedDevs_32 = _claimedDevs_T[32]; // @[Plic.scala 246:58]
  wire  out_woready_64 = out_back_io_deq_valid & auto_in_d_ready & ~out_back_io_deq_bits_read & out_backSel_160 &
    out_bindex == 23'h0; // @[RegisterRouter.scala 82:24]
  wire  out_womask_64 = &out_backMask[63:32]; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_64 = out_woready_64 & out_womask_64; // @[RegisterRouter.scala 82:24]
  wire [5:0] completerDev = out_back_io_deq_bits_data[37:32]; // @[package.scala 154:13]
  wire [32:0] _out_completer_1_T = enableVec0_1 >> completerDev; // @[Plic.scala 294:51]
  wire  completer_1 = out_f_woready_64 & _out_completer_1_T[0]; // @[Plic.scala 294:35]
  wire  out_woready_74 = out_back_io_deq_valid & auto_in_d_ready & ~out_back_io_deq_bits_read & out_backSel_128 &
    out_bindex == 23'h0; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_74 = out_woready_74 & out_womask_64; // @[RegisterRouter.scala 82:24]
  wire [32:0] _out_completer_0_T = enableVec0_0 >> completerDev; // @[Plic.scala 294:51]
  wire  completer_0 = out_f_woready_74 & _out_completer_0_T[0]; // @[Plic.scala 294:35]
  wire [1:0] _T_41 = {completer_1,completer_0}; // @[Plic.scala 261:23]
  wire [1:0] _T_44 = _T_41 - 2'h1; // @[Plic.scala 261:50]
  wire [1:0] _T_45 = _T_41 & _T_44; // @[Plic.scala 261:30]
  wire [63:0] _completedDevs_T_1 = 64'h1 << completerDev; // @[OneHot.scala 64:12]
  wire [32:0] completedDevs = completer_0 | completer_1 ? _completedDevs_T_1[32:0] : 33'h0; // @[Plic.scala 263:28]
  wire  out_backSel_64 = _out_backSel_T[64]; // @[RegisterRouter.scala 82:24]
  wire  out_woready_0 = out_back_io_deq_valid & auto_in_d_ready & ~out_back_io_deq_bits_read & out_backSel_64 &
    out_bindex == 23'h0; // @[RegisterRouter.scala 82:24]
  wire  out_womask_1 = &out_backMask[7:1]; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_1 = out_woready_0 & out_womask_1; // @[RegisterRouter.scala 82:24]
  wire  out_womask_2 = &out_backMask[15:8]; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_2 = out_woready_0 & out_womask_2; // @[RegisterRouter.scala 82:24]
  wire  out_womask_3 = &out_backMask[23:16]; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_3 = out_woready_0 & out_womask_3; // @[RegisterRouter.scala 82:24]
  wire  out_womask_4 = &out_backMask[31:24]; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_4 = out_woready_0 & out_womask_4; // @[RegisterRouter.scala 82:24]
  wire  out_womask_5 = &out_backMask[32]; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_5 = out_woready_0 & out_womask_5; // @[RegisterRouter.scala 82:24]
  wire [32:0] out_prepend_4 = {enables_0_4,enables_0_3,enables_0_2,enables_0_1,enables_0_0,1'h0}; // @[Cat.scala 31:58]
  wire  out_womask_6 = &out_backMask[34:32]; // @[RegisterRouter.scala 82:24]
  wire  out_backSel_0 = _out_backSel_T[0]; // @[RegisterRouter.scala 82:24]
  wire  out_woready_6 = out_back_io_deq_valid & auto_in_d_ready & ~out_back_io_deq_bits_read & out_backSel_0 &
    out_bindex == 23'h0; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_6 = out_woready_6 & out_womask_6; // @[RegisterRouter.scala 82:24]
  wire [34:0] out_prepend_5 = {priority_0,32'h0}; // @[Cat.scala 31:58]
  wire  out_womask_7 = &out_backMask[2:0]; // @[RegisterRouter.scala 82:24]
  wire  out_backSel_5 = _out_backSel_T[5]; // @[RegisterRouter.scala 82:24]
  wire  out_woready_7 = out_back_io_deq_valid & auto_in_d_ready & ~out_back_io_deq_bits_read & out_backSel_5 &
    out_bindex == 23'h0; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_7 = out_woready_7 & out_womask_7; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_8 = out_woready_7 & out_womask_6; // @[RegisterRouter.scala 82:24]
  wire [31:0] _out_prepend_T_6 = {{29'd0}, priority_9}; // @[RegisterRouter.scala 82:24]
  wire [34:0] out_prepend_6 = {priority_10,_out_prepend_T_6}; // @[Cat.scala 31:58]
  wire  out_backSel_10 = _out_backSel_T[10]; // @[RegisterRouter.scala 82:24]
  wire  out_woready_9 = out_back_io_deq_valid & auto_in_d_ready & ~out_back_io_deq_bits_read & out_backSel_10 &
    out_bindex == 23'h0; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_9 = out_woready_9 & out_womask_7; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_10 = out_woready_9 & out_womask_6; // @[RegisterRouter.scala 82:24]
  wire [31:0] _out_prepend_T_7 = {{29'd0}, priority_19}; // @[RegisterRouter.scala 82:24]
  wire [34:0] out_prepend_7 = {priority_20,_out_prepend_T_7}; // @[Cat.scala 31:58]
  wire  out_backSel_14 = _out_backSel_T[14]; // @[RegisterRouter.scala 82:24]
  wire  out_woready_11 = out_back_io_deq_valid & auto_in_d_ready & ~out_back_io_deq_bits_read & out_backSel_14 &
    out_bindex == 23'h0; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_11 = out_woready_11 & out_womask_7; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_12 = out_woready_11 & out_womask_6; // @[RegisterRouter.scala 82:24]
  wire [31:0] _out_prepend_T_8 = {{29'd0}, priority_27}; // @[RegisterRouter.scala 82:24]
  wire [34:0] out_prepend_8 = {priority_28,_out_prepend_T_8}; // @[Cat.scala 31:58]
  wire  out_backSel_80 = _out_backSel_T[80]; // @[RegisterRouter.scala 82:24]
  wire  out_woready_13 = out_back_io_deq_valid & auto_in_d_ready & ~out_back_io_deq_bits_read & out_backSel_80 &
    out_bindex == 23'h0; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_14 = out_woready_13 & out_womask_1; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_15 = out_woready_13 & out_womask_2; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_16 = out_woready_13 & out_womask_3; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_17 = out_woready_13 & out_womask_4; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_18 = out_woready_13 & out_womask_5; // @[RegisterRouter.scala 82:24]
  wire [32:0] out_prepend_13 = {enables_1_4,enables_1_3,enables_1_2,enables_1_1,enables_1_0,1'h0}; // @[Cat.scala 31:58]
  wire  out_backSel_1 = _out_backSel_T[1]; // @[RegisterRouter.scala 82:24]
  wire  out_woready_19 = out_back_io_deq_valid & auto_in_d_ready & ~out_back_io_deq_bits_read & out_backSel_1 &
    out_bindex == 23'h0; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_19 = out_woready_19 & out_womask_7; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_20 = out_woready_19 & out_womask_6; // @[RegisterRouter.scala 82:24]
  wire [31:0] _out_prepend_T_14 = {{29'd0}, priority_1}; // @[RegisterRouter.scala 82:24]
  wire [34:0] out_prepend_14 = {priority_2,_out_prepend_T_14}; // @[Cat.scala 31:58]
  wire  out_backSel_6 = _out_backSel_T[6]; // @[RegisterRouter.scala 82:24]
  wire  out_woready_21 = out_back_io_deq_valid & auto_in_d_ready & ~out_back_io_deq_bits_read & out_backSel_6 &
    out_bindex == 23'h0; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_21 = out_woready_21 & out_womask_7; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_22 = out_woready_21 & out_womask_6; // @[RegisterRouter.scala 82:24]
  wire [31:0] _out_prepend_T_15 = {{29'd0}, priority_11}; // @[RegisterRouter.scala 82:24]
  wire [34:0] out_prepend_15 = {priority_12,_out_prepend_T_15}; // @[Cat.scala 31:58]
  wire [9:0] out_prepend_24 = {pending_8,pending_7,pending_6,pending_5,pending_4,pending_3,pending_2,pending_1,pending_0
    ,1'h0}; // @[Cat.scala 31:58]
  wire [18:0] out_prepend_33 = {pending_17,pending_16,pending_15,pending_14,pending_13,pending_12,pending_11,pending_10,
    pending_9,out_prepend_24}; // @[Cat.scala 31:58]
  wire [27:0] out_prepend_42 = {pending_26,pending_25,pending_24,pending_23,pending_22,pending_21,pending_20,pending_19,
    pending_18,out_prepend_33}; // @[Cat.scala 31:58]
  wire [32:0] out_prepend_47 = {pending_31,pending_30,pending_29,pending_28,pending_27,out_prepend_42}; // @[Cat.scala 31:58]
  wire  out_backSel_9 = _out_backSel_T[9]; // @[RegisterRouter.scala 82:24]
  wire  out_woready_56 = out_back_io_deq_valid & auto_in_d_ready & ~out_back_io_deq_bits_read & out_backSel_9 &
    out_bindex == 23'h0; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_56 = out_woready_56 & out_womask_7; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_57 = out_woready_56 & out_womask_6; // @[RegisterRouter.scala 82:24]
  wire [31:0] _out_prepend_T_48 = {{29'd0}, priority_17}; // @[RegisterRouter.scala 82:24]
  wire [34:0] out_prepend_48 = {priority_18,_out_prepend_T_48}; // @[Cat.scala 31:58]
  wire  out_backSel_13 = _out_backSel_T[13]; // @[RegisterRouter.scala 82:24]
  wire  out_woready_58 = out_back_io_deq_valid & auto_in_d_ready & ~out_back_io_deq_bits_read & out_backSel_13 &
    out_bindex == 23'h0; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_58 = out_woready_58 & out_womask_7; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_59 = out_woready_58 & out_womask_6; // @[RegisterRouter.scala 82:24]
  wire [31:0] _out_prepend_T_49 = {{29'd0}, priority_25}; // @[RegisterRouter.scala 82:24]
  wire [34:0] out_prepend_49 = {priority_26,_out_prepend_T_49}; // @[Cat.scala 31:58]
  wire  out_backSel_2 = _out_backSel_T[2]; // @[RegisterRouter.scala 82:24]
  wire  out_woready_60 = out_back_io_deq_valid & auto_in_d_ready & ~out_back_io_deq_bits_read & out_backSel_2 &
    out_bindex == 23'h0; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_60 = out_woready_60 & out_womask_7; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_61 = out_woready_60 & out_womask_6; // @[RegisterRouter.scala 82:24]
  wire [31:0] _out_prepend_T_50 = {{29'd0}, priority_3}; // @[RegisterRouter.scala 82:24]
  wire [34:0] out_prepend_50 = {priority_4,_out_prepend_T_50}; // @[Cat.scala 31:58]
  wire  out_f_woready_62 = out_woready_64 & out_womask_7; // @[RegisterRouter.scala 82:24]
  wire [3:0] out_prepend_51 = {1'h0,threshold_1}; // @[Cat.scala 31:58]
  wire [31:0] _out_T_674 = {{28'd0}, out_prepend_51}; // @[RegisterRouter.scala 82:24]
  wire [37:0] out_prepend_52 = {maxDevs_1,_out_T_674}; // @[Cat.scala 31:58]
  wire [63:0] _out_T_690 = {{26'd0}, out_prepend_52}; // @[RegisterRouter.scala 82:24]
  wire  out_backSel_12 = _out_backSel_T[12]; // @[RegisterRouter.scala 82:24]
  wire  out_woready_65 = out_back_io_deq_valid & auto_in_d_ready & ~out_back_io_deq_bits_read & out_backSel_12 &
    out_bindex == 23'h0; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_65 = out_woready_65 & out_womask_7; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_66 = out_woready_65 & out_womask_6; // @[RegisterRouter.scala 82:24]
  wire [31:0] _out_prepend_T_53 = {{29'd0}, priority_23}; // @[RegisterRouter.scala 82:24]
  wire [34:0] out_prepend_53 = {priority_24,_out_prepend_T_53}; // @[Cat.scala 31:58]
  wire  out_backSel_7 = _out_backSel_T[7]; // @[RegisterRouter.scala 82:24]
  wire  out_woready_67 = out_back_io_deq_valid & auto_in_d_ready & ~out_back_io_deq_bits_read & out_backSel_7 &
    out_bindex == 23'h0; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_67 = out_woready_67 & out_womask_7; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_68 = out_woready_67 & out_womask_6; // @[RegisterRouter.scala 82:24]
  wire [31:0] _out_prepend_T_54 = {{29'd0}, priority_13}; // @[RegisterRouter.scala 82:24]
  wire [34:0] out_prepend_54 = {priority_14,_out_prepend_T_54}; // @[Cat.scala 31:58]
  wire  out_backSel_3 = _out_backSel_T[3]; // @[RegisterRouter.scala 82:24]
  wire  out_woready_69 = out_back_io_deq_valid & auto_in_d_ready & ~out_back_io_deq_bits_read & out_backSel_3 &
    out_bindex == 23'h0; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_69 = out_woready_69 & out_womask_7; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_70 = out_woready_69 & out_womask_6; // @[RegisterRouter.scala 82:24]
  wire [31:0] _out_prepend_T_55 = {{29'd0}, priority_5}; // @[RegisterRouter.scala 82:24]
  wire [34:0] out_prepend_55 = {priority_6,_out_prepend_T_55}; // @[Cat.scala 31:58]
  wire  out_backSel_16 = _out_backSel_T[16]; // @[RegisterRouter.scala 82:24]
  wire  out_woready_71 = out_back_io_deq_valid & auto_in_d_ready & ~out_back_io_deq_bits_read & out_backSel_16 &
    out_bindex == 23'h0; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_71 = out_woready_71 & out_womask_7; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_72 = out_woready_74 & out_womask_7; // @[RegisterRouter.scala 82:24]
  wire [3:0] out_prepend_56 = {1'h0,threshold_0}; // @[Cat.scala 31:58]
  wire [31:0] _out_T_787 = {{28'd0}, out_prepend_56}; // @[RegisterRouter.scala 82:24]
  wire [37:0] out_prepend_57 = {maxDevs_0,_out_T_787}; // @[Cat.scala 31:58]
  wire [63:0] _out_T_803 = {{26'd0}, out_prepend_57}; // @[RegisterRouter.scala 82:24]
  wire  out_backSel_11 = _out_backSel_T[11]; // @[RegisterRouter.scala 82:24]
  wire  out_woready_75 = out_back_io_deq_valid & auto_in_d_ready & ~out_back_io_deq_bits_read & out_backSel_11 &
    out_bindex == 23'h0; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_75 = out_woready_75 & out_womask_7; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_76 = out_woready_75 & out_womask_6; // @[RegisterRouter.scala 82:24]
  wire [31:0] _out_prepend_T_58 = {{29'd0}, priority_21}; // @[RegisterRouter.scala 82:24]
  wire [34:0] out_prepend_58 = {priority_22,_out_prepend_T_58}; // @[Cat.scala 31:58]
  wire  out_backSel_8 = _out_backSel_T[8]; // @[RegisterRouter.scala 82:24]
  wire  out_woready_77 = out_back_io_deq_valid & auto_in_d_ready & ~out_back_io_deq_bits_read & out_backSel_8 &
    out_bindex == 23'h0; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_77 = out_woready_77 & out_womask_7; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_78 = out_woready_77 & out_womask_6; // @[RegisterRouter.scala 82:24]
  wire [31:0] _out_prepend_T_59 = {{29'd0}, priority_15}; // @[RegisterRouter.scala 82:24]
  wire [34:0] out_prepend_59 = {priority_16,_out_prepend_T_59}; // @[Cat.scala 31:58]
  wire  out_backSel_4 = _out_backSel_T[4]; // @[RegisterRouter.scala 82:24]
  wire  out_woready_79 = out_back_io_deq_valid & auto_in_d_ready & ~out_back_io_deq_bits_read & out_backSel_4 &
    out_bindex == 23'h0; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_79 = out_woready_79 & out_womask_7; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_80 = out_woready_79 & out_womask_6; // @[RegisterRouter.scala 82:24]
  wire [31:0] _out_prepend_T_60 = {{29'd0}, priority_7}; // @[RegisterRouter.scala 82:24]
  wire [34:0] out_prepend_60 = {priority_8,_out_prepend_T_60}; // @[Cat.scala 31:58]
  wire  out_backSel_15 = _out_backSel_T[15]; // @[RegisterRouter.scala 82:24]
  wire  out_woready_81 = out_back_io_deq_valid & auto_in_d_ready & ~out_back_io_deq_bits_read & out_backSel_15 &
    out_bindex == 23'h0; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_81 = out_woready_81 & out_womask_7; // @[RegisterRouter.scala 82:24]
  wire  out_f_woready_82 = out_woready_81 & out_womask_6; // @[RegisterRouter.scala 82:24]
  wire [31:0] _out_prepend_T_61 = {{29'd0}, priority_29}; // @[RegisterRouter.scala 82:24]
  wire [34:0] out_prepend_61 = {priority_30,_out_prepend_T_61}; // @[Cat.scala 31:58]
  wire  _GEN_1100 = 8'ha0 == out_oindex ? _out_T_25 : 1'h1; // @[MuxLiteral.scala 53:{26,32}]
  wire  _GEN_1101 = 8'h80 == out_oindex ? _out_T_25 : _GEN_1100; // @[MuxLiteral.scala 53:{26,32}]
  wire  _GEN_1102 = 8'h50 == out_oindex ? _out_T_25 : _GEN_1101; // @[MuxLiteral.scala 53:{26,32}]
  wire  _GEN_1103 = 8'h40 == out_oindex ? _out_T_25 : _GEN_1102; // @[MuxLiteral.scala 53:{26,32}]
  wire  _GEN_1104 = 8'h20 == out_oindex ? _out_T_25 : _GEN_1103; // @[MuxLiteral.scala 53:{26,32}]
  wire  _GEN_1105 = 8'h10 == out_oindex ? _out_T_25 : _GEN_1104; // @[MuxLiteral.scala 53:{26,32}]
  wire  _GEN_1106 = 8'hf == out_oindex ? _out_T_25 : _GEN_1105; // @[MuxLiteral.scala 53:{26,32}]
  wire  _GEN_1107 = 8'he == out_oindex ? _out_T_25 : _GEN_1106; // @[MuxLiteral.scala 53:{26,32}]
  wire  _GEN_1108 = 8'hd == out_oindex ? _out_T_25 : _GEN_1107; // @[MuxLiteral.scala 53:{26,32}]
  wire  _GEN_1109 = 8'hc == out_oindex ? _out_T_25 : _GEN_1108; // @[MuxLiteral.scala 53:{26,32}]
  wire  _GEN_1110 = 8'hb == out_oindex ? _out_T_25 : _GEN_1109; // @[MuxLiteral.scala 53:{26,32}]
  wire  _GEN_1111 = 8'ha == out_oindex ? _out_T_25 : _GEN_1110; // @[MuxLiteral.scala 53:{26,32}]
  wire  _GEN_1112 = 8'h9 == out_oindex ? _out_T_25 : _GEN_1111; // @[MuxLiteral.scala 53:{26,32}]
  wire  _GEN_1113 = 8'h8 == out_oindex ? _out_T_25 : _GEN_1112; // @[MuxLiteral.scala 53:{26,32}]
  wire  _GEN_1114 = 8'h7 == out_oindex ? _out_T_25 : _GEN_1113; // @[MuxLiteral.scala 53:{26,32}]
  wire  _GEN_1115 = 8'h6 == out_oindex ? _out_T_25 : _GEN_1114; // @[MuxLiteral.scala 53:{26,32}]
  wire  _GEN_1116 = 8'h5 == out_oindex ? _out_T_25 : _GEN_1115; // @[MuxLiteral.scala 53:{26,32}]
  wire  _GEN_1117 = 8'h4 == out_oindex ? _out_T_25 : _GEN_1116; // @[MuxLiteral.scala 53:{26,32}]
  wire  _GEN_1118 = 8'h3 == out_oindex ? _out_T_25 : _GEN_1117; // @[MuxLiteral.scala 53:{26,32}]
  wire  _GEN_1119 = 8'h2 == out_oindex ? _out_T_25 : _GEN_1118; // @[MuxLiteral.scala 53:{26,32}]
  wire  _GEN_1120 = 8'h1 == out_oindex ? _out_T_25 : _GEN_1119; // @[MuxLiteral.scala 53:{26,32}]
  wire  out_out_bits_data_out = 8'h0 == out_oindex ? _out_T_25 : _GEN_1120; // @[MuxLiteral.scala 53:{26,32}]
  wire [63:0] _GEN_1122 = 8'ha0 == out_oindex ? _out_T_690 : 64'h0; // @[MuxLiteral.scala 53:{26,32}]
  wire [63:0] _GEN_1123 = 8'h80 == out_oindex ? _out_T_803 : _GEN_1122; // @[MuxLiteral.scala 53:{26,32}]
  wire [63:0] _GEN_1124 = 8'h50 == out_oindex ? {{31'd0}, out_prepend_13} : _GEN_1123; // @[MuxLiteral.scala 53:{26,32}]
  wire [63:0] _GEN_1125 = 8'h40 == out_oindex ? {{31'd0}, out_prepend_4} : _GEN_1124; // @[MuxLiteral.scala 53:{26,32}]
  wire [63:0] _GEN_1126 = 8'h20 == out_oindex ? {{31'd0}, out_prepend_47} : _GEN_1125; // @[MuxLiteral.scala 53:{26,32}]
  wire [63:0] _GEN_1127 = 8'h10 == out_oindex ? {{61'd0}, priority_31} : _GEN_1126; // @[MuxLiteral.scala 53:{26,32}]
  wire [63:0] _GEN_1128 = 8'hf == out_oindex ? {{29'd0}, out_prepend_61} : _GEN_1127; // @[MuxLiteral.scala 53:{26,32}]
  wire [63:0] _GEN_1129 = 8'he == out_oindex ? {{29'd0}, out_prepend_8} : _GEN_1128; // @[MuxLiteral.scala 53:{26,32}]
  wire [63:0] _GEN_1130 = 8'hd == out_oindex ? {{29'd0}, out_prepend_49} : _GEN_1129; // @[MuxLiteral.scala 53:{26,32}]
  wire [63:0] _GEN_1131 = 8'hc == out_oindex ? {{29'd0}, out_prepend_53} : _GEN_1130; // @[MuxLiteral.scala 53:{26,32}]
  wire [63:0] _GEN_1132 = 8'hb == out_oindex ? {{29'd0}, out_prepend_58} : _GEN_1131; // @[MuxLiteral.scala 53:{26,32}]
  wire [63:0] _GEN_1133 = 8'ha == out_oindex ? {{29'd0}, out_prepend_7} : _GEN_1132; // @[MuxLiteral.scala 53:{26,32}]
  wire [63:0] _GEN_1134 = 8'h9 == out_oindex ? {{29'd0}, out_prepend_48} : _GEN_1133; // @[MuxLiteral.scala 53:{26,32}]
  wire [63:0] _GEN_1135 = 8'h8 == out_oindex ? {{29'd0}, out_prepend_59} : _GEN_1134; // @[MuxLiteral.scala 53:{26,32}]
  wire [63:0] _GEN_1136 = 8'h7 == out_oindex ? {{29'd0}, out_prepend_54} : _GEN_1135; // @[MuxLiteral.scala 53:{26,32}]
  wire [63:0] _GEN_1137 = 8'h6 == out_oindex ? {{29'd0}, out_prepend_15} : _GEN_1136; // @[MuxLiteral.scala 53:{26,32}]
  wire [63:0] _GEN_1138 = 8'h5 == out_oindex ? {{29'd0}, out_prepend_6} : _GEN_1137; // @[MuxLiteral.scala 53:{26,32}]
  wire [63:0] _GEN_1139 = 8'h4 == out_oindex ? {{29'd0}, out_prepend_60} : _GEN_1138; // @[MuxLiteral.scala 53:{26,32}]
  wire [63:0] _GEN_1140 = 8'h3 == out_oindex ? {{29'd0}, out_prepend_55} : _GEN_1139; // @[MuxLiteral.scala 53:{26,32}]
  wire [63:0] _GEN_1141 = 8'h2 == out_oindex ? {{29'd0}, out_prepend_50} : _GEN_1140; // @[MuxLiteral.scala 53:{26,32}]
  wire [63:0] _GEN_1142 = 8'h1 == out_oindex ? {{29'd0}, out_prepend_14} : _GEN_1141; // @[MuxLiteral.scala 53:{26,32}]
  wire [63:0] out_out_bits_data_out_1 = 8'h0 == out_oindex ? {{29'd0}, out_prepend_5} : _GEN_1142; // @[MuxLiteral.scala 53:{26,32}]
  wire  out_bits_read = out_back_io_deq_bits_read; // @[RegisterRouter.scala 82:{24,24}]
//  TLMonitor_26 monitor ( // @[Nodes.scala 24:25]
//    .clock(monitor_clock),
//    .reset(monitor_reset),
//    .io_in_a_ready(monitor_io_in_a_ready),
//    .io_in_a_valid(monitor_io_in_a_valid),
//    .io_in_a_bits_opcode(monitor_io_in_a_bits_opcode),
//    .io_in_a_bits_param(monitor_io_in_a_bits_param),
//    .io_in_a_bits_size(monitor_io_in_a_bits_size),
//    .io_in_a_bits_source(monitor_io_in_a_bits_source),
//    .io_in_a_bits_address(monitor_io_in_a_bits_address),
//    .io_in_a_bits_mask(monitor_io_in_a_bits_mask),
//    .io_in_a_bits_corrupt(monitor_io_in_a_bits_corrupt),
//    .io_in_d_ready(monitor_io_in_d_ready),
//    .io_in_d_valid(monitor_io_in_d_valid),
//    .io_in_d_bits_opcode(monitor_io_in_d_bits_opcode),
//    .io_in_d_bits_size(monitor_io_in_d_bits_size),
//    .io_in_d_bits_source(monitor_io_in_d_bits_source)
//  );
  LevelGateway gateways_gateway ( // @[Plic.scala 155:27]
    .clock(gateways_gateway_clock),
    .reset(gateways_gateway_reset),
    .io_interrupt(gateways_gateway_io_interrupt),
    .io_plic_valid(gateways_gateway_io_plic_valid),
    .io_plic_ready(gateways_gateway_io_plic_ready),
    .io_plic_complete(gateways_gateway_io_plic_complete)
  );
  LevelGateway gateways_gateway_1 ( // @[Plic.scala 155:27]
    .clock(gateways_gateway_1_clock),
    .reset(gateways_gateway_1_reset),
    .io_interrupt(gateways_gateway_1_io_interrupt),
    .io_plic_valid(gateways_gateway_1_io_plic_valid),
    .io_plic_ready(gateways_gateway_1_io_plic_ready),
    .io_plic_complete(gateways_gateway_1_io_plic_complete)
  );
  LevelGateway gateways_gateway_2 ( // @[Plic.scala 155:27]
    .clock(gateways_gateway_2_clock),
    .reset(gateways_gateway_2_reset),
    .io_interrupt(gateways_gateway_2_io_interrupt),
    .io_plic_valid(gateways_gateway_2_io_plic_valid),
    .io_plic_ready(gateways_gateway_2_io_plic_ready),
    .io_plic_complete(gateways_gateway_2_io_plic_complete)
  );
  LevelGateway gateways_gateway_3 ( // @[Plic.scala 155:27]
    .clock(gateways_gateway_3_clock),
    .reset(gateways_gateway_3_reset),
    .io_interrupt(gateways_gateway_3_io_interrupt),
    .io_plic_valid(gateways_gateway_3_io_plic_valid),
    .io_plic_ready(gateways_gateway_3_io_plic_ready),
    .io_plic_complete(gateways_gateway_3_io_plic_complete)
  );
  LevelGateway gateways_gateway_4 ( // @[Plic.scala 155:27]
    .clock(gateways_gateway_4_clock),
    .reset(gateways_gateway_4_reset),
    .io_interrupt(gateways_gateway_4_io_interrupt),
    .io_plic_valid(gateways_gateway_4_io_plic_valid),
    .io_plic_ready(gateways_gateway_4_io_plic_ready),
    .io_plic_complete(gateways_gateway_4_io_plic_complete)
  );
  LevelGateway gateways_gateway_5 ( // @[Plic.scala 155:27]
    .clock(gateways_gateway_5_clock),
    .reset(gateways_gateway_5_reset),
    .io_interrupt(gateways_gateway_5_io_interrupt),
    .io_plic_valid(gateways_gateway_5_io_plic_valid),
    .io_plic_ready(gateways_gateway_5_io_plic_ready),
    .io_plic_complete(gateways_gateway_5_io_plic_complete)
  );
  LevelGateway gateways_gateway_6 ( // @[Plic.scala 155:27]
    .clock(gateways_gateway_6_clock),
    .reset(gateways_gateway_6_reset),
    .io_interrupt(gateways_gateway_6_io_interrupt),
    .io_plic_valid(gateways_gateway_6_io_plic_valid),
    .io_plic_ready(gateways_gateway_6_io_plic_ready),
    .io_plic_complete(gateways_gateway_6_io_plic_complete)
  );
  LevelGateway gateways_gateway_7 ( // @[Plic.scala 155:27]
    .clock(gateways_gateway_7_clock),
    .reset(gateways_gateway_7_reset),
    .io_interrupt(gateways_gateway_7_io_interrupt),
    .io_plic_valid(gateways_gateway_7_io_plic_valid),
    .io_plic_ready(gateways_gateway_7_io_plic_ready),
    .io_plic_complete(gateways_gateway_7_io_plic_complete)
  );
  LevelGateway gateways_gateway_8 ( // @[Plic.scala 155:27]
    .clock(gateways_gateway_8_clock),
    .reset(gateways_gateway_8_reset),
    .io_interrupt(gateways_gateway_8_io_interrupt),
    .io_plic_valid(gateways_gateway_8_io_plic_valid),
    .io_plic_ready(gateways_gateway_8_io_plic_ready),
    .io_plic_complete(gateways_gateway_8_io_plic_complete)
  );
  LevelGateway gateways_gateway_9 ( // @[Plic.scala 155:27]
    .clock(gateways_gateway_9_clock),
    .reset(gateways_gateway_9_reset),
    .io_interrupt(gateways_gateway_9_io_interrupt),
    .io_plic_valid(gateways_gateway_9_io_plic_valid),
    .io_plic_ready(gateways_gateway_9_io_plic_ready),
    .io_plic_complete(gateways_gateway_9_io_plic_complete)
  );
  LevelGateway gateways_gateway_10 ( // @[Plic.scala 155:27]
    .clock(gateways_gateway_10_clock),
    .reset(gateways_gateway_10_reset),
    .io_interrupt(gateways_gateway_10_io_interrupt),
    .io_plic_valid(gateways_gateway_10_io_plic_valid),
    .io_plic_ready(gateways_gateway_10_io_plic_ready),
    .io_plic_complete(gateways_gateway_10_io_plic_complete)
  );
  LevelGateway gateways_gateway_11 ( // @[Plic.scala 155:27]
    .clock(gateways_gateway_11_clock),
    .reset(gateways_gateway_11_reset),
    .io_interrupt(gateways_gateway_11_io_interrupt),
    .io_plic_valid(gateways_gateway_11_io_plic_valid),
    .io_plic_ready(gateways_gateway_11_io_plic_ready),
    .io_plic_complete(gateways_gateway_11_io_plic_complete)
  );
  LevelGateway gateways_gateway_12 ( // @[Plic.scala 155:27]
    .clock(gateways_gateway_12_clock),
    .reset(gateways_gateway_12_reset),
    .io_interrupt(gateways_gateway_12_io_interrupt),
    .io_plic_valid(gateways_gateway_12_io_plic_valid),
    .io_plic_ready(gateways_gateway_12_io_plic_ready),
    .io_plic_complete(gateways_gateway_12_io_plic_complete)
  );
  LevelGateway gateways_gateway_13 ( // @[Plic.scala 155:27]
    .clock(gateways_gateway_13_clock),
    .reset(gateways_gateway_13_reset),
    .io_interrupt(gateways_gateway_13_io_interrupt),
    .io_plic_valid(gateways_gateway_13_io_plic_valid),
    .io_plic_ready(gateways_gateway_13_io_plic_ready),
    .io_plic_complete(gateways_gateway_13_io_plic_complete)
  );
  LevelGateway gateways_gateway_14 ( // @[Plic.scala 155:27]
    .clock(gateways_gateway_14_clock),
    .reset(gateways_gateway_14_reset),
    .io_interrupt(gateways_gateway_14_io_interrupt),
    .io_plic_valid(gateways_gateway_14_io_plic_valid),
    .io_plic_ready(gateways_gateway_14_io_plic_ready),
    .io_plic_complete(gateways_gateway_14_io_plic_complete)
  );
  LevelGateway gateways_gateway_15 ( // @[Plic.scala 155:27]
    .clock(gateways_gateway_15_clock),
    .reset(gateways_gateway_15_reset),
    .io_interrupt(gateways_gateway_15_io_interrupt),
    .io_plic_valid(gateways_gateway_15_io_plic_valid),
    .io_plic_ready(gateways_gateway_15_io_plic_ready),
    .io_plic_complete(gateways_gateway_15_io_plic_complete)
  );
  LevelGateway gateways_gateway_16 ( // @[Plic.scala 155:27]
    .clock(gateways_gateway_16_clock),
    .reset(gateways_gateway_16_reset),
    .io_interrupt(gateways_gateway_16_io_interrupt),
    .io_plic_valid(gateways_gateway_16_io_plic_valid),
    .io_plic_ready(gateways_gateway_16_io_plic_ready),
    .io_plic_complete(gateways_gateway_16_io_plic_complete)
  );
  LevelGateway gateways_gateway_17 ( // @[Plic.scala 155:27]
    .clock(gateways_gateway_17_clock),
    .reset(gateways_gateway_17_reset),
    .io_interrupt(gateways_gateway_17_io_interrupt),
    .io_plic_valid(gateways_gateway_17_io_plic_valid),
    .io_plic_ready(gateways_gateway_17_io_plic_ready),
    .io_plic_complete(gateways_gateway_17_io_plic_complete)
  );
  LevelGateway gateways_gateway_18 ( // @[Plic.scala 155:27]
    .clock(gateways_gateway_18_clock),
    .reset(gateways_gateway_18_reset),
    .io_interrupt(gateways_gateway_18_io_interrupt),
    .io_plic_valid(gateways_gateway_18_io_plic_valid),
    .io_plic_ready(gateways_gateway_18_io_plic_ready),
    .io_plic_complete(gateways_gateway_18_io_plic_complete)
  );
  LevelGateway gateways_gateway_19 ( // @[Plic.scala 155:27]
    .clock(gateways_gateway_19_clock),
    .reset(gateways_gateway_19_reset),
    .io_interrupt(gateways_gateway_19_io_interrupt),
    .io_plic_valid(gateways_gateway_19_io_plic_valid),
    .io_plic_ready(gateways_gateway_19_io_plic_ready),
    .io_plic_complete(gateways_gateway_19_io_plic_complete)
  );
  LevelGateway gateways_gateway_20 ( // @[Plic.scala 155:27]
    .clock(gateways_gateway_20_clock),
    .reset(gateways_gateway_20_reset),
    .io_interrupt(gateways_gateway_20_io_interrupt),
    .io_plic_valid(gateways_gateway_20_io_plic_valid),
    .io_plic_ready(gateways_gateway_20_io_plic_ready),
    .io_plic_complete(gateways_gateway_20_io_plic_complete)
  );
  LevelGateway gateways_gateway_21 ( // @[Plic.scala 155:27]
    .clock(gateways_gateway_21_clock),
    .reset(gateways_gateway_21_reset),
    .io_interrupt(gateways_gateway_21_io_interrupt),
    .io_plic_valid(gateways_gateway_21_io_plic_valid),
    .io_plic_ready(gateways_gateway_21_io_plic_ready),
    .io_plic_complete(gateways_gateway_21_io_plic_complete)
  );
  LevelGateway gateways_gateway_22 ( // @[Plic.scala 155:27]
    .clock(gateways_gateway_22_clock),
    .reset(gateways_gateway_22_reset),
    .io_interrupt(gateways_gateway_22_io_interrupt),
    .io_plic_valid(gateways_gateway_22_io_plic_valid),
    .io_plic_ready(gateways_gateway_22_io_plic_ready),
    .io_plic_complete(gateways_gateway_22_io_plic_complete)
  );
  LevelGateway gateways_gateway_23 ( // @[Plic.scala 155:27]
    .clock(gateways_gateway_23_clock),
    .reset(gateways_gateway_23_reset),
    .io_interrupt(gateways_gateway_23_io_interrupt),
    .io_plic_valid(gateways_gateway_23_io_plic_valid),
    .io_plic_ready(gateways_gateway_23_io_plic_ready),
    .io_plic_complete(gateways_gateway_23_io_plic_complete)
  );
  LevelGateway gateways_gateway_24 ( // @[Plic.scala 155:27]
    .clock(gateways_gateway_24_clock),
    .reset(gateways_gateway_24_reset),
    .io_interrupt(gateways_gateway_24_io_interrupt),
    .io_plic_valid(gateways_gateway_24_io_plic_valid),
    .io_plic_ready(gateways_gateway_24_io_plic_ready),
    .io_plic_complete(gateways_gateway_24_io_plic_complete)
  );
  LevelGateway gateways_gateway_25 ( // @[Plic.scala 155:27]
    .clock(gateways_gateway_25_clock),
    .reset(gateways_gateway_25_reset),
    .io_interrupt(gateways_gateway_25_io_interrupt),
    .io_plic_valid(gateways_gateway_25_io_plic_valid),
    .io_plic_ready(gateways_gateway_25_io_plic_ready),
    .io_plic_complete(gateways_gateway_25_io_plic_complete)
  );
  LevelGateway gateways_gateway_26 ( // @[Plic.scala 155:27]
    .clock(gateways_gateway_26_clock),
    .reset(gateways_gateway_26_reset),
    .io_interrupt(gateways_gateway_26_io_interrupt),
    .io_plic_valid(gateways_gateway_26_io_plic_valid),
    .io_plic_ready(gateways_gateway_26_io_plic_ready),
    .io_plic_complete(gateways_gateway_26_io_plic_complete)
  );
  LevelGateway gateways_gateway_27 ( // @[Plic.scala 155:27]
    .clock(gateways_gateway_27_clock),
    .reset(gateways_gateway_27_reset),
    .io_interrupt(gateways_gateway_27_io_interrupt),
    .io_plic_valid(gateways_gateway_27_io_plic_valid),
    .io_plic_ready(gateways_gateway_27_io_plic_ready),
    .io_plic_complete(gateways_gateway_27_io_plic_complete)
  );
  LevelGateway gateways_gateway_28 ( // @[Plic.scala 155:27]
    .clock(gateways_gateway_28_clock),
    .reset(gateways_gateway_28_reset),
    .io_interrupt(gateways_gateway_28_io_interrupt),
    .io_plic_valid(gateways_gateway_28_io_plic_valid),
    .io_plic_ready(gateways_gateway_28_io_plic_ready),
    .io_plic_complete(gateways_gateway_28_io_plic_complete)
  );
  LevelGateway gateways_gateway_29 ( // @[Plic.scala 155:27]
    .clock(gateways_gateway_29_clock),
    .reset(gateways_gateway_29_reset),
    .io_interrupt(gateways_gateway_29_io_interrupt),
    .io_plic_valid(gateways_gateway_29_io_plic_valid),
    .io_plic_ready(gateways_gateway_29_io_plic_ready),
    .io_plic_complete(gateways_gateway_29_io_plic_complete)
  );
  LevelGateway gateways_gateway_30 ( // @[Plic.scala 155:27]
    .clock(gateways_gateway_30_clock),
    .reset(gateways_gateway_30_reset),
    .io_interrupt(gateways_gateway_30_io_interrupt),
    .io_plic_valid(gateways_gateway_30_io_plic_valid),
    .io_plic_ready(gateways_gateway_30_io_plic_ready),
    .io_plic_complete(gateways_gateway_30_io_plic_complete)
  );
  LevelGateway gateways_gateway_31 ( // @[Plic.scala 155:27]
    .clock(gateways_gateway_31_clock),
    .reset(gateways_gateway_31_reset),
    .io_interrupt(gateways_gateway_31_io_interrupt),
    .io_plic_valid(gateways_gateway_31_io_plic_valid),
    .io_plic_ready(gateways_gateway_31_io_plic_ready),
    .io_plic_complete(gateways_gateway_31_io_plic_complete)
  );
  PLICFanIn fanin ( // @[Plic.scala 183:25]
    .io_prio_0(fanin_io_prio_0),
    .io_prio_1(fanin_io_prio_1),
    .io_prio_2(fanin_io_prio_2),
    .io_prio_3(fanin_io_prio_3),
    .io_prio_4(fanin_io_prio_4),
    .io_prio_5(fanin_io_prio_5),
    .io_prio_6(fanin_io_prio_6),
    .io_prio_7(fanin_io_prio_7),
    .io_prio_8(fanin_io_prio_8),
    .io_prio_9(fanin_io_prio_9),
    .io_prio_10(fanin_io_prio_10),
    .io_prio_11(fanin_io_prio_11),
    .io_prio_12(fanin_io_prio_12),
    .io_prio_13(fanin_io_prio_13),
    .io_prio_14(fanin_io_prio_14),
    .io_prio_15(fanin_io_prio_15),
    .io_prio_16(fanin_io_prio_16),
    .io_prio_17(fanin_io_prio_17),
    .io_prio_18(fanin_io_prio_18),
    .io_prio_19(fanin_io_prio_19),
    .io_prio_20(fanin_io_prio_20),
    .io_prio_21(fanin_io_prio_21),
    .io_prio_22(fanin_io_prio_22),
    .io_prio_23(fanin_io_prio_23),
    .io_prio_24(fanin_io_prio_24),
    .io_prio_25(fanin_io_prio_25),
    .io_prio_26(fanin_io_prio_26),
    .io_prio_27(fanin_io_prio_27),
    .io_prio_28(fanin_io_prio_28),
    .io_prio_29(fanin_io_prio_29),
    .io_prio_30(fanin_io_prio_30),
    .io_prio_31(fanin_io_prio_31),
    .io_ip(fanin_io_ip),
    .io_dev(fanin_io_dev),
    .io_max(fanin_io_max)
  );
  PLICFanIn fanin_1 ( // @[Plic.scala 183:25]
    .io_prio_0(fanin_1_io_prio_0),
    .io_prio_1(fanin_1_io_prio_1),
    .io_prio_2(fanin_1_io_prio_2),
    .io_prio_3(fanin_1_io_prio_3),
    .io_prio_4(fanin_1_io_prio_4),
    .io_prio_5(fanin_1_io_prio_5),
    .io_prio_6(fanin_1_io_prio_6),
    .io_prio_7(fanin_1_io_prio_7),
    .io_prio_8(fanin_1_io_prio_8),
    .io_prio_9(fanin_1_io_prio_9),
    .io_prio_10(fanin_1_io_prio_10),
    .io_prio_11(fanin_1_io_prio_11),
    .io_prio_12(fanin_1_io_prio_12),
    .io_prio_13(fanin_1_io_prio_13),
    .io_prio_14(fanin_1_io_prio_14),
    .io_prio_15(fanin_1_io_prio_15),
    .io_prio_16(fanin_1_io_prio_16),
    .io_prio_17(fanin_1_io_prio_17),
    .io_prio_18(fanin_1_io_prio_18),
    .io_prio_19(fanin_1_io_prio_19),
    .io_prio_20(fanin_1_io_prio_20),
    .io_prio_21(fanin_1_io_prio_21),
    .io_prio_22(fanin_1_io_prio_22),
    .io_prio_23(fanin_1_io_prio_23),
    .io_prio_24(fanin_1_io_prio_24),
    .io_prio_25(fanin_1_io_prio_25),
    .io_prio_26(fanin_1_io_prio_26),
    .io_prio_27(fanin_1_io_prio_27),
    .io_prio_28(fanin_1_io_prio_28),
    .io_prio_29(fanin_1_io_prio_29),
    .io_prio_30(fanin_1_io_prio_30),
    .io_prio_31(fanin_1_io_prio_31),
    .io_ip(fanin_1_io_ip),
    .io_dev(fanin_1_io_dev),
    .io_max(fanin_1_io_max)
  );
  Queue_37 out_back ( // @[Decoupled.scala 361:21]
    .clock(out_back_clock),
    .reset(out_back_reset),
    .io_enq_ready(out_back_io_enq_ready),
    .io_enq_valid(out_back_io_enq_valid),
    .io_enq_bits_read(out_back_io_enq_bits_read),
    .io_enq_bits_index(out_back_io_enq_bits_index),
    .io_enq_bits_data(out_back_io_enq_bits_data),
    .io_enq_bits_mask(out_back_io_enq_bits_mask),
    .io_enq_bits_extra_tlrr_extra_source(out_back_io_enq_bits_extra_tlrr_extra_source),
    .io_enq_bits_extra_tlrr_extra_size(out_back_io_enq_bits_extra_tlrr_extra_size),
    .io_deq_ready(out_back_io_deq_ready),
    .io_deq_valid(out_back_io_deq_valid),
    .io_deq_bits_read(out_back_io_deq_bits_read),
    .io_deq_bits_index(out_back_io_deq_bits_index),
    .io_deq_bits_data(out_back_io_deq_bits_data),
    .io_deq_bits_mask(out_back_io_deq_bits_mask),
    .io_deq_bits_extra_tlrr_extra_source(out_back_io_deq_bits_extra_tlrr_extra_source),
    .io_deq_bits_extra_tlrr_extra_size(out_back_io_deq_bits_extra_tlrr_extra_size)
  );
  assign auto_int_out_1_0 = bundleOut_1_0_REG > threshold_1; // @[Plic.scala 187:63]
  assign auto_int_out_0_0 = bundleOut_0_0_REG > threshold_0; // @[Plic.scala 187:63]
  assign auto_in_a_ready = out_back_io_enq_ready; // @[Decoupled.scala 365:17 RegisterRouter.scala 82:24]
  assign auto_in_d_valid = out_back_io_deq_valid; // @[RegisterRouter.scala 82:24]
  assign auto_in_d_bits_opcode = {{2'd0}, out_bits_read}; // @[Nodes.scala 1210:84 RegisterRouter.scala 97:19]
  assign auto_in_d_bits_size = out_back_io_deq_bits_extra_tlrr_extra_size; // @[RegisterRouter.scala 82:{24,24}]
  assign auto_in_d_bits_source = out_back_io_deq_bits_extra_tlrr_extra_source; // @[RegisterRouter.scala 82:{24,24}]
  assign auto_in_d_bits_data = out_out_bits_data_out ? out_out_bits_data_out_1 : 64'h0; // @[RegisterRouter.scala 82:24]
  assign monitor_clock = clock;
  assign monitor_reset = reset;
  assign monitor_io_in_a_ready = out_back_io_enq_ready; // @[Decoupled.scala 365:17 RegisterRouter.scala 82:24]
  assign monitor_io_in_a_valid = auto_in_a_valid; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign monitor_io_in_a_bits_opcode = auto_in_a_bits_opcode; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign monitor_io_in_a_bits_param = auto_in_a_bits_param; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign monitor_io_in_a_bits_size = auto_in_a_bits_size; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign monitor_io_in_a_bits_source = auto_in_a_bits_source; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign monitor_io_in_a_bits_address = auto_in_a_bits_address; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign monitor_io_in_a_bits_mask = auto_in_a_bits_mask; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign monitor_io_in_a_bits_corrupt = auto_in_a_bits_corrupt; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign monitor_io_in_d_ready = auto_in_d_ready; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign monitor_io_in_d_valid = out_back_io_deq_valid; // @[RegisterRouter.scala 82:24]
  assign monitor_io_in_d_bits_opcode = {{2'd0}, out_bits_read}; // @[Nodes.scala 1210:84 RegisterRouter.scala 97:19]
  assign monitor_io_in_d_bits_size = out_back_io_deq_bits_extra_tlrr_extra_size; // @[RegisterRouter.scala 82:{24,24}]
  assign monitor_io_in_d_bits_source = out_back_io_deq_bits_extra_tlrr_extra_source; // @[RegisterRouter.scala 82:{24,24}]
  assign gateways_gateway_clock = clock;
  assign gateways_gateway_reset = reset;
  assign gateways_gateway_io_interrupt = auto_int_in_0; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign gateways_gateway_io_plic_ready = ~pending_0; // @[Plic.scala 249:18]
  assign gateways_gateway_io_plic_complete = completedDevs[1]; // @[Plic.scala 264:33]
  assign gateways_gateway_1_clock = clock;
  assign gateways_gateway_1_reset = reset;
  assign gateways_gateway_1_io_interrupt = auto_int_in_1; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign gateways_gateway_1_io_plic_ready = ~pending_1; // @[Plic.scala 249:18]
  assign gateways_gateway_1_io_plic_complete = completedDevs[2]; // @[Plic.scala 264:33]
  assign gateways_gateway_2_clock = clock;
  assign gateways_gateway_2_reset = reset;
  assign gateways_gateway_2_io_interrupt = auto_int_in_2; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign gateways_gateway_2_io_plic_ready = ~pending_2; // @[Plic.scala 249:18]
  assign gateways_gateway_2_io_plic_complete = completedDevs[3]; // @[Plic.scala 264:33]
  assign gateways_gateway_3_clock = clock;
  assign gateways_gateway_3_reset = reset;
  assign gateways_gateway_3_io_interrupt = auto_int_in_3; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign gateways_gateway_3_io_plic_ready = ~pending_3; // @[Plic.scala 249:18]
  assign gateways_gateway_3_io_plic_complete = completedDevs[4]; // @[Plic.scala 264:33]
  assign gateways_gateway_4_clock = clock;
  assign gateways_gateway_4_reset = reset;
  assign gateways_gateway_4_io_interrupt = auto_int_in_4; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign gateways_gateway_4_io_plic_ready = ~pending_4; // @[Plic.scala 249:18]
  assign gateways_gateway_4_io_plic_complete = completedDevs[5]; // @[Plic.scala 264:33]
  assign gateways_gateway_5_clock = clock;
  assign gateways_gateway_5_reset = reset;
  assign gateways_gateway_5_io_interrupt = auto_int_in_5; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign gateways_gateway_5_io_plic_ready = ~pending_5; // @[Plic.scala 249:18]
  assign gateways_gateway_5_io_plic_complete = completedDevs[6]; // @[Plic.scala 264:33]
  assign gateways_gateway_6_clock = clock;
  assign gateways_gateway_6_reset = reset;
  assign gateways_gateway_6_io_interrupt = auto_int_in_6; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign gateways_gateway_6_io_plic_ready = ~pending_6; // @[Plic.scala 249:18]
  assign gateways_gateway_6_io_plic_complete = completedDevs[7]; // @[Plic.scala 264:33]
  assign gateways_gateway_7_clock = clock;
  assign gateways_gateway_7_reset = reset;
  assign gateways_gateway_7_io_interrupt = auto_int_in_7; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign gateways_gateway_7_io_plic_ready = ~pending_7; // @[Plic.scala 249:18]
  assign gateways_gateway_7_io_plic_complete = completedDevs[8]; // @[Plic.scala 264:33]
  assign gateways_gateway_8_clock = clock;
  assign gateways_gateway_8_reset = reset;
  assign gateways_gateway_8_io_interrupt = auto_int_in_8; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign gateways_gateway_8_io_plic_ready = ~pending_8; // @[Plic.scala 249:18]
  assign gateways_gateway_8_io_plic_complete = completedDevs[9]; // @[Plic.scala 264:33]
  assign gateways_gateway_9_clock = clock;
  assign gateways_gateway_9_reset = reset;
  assign gateways_gateway_9_io_interrupt = auto_int_in_9; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign gateways_gateway_9_io_plic_ready = ~pending_9; // @[Plic.scala 249:18]
  assign gateways_gateway_9_io_plic_complete = completedDevs[10]; // @[Plic.scala 264:33]
  assign gateways_gateway_10_clock = clock;
  assign gateways_gateway_10_reset = reset;
  assign gateways_gateway_10_io_interrupt = auto_int_in_10; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign gateways_gateway_10_io_plic_ready = ~pending_10; // @[Plic.scala 249:18]
  assign gateways_gateway_10_io_plic_complete = completedDevs[11]; // @[Plic.scala 264:33]
  assign gateways_gateway_11_clock = clock;
  assign gateways_gateway_11_reset = reset;
  assign gateways_gateway_11_io_interrupt = auto_int_in_11; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign gateways_gateway_11_io_plic_ready = ~pending_11; // @[Plic.scala 249:18]
  assign gateways_gateway_11_io_plic_complete = completedDevs[12]; // @[Plic.scala 264:33]
  assign gateways_gateway_12_clock = clock;
  assign gateways_gateway_12_reset = reset;
  assign gateways_gateway_12_io_interrupt = auto_int_in_12; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign gateways_gateway_12_io_plic_ready = ~pending_12; // @[Plic.scala 249:18]
  assign gateways_gateway_12_io_plic_complete = completedDevs[13]; // @[Plic.scala 264:33]
  assign gateways_gateway_13_clock = clock;
  assign gateways_gateway_13_reset = reset;
  assign gateways_gateway_13_io_interrupt = auto_int_in_13; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign gateways_gateway_13_io_plic_ready = ~pending_13; // @[Plic.scala 249:18]
  assign gateways_gateway_13_io_plic_complete = completedDevs[14]; // @[Plic.scala 264:33]
  assign gateways_gateway_14_clock = clock;
  assign gateways_gateway_14_reset = reset;
  assign gateways_gateway_14_io_interrupt = auto_int_in_14; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign gateways_gateway_14_io_plic_ready = ~pending_14; // @[Plic.scala 249:18]
  assign gateways_gateway_14_io_plic_complete = completedDevs[15]; // @[Plic.scala 264:33]
  assign gateways_gateway_15_clock = clock;
  assign gateways_gateway_15_reset = reset;
  assign gateways_gateway_15_io_interrupt = auto_int_in_15; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign gateways_gateway_15_io_plic_ready = ~pending_15; // @[Plic.scala 249:18]
  assign gateways_gateway_15_io_plic_complete = completedDevs[16]; // @[Plic.scala 264:33]
  assign gateways_gateway_16_clock = clock;
  assign gateways_gateway_16_reset = reset;
  assign gateways_gateway_16_io_interrupt = auto_int_in_16; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign gateways_gateway_16_io_plic_ready = ~pending_16; // @[Plic.scala 249:18]
  assign gateways_gateway_16_io_plic_complete = completedDevs[17]; // @[Plic.scala 264:33]
  assign gateways_gateway_17_clock = clock;
  assign gateways_gateway_17_reset = reset;
  assign gateways_gateway_17_io_interrupt = auto_int_in_17; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign gateways_gateway_17_io_plic_ready = ~pending_17; // @[Plic.scala 249:18]
  assign gateways_gateway_17_io_plic_complete = completedDevs[18]; // @[Plic.scala 264:33]
  assign gateways_gateway_18_clock = clock;
  assign gateways_gateway_18_reset = reset;
  assign gateways_gateway_18_io_interrupt = auto_int_in_18; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign gateways_gateway_18_io_plic_ready = ~pending_18; // @[Plic.scala 249:18]
  assign gateways_gateway_18_io_plic_complete = completedDevs[19]; // @[Plic.scala 264:33]
  assign gateways_gateway_19_clock = clock;
  assign gateways_gateway_19_reset = reset;
  assign gateways_gateway_19_io_interrupt = auto_int_in_19; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign gateways_gateway_19_io_plic_ready = ~pending_19; // @[Plic.scala 249:18]
  assign gateways_gateway_19_io_plic_complete = completedDevs[20]; // @[Plic.scala 264:33]
  assign gateways_gateway_20_clock = clock;
  assign gateways_gateway_20_reset = reset;
  assign gateways_gateway_20_io_interrupt = auto_int_in_20; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign gateways_gateway_20_io_plic_ready = ~pending_20; // @[Plic.scala 249:18]
  assign gateways_gateway_20_io_plic_complete = completedDevs[21]; // @[Plic.scala 264:33]
  assign gateways_gateway_21_clock = clock;
  assign gateways_gateway_21_reset = reset;
  assign gateways_gateway_21_io_interrupt = auto_int_in_21; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign gateways_gateway_21_io_plic_ready = ~pending_21; // @[Plic.scala 249:18]
  assign gateways_gateway_21_io_plic_complete = completedDevs[22]; // @[Plic.scala 264:33]
  assign gateways_gateway_22_clock = clock;
  assign gateways_gateway_22_reset = reset;
  assign gateways_gateway_22_io_interrupt = auto_int_in_22; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign gateways_gateway_22_io_plic_ready = ~pending_22; // @[Plic.scala 249:18]
  assign gateways_gateway_22_io_plic_complete = completedDevs[23]; // @[Plic.scala 264:33]
  assign gateways_gateway_23_clock = clock;
  assign gateways_gateway_23_reset = reset;
  assign gateways_gateway_23_io_interrupt = auto_int_in_23; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign gateways_gateway_23_io_plic_ready = ~pending_23; // @[Plic.scala 249:18]
  assign gateways_gateway_23_io_plic_complete = completedDevs[24]; // @[Plic.scala 264:33]
  assign gateways_gateway_24_clock = clock;
  assign gateways_gateway_24_reset = reset;
  assign gateways_gateway_24_io_interrupt = auto_int_in_24; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign gateways_gateway_24_io_plic_ready = ~pending_24; // @[Plic.scala 249:18]
  assign gateways_gateway_24_io_plic_complete = completedDevs[25]; // @[Plic.scala 264:33]
  assign gateways_gateway_25_clock = clock;
  assign gateways_gateway_25_reset = reset;
  assign gateways_gateway_25_io_interrupt = auto_int_in_25; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign gateways_gateway_25_io_plic_ready = ~pending_25; // @[Plic.scala 249:18]
  assign gateways_gateway_25_io_plic_complete = completedDevs[26]; // @[Plic.scala 264:33]
  assign gateways_gateway_26_clock = clock;
  assign gateways_gateway_26_reset = reset;
  assign gateways_gateway_26_io_interrupt = auto_int_in_26; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign gateways_gateway_26_io_plic_ready = ~pending_26; // @[Plic.scala 249:18]
  assign gateways_gateway_26_io_plic_complete = completedDevs[27]; // @[Plic.scala 264:33]
  assign gateways_gateway_27_clock = clock;
  assign gateways_gateway_27_reset = reset;
  assign gateways_gateway_27_io_interrupt = auto_int_in_27; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign gateways_gateway_27_io_plic_ready = ~pending_27; // @[Plic.scala 249:18]
  assign gateways_gateway_27_io_plic_complete = completedDevs[28]; // @[Plic.scala 264:33]
  assign gateways_gateway_28_clock = clock;
  assign gateways_gateway_28_reset = reset;
  assign gateways_gateway_28_io_interrupt = auto_int_in_28; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign gateways_gateway_28_io_plic_ready = ~pending_28; // @[Plic.scala 249:18]
  assign gateways_gateway_28_io_plic_complete = completedDevs[29]; // @[Plic.scala 264:33]
  assign gateways_gateway_29_clock = clock;
  assign gateways_gateway_29_reset = reset;
  assign gateways_gateway_29_io_interrupt = auto_int_in_29; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign gateways_gateway_29_io_plic_ready = ~pending_29; // @[Plic.scala 249:18]
  assign gateways_gateway_29_io_plic_complete = completedDevs[30]; // @[Plic.scala 264:33]
  assign gateways_gateway_30_clock = clock;
  assign gateways_gateway_30_reset = reset;
  assign gateways_gateway_30_io_interrupt = auto_int_in_30; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign gateways_gateway_30_io_plic_ready = ~pending_30; // @[Plic.scala 249:18]
  assign gateways_gateway_30_io_plic_complete = completedDevs[31]; // @[Plic.scala 264:33]
  assign gateways_gateway_31_clock = clock;
  assign gateways_gateway_31_reset = reset;
  assign gateways_gateway_31_io_interrupt = auto_int_in_31; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign gateways_gateway_31_io_plic_ready = ~pending_31; // @[Plic.scala 249:18]
  assign gateways_gateway_31_io_plic_complete = completedDevs[32]; // @[Plic.scala 264:33]
  assign fanin_io_prio_0 = priority_0; // @[Plic.scala 184:21]
  assign fanin_io_prio_1 = priority_1; // @[Plic.scala 184:21]
  assign fanin_io_prio_2 = priority_2; // @[Plic.scala 184:21]
  assign fanin_io_prio_3 = priority_3; // @[Plic.scala 184:21]
  assign fanin_io_prio_4 = priority_4; // @[Plic.scala 184:21]
  assign fanin_io_prio_5 = priority_5; // @[Plic.scala 184:21]
  assign fanin_io_prio_6 = priority_6; // @[Plic.scala 184:21]
  assign fanin_io_prio_7 = priority_7; // @[Plic.scala 184:21]
  assign fanin_io_prio_8 = priority_8; // @[Plic.scala 184:21]
  assign fanin_io_prio_9 = priority_9; // @[Plic.scala 184:21]
  assign fanin_io_prio_10 = priority_10; // @[Plic.scala 184:21]
  assign fanin_io_prio_11 = priority_11; // @[Plic.scala 184:21]
  assign fanin_io_prio_12 = priority_12; // @[Plic.scala 184:21]
  assign fanin_io_prio_13 = priority_13; // @[Plic.scala 184:21]
  assign fanin_io_prio_14 = priority_14; // @[Plic.scala 184:21]
  assign fanin_io_prio_15 = priority_15; // @[Plic.scala 184:21]
  assign fanin_io_prio_16 = priority_16; // @[Plic.scala 184:21]
  assign fanin_io_prio_17 = priority_17; // @[Plic.scala 184:21]
  assign fanin_io_prio_18 = priority_18; // @[Plic.scala 184:21]
  assign fanin_io_prio_19 = priority_19; // @[Plic.scala 184:21]
  assign fanin_io_prio_20 = priority_20; // @[Plic.scala 184:21]
  assign fanin_io_prio_21 = priority_21; // @[Plic.scala 184:21]
  assign fanin_io_prio_22 = priority_22; // @[Plic.scala 184:21]
  assign fanin_io_prio_23 = priority_23; // @[Plic.scala 184:21]
  assign fanin_io_prio_24 = priority_24; // @[Plic.scala 184:21]
  assign fanin_io_prio_25 = priority_25; // @[Plic.scala 184:21]
  assign fanin_io_prio_26 = priority_26; // @[Plic.scala 184:21]
  assign fanin_io_prio_27 = priority_27; // @[Plic.scala 184:21]
  assign fanin_io_prio_28 = priority_28; // @[Plic.scala 184:21]
  assign fanin_io_prio_29 = priority_29; // @[Plic.scala 184:21]
  assign fanin_io_prio_30 = priority_30; // @[Plic.scala 184:21]
  assign fanin_io_prio_31 = priority_31; // @[Plic.scala 184:21]
  assign fanin_io_ip = enableVec_0 & pendingUInt; // @[Plic.scala 185:40]
  assign fanin_1_io_prio_0 = priority_0; // @[Plic.scala 184:21]
  assign fanin_1_io_prio_1 = priority_1; // @[Plic.scala 184:21]
  assign fanin_1_io_prio_2 = priority_2; // @[Plic.scala 184:21]
  assign fanin_1_io_prio_3 = priority_3; // @[Plic.scala 184:21]
  assign fanin_1_io_prio_4 = priority_4; // @[Plic.scala 184:21]
  assign fanin_1_io_prio_5 = priority_5; // @[Plic.scala 184:21]
  assign fanin_1_io_prio_6 = priority_6; // @[Plic.scala 184:21]
  assign fanin_1_io_prio_7 = priority_7; // @[Plic.scala 184:21]
  assign fanin_1_io_prio_8 = priority_8; // @[Plic.scala 184:21]
  assign fanin_1_io_prio_9 = priority_9; // @[Plic.scala 184:21]
  assign fanin_1_io_prio_10 = priority_10; // @[Plic.scala 184:21]
  assign fanin_1_io_prio_11 = priority_11; // @[Plic.scala 184:21]
  assign fanin_1_io_prio_12 = priority_12; // @[Plic.scala 184:21]
  assign fanin_1_io_prio_13 = priority_13; // @[Plic.scala 184:21]
  assign fanin_1_io_prio_14 = priority_14; // @[Plic.scala 184:21]
  assign fanin_1_io_prio_15 = priority_15; // @[Plic.scala 184:21]
  assign fanin_1_io_prio_16 = priority_16; // @[Plic.scala 184:21]
  assign fanin_1_io_prio_17 = priority_17; // @[Plic.scala 184:21]
  assign fanin_1_io_prio_18 = priority_18; // @[Plic.scala 184:21]
  assign fanin_1_io_prio_19 = priority_19; // @[Plic.scala 184:21]
  assign fanin_1_io_prio_20 = priority_20; // @[Plic.scala 184:21]
  assign fanin_1_io_prio_21 = priority_21; // @[Plic.scala 184:21]
  assign fanin_1_io_prio_22 = priority_22; // @[Plic.scala 184:21]
  assign fanin_1_io_prio_23 = priority_23; // @[Plic.scala 184:21]
  assign fanin_1_io_prio_24 = priority_24; // @[Plic.scala 184:21]
  assign fanin_1_io_prio_25 = priority_25; // @[Plic.scala 184:21]
  assign fanin_1_io_prio_26 = priority_26; // @[Plic.scala 184:21]
  assign fanin_1_io_prio_27 = priority_27; // @[Plic.scala 184:21]
  assign fanin_1_io_prio_28 = priority_28; // @[Plic.scala 184:21]
  assign fanin_1_io_prio_29 = priority_29; // @[Plic.scala 184:21]
  assign fanin_1_io_prio_30 = priority_30; // @[Plic.scala 184:21]
  assign fanin_1_io_prio_31 = priority_31; // @[Plic.scala 184:21]
  assign fanin_1_io_ip = enableVec_1 & pendingUInt; // @[Plic.scala 185:40]
  assign out_back_clock = clock;
  assign out_back_reset = reset;
  assign out_back_io_enq_valid = auto_in_a_valid; // @[RegisterRouter.scala 82:24]
  assign out_back_io_enq_bits_read = auto_in_a_bits_opcode == 3'h4; // @[RegisterRouter.scala 71:36]
  assign out_back_io_enq_bits_index = auto_in_a_bits_address[25:3]; // @[RegisterRouter.scala 70:18 72:19]
  assign out_back_io_enq_bits_data = auto_in_a_bits_data; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign out_back_io_enq_bits_mask = auto_in_a_bits_mask; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign out_back_io_enq_bits_extra_tlrr_extra_source = auto_in_a_bits_source; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign out_back_io_enq_bits_extra_tlrr_extra_size = auto_in_a_bits_size; // @[Nodes.scala 1210:84 LazyModule.scala 309:16]
  assign out_back_io_deq_ready = auto_in_d_ready; // @[RegisterRouter.scala 82:24]
  always @(posedge clock) begin
    if (out_f_woready_6) begin // @[RegField.scala 74:88]
      priority_0 <= out_back_io_deq_bits_data[34:32]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_19) begin // @[RegField.scala 74:88]
      priority_1 <= out_back_io_deq_bits_data[2:0]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_20) begin // @[RegField.scala 74:88]
      priority_2 <= out_back_io_deq_bits_data[34:32]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_60) begin // @[RegField.scala 74:88]
      priority_3 <= out_back_io_deq_bits_data[2:0]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_61) begin // @[RegField.scala 74:88]
      priority_4 <= out_back_io_deq_bits_data[34:32]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_69) begin // @[RegField.scala 74:88]
      priority_5 <= out_back_io_deq_bits_data[2:0]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_70) begin // @[RegField.scala 74:88]
      priority_6 <= out_back_io_deq_bits_data[34:32]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_79) begin // @[RegField.scala 74:88]
      priority_7 <= out_back_io_deq_bits_data[2:0]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_80) begin // @[RegField.scala 74:88]
      priority_8 <= out_back_io_deq_bits_data[34:32]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_7) begin // @[RegField.scala 74:88]
      priority_9 <= out_back_io_deq_bits_data[2:0]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_8) begin // @[RegField.scala 74:88]
      priority_10 <= out_back_io_deq_bits_data[34:32]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_21) begin // @[RegField.scala 74:88]
      priority_11 <= out_back_io_deq_bits_data[2:0]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_22) begin // @[RegField.scala 74:88]
      priority_12 <= out_back_io_deq_bits_data[34:32]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_67) begin // @[RegField.scala 74:88]
      priority_13 <= out_back_io_deq_bits_data[2:0]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_68) begin // @[RegField.scala 74:88]
      priority_14 <= out_back_io_deq_bits_data[34:32]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_77) begin // @[RegField.scala 74:88]
      priority_15 <= out_back_io_deq_bits_data[2:0]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_78) begin // @[RegField.scala 74:88]
      priority_16 <= out_back_io_deq_bits_data[34:32]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_56) begin // @[RegField.scala 74:88]
      priority_17 <= out_back_io_deq_bits_data[2:0]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_57) begin // @[RegField.scala 74:88]
      priority_18 <= out_back_io_deq_bits_data[34:32]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_9) begin // @[RegField.scala 74:88]
      priority_19 <= out_back_io_deq_bits_data[2:0]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_10) begin // @[RegField.scala 74:88]
      priority_20 <= out_back_io_deq_bits_data[34:32]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_75) begin // @[RegField.scala 74:88]
      priority_21 <= out_back_io_deq_bits_data[2:0]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_76) begin // @[RegField.scala 74:88]
      priority_22 <= out_back_io_deq_bits_data[34:32]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_65) begin // @[RegField.scala 74:88]
      priority_23 <= out_back_io_deq_bits_data[2:0]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_66) begin // @[RegField.scala 74:88]
      priority_24 <= out_back_io_deq_bits_data[34:32]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_58) begin // @[RegField.scala 74:88]
      priority_25 <= out_back_io_deq_bits_data[2:0]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_59) begin // @[RegField.scala 74:88]
      priority_26 <= out_back_io_deq_bits_data[34:32]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_11) begin // @[RegField.scala 74:88]
      priority_27 <= out_back_io_deq_bits_data[2:0]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_12) begin // @[RegField.scala 74:88]
      priority_28 <= out_back_io_deq_bits_data[34:32]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_81) begin // @[RegField.scala 74:88]
      priority_29 <= out_back_io_deq_bits_data[2:0]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_82) begin // @[RegField.scala 74:88]
      priority_30 <= out_back_io_deq_bits_data[34:32]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_71) begin // @[RegField.scala 74:88]
      priority_31 <= out_back_io_deq_bits_data[2:0]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_72) begin // @[RegField.scala 74:88]
      threshold_0 <= out_back_io_deq_bits_data[2:0]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_62) begin // @[RegField.scala 74:88]
      threshold_1 <= out_back_io_deq_bits_data[2:0]; // @[RegField.scala 74:92]
    end
    if (reset) begin // @[Plic.scala 167:22]
      pending_0 <= 1'h0; // @[Plic.scala 167:22]
    end else if (claimedDevs_1 | gateways_gateway_io_plic_valid) begin // @[Plic.scala 250:27]
      pending_0 <= ~claimedDevs_1; // @[Plic.scala 250:31]
    end
    if (reset) begin // @[Plic.scala 167:22]
      pending_1 <= 1'h0; // @[Plic.scala 167:22]
    end else if (claimedDevs_2 | gateways_gateway_1_io_plic_valid) begin // @[Plic.scala 250:27]
      pending_1 <= ~claimedDevs_2; // @[Plic.scala 250:31]
    end
    if (reset) begin // @[Plic.scala 167:22]
      pending_2 <= 1'h0; // @[Plic.scala 167:22]
    end else if (claimedDevs_3 | gateways_gateway_2_io_plic_valid) begin // @[Plic.scala 250:27]
      pending_2 <= ~claimedDevs_3; // @[Plic.scala 250:31]
    end
    if (reset) begin // @[Plic.scala 167:22]
      pending_3 <= 1'h0; // @[Plic.scala 167:22]
    end else if (claimedDevs_4 | gateways_gateway_3_io_plic_valid) begin // @[Plic.scala 250:27]
      pending_3 <= ~claimedDevs_4; // @[Plic.scala 250:31]
    end
    if (reset) begin // @[Plic.scala 167:22]
      pending_4 <= 1'h0; // @[Plic.scala 167:22]
    end else if (claimedDevs_5 | gateways_gateway_4_io_plic_valid) begin // @[Plic.scala 250:27]
      pending_4 <= ~claimedDevs_5; // @[Plic.scala 250:31]
    end
    if (reset) begin // @[Plic.scala 167:22]
      pending_5 <= 1'h0; // @[Plic.scala 167:22]
    end else if (claimedDevs_6 | gateways_gateway_5_io_plic_valid) begin // @[Plic.scala 250:27]
      pending_5 <= ~claimedDevs_6; // @[Plic.scala 250:31]
    end
    if (reset) begin // @[Plic.scala 167:22]
      pending_6 <= 1'h0; // @[Plic.scala 167:22]
    end else if (claimedDevs_7 | gateways_gateway_6_io_plic_valid) begin // @[Plic.scala 250:27]
      pending_6 <= ~claimedDevs_7; // @[Plic.scala 250:31]
    end
    if (reset) begin // @[Plic.scala 167:22]
      pending_7 <= 1'h0; // @[Plic.scala 167:22]
    end else if (claimedDevs_8 | gateways_gateway_7_io_plic_valid) begin // @[Plic.scala 250:27]
      pending_7 <= ~claimedDevs_8; // @[Plic.scala 250:31]
    end
    if (reset) begin // @[Plic.scala 167:22]
      pending_8 <= 1'h0; // @[Plic.scala 167:22]
    end else if (claimedDevs_9 | gateways_gateway_8_io_plic_valid) begin // @[Plic.scala 250:27]
      pending_8 <= ~claimedDevs_9; // @[Plic.scala 250:31]
    end
    if (reset) begin // @[Plic.scala 167:22]
      pending_9 <= 1'h0; // @[Plic.scala 167:22]
    end else if (claimedDevs_10 | gateways_gateway_9_io_plic_valid) begin // @[Plic.scala 250:27]
      pending_9 <= ~claimedDevs_10; // @[Plic.scala 250:31]
    end
    if (reset) begin // @[Plic.scala 167:22]
      pending_10 <= 1'h0; // @[Plic.scala 167:22]
    end else if (claimedDevs_11 | gateways_gateway_10_io_plic_valid) begin // @[Plic.scala 250:27]
      pending_10 <= ~claimedDevs_11; // @[Plic.scala 250:31]
    end
    if (reset) begin // @[Plic.scala 167:22]
      pending_11 <= 1'h0; // @[Plic.scala 167:22]
    end else if (claimedDevs_12 | gateways_gateway_11_io_plic_valid) begin // @[Plic.scala 250:27]
      pending_11 <= ~claimedDevs_12; // @[Plic.scala 250:31]
    end
    if (reset) begin // @[Plic.scala 167:22]
      pending_12 <= 1'h0; // @[Plic.scala 167:22]
    end else if (claimedDevs_13 | gateways_gateway_12_io_plic_valid) begin // @[Plic.scala 250:27]
      pending_12 <= ~claimedDevs_13; // @[Plic.scala 250:31]
    end
    if (reset) begin // @[Plic.scala 167:22]
      pending_13 <= 1'h0; // @[Plic.scala 167:22]
    end else if (claimedDevs_14 | gateways_gateway_13_io_plic_valid) begin // @[Plic.scala 250:27]
      pending_13 <= ~claimedDevs_14; // @[Plic.scala 250:31]
    end
    if (reset) begin // @[Plic.scala 167:22]
      pending_14 <= 1'h0; // @[Plic.scala 167:22]
    end else if (claimedDevs_15 | gateways_gateway_14_io_plic_valid) begin // @[Plic.scala 250:27]
      pending_14 <= ~claimedDevs_15; // @[Plic.scala 250:31]
    end
    if (reset) begin // @[Plic.scala 167:22]
      pending_15 <= 1'h0; // @[Plic.scala 167:22]
    end else if (claimedDevs_16 | gateways_gateway_15_io_plic_valid) begin // @[Plic.scala 250:27]
      pending_15 <= ~claimedDevs_16; // @[Plic.scala 250:31]
    end
    if (reset) begin // @[Plic.scala 167:22]
      pending_16 <= 1'h0; // @[Plic.scala 167:22]
    end else if (claimedDevs_17 | gateways_gateway_16_io_plic_valid) begin // @[Plic.scala 250:27]
      pending_16 <= ~claimedDevs_17; // @[Plic.scala 250:31]
    end
    if (reset) begin // @[Plic.scala 167:22]
      pending_17 <= 1'h0; // @[Plic.scala 167:22]
    end else if (claimedDevs_18 | gateways_gateway_17_io_plic_valid) begin // @[Plic.scala 250:27]
      pending_17 <= ~claimedDevs_18; // @[Plic.scala 250:31]
    end
    if (reset) begin // @[Plic.scala 167:22]
      pending_18 <= 1'h0; // @[Plic.scala 167:22]
    end else if (claimedDevs_19 | gateways_gateway_18_io_plic_valid) begin // @[Plic.scala 250:27]
      pending_18 <= ~claimedDevs_19; // @[Plic.scala 250:31]
    end
    if (reset) begin // @[Plic.scala 167:22]
      pending_19 <= 1'h0; // @[Plic.scala 167:22]
    end else if (claimedDevs_20 | gateways_gateway_19_io_plic_valid) begin // @[Plic.scala 250:27]
      pending_19 <= ~claimedDevs_20; // @[Plic.scala 250:31]
    end
    if (reset) begin // @[Plic.scala 167:22]
      pending_20 <= 1'h0; // @[Plic.scala 167:22]
    end else if (claimedDevs_21 | gateways_gateway_20_io_plic_valid) begin // @[Plic.scala 250:27]
      pending_20 <= ~claimedDevs_21; // @[Plic.scala 250:31]
    end
    if (reset) begin // @[Plic.scala 167:22]
      pending_21 <= 1'h0; // @[Plic.scala 167:22]
    end else if (claimedDevs_22 | gateways_gateway_21_io_plic_valid) begin // @[Plic.scala 250:27]
      pending_21 <= ~claimedDevs_22; // @[Plic.scala 250:31]
    end
    if (reset) begin // @[Plic.scala 167:22]
      pending_22 <= 1'h0; // @[Plic.scala 167:22]
    end else if (claimedDevs_23 | gateways_gateway_22_io_plic_valid) begin // @[Plic.scala 250:27]
      pending_22 <= ~claimedDevs_23; // @[Plic.scala 250:31]
    end
    if (reset) begin // @[Plic.scala 167:22]
      pending_23 <= 1'h0; // @[Plic.scala 167:22]
    end else if (claimedDevs_24 | gateways_gateway_23_io_plic_valid) begin // @[Plic.scala 250:27]
      pending_23 <= ~claimedDevs_24; // @[Plic.scala 250:31]
    end
    if (reset) begin // @[Plic.scala 167:22]
      pending_24 <= 1'h0; // @[Plic.scala 167:22]
    end else if (claimedDevs_25 | gateways_gateway_24_io_plic_valid) begin // @[Plic.scala 250:27]
      pending_24 <= ~claimedDevs_25; // @[Plic.scala 250:31]
    end
    if (reset) begin // @[Plic.scala 167:22]
      pending_25 <= 1'h0; // @[Plic.scala 167:22]
    end else if (claimedDevs_26 | gateways_gateway_25_io_plic_valid) begin // @[Plic.scala 250:27]
      pending_25 <= ~claimedDevs_26; // @[Plic.scala 250:31]
    end
    if (reset) begin // @[Plic.scala 167:22]
      pending_26 <= 1'h0; // @[Plic.scala 167:22]
    end else if (claimedDevs_27 | gateways_gateway_26_io_plic_valid) begin // @[Plic.scala 250:27]
      pending_26 <= ~claimedDevs_27; // @[Plic.scala 250:31]
    end
    if (reset) begin // @[Plic.scala 167:22]
      pending_27 <= 1'h0; // @[Plic.scala 167:22]
    end else if (claimedDevs_28 | gateways_gateway_27_io_plic_valid) begin // @[Plic.scala 250:27]
      pending_27 <= ~claimedDevs_28; // @[Plic.scala 250:31]
    end
    if (reset) begin // @[Plic.scala 167:22]
      pending_28 <= 1'h0; // @[Plic.scala 167:22]
    end else if (claimedDevs_29 | gateways_gateway_28_io_plic_valid) begin // @[Plic.scala 250:27]
      pending_28 <= ~claimedDevs_29; // @[Plic.scala 250:31]
    end
    if (reset) begin // @[Plic.scala 167:22]
      pending_29 <= 1'h0; // @[Plic.scala 167:22]
    end else if (claimedDevs_30 | gateways_gateway_29_io_plic_valid) begin // @[Plic.scala 250:27]
      pending_29 <= ~claimedDevs_30; // @[Plic.scala 250:31]
    end
    if (reset) begin // @[Plic.scala 167:22]
      pending_30 <= 1'h0; // @[Plic.scala 167:22]
    end else if (claimedDevs_31 | gateways_gateway_30_io_plic_valid) begin // @[Plic.scala 250:27]
      pending_30 <= ~claimedDevs_31; // @[Plic.scala 250:31]
    end
    if (reset) begin // @[Plic.scala 167:22]
      pending_31 <= 1'h0; // @[Plic.scala 167:22]
    end else if (claimedDevs_32 | gateways_gateway_31_io_plic_valid) begin // @[Plic.scala 250:27]
      pending_31 <= ~claimedDevs_32; // @[Plic.scala 250:31]
    end
    if (out_f_woready_1) begin // @[RegField.scala 74:88]
      enables_0_0 <= out_back_io_deq_bits_data[7:1]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_2) begin // @[RegField.scala 74:88]
      enables_0_1 <= out_back_io_deq_bits_data[15:8]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_3) begin // @[RegField.scala 74:88]
      enables_0_2 <= out_back_io_deq_bits_data[23:16]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_4) begin // @[RegField.scala 74:88]
      enables_0_3 <= out_back_io_deq_bits_data[31:24]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_5) begin // @[RegField.scala 74:88]
      enables_0_4 <= out_back_io_deq_bits_data[32]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_14) begin // @[RegField.scala 74:88]
      enables_1_0 <= out_back_io_deq_bits_data[7:1]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_15) begin // @[RegField.scala 74:88]
      enables_1_1 <= out_back_io_deq_bits_data[15:8]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_16) begin // @[RegField.scala 74:88]
      enables_1_2 <= out_back_io_deq_bits_data[23:16]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_17) begin // @[RegField.scala 74:88]
      enables_1_3 <= out_back_io_deq_bits_data[31:24]; // @[RegField.scala 74:92]
    end
    if (out_f_woready_18) begin // @[RegField.scala 74:88]
      enables_1_4 <= out_back_io_deq_bits_data[32]; // @[RegField.scala 74:92]
    end
    maxDevs_0 <= fanin_io_dev; // @[Plic.scala 186:21]
    maxDevs_1 <= fanin_1_io_dev; // @[Plic.scala 186:21]
    bundleOut_0_0_REG <= fanin_io_max; // @[Plic.scala 187:41]
    bundleOut_1_0_REG <= fanin_1_io_max; // @[Plic.scala 187:41]
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~(_T_4 == 2'h0) & ~reset) begin
          $fatal; // @[Plic.scala 244:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~reset & ~(_T_4 == 2'h0)) begin
          $fwrite(32'h80000002,
            "Assertion failed\n    at Plic.scala:244 assert((claimer.asUInt & (claimer.asUInt - UInt(1))) === UInt(0)) // One-Hot\n"
            ); // @[Plic.scala 244:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~(_T_45 == 2'h0) & _T_7) begin
          $fatal; // @[Plic.scala 261:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_7 & ~(_T_45 == 2'h0)) begin
          $fwrite(32'h80000002,
            "Assertion failed\n    at Plic.scala:261 assert((completer.asUInt & (completer.asUInt - UInt(1))) === UInt(0)) // One-Hot\n"
            ); // @[Plic.scala 261:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~(completerDev == completerDev) & _T_7) begin
          $fatal; // @[Plic.scala 291:19]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_7 & ~(completerDev == completerDev)) begin
          $fwrite(32'h80000002,
            "Assertion failed: completerDev should be consistent for all harts\n    at Plic.scala:291 assert(completerDev === data.extract(log2Ceil(nDevices+1)-1, 0),\n"
            ); // @[Plic.scala 291:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~(completerDev == completerDev) & _T_7) begin
          $fatal; // @[Plic.scala 291:19]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_7 & ~(completerDev == completerDev)) begin
          $fwrite(32'h80000002,
            "Assertion failed: completerDev should be consistent for all harts\n    at Plic.scala:291 assert(completerDev === data.extract(log2Ceil(nDevices+1)-1, 0),\n"
            ); // @[Plic.scala 291:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  priority_0 = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  priority_1 = _RAND_1[2:0];
  _RAND_2 = {1{`RANDOM}};
  priority_2 = _RAND_2[2:0];
  _RAND_3 = {1{`RANDOM}};
  priority_3 = _RAND_3[2:0];
  _RAND_4 = {1{`RANDOM}};
  priority_4 = _RAND_4[2:0];
  _RAND_5 = {1{`RANDOM}};
  priority_5 = _RAND_5[2:0];
  _RAND_6 = {1{`RANDOM}};
  priority_6 = _RAND_6[2:0];
  _RAND_7 = {1{`RANDOM}};
  priority_7 = _RAND_7[2:0];
  _RAND_8 = {1{`RANDOM}};
  priority_8 = _RAND_8[2:0];
  _RAND_9 = {1{`RANDOM}};
  priority_9 = _RAND_9[2:0];
  _RAND_10 = {1{`RANDOM}};
  priority_10 = _RAND_10[2:0];
  _RAND_11 = {1{`RANDOM}};
  priority_11 = _RAND_11[2:0];
  _RAND_12 = {1{`RANDOM}};
  priority_12 = _RAND_12[2:0];
  _RAND_13 = {1{`RANDOM}};
  priority_13 = _RAND_13[2:0];
  _RAND_14 = {1{`RANDOM}};
  priority_14 = _RAND_14[2:0];
  _RAND_15 = {1{`RANDOM}};
  priority_15 = _RAND_15[2:0];
  _RAND_16 = {1{`RANDOM}};
  priority_16 = _RAND_16[2:0];
  _RAND_17 = {1{`RANDOM}};
  priority_17 = _RAND_17[2:0];
  _RAND_18 = {1{`RANDOM}};
  priority_18 = _RAND_18[2:0];
  _RAND_19 = {1{`RANDOM}};
  priority_19 = _RAND_19[2:0];
  _RAND_20 = {1{`RANDOM}};
  priority_20 = _RAND_20[2:0];
  _RAND_21 = {1{`RANDOM}};
  priority_21 = _RAND_21[2:0];
  _RAND_22 = {1{`RANDOM}};
  priority_22 = _RAND_22[2:0];
  _RAND_23 = {1{`RANDOM}};
  priority_23 = _RAND_23[2:0];
  _RAND_24 = {1{`RANDOM}};
  priority_24 = _RAND_24[2:0];
  _RAND_25 = {1{`RANDOM}};
  priority_25 = _RAND_25[2:0];
  _RAND_26 = {1{`RANDOM}};
  priority_26 = _RAND_26[2:0];
  _RAND_27 = {1{`RANDOM}};
  priority_27 = _RAND_27[2:0];
  _RAND_28 = {1{`RANDOM}};
  priority_28 = _RAND_28[2:0];
  _RAND_29 = {1{`RANDOM}};
  priority_29 = _RAND_29[2:0];
  _RAND_30 = {1{`RANDOM}};
  priority_30 = _RAND_30[2:0];
  _RAND_31 = {1{`RANDOM}};
  priority_31 = _RAND_31[2:0];
  _RAND_32 = {1{`RANDOM}};
  threshold_0 = _RAND_32[2:0];
  _RAND_33 = {1{`RANDOM}};
  threshold_1 = _RAND_33[2:0];
  _RAND_34 = {1{`RANDOM}};
  pending_0 = _RAND_34[0:0];
  _RAND_35 = {1{`RANDOM}};
  pending_1 = _RAND_35[0:0];
  _RAND_36 = {1{`RANDOM}};
  pending_2 = _RAND_36[0:0];
  _RAND_37 = {1{`RANDOM}};
  pending_3 = _RAND_37[0:0];
  _RAND_38 = {1{`RANDOM}};
  pending_4 = _RAND_38[0:0];
  _RAND_39 = {1{`RANDOM}};
  pending_5 = _RAND_39[0:0];
  _RAND_40 = {1{`RANDOM}};
  pending_6 = _RAND_40[0:0];
  _RAND_41 = {1{`RANDOM}};
  pending_7 = _RAND_41[0:0];
  _RAND_42 = {1{`RANDOM}};
  pending_8 = _RAND_42[0:0];
  _RAND_43 = {1{`RANDOM}};
  pending_9 = _RAND_43[0:0];
  _RAND_44 = {1{`RANDOM}};
  pending_10 = _RAND_44[0:0];
  _RAND_45 = {1{`RANDOM}};
  pending_11 = _RAND_45[0:0];
  _RAND_46 = {1{`RANDOM}};
  pending_12 = _RAND_46[0:0];
  _RAND_47 = {1{`RANDOM}};
  pending_13 = _RAND_47[0:0];
  _RAND_48 = {1{`RANDOM}};
  pending_14 = _RAND_48[0:0];
  _RAND_49 = {1{`RANDOM}};
  pending_15 = _RAND_49[0:0];
  _RAND_50 = {1{`RANDOM}};
  pending_16 = _RAND_50[0:0];
  _RAND_51 = {1{`RANDOM}};
  pending_17 = _RAND_51[0:0];
  _RAND_52 = {1{`RANDOM}};
  pending_18 = _RAND_52[0:0];
  _RAND_53 = {1{`RANDOM}};
  pending_19 = _RAND_53[0:0];
  _RAND_54 = {1{`RANDOM}};
  pending_20 = _RAND_54[0:0];
  _RAND_55 = {1{`RANDOM}};
  pending_21 = _RAND_55[0:0];
  _RAND_56 = {1{`RANDOM}};
  pending_22 = _RAND_56[0:0];
  _RAND_57 = {1{`RANDOM}};
  pending_23 = _RAND_57[0:0];
  _RAND_58 = {1{`RANDOM}};
  pending_24 = _RAND_58[0:0];
  _RAND_59 = {1{`RANDOM}};
  pending_25 = _RAND_59[0:0];
  _RAND_60 = {1{`RANDOM}};
  pending_26 = _RAND_60[0:0];
  _RAND_61 = {1{`RANDOM}};
  pending_27 = _RAND_61[0:0];
  _RAND_62 = {1{`RANDOM}};
  pending_28 = _RAND_62[0:0];
  _RAND_63 = {1{`RANDOM}};
  pending_29 = _RAND_63[0:0];
  _RAND_64 = {1{`RANDOM}};
  pending_30 = _RAND_64[0:0];
  _RAND_65 = {1{`RANDOM}};
  pending_31 = _RAND_65[0:0];
  _RAND_66 = {1{`RANDOM}};
  enables_0_0 = _RAND_66[6:0];
  _RAND_67 = {1{`RANDOM}};
  enables_0_1 = _RAND_67[7:0];
  _RAND_68 = {1{`RANDOM}};
  enables_0_2 = _RAND_68[7:0];
  _RAND_69 = {1{`RANDOM}};
  enables_0_3 = _RAND_69[7:0];
  _RAND_70 = {1{`RANDOM}};
  enables_0_4 = _RAND_70[0:0];
  _RAND_71 = {1{`RANDOM}};
  enables_1_0 = _RAND_71[6:0];
  _RAND_72 = {1{`RANDOM}};
  enables_1_1 = _RAND_72[7:0];
  _RAND_73 = {1{`RANDOM}};
  enables_1_2 = _RAND_73[7:0];
  _RAND_74 = {1{`RANDOM}};
  enables_1_3 = _RAND_74[7:0];
  _RAND_75 = {1{`RANDOM}};
  enables_1_4 = _RAND_75[0:0];
  _RAND_76 = {1{`RANDOM}};
  maxDevs_0 = _RAND_76[5:0];
  _RAND_77 = {1{`RANDOM}};
  maxDevs_1 = _RAND_77[5:0];
  _RAND_78 = {1{`RANDOM}};
  bundleOut_0_0_REG = _RAND_78[2:0];
  _RAND_79 = {1{`RANDOM}};
  bundleOut_1_0_REG = _RAND_79[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module TLMonitor_26(
  input         clock,
  input         reset,
  input         io_in_a_ready,
  input         io_in_a_valid,
  input  [2:0]  io_in_a_bits_opcode,
  input  [2:0]  io_in_a_bits_param,
  input  [1:0]  io_in_a_bits_size,
  input  [8:0]  io_in_a_bits_source,
  input  [27:0] io_in_a_bits_address,
  input  [7:0]  io_in_a_bits_mask,
  input         io_in_a_bits_corrupt,
  input         io_in_d_ready,
  input         io_in_d_valid,
  input  [2:0]  io_in_d_bits_opcode,
  input  [1:0]  io_in_d_bits_size,
  input  [8:0]  io_in_d_bits_source
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [319:0] _RAND_10;
  reg [1215:0] _RAND_11;
  reg [1215:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [319:0] _RAND_16;
  reg [1215:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
`endif // RANDOMIZE_REG_INIT
  wire [31:0] plusarg_reader_out; // @[PlusArg.scala 80:11]
  wire [31:0] plusarg_reader_1_out; // @[PlusArg.scala 80:11]
  wire  _T_2 = ~reset; // @[Monitor.scala 42:11]
  wire  _source_ok_T_4 = io_in_a_bits_source <= 9'h12f; // @[Parameters.scala 57:20]
  wire [5:0] _is_aligned_mask_T_1 = 6'h7 << io_in_a_bits_size; // @[package.scala 234:77]
  wire [2:0] is_aligned_mask = ~_is_aligned_mask_T_1[2:0]; // @[package.scala 234:46]
  wire [27:0] _GEN_71 = {{25'd0}, is_aligned_mask}; // @[Edges.scala 20:16]
  wire [27:0] _is_aligned_T = io_in_a_bits_address & _GEN_71; // @[Edges.scala 20:16]
  wire  is_aligned = _is_aligned_T == 28'h0; // @[Edges.scala 20:24]
  wire [2:0] _mask_sizeOH_T = {{1'd0}, io_in_a_bits_size}; // @[Misc.scala 201:34]
  wire [1:0] mask_sizeOH_shiftAmount = _mask_sizeOH_T[1:0]; // @[OneHot.scala 63:49]
  wire [3:0] _mask_sizeOH_T_1 = 4'h1 << mask_sizeOH_shiftAmount; // @[OneHot.scala 64:12]
  wire [2:0] mask_sizeOH = _mask_sizeOH_T_1[2:0] | 3'h1; // @[Misc.scala 201:81]
  wire  _mask_T = io_in_a_bits_size >= 2'h3; // @[Misc.scala 205:21]
  wire  mask_size = mask_sizeOH[2]; // @[Misc.scala 208:26]
  wire  mask_bit = io_in_a_bits_address[2]; // @[Misc.scala 209:26]
  wire  mask_nbit = ~mask_bit; // @[Misc.scala 210:20]
  wire  mask_acc = _mask_T | mask_size & mask_nbit; // @[Misc.scala 214:29]
  wire  mask_acc_1 = _mask_T | mask_size & mask_bit; // @[Misc.scala 214:29]
  wire  mask_size_1 = mask_sizeOH[1]; // @[Misc.scala 208:26]
  wire  mask_bit_1 = io_in_a_bits_address[1]; // @[Misc.scala 209:26]
  wire  mask_nbit_1 = ~mask_bit_1; // @[Misc.scala 210:20]
  wire  mask_eq_2 = mask_nbit & mask_nbit_1; // @[Misc.scala 213:27]
  wire  mask_acc_2 = mask_acc | mask_size_1 & mask_eq_2; // @[Misc.scala 214:29]
  wire  mask_eq_3 = mask_nbit & mask_bit_1; // @[Misc.scala 213:27]
  wire  mask_acc_3 = mask_acc | mask_size_1 & mask_eq_3; // @[Misc.scala 214:29]
  wire  mask_eq_4 = mask_bit & mask_nbit_1; // @[Misc.scala 213:27]
  wire  mask_acc_4 = mask_acc_1 | mask_size_1 & mask_eq_4; // @[Misc.scala 214:29]
  wire  mask_eq_5 = mask_bit & mask_bit_1; // @[Misc.scala 213:27]
  wire  mask_acc_5 = mask_acc_1 | mask_size_1 & mask_eq_5; // @[Misc.scala 214:29]
  wire  mask_size_2 = mask_sizeOH[0]; // @[Misc.scala 208:26]
  wire  mask_bit_2 = io_in_a_bits_address[0]; // @[Misc.scala 209:26]
  wire  mask_nbit_2 = ~mask_bit_2; // @[Misc.scala 210:20]
  wire  mask_eq_6 = mask_eq_2 & mask_nbit_2; // @[Misc.scala 213:27]
  wire  mask_acc_6 = mask_acc_2 | mask_size_2 & mask_eq_6; // @[Misc.scala 214:29]
  wire  mask_eq_7 = mask_eq_2 & mask_bit_2; // @[Misc.scala 213:27]
  wire  mask_acc_7 = mask_acc_2 | mask_size_2 & mask_eq_7; // @[Misc.scala 214:29]
  wire  mask_eq_8 = mask_eq_3 & mask_nbit_2; // @[Misc.scala 213:27]
  wire  mask_acc_8 = mask_acc_3 | mask_size_2 & mask_eq_8; // @[Misc.scala 214:29]
  wire  mask_eq_9 = mask_eq_3 & mask_bit_2; // @[Misc.scala 213:27]
  wire  mask_acc_9 = mask_acc_3 | mask_size_2 & mask_eq_9; // @[Misc.scala 214:29]
  wire  mask_eq_10 = mask_eq_4 & mask_nbit_2; // @[Misc.scala 213:27]
  wire  mask_acc_10 = mask_acc_4 | mask_size_2 & mask_eq_10; // @[Misc.scala 214:29]
  wire  mask_eq_11 = mask_eq_4 & mask_bit_2; // @[Misc.scala 213:27]
  wire  mask_acc_11 = mask_acc_4 | mask_size_2 & mask_eq_11; // @[Misc.scala 214:29]
  wire  mask_eq_12 = mask_eq_5 & mask_nbit_2; // @[Misc.scala 213:27]
  wire  mask_acc_12 = mask_acc_5 | mask_size_2 & mask_eq_12; // @[Misc.scala 214:29]
  wire  mask_eq_13 = mask_eq_5 & mask_bit_2; // @[Misc.scala 213:27]
  wire  mask_acc_13 = mask_acc_5 | mask_size_2 & mask_eq_13; // @[Misc.scala 214:29]
  wire [7:0] mask = {mask_acc_13,mask_acc_12,mask_acc_11,mask_acc_10,mask_acc_9,mask_acc_8,mask_acc_7,mask_acc_6}; // @[Cat.scala 31:58]
  wire  _T_10 = ~_source_ok_T_4; // @[Monitor.scala 63:7]
  wire  _T_20 = io_in_a_bits_opcode == 3'h6; // @[Monitor.scala 81:25]
  wire [27:0] _T_33 = io_in_a_bits_address ^ 28'hc000000; // @[Parameters.scala 137:31]
  wire [28:0] _T_34 = {1'b0,$signed(_T_33)}; // @[Parameters.scala 137:49]
  wire [28:0] _T_36 = $signed(_T_34) & -29'sh4000000; // @[Parameters.scala 137:52]
  wire  _T_37 = $signed(_T_36) == 29'sh0; // @[Parameters.scala 137:67]
  wire  _T_69 = io_in_a_bits_param <= 3'h2; // @[Bundles.scala 108:27]
  wire [7:0] _T_73 = ~io_in_a_bits_mask; // @[Monitor.scala 88:18]
  wire  _T_74 = _T_73 == 8'h0; // @[Monitor.scala 88:31]
  wire  _T_78 = ~io_in_a_bits_corrupt; // @[Monitor.scala 89:18]
  wire  _T_82 = io_in_a_bits_opcode == 3'h7; // @[Monitor.scala 92:25]
  wire  _T_135 = io_in_a_bits_param != 3'h0; // @[Monitor.scala 99:31]
  wire  _T_148 = io_in_a_bits_opcode == 3'h4; // @[Monitor.scala 104:25]
  wire  _T_183 = io_in_a_bits_param == 3'h0; // @[Monitor.scala 109:31]
  wire  _T_187 = io_in_a_bits_mask == mask; // @[Monitor.scala 110:30]
  wire  _T_195 = io_in_a_bits_opcode == 3'h0; // @[Monitor.scala 114:25]
  wire  _T_218 = _source_ok_T_4 & _T_37; // @[Monitor.scala 115:71]
  wire  _T_236 = io_in_a_bits_opcode == 3'h1; // @[Monitor.scala 122:25]
  wire [7:0] _T_273 = ~mask; // @[Monitor.scala 127:33]
  wire [7:0] _T_274 = io_in_a_bits_mask & _T_273; // @[Monitor.scala 127:31]
  wire  _T_275 = _T_274 == 8'h0; // @[Monitor.scala 127:40]
  wire  _T_279 = io_in_a_bits_opcode == 3'h2; // @[Monitor.scala 130:25]
  wire  _T_309 = io_in_a_bits_param <= 3'h4; // @[Bundles.scala 138:33]
  wire  _T_317 = io_in_a_bits_opcode == 3'h3; // @[Monitor.scala 138:25]
  wire  _T_347 = io_in_a_bits_param <= 3'h3; // @[Bundles.scala 145:30]
  wire  _T_355 = io_in_a_bits_opcode == 3'h5; // @[Monitor.scala 146:25]
  wire  _T_385 = io_in_a_bits_param <= 3'h1; // @[Bundles.scala 158:28]
  wire  _T_397 = io_in_d_bits_opcode <= 3'h6; // @[Bundles.scala 42:24]
  wire  _source_ok_T_10 = io_in_d_bits_source <= 9'h12f; // @[Parameters.scala 57:20]
  wire  _T_401 = io_in_d_bits_opcode == 3'h6; // @[Monitor.scala 310:25]
  wire  _T_405 = io_in_d_bits_size >= 2'h3; // @[Monitor.scala 312:27]
  wire  _T_421 = io_in_d_bits_opcode == 3'h4; // @[Monitor.scala 318:25]
  wire  _T_449 = io_in_d_bits_opcode == 3'h5; // @[Monitor.scala 328:25]
  wire  _T_478 = io_in_d_bits_opcode == 3'h0; // @[Monitor.scala 338:25]
  wire  _T_495 = io_in_d_bits_opcode == 3'h1; // @[Monitor.scala 346:25]
  wire  _T_513 = io_in_d_bits_opcode == 3'h2; // @[Monitor.scala 354:25]
  wire  a_first_done = io_in_a_ready & io_in_a_valid; // @[Decoupled.scala 50:35]
  reg  a_first_counter; // @[Edges.scala 228:27]
  wire  a_first_counter1 = a_first_counter - 1'h1; // @[Edges.scala 229:28]
  wire  a_first = ~a_first_counter; // @[Edges.scala 230:25]
  reg [2:0] opcode; // @[Monitor.scala 384:22]
  reg [2:0] param; // @[Monitor.scala 385:22]
  reg [1:0] size; // @[Monitor.scala 386:22]
  reg [8:0] source; // @[Monitor.scala 387:22]
  reg [27:0] address; // @[Monitor.scala 388:22]
  wire  _T_543 = io_in_a_valid & ~a_first; // @[Monitor.scala 389:19]
  wire  _T_544 = io_in_a_bits_opcode == opcode; // @[Monitor.scala 390:32]
  wire  _T_548 = io_in_a_bits_param == param; // @[Monitor.scala 391:32]
  wire  _T_552 = io_in_a_bits_size == size; // @[Monitor.scala 392:32]
  wire  _T_556 = io_in_a_bits_source == source; // @[Monitor.scala 393:32]
  wire  _T_560 = io_in_a_bits_address == address; // @[Monitor.scala 394:32]
  wire  d_first_done = io_in_d_ready & io_in_d_valid; // @[Decoupled.scala 50:35]
  reg  d_first_counter; // @[Edges.scala 228:27]
  wire  d_first_counter1 = d_first_counter - 1'h1; // @[Edges.scala 229:28]
  wire  d_first = ~d_first_counter; // @[Edges.scala 230:25]
  reg [2:0] opcode_1; // @[Monitor.scala 535:22]
  reg [1:0] size_1; // @[Monitor.scala 537:22]
  reg [8:0] source_1; // @[Monitor.scala 538:22]
  wire  _T_567 = io_in_d_valid & ~d_first; // @[Monitor.scala 541:19]
  wire  _T_568 = io_in_d_bits_opcode == opcode_1; // @[Monitor.scala 542:29]
  wire  _T_576 = io_in_d_bits_size == size_1; // @[Monitor.scala 544:29]
  wire  _T_580 = io_in_d_bits_source == source_1; // @[Monitor.scala 545:29]
  reg [303:0] inflight; // @[Monitor.scala 611:27]
  reg [1215:0] inflight_opcodes; // @[Monitor.scala 613:35]
  reg [1215:0] inflight_sizes; // @[Monitor.scala 615:33]
  reg  a_first_counter_1; // @[Edges.scala 228:27]
  wire  a_first_counter1_1 = a_first_counter_1 - 1'h1; // @[Edges.scala 229:28]
  wire  a_first_1 = ~a_first_counter_1; // @[Edges.scala 230:25]
  reg  d_first_counter_1; // @[Edges.scala 228:27]
  wire  d_first_counter1_1 = d_first_counter_1 - 1'h1; // @[Edges.scala 229:28]
  wire  d_first_1 = ~d_first_counter_1; // @[Edges.scala 230:25]
  wire [10:0] _GEN_72 = {io_in_d_bits_source, 2'h0}; // @[Monitor.scala 634:69]
  wire [11:0] _a_opcode_lookup_T = {{1'd0}, _GEN_72}; // @[Monitor.scala 634:69]
  wire [1215:0] _a_opcode_lookup_T_1 = inflight_opcodes >> _a_opcode_lookup_T; // @[Monitor.scala 634:44]
  wire [15:0] _a_opcode_lookup_T_5 = 16'h10 - 16'h1; // @[Monitor.scala 609:57]
  wire [1215:0] _GEN_73 = {{1200'd0}, _a_opcode_lookup_T_5}; // @[Monitor.scala 634:97]
  wire [1215:0] _a_opcode_lookup_T_6 = _a_opcode_lookup_T_1 & _GEN_73; // @[Monitor.scala 634:97]
  wire [1215:0] _a_opcode_lookup_T_7 = {{1'd0}, _a_opcode_lookup_T_6[1215:1]}; // @[Monitor.scala 634:152]
  wire [1215:0] _a_size_lookup_T_1 = inflight_sizes >> _a_opcode_lookup_T; // @[Monitor.scala 638:40]
  wire [1215:0] _a_size_lookup_T_6 = _a_size_lookup_T_1 & _GEN_73; // @[Monitor.scala 638:91]
  wire [1215:0] _a_size_lookup_T_7 = {{1'd0}, _a_size_lookup_T_6[1215:1]}; // @[Monitor.scala 638:144]
  wire  _T_594 = io_in_a_valid & a_first_1; // @[Monitor.scala 648:26]
  wire [511:0] _a_set_wo_ready_T = 512'h1 << io_in_a_bits_source; // @[OneHot.scala 57:35]
  wire [511:0] _GEN_15 = io_in_a_valid & a_first_1 ? _a_set_wo_ready_T : 512'h0; // @[Monitor.scala 648:71 649:22]
  wire  _T_597 = a_first_done & a_first_1; // @[Monitor.scala 652:27]
  wire [3:0] _a_opcodes_set_interm_T = {io_in_a_bits_opcode, 1'h0}; // @[Monitor.scala 654:53]
  wire [3:0] _a_opcodes_set_interm_T_1 = _a_opcodes_set_interm_T | 4'h1; // @[Monitor.scala 654:61]
  wire [2:0] _a_sizes_set_interm_T = {io_in_a_bits_size, 1'h0}; // @[Monitor.scala 655:51]
  wire [2:0] _a_sizes_set_interm_T_1 = _a_sizes_set_interm_T | 3'h1; // @[Monitor.scala 655:59]
  wire [10:0] _GEN_78 = {io_in_a_bits_source, 2'h0}; // @[Monitor.scala 656:79]
  wire [11:0] _a_opcodes_set_T = {{1'd0}, _GEN_78}; // @[Monitor.scala 656:79]
  wire [3:0] a_opcodes_set_interm = a_first_done & a_first_1 ? _a_opcodes_set_interm_T_1 : 4'h0; // @[Monitor.scala 652:72 654:28]
  wire [4098:0] _GEN_1 = {{4095'd0}, a_opcodes_set_interm}; // @[Monitor.scala 656:54]
  wire [4098:0] _a_opcodes_set_T_1 = _GEN_1 << _a_opcodes_set_T; // @[Monitor.scala 656:54]
  wire [2:0] a_sizes_set_interm = a_first_done & a_first_1 ? _a_sizes_set_interm_T_1 : 3'h0; // @[Monitor.scala 652:72 655:28]
  wire [4097:0] _GEN_2 = {{4095'd0}, a_sizes_set_interm}; // @[Monitor.scala 657:52]
  wire [4097:0] _a_sizes_set_T_1 = _GEN_2 << _a_opcodes_set_T; // @[Monitor.scala 657:52]
  wire [303:0] _T_599 = inflight >> io_in_a_bits_source; // @[Monitor.scala 658:26]
  wire  _T_601 = ~_T_599[0]; // @[Monitor.scala 658:17]
  wire [511:0] _GEN_16 = a_first_done & a_first_1 ? _a_set_wo_ready_T : 512'h0; // @[Monitor.scala 652:72 653:28]
  wire [4098:0] _GEN_19 = a_first_done & a_first_1 ? _a_opcodes_set_T_1 : 4099'h0; // @[Monitor.scala 652:72 656:28]
  wire [4097:0] _GEN_20 = a_first_done & a_first_1 ? _a_sizes_set_T_1 : 4098'h0; // @[Monitor.scala 652:72 657:28]
  wire  _T_605 = io_in_d_valid & d_first_1; // @[Monitor.scala 671:26]
  wire  _T_607 = ~_T_401; // @[Monitor.scala 671:74]
  wire  _T_608 = io_in_d_valid & d_first_1 & ~_T_401; // @[Monitor.scala 671:71]
  wire [511:0] _d_clr_wo_ready_T = 512'h1 << io_in_d_bits_source; // @[OneHot.scala 57:35]
  wire [511:0] _GEN_21 = io_in_d_valid & d_first_1 & ~_T_401 ? _d_clr_wo_ready_T : 512'h0; // @[Monitor.scala 671:90 672:22]
  wire [4110:0] _GEN_3 = {{4095'd0}, _a_opcode_lookup_T_5}; // @[Monitor.scala 677:76]
  wire [4110:0] _d_opcodes_clr_T_5 = _GEN_3 << _a_opcode_lookup_T; // @[Monitor.scala 677:76]
  wire [511:0] _GEN_22 = d_first_done & d_first_1 & _T_607 ? _d_clr_wo_ready_T : 512'h0; // @[Monitor.scala 675:91 676:21]
  wire [4110:0] _GEN_23 = d_first_done & d_first_1 & _T_607 ? _d_opcodes_clr_T_5 : 4111'h0; // @[Monitor.scala 675:91 677:21]
  wire  _same_cycle_resp_T_2 = io_in_a_bits_source == io_in_d_bits_source; // @[Monitor.scala 681:113]
  wire  same_cycle_resp = _T_594 & io_in_a_bits_source == io_in_d_bits_source; // @[Monitor.scala 681:88]
  wire [303:0] _T_618 = inflight >> io_in_d_bits_source; // @[Monitor.scala 682:25]
  wire  _T_620 = _T_618[0] | same_cycle_resp; // @[Monitor.scala 682:49]
  wire [2:0] _GEN_27 = 3'h2 == io_in_a_bits_opcode ? 3'h1 : 3'h0; // @[Monitor.scala 685:{38,38}]
  wire [2:0] _GEN_28 = 3'h3 == io_in_a_bits_opcode ? 3'h1 : _GEN_27; // @[Monitor.scala 685:{38,38}]
  wire [2:0] _GEN_29 = 3'h4 == io_in_a_bits_opcode ? 3'h1 : _GEN_28; // @[Monitor.scala 685:{38,38}]
  wire [2:0] _GEN_30 = 3'h5 == io_in_a_bits_opcode ? 3'h2 : _GEN_29; // @[Monitor.scala 685:{38,38}]
  wire [2:0] _GEN_31 = 3'h6 == io_in_a_bits_opcode ? 3'h4 : _GEN_30; // @[Monitor.scala 685:{38,38}]
  wire [2:0] _GEN_32 = 3'h7 == io_in_a_bits_opcode ? 3'h4 : _GEN_31; // @[Monitor.scala 685:{38,38}]
  wire [2:0] _GEN_39 = 3'h6 == io_in_a_bits_opcode ? 3'h5 : _GEN_30; // @[Monitor.scala 686:{39,39}]
  wire [2:0] _GEN_40 = 3'h7 == io_in_a_bits_opcode ? 3'h4 : _GEN_39; // @[Monitor.scala 686:{39,39}]
  wire  _T_625 = io_in_d_bits_opcode == _GEN_40; // @[Monitor.scala 686:39]
  wire  _T_626 = io_in_d_bits_opcode == _GEN_32 | _T_625; // @[Monitor.scala 685:77]
  wire  _T_630 = io_in_a_bits_size == io_in_d_bits_size; // @[Monitor.scala 687:36]
  wire [3:0] a_opcode_lookup = _a_opcode_lookup_T_7[3:0];
  wire [2:0] _GEN_43 = 3'h2 == a_opcode_lookup[2:0] ? 3'h1 : 3'h0; // @[Monitor.scala 689:{38,38}]
  wire [2:0] _GEN_44 = 3'h3 == a_opcode_lookup[2:0] ? 3'h1 : _GEN_43; // @[Monitor.scala 689:{38,38}]
  wire [2:0] _GEN_45 = 3'h4 == a_opcode_lookup[2:0] ? 3'h1 : _GEN_44; // @[Monitor.scala 689:{38,38}]
  wire [2:0] _GEN_46 = 3'h5 == a_opcode_lookup[2:0] ? 3'h2 : _GEN_45; // @[Monitor.scala 689:{38,38}]
  wire [2:0] _GEN_47 = 3'h6 == a_opcode_lookup[2:0] ? 3'h4 : _GEN_46; // @[Monitor.scala 689:{38,38}]
  wire [2:0] _GEN_48 = 3'h7 == a_opcode_lookup[2:0] ? 3'h4 : _GEN_47; // @[Monitor.scala 689:{38,38}]
  wire [2:0] _GEN_55 = 3'h6 == a_opcode_lookup[2:0] ? 3'h5 : _GEN_46; // @[Monitor.scala 690:{38,38}]
  wire [2:0] _GEN_56 = 3'h7 == a_opcode_lookup[2:0] ? 3'h4 : _GEN_55; // @[Monitor.scala 690:{38,38}]
  wire  _T_637 = io_in_d_bits_opcode == _GEN_56; // @[Monitor.scala 690:38]
  wire  _T_638 = io_in_d_bits_opcode == _GEN_48 | _T_637; // @[Monitor.scala 689:72]
  wire [3:0] a_size_lookup = _a_size_lookup_T_7[3:0];
  wire [3:0] _GEN_82 = {{2'd0}, io_in_d_bits_size}; // @[Monitor.scala 691:36]
  wire  _T_642 = _GEN_82 == a_size_lookup; // @[Monitor.scala 691:36]
  wire  _T_652 = _T_605 & a_first_1 & io_in_a_valid & _same_cycle_resp_T_2 & _T_607; // @[Monitor.scala 694:116]
  wire  _T_654 = ~io_in_d_ready | io_in_a_ready; // @[Monitor.scala 695:32]
  wire [303:0] a_set_wo_ready = _GEN_15[303:0];
  wire [303:0] d_clr_wo_ready = _GEN_21[303:0];
  wire  _T_661 = a_set_wo_ready != d_clr_wo_ready | ~(|a_set_wo_ready); // @[Monitor.scala 699:48]
  wire [303:0] a_set = _GEN_16[303:0];
  wire [303:0] _inflight_T = inflight | a_set; // @[Monitor.scala 702:27]
  wire [303:0] d_clr = _GEN_22[303:0];
  wire [303:0] _inflight_T_1 = ~d_clr; // @[Monitor.scala 702:38]
  wire [303:0] _inflight_T_2 = _inflight_T & _inflight_T_1; // @[Monitor.scala 702:36]
  wire [1215:0] a_opcodes_set = _GEN_19[1215:0];
  wire [1215:0] _inflight_opcodes_T = inflight_opcodes | a_opcodes_set; // @[Monitor.scala 703:43]
  wire [1215:0] d_opcodes_clr = _GEN_23[1215:0];
  wire [1215:0] _inflight_opcodes_T_1 = ~d_opcodes_clr; // @[Monitor.scala 703:62]
  wire [1215:0] _inflight_opcodes_T_2 = _inflight_opcodes_T & _inflight_opcodes_T_1; // @[Monitor.scala 703:60]
  wire [1215:0] a_sizes_set = _GEN_20[1215:0];
  wire [1215:0] _inflight_sizes_T = inflight_sizes | a_sizes_set; // @[Monitor.scala 704:39]
  wire [1215:0] _inflight_sizes_T_2 = _inflight_sizes_T & _inflight_opcodes_T_1; // @[Monitor.scala 704:54]
  reg [31:0] watchdog; // @[Monitor.scala 706:27]
  wire  _T_670 = ~(|inflight) | plusarg_reader_out == 32'h0 | watchdog < plusarg_reader_out; // @[Monitor.scala 709:47]
  wire [31:0] _watchdog_T_1 = watchdog + 32'h1; // @[Monitor.scala 711:26]
  reg [303:0] inflight_1; // @[Monitor.scala 723:35]
  reg [1215:0] inflight_sizes_1; // @[Monitor.scala 725:35]
  reg  d_first_counter_2; // @[Edges.scala 228:27]
  wire  d_first_counter1_2 = d_first_counter_2 - 1'h1; // @[Edges.scala 229:28]
  wire  d_first_2 = ~d_first_counter_2; // @[Edges.scala 230:25]
  wire [1215:0] _c_size_lookup_T_1 = inflight_sizes_1 >> _a_opcode_lookup_T; // @[Monitor.scala 747:42]
  wire [1215:0] _c_size_lookup_T_6 = _c_size_lookup_T_1 & _GEN_73; // @[Monitor.scala 747:93]
  wire [1215:0] _c_size_lookup_T_7 = {{1'd0}, _c_size_lookup_T_6[1215:1]}; // @[Monitor.scala 747:146]
  wire  _T_696 = io_in_d_valid & d_first_2 & _T_401; // @[Monitor.scala 779:71]
  wire [511:0] _GEN_67 = d_first_done & d_first_2 & _T_401 ? _d_clr_wo_ready_T : 512'h0; // @[Monitor.scala 783:90 784:21]
  wire [4110:0] _GEN_68 = d_first_done & d_first_2 & _T_401 ? _d_opcodes_clr_T_5 : 4111'h0; // @[Monitor.scala 783:90 785:21]
  wire [303:0] _T_704 = inflight_1 >> io_in_d_bits_source; // @[Monitor.scala 791:25]
  wire [3:0] c_size_lookup = _c_size_lookup_T_7[3:0];
  wire  _T_714 = _GEN_82 == c_size_lookup; // @[Monitor.scala 795:36]
  wire [303:0] d_clr_1 = _GEN_67[303:0];
  wire [303:0] _inflight_T_4 = ~d_clr_1; // @[Monitor.scala 809:46]
  wire [303:0] _inflight_T_5 = inflight_1 & _inflight_T_4; // @[Monitor.scala 809:44]
  wire [1215:0] d_opcodes_clr_1 = _GEN_68[1215:0];
  wire [1215:0] _inflight_opcodes_T_4 = ~d_opcodes_clr_1; // @[Monitor.scala 810:62]
  wire [1215:0] _inflight_sizes_T_5 = inflight_sizes_1 & _inflight_opcodes_T_4; // @[Monitor.scala 811:56]
  reg [31:0] watchdog_1; // @[Monitor.scala 813:27]
  wire  _T_739 = ~(|inflight_1) | plusarg_reader_1_out == 32'h0 | watchdog_1 < plusarg_reader_1_out; // @[Monitor.scala 816:47]
  wire [31:0] _watchdog_T_3 = watchdog_1 + 32'h1; // @[Monitor.scala 818:26]
  plusarg_reader #(.FORMAT("tilelink_timeout=%d"), .DEFAULT(0), .WIDTH(32)) plusarg_reader ( // @[PlusArg.scala 80:11]
    .out(plusarg_reader_out)
  );
  plusarg_reader #(.FORMAT("tilelink_timeout=%d"), .DEFAULT(0), .WIDTH(32)) plusarg_reader_1 ( // @[PlusArg.scala 80:11]
    .out(plusarg_reader_1_out)
  );
  always @(posedge clock) begin
    if (reset) begin // @[Edges.scala 228:27]
      a_first_counter <= 1'h0; // @[Edges.scala 228:27]
    end else if (a_first_done) begin // @[Edges.scala 234:17]
      if (a_first) begin // @[Edges.scala 235:21]
        a_first_counter <= 1'h0;
      end else begin
        a_first_counter <= a_first_counter1;
      end
    end
    if (a_first_done & a_first) begin // @[Monitor.scala 396:32]
      opcode <= io_in_a_bits_opcode; // @[Monitor.scala 397:15]
    end
    if (a_first_done & a_first) begin // @[Monitor.scala 396:32]
      param <= io_in_a_bits_param; // @[Monitor.scala 398:15]
    end
    if (a_first_done & a_first) begin // @[Monitor.scala 396:32]
      size <= io_in_a_bits_size; // @[Monitor.scala 399:15]
    end
    if (a_first_done & a_first) begin // @[Monitor.scala 396:32]
      source <= io_in_a_bits_source; // @[Monitor.scala 400:15]
    end
    if (a_first_done & a_first) begin // @[Monitor.scala 396:32]
      address <= io_in_a_bits_address; // @[Monitor.scala 401:15]
    end
    if (reset) begin // @[Edges.scala 228:27]
      d_first_counter <= 1'h0; // @[Edges.scala 228:27]
    end else if (d_first_done) begin // @[Edges.scala 234:17]
      if (d_first) begin // @[Edges.scala 235:21]
        d_first_counter <= 1'h0;
      end else begin
        d_first_counter <= d_first_counter1;
      end
    end
    if (d_first_done & d_first) begin // @[Monitor.scala 549:32]
      opcode_1 <= io_in_d_bits_opcode; // @[Monitor.scala 550:15]
    end
    if (d_first_done & d_first) begin // @[Monitor.scala 549:32]
      size_1 <= io_in_d_bits_size; // @[Monitor.scala 552:15]
    end
    if (d_first_done & d_first) begin // @[Monitor.scala 549:32]
      source_1 <= io_in_d_bits_source; // @[Monitor.scala 553:15]
    end
    if (reset) begin // @[Monitor.scala 611:27]
      inflight <= 304'h0; // @[Monitor.scala 611:27]
    end else begin
      inflight <= _inflight_T_2; // @[Monitor.scala 702:14]
    end
    if (reset) begin // @[Monitor.scala 613:35]
      inflight_opcodes <= 1216'h0; // @[Monitor.scala 613:35]
    end else begin
      inflight_opcodes <= _inflight_opcodes_T_2; // @[Monitor.scala 703:22]
    end
    if (reset) begin // @[Monitor.scala 615:33]
      inflight_sizes <= 1216'h0; // @[Monitor.scala 615:33]
    end else begin
      inflight_sizes <= _inflight_sizes_T_2; // @[Monitor.scala 704:20]
    end
    if (reset) begin // @[Edges.scala 228:27]
      a_first_counter_1 <= 1'h0; // @[Edges.scala 228:27]
    end else if (a_first_done) begin // @[Edges.scala 234:17]
      if (a_first_1) begin // @[Edges.scala 235:21]
        a_first_counter_1 <= 1'h0;
      end else begin
        a_first_counter_1 <= a_first_counter1_1;
      end
    end
    if (reset) begin // @[Edges.scala 228:27]
      d_first_counter_1 <= 1'h0; // @[Edges.scala 228:27]
    end else if (d_first_done) begin // @[Edges.scala 234:17]
      if (d_first_1) begin // @[Edges.scala 235:21]
        d_first_counter_1 <= 1'h0;
      end else begin
        d_first_counter_1 <= d_first_counter1_1;
      end
    end
    if (reset) begin // @[Monitor.scala 706:27]
      watchdog <= 32'h0; // @[Monitor.scala 706:27]
    end else if (a_first_done | d_first_done) begin // @[Monitor.scala 712:47]
      watchdog <= 32'h0; // @[Monitor.scala 712:58]
    end else begin
      watchdog <= _watchdog_T_1; // @[Monitor.scala 711:14]
    end
    if (reset) begin // @[Monitor.scala 723:35]
      inflight_1 <= 304'h0; // @[Monitor.scala 723:35]
    end else begin
      inflight_1 <= _inflight_T_5; // @[Monitor.scala 809:22]
    end
    if (reset) begin // @[Monitor.scala 725:35]
      inflight_sizes_1 <= 1216'h0; // @[Monitor.scala 725:35]
    end else begin
      inflight_sizes_1 <= _inflight_sizes_T_5; // @[Monitor.scala 811:22]
    end
    if (reset) begin // @[Edges.scala 228:27]
      d_first_counter_2 <= 1'h0; // @[Edges.scala 228:27]
    end else if (d_first_done) begin // @[Edges.scala 234:17]
      if (d_first_2) begin // @[Edges.scala 235:21]
        d_first_counter_2 <= 1'h0;
      end else begin
        d_first_counter_2 <= d_first_counter1_2;
      end
    end
    if (reset) begin // @[Monitor.scala 813:27]
      watchdog_1 <= 32'h0; // @[Monitor.scala 813:27]
    end else if (d_first_done) begin // @[Monitor.scala 819:47]
      watchdog_1 <= 32'h0; // @[Monitor.scala 819:58]
    end else begin
      watchdog_1 <= _watchdog_T_3; // @[Monitor.scala 818:14]
    end
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (io_in_a_valid & _T_20 & ~reset) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_20 & ~reset) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel carries AcquireBlock type which is unexpected using diplomatic parameters (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (io_in_a_valid & _T_20 & ~reset) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_20 & ~reset) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel carries AcquireBlock from a client which does not support Probe (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_10 & (io_in_a_valid & _T_20 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_20 & ~reset & _T_10) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel AcquireBlock carries invalid source ID (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_mask_T & (io_in_a_valid & _T_20 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_20 & ~reset & ~_mask_T) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel AcquireBlock smaller than a beat (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~is_aligned & (io_in_a_valid & _T_20 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_20 & ~reset & ~is_aligned) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel AcquireBlock address not aligned to size (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_69 & (io_in_a_valid & _T_20 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_20 & ~reset & ~_T_69) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel AcquireBlock carries invalid grow param (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_74 & (io_in_a_valid & _T_20 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_20 & ~reset & ~_T_74) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel AcquireBlock contains invalid mask (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_78 & (io_in_a_valid & _T_20 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_20 & ~reset & ~_T_78) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel AcquireBlock is corrupt (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (io_in_a_valid & _T_82 & ~reset) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_82 & ~reset) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel carries AcquirePerm type which is unexpected using diplomatic parameters (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (io_in_a_valid & _T_82 & ~reset) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_82 & ~reset) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel carries AcquirePerm from a client which does not support Probe (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_10 & (io_in_a_valid & _T_82 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_82 & ~reset & _T_10) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel AcquirePerm carries invalid source ID (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_mask_T & (io_in_a_valid & _T_82 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_82 & ~reset & ~_mask_T) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel AcquirePerm smaller than a beat (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~is_aligned & (io_in_a_valid & _T_82 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_82 & ~reset & ~is_aligned) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel AcquirePerm address not aligned to size (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_69 & (io_in_a_valid & _T_82 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_82 & ~reset & ~_T_69) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel AcquirePerm carries invalid grow param (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_135 & (io_in_a_valid & _T_82 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_82 & ~reset & ~_T_135) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel AcquirePerm requests NtoB (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_74 & (io_in_a_valid & _T_82 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_82 & ~reset & ~_T_74) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel AcquirePerm contains invalid mask (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_78 & (io_in_a_valid & _T_82 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_82 & ~reset & ~_T_78) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel AcquirePerm is corrupt (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_10 & (io_in_a_valid & _T_148 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_148 & ~reset & _T_10) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel carries Get type which master claims it can't emit (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_37 & (io_in_a_valid & _T_148 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_148 & ~reset & ~_T_37) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel carries Get type which slave claims it can't support (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_10 & (io_in_a_valid & _T_148 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_148 & ~reset & _T_10) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel Get carries invalid source ID (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~is_aligned & (io_in_a_valid & _T_148 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_148 & ~reset & ~is_aligned) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel Get address not aligned to size (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_183 & (io_in_a_valid & _T_148 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_148 & ~reset & ~_T_183) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel Get carries invalid param (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_187 & (io_in_a_valid & _T_148 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_148 & ~reset & ~_T_187) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel Get contains invalid mask (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_78 & (io_in_a_valid & _T_148 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_148 & ~reset & ~_T_78) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel Get is corrupt (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_218 & (io_in_a_valid & _T_195 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_195 & ~reset & ~_T_218) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel carries PutFull type which is unexpected using diplomatic parameters (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_10 & (io_in_a_valid & _T_195 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_195 & ~reset & _T_10) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel PutFull carries invalid source ID (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~is_aligned & (io_in_a_valid & _T_195 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_195 & ~reset & ~is_aligned) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel PutFull address not aligned to size (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_183 & (io_in_a_valid & _T_195 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_195 & ~reset & ~_T_183) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel PutFull carries invalid param (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_187 & (io_in_a_valid & _T_195 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_195 & ~reset & ~_T_187) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel PutFull contains invalid mask (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_218 & (io_in_a_valid & _T_236 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_236 & ~reset & ~_T_218) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel carries PutPartial type which is unexpected using diplomatic parameters (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_10 & (io_in_a_valid & _T_236 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_236 & ~reset & _T_10) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel PutPartial carries invalid source ID (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~is_aligned & (io_in_a_valid & _T_236 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_236 & ~reset & ~is_aligned) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel PutPartial address not aligned to size (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_183 & (io_in_a_valid & _T_236 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_236 & ~reset & ~_T_183) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel PutPartial carries invalid param (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_275 & (io_in_a_valid & _T_236 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_236 & ~reset & ~_T_275) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel PutPartial contains invalid mask (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (io_in_a_valid & _T_279 & ~reset) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_279 & ~reset) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel carries Arithmetic type which is unexpected using diplomatic parameters (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_10 & (io_in_a_valid & _T_279 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_279 & ~reset & _T_10) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel Arithmetic carries invalid source ID (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~is_aligned & (io_in_a_valid & _T_279 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_279 & ~reset & ~is_aligned) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel Arithmetic address not aligned to size (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_309 & (io_in_a_valid & _T_279 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_279 & ~reset & ~_T_309) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel Arithmetic carries invalid opcode param (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_187 & (io_in_a_valid & _T_279 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_279 & ~reset & ~_T_187) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel Arithmetic contains invalid mask (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (io_in_a_valid & _T_317 & ~reset) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_317 & ~reset) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel carries Logical type which is unexpected using diplomatic parameters (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_10 & (io_in_a_valid & _T_317 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_317 & ~reset & _T_10) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel Logical carries invalid source ID (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~is_aligned & (io_in_a_valid & _T_317 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_317 & ~reset & ~is_aligned) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel Logical address not aligned to size (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_347 & (io_in_a_valid & _T_317 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_317 & ~reset & ~_T_347) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel Logical carries invalid opcode param (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_187 & (io_in_a_valid & _T_317 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_317 & ~reset & ~_T_187) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel Logical contains invalid mask (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (io_in_a_valid & _T_355 & ~reset) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_355 & ~reset) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel carries Hint type which is unexpected using diplomatic parameters (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_10 & (io_in_a_valid & _T_355 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_355 & ~reset & _T_10) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel Hint carries invalid source ID (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~is_aligned & (io_in_a_valid & _T_355 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_355 & ~reset & ~is_aligned) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel Hint address not aligned to size (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_385 & (io_in_a_valid & _T_355 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_355 & ~reset & ~_T_385) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel Hint carries invalid opcode param (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_187 & (io_in_a_valid & _T_355 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_355 & ~reset & ~_T_187) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel Hint contains invalid mask (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_78 & (io_in_a_valid & _T_355 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_a_valid & _T_355 & ~reset & ~_T_78) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel Hint is corrupt (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_397 & (io_in_d_valid & _T_2)) begin
          $fatal; // @[Monitor.scala 49:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_d_valid & _T_2 & ~_T_397) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'D' channel has invalid opcode (connected at Plic.scala:362:15)\n    at Monitor.scala:49 assert(cond, message)\n"
            ); // @[Monitor.scala 49:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_source_ok_T_10 & (io_in_d_valid & _T_401 & _T_2)) begin
          $fatal; // @[Monitor.scala 49:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_d_valid & _T_401 & _T_2 & ~_source_ok_T_10) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'D' channel ReleaseAck carries invalid source ID (connected at Plic.scala:362:15)\n    at Monitor.scala:49 assert(cond, message)\n"
            ); // @[Monitor.scala 49:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_405 & (io_in_d_valid & _T_401 & _T_2)) begin
          $fatal; // @[Monitor.scala 49:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_d_valid & _T_401 & _T_2 & ~_T_405) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'D' channel ReleaseAck smaller than a beat (connected at Plic.scala:362:15)\n    at Monitor.scala:49 assert(cond, message)\n"
            ); // @[Monitor.scala 49:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_source_ok_T_10 & (io_in_d_valid & _T_421 & _T_2)) begin
          $fatal; // @[Monitor.scala 49:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_d_valid & _T_421 & _T_2 & ~_source_ok_T_10) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'D' channel Grant carries invalid source ID (connected at Plic.scala:362:15)\n    at Monitor.scala:49 assert(cond, message)\n"
            ); // @[Monitor.scala 49:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (io_in_d_valid & _T_421 & _T_2) begin
          $fatal; // @[Monitor.scala 49:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_d_valid & _T_421 & _T_2) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'D' channel Grant carries invalid sink ID (connected at Plic.scala:362:15)\n    at Monitor.scala:49 assert(cond, message)\n"
            ); // @[Monitor.scala 49:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_405 & (io_in_d_valid & _T_421 & _T_2)) begin
          $fatal; // @[Monitor.scala 49:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_d_valid & _T_421 & _T_2 & ~_T_405) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'D' channel Grant smaller than a beat (connected at Plic.scala:362:15)\n    at Monitor.scala:49 assert(cond, message)\n"
            ); // @[Monitor.scala 49:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_source_ok_T_10 & (io_in_d_valid & _T_449 & _T_2)) begin
          $fatal; // @[Monitor.scala 49:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_d_valid & _T_449 & _T_2 & ~_source_ok_T_10) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'D' channel GrantData carries invalid source ID (connected at Plic.scala:362:15)\n    at Monitor.scala:49 assert(cond, message)\n"
            ); // @[Monitor.scala 49:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (io_in_d_valid & _T_449 & _T_2) begin
          $fatal; // @[Monitor.scala 49:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_d_valid & _T_449 & _T_2) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'D' channel GrantData carries invalid sink ID (connected at Plic.scala:362:15)\n    at Monitor.scala:49 assert(cond, message)\n"
            ); // @[Monitor.scala 49:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_405 & (io_in_d_valid & _T_449 & _T_2)) begin
          $fatal; // @[Monitor.scala 49:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_d_valid & _T_449 & _T_2 & ~_T_405) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'D' channel GrantData smaller than a beat (connected at Plic.scala:362:15)\n    at Monitor.scala:49 assert(cond, message)\n"
            ); // @[Monitor.scala 49:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_source_ok_T_10 & (io_in_d_valid & _T_478 & _T_2)) begin
          $fatal; // @[Monitor.scala 49:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_d_valid & _T_478 & _T_2 & ~_source_ok_T_10) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'D' channel AccessAck carries invalid source ID (connected at Plic.scala:362:15)\n    at Monitor.scala:49 assert(cond, message)\n"
            ); // @[Monitor.scala 49:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_source_ok_T_10 & (io_in_d_valid & _T_495 & _T_2)) begin
          $fatal; // @[Monitor.scala 49:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_d_valid & _T_495 & _T_2 & ~_source_ok_T_10) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'D' channel AccessAckData carries invalid source ID (connected at Plic.scala:362:15)\n    at Monitor.scala:49 assert(cond, message)\n"
            ); // @[Monitor.scala 49:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_source_ok_T_10 & (io_in_d_valid & _T_513 & _T_2)) begin
          $fatal; // @[Monitor.scala 49:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_in_d_valid & _T_513 & _T_2 & ~_source_ok_T_10) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'D' channel HintAck carries invalid source ID (connected at Plic.scala:362:15)\n    at Monitor.scala:49 assert(cond, message)\n"
            ); // @[Monitor.scala 49:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_544 & (_T_543 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_543 & ~reset & ~_T_544) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel opcode changed within multibeat operation (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_548 & (_T_543 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_543 & ~reset & ~_T_548) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel param changed within multibeat operation (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_552 & (_T_543 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_543 & ~reset & ~_T_552) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel size changed within multibeat operation (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_556 & (_T_543 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_543 & ~reset & ~_T_556) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel source changed within multibeat operation (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_560 & (_T_543 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_543 & ~reset & ~_T_560) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel address changed with multibeat operation (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_568 & (_T_567 & _T_2)) begin
          $fatal; // @[Monitor.scala 49:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_567 & _T_2 & ~_T_568) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'D' channel opcode changed within multibeat operation (connected at Plic.scala:362:15)\n    at Monitor.scala:49 assert(cond, message)\n"
            ); // @[Monitor.scala 49:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_576 & (_T_567 & _T_2)) begin
          $fatal; // @[Monitor.scala 49:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_567 & _T_2 & ~_T_576) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'D' channel size changed within multibeat operation (connected at Plic.scala:362:15)\n    at Monitor.scala:49 assert(cond, message)\n"
            ); // @[Monitor.scala 49:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_580 & (_T_567 & _T_2)) begin
          $fatal; // @[Monitor.scala 49:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_567 & _T_2 & ~_T_580) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'D' channel source changed within multibeat operation (connected at Plic.scala:362:15)\n    at Monitor.scala:49 assert(cond, message)\n"
            ); // @[Monitor.scala 49:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_601 & (_T_597 & ~reset)) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_597 & ~reset & ~_T_601) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' channel re-used a source ID (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_620 & (_T_608 & _T_2)) begin
          $fatal; // @[Monitor.scala 49:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_608 & _T_2 & ~_T_620) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'D' channel acknowledged for nothing inflight (connected at Plic.scala:362:15)\n    at Monitor.scala:49 assert(cond, message)\n"
            ); // @[Monitor.scala 49:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_626 & (_T_608 & same_cycle_resp & _T_2)) begin
          $fatal; // @[Monitor.scala 49:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_608 & same_cycle_resp & _T_2 & ~_T_626) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'D' channel contains improper opcode response (connected at Plic.scala:362:15)\n    at Monitor.scala:49 assert(cond, message)\n"
            ); // @[Monitor.scala 49:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_630 & (_T_608 & same_cycle_resp & _T_2)) begin
          $fatal; // @[Monitor.scala 49:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_608 & same_cycle_resp & _T_2 & ~_T_630) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'D' channel contains improper response size (connected at Plic.scala:362:15)\n    at Monitor.scala:49 assert(cond, message)\n"
            ); // @[Monitor.scala 49:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_638 & (_T_608 & ~same_cycle_resp & _T_2)) begin
          $fatal; // @[Monitor.scala 49:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_608 & ~same_cycle_resp & _T_2 & ~_T_638) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'D' channel contains improper opcode response (connected at Plic.scala:362:15)\n    at Monitor.scala:49 assert(cond, message)\n"
            ); // @[Monitor.scala 49:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_642 & (_T_608 & ~same_cycle_resp & _T_2)) begin
          $fatal; // @[Monitor.scala 49:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_608 & ~same_cycle_resp & _T_2 & ~_T_642) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'D' channel contains improper response size (connected at Plic.scala:362:15)\n    at Monitor.scala:49 assert(cond, message)\n"
            ); // @[Monitor.scala 49:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_654 & (_T_652 & _T_2)) begin
          $fatal; // @[Monitor.scala 49:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_652 & _T_2 & ~_T_654) begin
          $fwrite(32'h80000002,"Assertion failed: ready check\n    at Monitor.scala:49 assert(cond, message)\n"); // @[Monitor.scala 49:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_661 & _T_2) begin
          $fatal; // @[Monitor.scala 49:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_2 & ~_T_661) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'A' and 'D' concurrent, despite minlatency 1 (connected at Plic.scala:362:15)\n    at Monitor.scala:49 assert(cond, message)\n"
            ); // @[Monitor.scala 49:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_670 & ~reset) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~reset & ~_T_670) begin
          $fwrite(32'h80000002,
            "Assertion failed: TileLink timeout expired (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_704[0] & (_T_696 & _T_2)) begin
          $fatal; // @[Monitor.scala 49:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_696 & _T_2 & ~_T_704[0]) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'D' channel acknowledged for nothing inflight (connected at Plic.scala:362:15)\n    at Monitor.scala:49 assert(cond, message)\n"
            ); // @[Monitor.scala 49:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_714 & (_T_696 & _T_2)) begin
          $fatal; // @[Monitor.scala 49:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_696 & _T_2 & ~_T_714) begin
          $fwrite(32'h80000002,
            "Assertion failed: 'D' channel contains improper response size (connected at Plic.scala:362:15)\n    at Monitor.scala:49 assert(cond, message)\n"
            ); // @[Monitor.scala 49:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~_T_739 & ~reset) begin
          $fatal; // @[Monitor.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~reset & ~_T_739) begin
          $fwrite(32'h80000002,
            "Assertion failed: TileLink timeout expired (connected at Plic.scala:362:15)\n    at Monitor.scala:42 assert(cond, message)\n"
            ); // @[Monitor.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  a_first_counter = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  opcode = _RAND_1[2:0];
  _RAND_2 = {1{`RANDOM}};
  param = _RAND_2[2:0];
  _RAND_3 = {1{`RANDOM}};
  size = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  source = _RAND_4[8:0];
  _RAND_5 = {1{`RANDOM}};
  address = _RAND_5[27:0];
  _RAND_6 = {1{`RANDOM}};
  d_first_counter = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  opcode_1 = _RAND_7[2:0];
  _RAND_8 = {1{`RANDOM}};
  size_1 = _RAND_8[1:0];
  _RAND_9 = {1{`RANDOM}};
  source_1 = _RAND_9[8:0];
  _RAND_10 = {10{`RANDOM}};
  inflight = _RAND_10[303:0];
  _RAND_11 = {38{`RANDOM}};
  inflight_opcodes = _RAND_11[1215:0];
  _RAND_12 = {38{`RANDOM}};
  inflight_sizes = _RAND_12[1215:0];
  _RAND_13 = {1{`RANDOM}};
  a_first_counter_1 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  d_first_counter_1 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  watchdog = _RAND_15[31:0];
  _RAND_16 = {10{`RANDOM}};
  inflight_1 = _RAND_16[303:0];
  _RAND_17 = {38{`RANDOM}};
  inflight_sizes_1 = _RAND_17[1215:0];
  _RAND_18 = {1{`RANDOM}};
  d_first_counter_2 = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  watchdog_1 = _RAND_19[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Queue_37(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input         io_enq_bits_read,
  input  [22:0] io_enq_bits_index,
  input  [63:0] io_enq_bits_data,
  input  [7:0]  io_enq_bits_mask,
  input  [8:0]  io_enq_bits_extra_tlrr_extra_source,
  input  [1:0]  io_enq_bits_extra_tlrr_extra_size,
  input         io_deq_ready,
  output        io_deq_valid,
  output        io_deq_bits_read,
  output [22:0] io_deq_bits_index,
  output [63:0] io_deq_bits_data,
  output [7:0]  io_deq_bits_mask,
  output [8:0]  io_deq_bits_extra_tlrr_extra_source,
  output [1:0]  io_deq_bits_extra_tlrr_extra_size
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  reg  ram_read [0:0]; // @[Decoupled.scala 259:95]
  wire  ram_read_io_deq_bits_MPORT_en; // @[Decoupled.scala 259:95]
  wire  ram_read_io_deq_bits_MPORT_addr; // @[Decoupled.scala 259:95]
  wire  ram_read_io_deq_bits_MPORT_data; // @[Decoupled.scala 259:95]
  wire  ram_read_MPORT_data; // @[Decoupled.scala 259:95]
  wire  ram_read_MPORT_addr; // @[Decoupled.scala 259:95]
  wire  ram_read_MPORT_mask; // @[Decoupled.scala 259:95]
  wire  ram_read_MPORT_en; // @[Decoupled.scala 259:95]
  reg [22:0] ram_index [0:0]; // @[Decoupled.scala 259:95]
  wire  ram_index_io_deq_bits_MPORT_en; // @[Decoupled.scala 259:95]
  wire  ram_index_io_deq_bits_MPORT_addr; // @[Decoupled.scala 259:95]
  wire [22:0] ram_index_io_deq_bits_MPORT_data; // @[Decoupled.scala 259:95]
  wire [22:0] ram_index_MPORT_data; // @[Decoupled.scala 259:95]
  wire  ram_index_MPORT_addr; // @[Decoupled.scala 259:95]
  wire  ram_index_MPORT_mask; // @[Decoupled.scala 259:95]
  wire  ram_index_MPORT_en; // @[Decoupled.scala 259:95]
  reg [63:0] ram_data [0:0]; // @[Decoupled.scala 259:95]
  wire  ram_data_io_deq_bits_MPORT_en; // @[Decoupled.scala 259:95]
  wire  ram_data_io_deq_bits_MPORT_addr; // @[Decoupled.scala 259:95]
  wire [63:0] ram_data_io_deq_bits_MPORT_data; // @[Decoupled.scala 259:95]
  wire [63:0] ram_data_MPORT_data; // @[Decoupled.scala 259:95]
  wire  ram_data_MPORT_addr; // @[Decoupled.scala 259:95]
  wire  ram_data_MPORT_mask; // @[Decoupled.scala 259:95]
  wire  ram_data_MPORT_en; // @[Decoupled.scala 259:95]
  reg [7:0] ram_mask [0:0]; // @[Decoupled.scala 259:95]
  wire  ram_mask_io_deq_bits_MPORT_en; // @[Decoupled.scala 259:95]
  wire  ram_mask_io_deq_bits_MPORT_addr; // @[Decoupled.scala 259:95]
  wire [7:0] ram_mask_io_deq_bits_MPORT_data; // @[Decoupled.scala 259:95]
  wire [7:0] ram_mask_MPORT_data; // @[Decoupled.scala 259:95]
  wire  ram_mask_MPORT_addr; // @[Decoupled.scala 259:95]
  wire  ram_mask_MPORT_mask; // @[Decoupled.scala 259:95]
  wire  ram_mask_MPORT_en; // @[Decoupled.scala 259:95]
  reg [8:0] ram_extra_tlrr_extra_source [0:0]; // @[Decoupled.scala 259:95]
  wire  ram_extra_tlrr_extra_source_io_deq_bits_MPORT_en; // @[Decoupled.scala 259:95]
  wire  ram_extra_tlrr_extra_source_io_deq_bits_MPORT_addr; // @[Decoupled.scala 259:95]
  wire [8:0] ram_extra_tlrr_extra_source_io_deq_bits_MPORT_data; // @[Decoupled.scala 259:95]
  wire [8:0] ram_extra_tlrr_extra_source_MPORT_data; // @[Decoupled.scala 259:95]
  wire  ram_extra_tlrr_extra_source_MPORT_addr; // @[Decoupled.scala 259:95]
  wire  ram_extra_tlrr_extra_source_MPORT_mask; // @[Decoupled.scala 259:95]
  wire  ram_extra_tlrr_extra_source_MPORT_en; // @[Decoupled.scala 259:95]
  reg [1:0] ram_extra_tlrr_extra_size [0:0]; // @[Decoupled.scala 259:95]
  wire  ram_extra_tlrr_extra_size_io_deq_bits_MPORT_en; // @[Decoupled.scala 259:95]
  wire  ram_extra_tlrr_extra_size_io_deq_bits_MPORT_addr; // @[Decoupled.scala 259:95]
  wire [1:0] ram_extra_tlrr_extra_size_io_deq_bits_MPORT_data; // @[Decoupled.scala 259:95]
  wire [1:0] ram_extra_tlrr_extra_size_MPORT_data; // @[Decoupled.scala 259:95]
  wire  ram_extra_tlrr_extra_size_MPORT_addr; // @[Decoupled.scala 259:95]
  wire  ram_extra_tlrr_extra_size_MPORT_mask; // @[Decoupled.scala 259:95]
  wire  ram_extra_tlrr_extra_size_MPORT_en; // @[Decoupled.scala 259:95]
  reg  maybe_full; // @[Decoupled.scala 262:27]
  wire  empty = ~maybe_full; // @[Decoupled.scala 264:28]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 50:35]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 50:35]
  assign ram_read_io_deq_bits_MPORT_en = 1'h1;
  assign ram_read_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_read_io_deq_bits_MPORT_data = ram_read[ram_read_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 259:95]
  assign ram_read_MPORT_data = io_enq_bits_read;
  assign ram_read_MPORT_addr = 1'h0;
  assign ram_read_MPORT_mask = 1'h1;
  assign ram_read_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_index_io_deq_bits_MPORT_en = 1'h1;
  assign ram_index_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_index_io_deq_bits_MPORT_data = ram_index[ram_index_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 259:95]
  assign ram_index_MPORT_data = io_enq_bits_index;
  assign ram_index_MPORT_addr = 1'h0;
  assign ram_index_MPORT_mask = 1'h1;
  assign ram_index_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_data_io_deq_bits_MPORT_en = 1'h1;
  assign ram_data_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_data_io_deq_bits_MPORT_data = ram_data[ram_data_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 259:95]
  assign ram_data_MPORT_data = io_enq_bits_data;
  assign ram_data_MPORT_addr = 1'h0;
  assign ram_data_MPORT_mask = 1'h1;
  assign ram_data_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_mask_io_deq_bits_MPORT_en = 1'h1;
  assign ram_mask_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_mask_io_deq_bits_MPORT_data = ram_mask[ram_mask_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 259:95]
  assign ram_mask_MPORT_data = io_enq_bits_mask;
  assign ram_mask_MPORT_addr = 1'h0;
  assign ram_mask_MPORT_mask = 1'h1;
  assign ram_mask_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_extra_tlrr_extra_source_io_deq_bits_MPORT_en = 1'h1;
  assign ram_extra_tlrr_extra_source_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_extra_tlrr_extra_source_io_deq_bits_MPORT_data =
    ram_extra_tlrr_extra_source[ram_extra_tlrr_extra_source_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 259:95]
  assign ram_extra_tlrr_extra_source_MPORT_data = io_enq_bits_extra_tlrr_extra_source;
  assign ram_extra_tlrr_extra_source_MPORT_addr = 1'h0;
  assign ram_extra_tlrr_extra_source_MPORT_mask = 1'h1;
  assign ram_extra_tlrr_extra_source_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_extra_tlrr_extra_size_io_deq_bits_MPORT_en = 1'h1;
  assign ram_extra_tlrr_extra_size_io_deq_bits_MPORT_addr = 1'h0;
  assign ram_extra_tlrr_extra_size_io_deq_bits_MPORT_data =
    ram_extra_tlrr_extra_size[ram_extra_tlrr_extra_size_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 259:95]
  assign ram_extra_tlrr_extra_size_MPORT_data = io_enq_bits_extra_tlrr_extra_size;
  assign ram_extra_tlrr_extra_size_MPORT_addr = 1'h0;
  assign ram_extra_tlrr_extra_size_MPORT_mask = 1'h1;
  assign ram_extra_tlrr_extra_size_MPORT_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = ~maybe_full; // @[Decoupled.scala 289:19]
  assign io_deq_valid = ~empty; // @[Decoupled.scala 288:19]
  assign io_deq_bits_read = ram_read_io_deq_bits_MPORT_data; // @[Decoupled.scala 296:17]
  assign io_deq_bits_index = ram_index_io_deq_bits_MPORT_data; // @[Decoupled.scala 296:17]
  assign io_deq_bits_data = ram_data_io_deq_bits_MPORT_data; // @[Decoupled.scala 296:17]
  assign io_deq_bits_mask = ram_mask_io_deq_bits_MPORT_data; // @[Decoupled.scala 296:17]
  assign io_deq_bits_extra_tlrr_extra_source = ram_extra_tlrr_extra_source_io_deq_bits_MPORT_data; // @[Decoupled.scala 296:17]
  assign io_deq_bits_extra_tlrr_extra_size = ram_extra_tlrr_extra_size_io_deq_bits_MPORT_data; // @[Decoupled.scala 296:17]
  always @(posedge clock) begin
    if (ram_read_MPORT_en & ram_read_MPORT_mask) begin
      ram_read[ram_read_MPORT_addr] <= ram_read_MPORT_data; // @[Decoupled.scala 259:95]
    end
    if (ram_index_MPORT_en & ram_index_MPORT_mask) begin
      ram_index[ram_index_MPORT_addr] <= ram_index_MPORT_data; // @[Decoupled.scala 259:95]
    end
    if (ram_data_MPORT_en & ram_data_MPORT_mask) begin
      ram_data[ram_data_MPORT_addr] <= ram_data_MPORT_data; // @[Decoupled.scala 259:95]
    end
    if (ram_mask_MPORT_en & ram_mask_MPORT_mask) begin
      ram_mask[ram_mask_MPORT_addr] <= ram_mask_MPORT_data; // @[Decoupled.scala 259:95]
    end
    if (ram_extra_tlrr_extra_source_MPORT_en & ram_extra_tlrr_extra_source_MPORT_mask) begin
      ram_extra_tlrr_extra_source[ram_extra_tlrr_extra_source_MPORT_addr] <= ram_extra_tlrr_extra_source_MPORT_data; // @[Decoupled.scala 259:95]
    end
    if (ram_extra_tlrr_extra_size_MPORT_en & ram_extra_tlrr_extra_size_MPORT_mask) begin
      ram_extra_tlrr_extra_size[ram_extra_tlrr_extra_size_MPORT_addr] <= ram_extra_tlrr_extra_size_MPORT_data; // @[Decoupled.scala 259:95]
    end
    if (reset) begin // @[Decoupled.scala 262:27]
      maybe_full <= 1'h0; // @[Decoupled.scala 262:27]
    end else if (do_enq != do_deq) begin // @[Decoupled.scala 279:27]
      maybe_full <= do_enq; // @[Decoupled.scala 280:16]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_read[initvar] = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_index[initvar] = _RAND_1[22:0];
  _RAND_2 = {2{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_data[initvar] = _RAND_2[63:0];
  _RAND_3 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_mask[initvar] = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_extra_tlrr_extra_source[initvar] = _RAND_4[8:0];
  _RAND_5 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_extra_tlrr_extra_size[initvar] = _RAND_5[1:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  maybe_full = _RAND_6[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
