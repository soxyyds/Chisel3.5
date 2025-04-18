package riscv_core

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class ExSofTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "ExSof"

  it should "process instructions when both ALUs are ready" in {
    test(new ExSof) { dut =>
      // 测试1：两个ALU都就绪且有有效指令

      // 指令1: ADD r3, r1, r2
      dut.io.issue_in_0.rs1.poke(10.U)     // r1 = 10
      dut.io.issue_in_0.rs2.poke(20.U)     // r2 = 20
      dut.io.issue_in_0.imm.poke(0.U)
      dut.io.issue_in_0.op.poke(ALUOps.ADD)
      dut.io.issue_in_0.isMem.poke(false.B)
      dut.io.issue_in_0.memOp.poke(0.U)
      dut.io.issue_in_0.rd.poke(3.U)       // 目标寄存器 r3
      dut.io.issue_in_0.rdWen.poke(true.B) // 写回寄存器
      dut.io.valid_in_0.poke(true.B)       // 指令有效
      dut.io.alu_ready_in_0.poke(true.B)   // ALU 0 就绪

      // 指令2: SUB r5, r3, r4
      dut.io.issue_in_1.rs1.poke(30.U)     // r3 = 30
      dut.io.issue_in_1.rs2.poke(5.U)      // r4 = 5
      dut.io.issue_in_1.imm.poke(0.U)
      dut.io.issue_in_1.op.poke(ALUOps.SUB)
      dut.io.issue_in_1.isMem.poke(false.B)
      dut.io.issue_in_1.memOp.poke(0.U)
      dut.io.issue_in_1.rd.poke(5.U)       // 目标寄存器 r5
      dut.io.issue_in_1.rdWen.poke(true.B) // 写回寄存器
      dut.io.valid_in_1.poke(true.B)       // 指令有效
      dut.io.alu_ready_in_1.poke(true.B)   // ALU 1 就绪

      dut.clock.step(1)

      // 验证ALU 0输出
      dut.io.result_ready_out_0.expect(true.B)
      dut.io.ex_ctrl_out_0.writeEnable.expect(true.B)
      dut.io.ex_ctrl_out_0.isALU.expect(true.B)
      dut.io.ex_ctrl_out_0.isMem.expect(false.B)
      dut.io.alu_data_out_0.src1.expect(10.U)
      dut.io.alu_data_out_0.src2.expect(20.U)
      dut.io.alu_data_out_0.op.expect(ALUOps.ADD)

      // 验证ALU 1输出
      dut.io.result_ready_out_1.expect(true.B)
      dut.io.ex_ctrl_out_1.writeEnable.expect(true.B)
      dut.io.alu_data_out_1.src1.expect(30.U)
      dut.io.alu_data_out_1.src2.expect(5.U)
      dut.io.alu_data_out_1.op.expect(ALUOps.SUB)
    }
  }

  it should "handle memory operations correctly" in {
    test(new ExSof) { dut =>
      // 测试2：内存操作

      // 指令1: 加载指令 (LW)
      dut.io.issue_in_0.rs1.poke(100.U)    // 基地址寄存器 = 100
      dut.io.issue_in_0.imm.poke(4.U)      // 偏移量 = 4
      dut.io.issue_in_0.op.poke(ALUOps.ADD)
      dut.io.issue_in_0.isMem.poke(true.B) // 访存操作
      dut.io.issue_in_0.memOp.poke(1.U)    // 读内存
      dut.io.valid_in_0.poke(true.B)
      dut.io.alu_ready_in_0.poke(true.B)

      // 指令2: 存储指令 (SW)
      dut.io.issue_in_1.rs1.poke(200.U)    // 基地址寄存器 = 200
      dut.io.issue_in_1.rs2.poke(50.U)     // 存储数据 = 50
      dut.io.issue_in_1.imm.poke(8.U)      // 偏移量 = 8
      dut.io.issue_in_1.op.poke(ALUOps.ADD)
      dut.io.issue_in_1.isMem.poke(true.B) // 访存操作
      dut.io.issue_in_1.memOp.poke(2.U)    // 写内存
      dut.io.valid_in_1.poke(true.B)
      dut.io.alu_ready_in_1.poke(true.B)

      dut.clock.step(1)

      // 验证加载指令
      dut.io.alu_data_out_0.src1.expect(100.U)
      dut.io.alu_data_out_0.src2.expect(4.U)  // 访存操作，src2为立即数
      dut.io.mem_op_out_0.isMem.expect(true.B)
      dut.io.mem_op_out_0.memOp.expect(1.U)

      // 验证存储指令
      dut.io.alu_data_out_1.src1.expect(200.U)
      dut.io.alu_data_out_1.src2.expect(8.U)  // 访存操作，src2为立即数
      dut.io.mem_op_out_1.isMem.expect(true.B)
      dut.io.mem_op_out_1.memOp.expect(2.U)
    }
  }

  it should "respect ALU ready signals" in {
    test(new ExSof) { dut =>
      // 测试3：ALU未就绪的情况

      dut.io.issue_in_0.rs1.poke(10.U)
      dut.io.issue_in_0.rs2.poke(20.U)
      dut.io.issue_in_0.op.poke(ALUOps.ADD)
      dut.io.valid_in_0.poke(true.B)
      dut.io.alu_ready_in_0.poke(false.B)  // ALU 0 未就绪

      dut.io.issue_in_1.rs1.poke(30.U)
      dut.io.issue_in_1.rs2.poke(40.U)
      dut.io.issue_in_1.op.poke(ALUOps.ADD)
      dut.io.valid_in_1.poke(true.B)
      dut.io.alu_ready_in_1.poke(false.B)  // ALU 1 未就绪

      dut.clock.step(1)

      // 验证：不应发送任何指令
      dut.io.result_ready_out_0.expect(false.B)
      dut.io.result_ready_out_1.expect(false.B)
      dut.io.ex_ctrl_out_0.writeEnable.expect(false.B)
      dut.io.ex_ctrl_out_1.writeEnable.expect(false.B)
    }
  }
}