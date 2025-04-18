circuit ExSof :
  module ExSof :
    input clock : Clock
    input reset : UInt<1>
    input io_issue_in_0_rs1 : UInt<32>
    input io_issue_in_0_rs2 : UInt<32>
    input io_issue_in_0_imm : UInt<32>
    input io_issue_in_0_op : UInt<4>
    input io_issue_in_0_isMem : UInt<1>
    input io_issue_in_0_memOp : UInt<2>
    input io_issue_in_0_rd : UInt<5>
    input io_issue_in_0_rdWen : UInt<1>
    input io_issue_in_1_rs1 : UInt<32>
    input io_issue_in_1_rs2 : UInt<32>
    input io_issue_in_1_imm : UInt<32>
    input io_issue_in_1_op : UInt<4>
    input io_issue_in_1_isMem : UInt<1>
    input io_issue_in_1_memOp : UInt<2>
    input io_issue_in_1_rd : UInt<5>
    input io_issue_in_1_rdWen : UInt<1>
    input io_valid_in_0 : UInt<1>
    input io_valid_in_1 : UInt<1>
    input io_alu_ready_in_0 : UInt<1>
    input io_alu_ready_in_1 : UInt<1>
    output io_result_ready_out_0 : UInt<1>
    output io_result_ready_out_1 : UInt<1>
    output io_ex_ctrl_out_0_writeEnable : UInt<1>
    output io_ex_ctrl_out_0_isALU : UInt<1>
    output io_ex_ctrl_out_0_isMem : UInt<1>
    output io_ex_ctrl_out_0_rd : UInt<5>
    output io_ex_ctrl_out_0_rdWen : UInt<1>
    output io_alu_data_out_0_src1 : UInt<32>
    output io_alu_data_out_0_src2 : UInt<32>
    output io_alu_data_out_0_op : UInt<4>
    output io_mem_op_out_0_isMem : UInt<1>
    output io_mem_op_out_0_memOp : UInt<2>
    output io_ex_ctrl_out_1_writeEnable : UInt<1>
    output io_ex_ctrl_out_1_isALU : UInt<1>
    output io_ex_ctrl_out_1_isMem : UInt<1>
    output io_ex_ctrl_out_1_rd : UInt<5>
    output io_ex_ctrl_out_1_rdWen : UInt<1>
    output io_alu_data_out_1_src1 : UInt<32>
    output io_alu_data_out_1_src2 : UInt<32>
    output io_alu_data_out_1_op : UInt<4>
    output io_mem_op_out_1_isMem : UInt<1>
    output io_mem_op_out_1_memOp : UInt<2>

    node execute_fire_0 = and(io_valid_in_0, io_alu_ready_in_0) @[ExSof.scala 63:38]
    node execute_fire_1 = and(io_valid_in_1, io_alu_ready_in_1) @[ExSof.scala 64:38]
    node _io_alu_data_out_0_src2_T = mux(io_issue_in_0_isMem, io_issue_in_0_imm, io_issue_in_0_rs2) @[ExSof.scala 68:32]
    node _io_alu_data_out_1_src2_T = mux(io_issue_in_1_isMem, io_issue_in_1_imm, io_issue_in_1_rs2) @[ExSof.scala 73:32]
    io_result_ready_out_0 <= execute_fire_0 @[ExSof.scala 99:25]
    io_result_ready_out_1 <= execute_fire_1 @[ExSof.scala 100:25]
    io_ex_ctrl_out_0_writeEnable <= execute_fire_0 @[ExSof.scala 77:32]
    io_ex_ctrl_out_0_isALU <= UInt<1>("h1") @[ExSof.scala 78:32]
    io_ex_ctrl_out_0_isMem <= io_issue_in_0_isMem @[ExSof.scala 79:32]
    io_ex_ctrl_out_0_rd <= io_issue_in_0_rd @[ExSof.scala 80:32]
    io_ex_ctrl_out_0_rdWen <= io_issue_in_0_rdWen @[ExSof.scala 81:32]
    io_alu_data_out_0_src1 <= io_issue_in_0_rs1 @[ExSof.scala 67:26]
    io_alu_data_out_0_src2 <= _io_alu_data_out_0_src2_T @[ExSof.scala 68:26]
    io_alu_data_out_0_op <= io_issue_in_0_op @[ExSof.scala 69:26]
    io_mem_op_out_0_isMem <= io_issue_in_0_isMem @[ExSof.scala 91:25]
    io_mem_op_out_0_memOp <= io_issue_in_0_memOp @[ExSof.scala 92:25]
    io_ex_ctrl_out_1_writeEnable <= execute_fire_1 @[ExSof.scala 84:32]
    io_ex_ctrl_out_1_isALU <= UInt<1>("h1") @[ExSof.scala 85:32]
    io_ex_ctrl_out_1_isMem <= io_issue_in_1_isMem @[ExSof.scala 86:32]
    io_ex_ctrl_out_1_rd <= io_issue_in_1_rd @[ExSof.scala 87:32]
    io_ex_ctrl_out_1_rdWen <= io_issue_in_1_rdWen @[ExSof.scala 88:32]
    io_alu_data_out_1_src1 <= io_issue_in_1_rs1 @[ExSof.scala 72:26]
    io_alu_data_out_1_src2 <= _io_alu_data_out_1_src2_T @[ExSof.scala 73:26]
    io_alu_data_out_1_op <= io_issue_in_1_op @[ExSof.scala 74:26]
    io_mem_op_out_1_isMem <= io_issue_in_1_isMem @[ExSof.scala 95:25]
    io_mem_op_out_1_memOp <= io_issue_in_1_memOp @[ExSof.scala 96:25]
