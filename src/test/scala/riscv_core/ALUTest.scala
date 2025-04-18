package riscv_core

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class ALUTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "ALU"

  // 测试基本算术逻辑运算
  it should "correctly perform arithmetic and logic operations" in {
    test(new ALU) { dut =>
      // 常规设置
      dut.io.valid_in.poke(true.B)
      dut.io.flush_in.poke(false.B)
      dut.io.is_branch.poke(false.B)
      dut.io.is_jump.poke(false.B)

      // 测试ADD
      dut.io.op_in.poke(ALUOps.ADD)
      dut.io.src1_in.poke(10.U)
      dut.io.src2_in.poke(20.U)
      dut.clock.step()
      dut.io.result_out.expect(30.U)

      // 测试SUB
      dut.io.op_in.poke(ALUOps.SUB)
      dut.io.src1_in.poke(50.U)
      dut.io.src2_in.poke(20.U)
      dut.clock.step()
      dut.io.result_out.expect(30.U)

      // 测试AND
      dut.io.op_in.poke(ALUOps.AND)
      dut.io.src1_in.poke("b1010".U)
      dut.io.src2_in.poke("b1100".U)
      dut.clock.step()
      dut.io.result_out.expect("b1000".U)

      // 测试OR
      dut.io.op_in.poke(ALUOps.OR)
      dut.io.src1_in.poke("b1010".U)
      dut.io.src2_in.poke("b1100".U)
      dut.clock.step()
      dut.io.result_out.expect("b1110".U)

      // 测试XOR
      dut.io.op_in.poke(ALUOps.XOR)
      dut.io.src1_in.poke("b1010".U)
      dut.io.src2_in.poke("b1100".U)
      dut.clock.step()
      dut.io.result_out.expect("b0110".U)

      // 测试SLL
      dut.io.op_in.poke(ALUOps.SLL)
      dut.io.src1_in.poke(1.U)
      dut.io.src2_in.poke(4.U)
      dut.clock.step()
      dut.io.result_out.expect(16.U)

      // 测试SRL
      dut.io.op_in.poke(ALUOps.SRL)
      dut.io.src1_in.poke(16.U)
      dut.io.src2_in.poke(2.U)
      dut.clock.step()
      dut.io.result_out.expect(4.U)

      // 测试SRA（有符号右移）
      dut.io.op_in.poke(ALUOps.SRA)
      dut.io.src1_in.poke("hF0000000".U)  // 负数最高位为1
      dut.io.src2_in.poke(4.U)
      dut.clock.step()
      dut.io.result_out.expect("hFF000000".U)  // 右移后填充1
    }
  }

  // 测试比较操作
  it should "correctly perform comparison operations" in {
    test(new ALU) { dut =>
      dut.io.valid_in.poke(true.B)
      dut.io.flush_in.poke(false.B)
      dut.io.is_branch.poke(false.B)
      dut.io.is_jump.poke(false.B)

      // 测试SLT（有符号小于）
      dut.io.op_in.poke(ALUOps.SLT)
      // 正数 < 正数
      dut.io.src1_in.poke(10.U)
      dut.io.src2_in.poke(20.U)
      dut.clock.step()
      dut.io.result_out.expect(1.U)
      // 负数 < 正数
      dut.io.src1_in.poke("h80000000".U)  // 负数
      dut.io.src2_in.poke(20.U)
      dut.clock.step()
      dut.io.result_out.expect(1.U)

      // 测试SLTU（无符号小于）
      dut.io.op_in.poke(ALUOps.SLTU)
      // 小值 < 大值
      dut.io.src1_in.poke(10.U)
      dut.io.src2_in.poke(20.U)
      dut.clock.step()
      dut.io.result_out.expect(1.U)
      // 对无符号来说，"负数"其实是很大的正数
      dut.io.src1_in.poke("h80000000".U)
      dut.io.src2_in.poke(20.U)
      dut.clock.step()
      dut.io.result_out.expect(0.U)
    }
  }

  // 测试分支指令
  it should "correctly evaluate branch conditions" in {
    test(new ALU) { dut =>
      dut.io.valid_in.poke(true.B)
      dut.io.flush_in.poke(false.B)
      dut.io.is_branch.poke(true.B)
      dut.io.is_jump.poke(false.B)
      dut.io.pc_in.poke(100.U)
      dut.io.imm_in.poke(16.U)

      // 测试BEQ（相等时分支）
      dut.io.op_in.poke(ALUOps.BEQ)
      // 相等
      dut.io.src1_in.poke(42.U)
      dut.io.src2_in.poke(42.U)
      dut.clock.step()
      dut.io.branch_out.expect(true.B)
      dut.io.jump_addr.expect(116.U)
      // 不相等
      dut.io.src1_in.poke(42.U)
      dut.io.src2_in.poke(24.U)
      dut.clock.step()
      dut.io.branch_out.expect(false.B)

      // 测试BNE（不相等时分支）
      dut.io.op_in.poke(ALUOps.BNE)
      // 不相等
      dut.io.src1_in.poke(42.U)
      dut.io.src2_in.poke(24.U)
      dut.clock.step()
      dut.io.branch_out.expect(true.B)
      // 相等
      dut.io.src1_in.poke(42.U)
      dut.io.src2_in.poke(42.U)
      dut.clock.step()
      dut.io.branch_out.expect(false.B)

      // 测试BLT（小于时分支）
      dut.io.op_in.poke(ALUOps.BLT)
      // 小于
      dut.io.src1_in.poke(24.U)
      dut.io.src2_in.poke(42.U)
      dut.clock.step()
      dut.io.branch_out.expect(true.B)
      // 大于
      dut.io.src1_in.poke(42.U)
      dut.io.src2_in.poke(24.U)
      dut.clock.step()
      dut.io.branch_out.expect(false.B)

      // 测试BGE（大于等于时分支）
      dut.io.op_in.poke(ALUOps.BGE)
      // 大于
      dut.io.src1_in.poke(42.U)
      dut.io.src2_in.poke(24.U)
      dut.clock.step()
      dut.io.branch_out.expect(true.B)
      // 等于
      dut.io.src1_in.poke(42.U)
      dut.io.src2_in.poke(42.U)
      dut.clock.step()
      dut.io.branch_out.expect(true.B)
      // 小于
      dut.io.src1_in.poke(24.U)
      dut.io.src2_in.poke(42.U)
      dut.clock.step()
      dut.io.branch_out.expect(false.B)
    }
  }

  // 测试跳转指令
  it should "correctly handle jump instructions" in {
    test(new ALU) { dut =>
      dut.io.valid_in.poke(true.B)
      dut.io.flush_in.poke(false.B)
      dut.io.is_branch.poke(false.B)
      dut.io.is_jump.poke(true.B)
      dut.io.pc_in.poke(100.U)
      dut.io.imm_in.poke(16.U)

      // 测试JAL
      dut.io.op_in.poke(0.U)  // JAL使用0作为操作码
      dut.clock.step()
      dut.io.result_out.expect(104.U)  // PC+4返回地址
      dut.io.branch_out.expect(true.B)
      dut.io.jump_addr.expect(116.U)   // PC+imm跳转地址

      // 测试JALR
      dut.io.op_in.poke(1.U)  // JALR使用1作为操作码
      dut.io.src1_in.poke(200.U)
      dut.clock.step()
      dut.io.result_out.expect(104.U)  // 仍然是PC+4返回地址
      dut.io.branch_out.expect(true.B)
      dut.io.jump_addr.expect(216.U)   // rs1+imm (并确保最低位为0)

      // JALR确保最低位为0
      dut.io.src1_in.poke(201.U)  // 地址最低位为1
      dut.clock.step()
      dut.io.jump_addr.expect(216.U)   // (201+16)&~1 = 216
    }
  }

  // 测试flush和valid信号
  it should "respect flush and valid signals" in {
    test(new ALU) { dut =>
      // 有效，不刷新
      dut.io.valid_in.poke(true.B)
      dut.io.flush_in.poke(false.B)
      dut.io.op_in.poke(ALUOps.ADD)
      dut.io.src1_in.poke(10.U)
      dut.io.src2_in.poke(20.U)
      dut.clock.step()
      dut.io.result_out.expect(30.U)
      dut.io.valid_out.expect(true.B)

      // 有效，刷新
      dut.io.valid_in.poke(true.B)
      dut.io.flush_in.poke(true.B)
      dut.clock.step()
      dut.io.result_out.expect(0.U)
      dut.io.valid_out.expect(false.B)

      // 无效，不刷新
      dut.io.valid_in.poke(false.B)
      dut.io.flush_in.poke(false.B)
      dut.clock.step()
      dut.io.result_out.expect(0.U)
      dut.io.valid_out.expect(false.B)
    }
  }
}