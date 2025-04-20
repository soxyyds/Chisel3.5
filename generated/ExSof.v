module ExSof(
  input         clock,
  input         reset,
  input  [31:0] io_issue_in_0_rs1,
  input  [31:0] io_issue_in_0_rs2,
  input  [31:0] io_issue_in_0_imm,
  input  [3:0]  io_issue_in_0_op,
  input         io_issue_in_0_isMem,
  input  [1:0]  io_issue_in_0_memOp,
  input  [4:0]  io_issue_in_0_rd,
  input         io_issue_in_0_rdWen,
  input  [31:0] io_issue_in_1_rs1,
  input  [31:0] io_issue_in_1_rs2,
  input  [31:0] io_issue_in_1_imm,
  input  [3:0]  io_issue_in_1_op,
  input         io_issue_in_1_isMem,
  input  [1:0]  io_issue_in_1_memOp,
  input  [4:0]  io_issue_in_1_rd,
  input         io_issue_in_1_rdWen,
  input         io_valid_in_0,
  input         io_valid_in_1,
  input         io_alu_ready_in_0,
  input         io_alu_ready_in_1,
  output        io_result_ready_out_0,
  output        io_result_ready_out_1,
  output        io_ex_ctrl_out_0_writeEnable,
  output        io_ex_ctrl_out_0_isALU,
  output        io_ex_ctrl_out_0_isMem,
  output [4:0]  io_ex_ctrl_out_0_rd,
  output        io_ex_ctrl_out_0_rdWen,
  output [31:0] io_alu_data_out_0_src1,
  output [31:0] io_alu_data_out_0_src2,
  output [3:0]  io_alu_data_out_0_op,
  output        io_mem_op_out_0_isMem,
  output [1:0]  io_mem_op_out_0_memOp,
  output        io_ex_ctrl_out_1_writeEnable,
  output        io_ex_ctrl_out_1_isALU,
  output        io_ex_ctrl_out_1_isMem,
  output [4:0]  io_ex_ctrl_out_1_rd,
  output        io_ex_ctrl_out_1_rdWen,
  output [31:0] io_alu_data_out_1_src1,
  output [31:0] io_alu_data_out_1_src2,
  output [3:0]  io_alu_data_out_1_op,
  output        io_mem_op_out_1_isMem,
  output [1:0]  io_mem_op_out_1_memOp
);
  assign io_result_ready_out_0 = io_valid_in_0 & io_alu_ready_in_0; // @[EX.scala 63:38]
  assign io_result_ready_out_1 = io_valid_in_1 & io_alu_ready_in_1; // @[EX.scala 64:38]
  assign io_ex_ctrl_out_0_writeEnable = io_valid_in_0 & io_alu_ready_in_0; // @[EX.scala 63:38]
  assign io_ex_ctrl_out_0_isALU = 1'h1; // @[EX.scala 78:32]
  assign io_ex_ctrl_out_0_isMem = io_issue_in_0_isMem; // @[EX.scala 79:32]
  assign io_ex_ctrl_out_0_rd = io_issue_in_0_rd; // @[EX.scala 80:32]
  assign io_ex_ctrl_out_0_rdWen = io_issue_in_0_rdWen; // @[EX.scala 81:32]
  assign io_alu_data_out_0_src1 = io_issue_in_0_rs1; // @[EX.scala 67:26]
  assign io_alu_data_out_0_src2 = io_issue_in_0_isMem ? io_issue_in_0_imm : io_issue_in_0_rs2; // @[EX.scala 68:32]
  assign io_alu_data_out_0_op = io_issue_in_0_op; // @[EX.scala 69:26]
  assign io_mem_op_out_0_isMem = io_issue_in_0_isMem; // @[EX.scala 91:25]
  assign io_mem_op_out_0_memOp = io_issue_in_0_memOp; // @[EX.scala 92:25]
  assign io_ex_ctrl_out_1_writeEnable = io_valid_in_1 & io_alu_ready_in_1; // @[EX.scala 64:38]
  assign io_ex_ctrl_out_1_isALU = 1'h1; // @[EX.scala 85:32]
  assign io_ex_ctrl_out_1_isMem = io_issue_in_1_isMem; // @[EX.scala 86:32]
  assign io_ex_ctrl_out_1_rd = io_issue_in_1_rd; // @[EX.scala 87:32]
  assign io_ex_ctrl_out_1_rdWen = io_issue_in_1_rdWen; // @[EX.scala 88:32]
  assign io_alu_data_out_1_src1 = io_issue_in_1_rs1; // @[EX.scala 72:26]
  assign io_alu_data_out_1_src2 = io_issue_in_1_isMem ? io_issue_in_1_imm : io_issue_in_1_rs2; // @[EX.scala 73:32]
  assign io_alu_data_out_1_op = io_issue_in_1_op; // @[EX.scala 74:26]
  assign io_mem_op_out_1_isMem = io_issue_in_1_isMem; // @[EX.scala 95:25]
  assign io_mem_op_out_1_memOp = io_issue_in_1_memOp; // @[EX.scala 96:25]
endmodule
