module ALU(
  input         clock,
  input         reset,
  input  [31:0] io_src1_in,
  input  [31:0] io_src2_in,
  input  [3:0]  io_op_in,
  input         io_valid_in,
  input         io_flush_in,
  input  [31:0] io_pc_in,
  input  [31:0] io_imm_in,
  input         io_is_branch,
  input         io_is_jump,
  output [31:0] io_result_out,
  output        io_valid_out,
  output        io_branch_out,
  output [31:0] io_jump_addr
);
  wire [31:0] _result_T_1 = io_src1_in + io_src2_in; // @[ALU.scala 60:44]
  wire [31:0] _result_T_3 = io_src1_in - io_src2_in; // @[ALU.scala 61:44]
  wire [62:0] _GEN_20 = {{31'd0}, io_src1_in}; // @[ALU.scala 62:44]
  wire [62:0] _result_T_5 = _GEN_20 << io_src2_in[4:0]; // @[ALU.scala 62:44]
  wire [31:0] _result_T_7 = io_src1_in >> io_src2_in[4:0]; // @[ALU.scala 63:44]
  wire [31:0] _result_T_11 = $signed(io_src1_in) >>> io_src2_in[4:0]; // @[ALU.scala 64:73]
  wire [31:0] _result_T_12 = io_src1_in | io_src2_in; // @[ALU.scala 65:44]
  wire [31:0] _result_T_13 = io_src1_in & io_src2_in; // @[ALU.scala 66:44]
  wire [31:0] _result_T_14 = io_src1_in ^ io_src2_in; // @[ALU.scala 67:44]
  wire  _result_T_17 = $signed(io_src1_in) < $signed(io_src2_in); // @[ALU.scala 68:52]
  wire  _result_T_18 = io_src1_in < io_src2_in; // @[ALU.scala 69:45]
  wire  _GEN_0 = 4'h9 == io_op_in & io_src1_in < io_src2_in; // @[ALU.scala 54:10 59:20 69:30]
  wire  _GEN_1 = 4'h8 == io_op_in ? $signed(io_src1_in) < $signed(io_src2_in) : _GEN_0; // @[ALU.scala 59:20 68:30]
  wire [31:0] _GEN_2 = 4'h7 == io_op_in ? _result_T_14 : {{31'd0}, _GEN_1}; // @[ALU.scala 59:20 67:30]
  wire [31:0] _GEN_3 = 4'h6 == io_op_in ? _result_T_13 : _GEN_2; // @[ALU.scala 59:20 66:30]
  wire [31:0] _GEN_4 = 4'h5 == io_op_in ? _result_T_12 : _GEN_3; // @[ALU.scala 59:20 65:30]
  wire [31:0] _GEN_5 = 4'h4 == io_op_in ? _result_T_11 : _GEN_4; // @[ALU.scala 59:20 64:30]
  wire [31:0] _GEN_6 = 4'h3 == io_op_in ? _result_T_7 : _GEN_5; // @[ALU.scala 59:20 63:30]
  wire [62:0] _GEN_7 = 4'h2 == io_op_in ? _result_T_5 : {{31'd0}, _GEN_6}; // @[ALU.scala 59:20 62:30]
  wire [62:0] _GEN_8 = 4'h1 == io_op_in ? {{31'd0}, _result_T_3} : _GEN_7; // @[ALU.scala 59:20 61:30]
  wire [62:0] _GEN_9 = 4'h0 == io_op_in ? {{31'd0}, _result_T_1} : _GEN_8; // @[ALU.scala 59:20 60:30]
  wire  _GEN_10 = io_op_in[0] ? _result_T_18 : _result_T_17; // @[ALU.scala 78:27 79:24 81:24]
  wire  _GEN_11 = io_op_in[0] ? io_src1_in >= io_src2_in : $signed(io_src1_in) >= $signed(io_src2_in); // @[ALU.scala 85:27 86:24 88:24]
  wire  _GEN_12 = 4'hf == io_op_in & _GEN_11; // @[ALU.scala 55:16 74:22]
  wire  _GEN_13 = 4'he == io_op_in ? _GEN_10 : _GEN_12; // @[ALU.scala 74:22]
  wire  _GEN_14 = 4'hd == io_op_in ? io_src1_in != io_src2_in : _GEN_13; // @[ALU.scala 74:22 76:38]
  wire  _GEN_15 = 4'hc == io_op_in ? io_src1_in == io_src2_in : _GEN_14; // @[ALU.scala 74:22 75:38]
  wire [31:0] _next_pc_T_1 = io_pc_in + io_imm_in; // @[ALU.scala 92:43]
  wire  _GEN_16 = io_is_branch & _GEN_15; // @[ALU.scala 55:16 73:22]
  wire  branch_taken = io_is_jump | _GEN_16; // @[ALU.scala 96:20 98:18]
  wire [31:0] _next_pc_T_2 = branch_taken ? _next_pc_T_1 : 32'h0; // @[ALU.scala 92:19]
  wire [31:0] _GEN_17 = io_is_branch ? _next_pc_T_2 : 32'h0; // @[ALU.scala 56:11 73:22 92:13]
  wire [31:0] _result_T_20 = io_pc_in + 32'h4; // @[ALU.scala 97:24]
  wire [31:0] _next_pc_T_4 = io_src1_in + io_imm_in; // @[ALU.scala 101:30]
  wire [31:0] _next_pc_T_5 = _next_pc_T_4 & 32'hfffffffe; // @[ALU.scala 101:43]
  wire [31:0] _GEN_18 = io_op_in[0] ? _next_pc_T_5 : _next_pc_T_1; // @[ALU.scala 100:23 101:15 103:15]
  wire [62:0] _GEN_19 = io_is_jump ? {{31'd0}, _result_T_20} : _GEN_9; // @[ALU.scala 96:20 97:12]
  wire [31:0] next_pc = io_is_jump ? _GEN_18 : _GEN_17; // @[ALU.scala 96:20]
  wire  _io_result_out_T = ~io_flush_in; // @[ALU.scala 108:39]
  wire  _io_result_out_T_1 = io_valid_in & ~io_flush_in; // @[ALU.scala 108:36]
  wire [31:0] result = _GEN_19[31:0]; // @[ALU.scala 49:20]
  wire  _io_branch_out_T_2 = _io_result_out_T_1 & branch_taken; // @[ALU.scala 110:48]
  assign io_result_out = io_valid_in & ~io_flush_in ? result : 32'h0; // @[ALU.scala 108:23]
  assign io_valid_out = io_valid_in & _io_result_out_T; // @[ALU.scala 109:32]
  assign io_branch_out = _io_result_out_T_1 & branch_taken; // @[ALU.scala 110:48]
  assign io_jump_addr = _io_branch_out_T_2 ? next_pc : 32'h0; // @[ALU.scala 111:23]
endmodule
