circuit ExSof :
  module ExSof :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip issue_in_0 : { rs1 : UInt<32>, rs2 : UInt<32>, imm : UInt<32>, op : UInt<4>, isMem : UInt<1>, memOp : UInt<2>, rd : UInt<5>, rdWen : UInt<1>}, flip issue_in_1 : { rs1 : UInt<32>, rs2 : UInt<32>, imm : UInt<32>, op : UInt<4>, isMem : UInt<1>, memOp : UInt<2>, rd : UInt<5>, rdWen : UInt<1>}, flip valid_in_0 : UInt<1>, flip valid_in_1 : UInt<1>, flip alu_ready_in_0 : UInt<1>, flip alu_ready_in_1 : UInt<1>, result_ready_out_0 : UInt<1>, result_ready_out_1 : UInt<1>, ex_ctrl_out_0 : { writeEnable : UInt<1>, isALU : UInt<1>, isMem : UInt<1>, rd : UInt<5>, rdWen : UInt<1>}, alu_data_out_0 : { src1 : UInt<32>, src2 : UInt<32>, op : UInt<4>}, mem_op_out_0 : { isMem : UInt<1>, memOp : UInt<2>}, ex_ctrl_out_1 : { writeEnable : UInt<1>, isALU : UInt<1>, isMem : UInt<1>, rd : UInt<5>, rdWen : UInt<1>}, alu_data_out_1 : { src1 : UInt<32>, src2 : UInt<32>, op : UInt<4>}, mem_op_out_1 : { isMem : UInt<1>, memOp : UInt<2>}}

    node execute_fire_0 = and(io.valid_in_0, io.alu_ready_in_0) @[ExSof.scala 63:38]
    node execute_fire_1 = and(io.valid_in_1, io.alu_ready_in_1) @[ExSof.scala 64:38]
    io.alu_data_out_0.src1 <= io.issue_in_0.rs1 @[ExSof.scala 67:26]
    node _io_alu_data_out_0_src2_T = mux(io.issue_in_0.isMem, io.issue_in_0.imm, io.issue_in_0.rs2) @[ExSof.scala 68:32]
    io.alu_data_out_0.src2 <= _io_alu_data_out_0_src2_T @[ExSof.scala 68:26]
    io.alu_data_out_0.op <= io.issue_in_0.op @[ExSof.scala 69:26]
    io.alu_data_out_1.src1 <= io.issue_in_1.rs1 @[ExSof.scala 72:26]
    node _io_alu_data_out_1_src2_T = mux(io.issue_in_1.isMem, io.issue_in_1.imm, io.issue_in_1.rs2) @[ExSof.scala 73:32]
    io.alu_data_out_1.src2 <= _io_alu_data_out_1_src2_T @[ExSof.scala 73:26]
    io.alu_data_out_1.op <= io.issue_in_1.op @[ExSof.scala 74:26]
    io.ex_ctrl_out_0.writeEnable <= execute_fire_0 @[ExSof.scala 77:32]
    io.ex_ctrl_out_0.isALU <= UInt<1>("h1") @[ExSof.scala 78:32]
    io.ex_ctrl_out_0.isMem <= io.issue_in_0.isMem @[ExSof.scala 79:32]
    io.ex_ctrl_out_0.rd <= io.issue_in_0.rd @[ExSof.scala 80:32]
    io.ex_ctrl_out_0.rdWen <= io.issue_in_0.rdWen @[ExSof.scala 81:32]
    io.ex_ctrl_out_1.writeEnable <= execute_fire_1 @[ExSof.scala 84:32]
    io.ex_ctrl_out_1.isALU <= UInt<1>("h1") @[ExSof.scala 85:32]
    io.ex_ctrl_out_1.isMem <= io.issue_in_1.isMem @[ExSof.scala 86:32]
    io.ex_ctrl_out_1.rd <= io.issue_in_1.rd @[ExSof.scala 87:32]
    io.ex_ctrl_out_1.rdWen <= io.issue_in_1.rdWen @[ExSof.scala 88:32]
    io.mem_op_out_0.isMem <= io.issue_in_0.isMem @[ExSof.scala 91:25]
    io.mem_op_out_0.memOp <= io.issue_in_0.memOp @[ExSof.scala 92:25]
    io.mem_op_out_1.isMem <= io.issue_in_1.isMem @[ExSof.scala 95:25]
    io.mem_op_out_1.memOp <= io.issue_in_1.memOp @[ExSof.scala 96:25]
    io.result_ready_out_0 <= execute_fire_0 @[ExSof.scala 99:25]
    io.result_ready_out_1 <= execute_fire_1 @[ExSof.scala 100:25]

