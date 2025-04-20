package riscv_core

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class ExTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "Ex"

  it should "execute basic arithmetic instructions correctly" in {
    test(new Ex) { dut =>
      // 指令1: ADD r3, r1, r2 (r3 = 10 + 20 = 30)
      dut.io.decode_in_0.rs1.poke(1.U)
      dut.io.decode_in_0.rs2.poke(2.U)
      dut.io.decode_in_0.rd.poke(3.U)
      dut.io.decode_in_0.rs1_data.poke(10.U)
      dut.io.decode_in_0.rs2_data.poke(20.U)
      dut.io.decode_in_0.imm.poke(0.U)
      dut.io.decode_in_0.instr_id.poke(RV32IInstructions.ADD)
      dut.io.decode_in_0.rdWen.poke(true.B)
      dut.io.valid_in_0.poke(true.B)
      dut.io.flush_in.poke(false.B)

      // 指令2: SUB r5, r3, r4 (r5 = 30 - 15 = 15)
      dut.io.decode_in_1.rs1.poke(3.U)
      dut.io.decode_in_1.rs2.poke(4.U)
      dut.io.decode_in_1.rd.poke(5.U)
      dut.io.decode_in_1.rs1_data.poke(30.U)
      dut.io.decode_in_1.rs2_data.poke(15.U)
      dut.io.decode_in_1.imm.poke(0.U)
      dut.io.decode_in_1.instr_id.poke(RV32IInstructions.SUB)
      dut.io.decode_in_1.rdWen.poke(true.B)
      dut.io.valid_in_1.poke(true.B)

      dut.clock.step(1)

      // 验证计算结果
      dut.io.result_out_0.expect(30.U) // 10 + 20 = 30
      dut.io.result_out_1.expect(15.U) // 30 - 15 = 15

      // 验证前馈信号
      dut.io.forward_0.rd.expect(3.U)
      dut.io.forward_0.rdWen.expect(true.B)
      dut.io.forward_0.result.expect(30.U)
      dut.io.forward_0.valid.expect(true.B)

      dut.io.forward_1.rd.expect(5.U)
      dut.io.forward_1.rdWen.expect(true.B)
      dut.io.forward_1.result.expect(15.U)
      dut.io.forward_1.valid.expect(true.B)
    }
  }

  it should "handle memory instructions correctly" in {
    test(new Ex) { dut =>
      // 指令1: LW r2, 12(r1) - 加载指令
      dut.io.decode_in_0.rs1.poke(1.U)
      dut.io.decode_in_0.rd.poke(2.U)
      dut.io.decode_in_0.rs1_data.poke(0x1000.U)
      dut.io.decode_in_0.imm.poke(12.U)
      dut.io.decode_in_0.instr_id.poke(RV32IInstructions.LW)
      dut.io.decode_in_0.rdWen.poke(true.B)
      dut.io.valid_in_0.poke(true.B)
      dut.io.flush_in.poke(false.B)

      // 指令2: SW r3, 16(r4) - 存储指令
      dut.io.decode_in_1.rs1.poke(4.U)
      dut.io.decode_in_1.rs2.poke(3.U)
      dut.io.decode_in_1.rs1_data.poke(0x2000.U)
      dut.io.decode_in_1.rs2_data.poke(0xABCD.U)
      dut.io.decode_in_1.imm.poke(16.U)
      dut.io.decode_in_1.instr_id.poke(RV32IInstructions.SW)
      dut.io.decode_in_1.rdWen.poke(false.B)
      dut.io.valid_in_1.poke(true.B)

      dut.clock.step(1)

      // 验证加载指令
      dut.io.is_load_0.expect(true.B)
      dut.io.is_store_0.expect(false.B)
      dut.io.mem_addr_0.expect(0x100C.U) // 基址 + 偏移 = 0x1000 + 12 = 0x100C
      dut.io.forward_0.is_load.expect(true.B)

      // 验证存储指令
      dut.io.is_load_1.expect(false.B)
      dut.io.is_store_1.expect(true.B)
      dut.io.mem_addr_1.expect(0x2010.U) // 基址 + 偏移 = 0x2000 + 16 = 0x2010
      dut.io.mem_wdata_1.expect(0xABCD.U) // rs2的值作为存储数据
    }
  }

  it should "handle branch instructions correctly" in {
    test(new Ex) { dut =>
      // 指令1: BEQ r1, r2, offset (如果r1==r2则分支, PC+imm)
      dut.io.decode_in_0.rs1.poke(1.U)
      dut.io.decode_in_0.rs2.poke(2.U)
      dut.io.decode_in_0.rs1_data.poke(100.U)
      dut.io.decode_in_0.rs2_data.poke(100.U) // 相等, 应该分支
      dut.io.decode_in_0.imm.poke(0x100.U) // 偏移量 = 256
      dut.io.decode_in_0.pc.poke(0x1000.U) // 当前PC = 0x1000
      dut.io.decode_in_0.instr_id.poke(RV32IInstructions.BEQ)
      dut.io.valid_in_0.poke(true.B)
      dut.io.flush_in.poke(false.B)

      // 指令2: ADDI r5, r3, 10 (正常指令, 但会被分支取消)
      dut.io.decode_in_1.rs1.poke(3.U)
      dut.io.decode_in_1.rd.poke(5.U)
      dut.io.decode_in_1.rs1_data.poke(20.U)
      dut.io.decode_in_1.imm.poke(10.U)
      dut.io.decode_in_1.instr_id.poke(RV32IInstructions.ADDI)
      dut.io.decode_in_1.rdWen.poke(true.B)
      dut.io.valid_in_1.poke(true.B)

      dut.clock.step(1)

      // 验证分支结果
      dut.io.branch_taken_0.expect(true.B)
      dut.io.jump_addr_0.expect(0x1100.U) // PC + imm = 0x1000 + 0x100 = 0x1100

      // 验证第二条指令被分支取消
      dut.io.valid_out_1.expect(false.B) // 由于ALU0的分支被采纳,ALU1的指令应被取消
    }
  }

  it should "handle jump instructions correctly" in {
    test(new Ex) { dut =>
      // 指令1: JAL rd, offset (无条件跳转并保存返回地址)
      dut.io.decode_in_0.rd.poke(1.U)
      dut.io.decode_in_0.imm.poke(0x200.U) // 偏移量 = 512
      dut.io.decode_in_0.pc.poke(0x2000.U) // 当前PC = 0x2000
      dut.io.decode_in_0.instr_id.poke(RV32IInstructions.JAL)
      dut.io.decode_in_0.rdWen.poke(true.B)
      dut.io.valid_in_0.poke(true.B)
      dut.io.flush_in.poke(false.B)

      dut.clock.step(1)

      // 验证跳转结果
      dut.io.branch_taken_0.expect(true.B)
      dut.io.jump_addr_0.expect(0x2200.U) // PC + imm = 0x2000 + 0x200 = 0x2200
      dut.io.result_out_0.expect(0x2004.U) // 返回地址 = PC + 4 = 0x2000 + 4 = 0x2004
    }
  }

  it should "handle JALR instructions correctly" in {
    test(new Ex) { dut =>
      // 指令1: JALR rd, rs1, imm (跳转到rs1+imm并保存返回地址)
      dut.io.decode_in_0.rd.poke(1.U)
      dut.io.decode_in_0.rs1.poke(2.U)
      dut.io.decode_in_0.rs1_data.poke(0x3000.U) // 基址 = 0x3000
      dut.io.decode_in_0.imm.poke(0x10.U) // 偏移量 = 16
      dut.io.decode_in_0.pc.poke(0x2000.U) // 当前PC = 0x2000
      dut.io.decode_in_0.instr_id.poke(RV32IInstructions.JALR)
      dut.io.decode_in_0.rdWen.poke(true.B)
      dut.io.valid_in_0.poke(true.B)
      dut.io.flush_in.poke(false.B)

      dut.clock.step(1)

      // 验证跳转结果
      dut.io.branch_taken_0.expect(true.B)
      dut.io.jump_addr_0.expect(0x3010.U) // rs1 + imm = 0x3000 + 0x10 = 0x3010
      dut.io.result_out_0.expect(0x2004.U) // 返回地址 = PC + 4 = 0x2000 + 4 = 0x2004
    }
  }

  it should "respect flush signals" in {
    test(new Ex) { dut =>
      // 设置两条指令
      dut.io.decode_in_0.rs1.poke(1.U)
      dut.io.decode_in_0.rs2.poke(2.U)
      dut.io.decode_in_0.rs1_data.poke(10.U)
      dut.io.decode_in_0.rs2_data.poke(20.U)
      dut.io.decode_in_0.instr_id.poke(RV32IInstructions.ADD)
      dut.io.valid_in_0.poke(true.B)

      dut.io.decode_in_1.rs1.poke(3.U)
      dut.io.decode_in_1.rs2.poke(4.U)
      dut.io.decode_in_1.rs1_data.poke(30.U)
      dut.io.decode_in_1.rs2_data.poke(40.U)
      dut.io.decode_in_1.instr_id.poke(RV32IInstructions.ADD)
      dut.io.valid_in_1.poke(true.B)

      // 触发刷新信号
      dut.io.flush_in.poke(true.B)

      dut.clock.step(1)

      // 验证刷新效果 - 两条指令都应该无效
      dut.io.valid_out_0.expect(false.B)
      dut.io.valid_out_1.expect(false.B)
    }
  }

  it should "handle immediate instructions" in {
    test(new Ex) { dut =>
      // 指令: ADDI r2, r1, 100
      dut.io.decode_in_0.rs1.poke(1.U)
      dut.io.decode_in_0.rd.poke(2.U)
      dut.io.decode_in_0.rs1_data.poke(50.U)
      dut.io.decode_in_0.imm.poke(100.U)
      dut.io.decode_in_0.instr_id.poke(RV32IInstructions.ADDI)
      dut.io.decode_in_0.rdWen.poke(true.B)
      dut.io.valid_in_0.poke(true.B)
      dut.io.flush_in.poke(false.B)

      dut.clock.step(1)

      // 验证结果: 50 + 100 = 150
      dut.io.result_out_0.expect(150.U)
    }
  }
}