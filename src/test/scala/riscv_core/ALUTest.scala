package riscv_core

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class ALUTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "ALU"

  // 通用测试方法
  def setupALU(dut: ALU, instr_id: UInt, src1: UInt, src2: UInt, imm: UInt = 0.U, pc: UInt = 0.U): Unit = {
    dut.io.instr_id.poke(instr_id)
    dut.io.src1_in.poke(src1)
    dut.io.src2_in.poke(src2)
    dut.io.imm_in.poke(imm)
    dut.io.pc_in.poke(pc)
    dut.io.valid_in.poke(true.B)
    dut.io.flush_in.poke(false.B)
  }

  // 算术指令测试
  it should "正确执行算术指令" in {
    test(new ALU) { dut =>
      import RV32IInstructions._

      // ADD 测试
      setupALU(dut, ADD, 10.U, 20.U)
      dut.io.result_out.expect(30.U)
      dut.io.branch_out.expect(false.B)

      // SUB 测试
      setupALU(dut, SUB, 30.U, 10.U)
      dut.io.result_out.expect(20.U)

      // ADDI 测试
      setupALU(dut, ADDI, 15.U, 0.U, 25.U)
      dut.io.result_out.expect(40.U)

      // LUI 测试 (只使用立即数)
      setupALU(dut, LUI, 0.U, 0.U, "h12345000".U)
      dut.io.result_out.expect("h12345000".U)

      // AUIPC 测试 (PC + 立即数)
      setupALU(dut, AUIPC, 0.U, 0.U, "h00010000".U, "h1000".U)
      dut.io.result_out.expect("h00011000".U)
    }
  }

  // 逻辑指令测试
  it should "正确执行逻辑指令" in {
    test(new ALU) { dut =>
      import RV32IInstructions._

      // AND 测试
      setupALU(dut, AND, "hFF00FF00".U, "h0F0F0F0F".U)
      dut.io.result_out.expect("h0F000F00".U)

      // ANDI 测试
      setupALU(dut, ANDI, "hFF00FF00".U, 0.U, "h0000FFFF".U)
      dut.io.result_out.expect("h0000FF00".U)

      // OR 测试
      setupALU(dut, OR, "hFF00FF00".U, "h0F0F0F0F".U)
      dut.io.result_out.expect("hFF0FFF0F".U)

      // ORI 测试
      setupALU(dut, ORI, "hFF00FF00".U, 0.U, "h0000FFFF".U)
      dut.io.result_out.expect("hFF00FFFF".U)

      // XOR 测试
      setupALU(dut, XOR, "hFF00FF00".U, "h0F0F0F0F".U)
      dut.io.result_out.expect("hF00FF00F".U)

      // XORI 测试
      setupALU(dut, XORI, "hFF00FF00".U, 0.U, "h0000FFFF".U)
      dut.io.result_out.expect("hFF0000FF".U)
    }
  }

  // 移位指令测试
  it should "正确执行移位指令" in {
    test(new ALU) { dut =>
      import RV32IInstructions._

      // SLL 测试
      setupALU(dut, SLL, "h00000001".U, 4.U)
      dut.io.result_out.expect("h00000010".U)

      // SLLI 测试
      setupALU(dut, SLLI, "h00000001".U, 0.U, 8.U)
      dut.io.result_out.expect("h00000100".U)

      // SRL 测试
      setupALU(dut, SRL, "h00000100".U, 4.U)
      dut.io.result_out.expect("h00000010".U)

      // SRLI 测试
      setupALU(dut, SRLI, "h00001000".U, 0.U, 3.U)
      dut.io.result_out.expect("h00000200".U)

      // SRA 测试 (带符号右移)
      setupALU(dut, SRA, "h80000000".U, 4.U)
      dut.io.result_out.expect("hF8000000".U)

      // SRAI 测试 (带符号右移)
      setupALU(dut, SRAI, "h80000000".U, 0.U, 4.U)
      dut.io.result_out.expect("hF8000000".U)
    }
  }

  // 比较指令测试
  it should "正确执行比较指令" in {
    test(new ALU) { dut =>
      import RV32IInstructions._

      // SLT 测试 (有符号比较)
      setupALU(dut, SLT, "h80000000".U, "h00000001".U)
      dut.io.result_out.expect(1.U)  // -2^31 < 1
      setupALU(dut, SLT, "h00000010".U, "h00000001".U)
      dut.io.result_out.expect(0.U)  // 16 > 1

      // SLTI 测试
      setupALU(dut, SLTI, "h80000000".U, 0.U, 1.U)
      dut.io.result_out.expect(1.U)  // -2^31 < 1

      // SLTU 测试 (无符号比较)
      setupALU(dut, SLTU, "h80000000".U, "h00000001".U)
      dut.io.result_out.expect(0.U)  // 2^31 > 1 (无符号)

      // SLTIU 测试
      setupALU(dut, SLTIU, "h00000010".U, 0.U, "h00000020".U)
      dut.io.result_out.expect(1.U)  // 16 < 32
    }
  }

  // 分支指令测试
  it should "正确执行分支指令" in {
    test(new ALU) { dut =>
      import RV32IInstructions._
      val pc = "h1000".U
      val offset = "h100".U

      // BEQ 测试
      setupALU(dut, BEQ, 10.U, 10.U, offset, pc)
      dut.io.branch_out.expect(true.B)
      dut.io.jump_addr.expect("h1100".U)

      setupALU(dut, BEQ, 10.U, 20.U, offset, pc)
      dut.io.branch_out.expect(false.B)
      dut.io.jump_addr.expect("h1004".U)  // PC+4

      // BNE 测试
      setupALU(dut, BNE, 10.U, 20.U, offset, pc)
      dut.io.branch_out.expect(true.B)
      dut.io.jump_addr.expect("h1100".U)

      // BLT 测试
      setupALU(dut, BLT, "h80000000".U, 0.U, offset, pc)
      dut.io.branch_out.expect(true.B)  // 负数 < 0

      // BGE 测试
      setupALU(dut, BGE, 10.U, 5.U, offset, pc)
      dut.io.branch_out.expect(true.B)  // 10 >= 5

      // BLTU 测试
      setupALU(dut, BLTU, 5.U, 10.U, offset, pc)
      dut.io.branch_out.expect(true.B)  // 5 < 10

      // BGEU 测试
      setupALU(dut, BGEU, "h80000000".U, 1.U, offset, pc)
      dut.io.branch_out.expect(true.B)  // 2^31 > 1 (无符号)
    }
  }

  // 跳转指令测试
  it should "正确执行跳转指令" in {
    test(new ALU) { dut =>
      import RV32IInstructions._
      val pc = "h1000".U
      val offset = "h100".U

      // JAL 测试
      setupALU(dut, JAL, 0.U, 0.U, offset, pc)
      dut.io.result_out.expect("h1004".U)  // PC+4 保存到寄存器
      dut.io.branch_out.expect(true.B)     // 无条件跳转
      dut.io.jump_addr.expect("h1100".U)   // PC+offset

      // JALR 测试
      setupALU(dut, JALR, "h2000".U, 0.U, "h100".U, pc)
      dut.io.result_out.expect("h1004".U)  // PC+4 保存到寄存器
      dut.io.branch_out.expect(true.B)     // 无条件跳转
      dut.io.jump_addr.expect("h2100".U)   // src1+offset
    }
  }

  // 访存指令测试
  it should "正确计算访存地址" in {
    test(new ALU) { dut =>
      import RV32IInstructions._

      // 加载指令
      setupALU(dut, LW, "h1000".U, 0.U, "h20".U)
      dut.io.result_out.expect("h1020".U)
      dut.io.is_load.expect(true.B)
      dut.io.is_store.expect(false.B)

      // 不同类型的加载指令
      Seq(LB, LH, LBU, LHU).foreach { instr =>
        setupALU(dut, instr, "h1000".U, 0.U, "h24".U)
        dut.io.result_out.expect("h1024".U)
        dut.io.is_load.expect(true.B)
      }

      // 存储指令
      setupALU(dut, SW, "h1000".U, "hABCDEF01".U, "h28".U)
      dut.io.result_out.expect("h1028".U)
      dut.io.is_load.expect(false.B)
      dut.io.is_store.expect(true.B)

      // 不同类型的存储指令
      Seq(SB, SH).foreach { instr =>
        setupALU(dut, instr, "h1000".U, "hABCDEF01".U, "h2C".U)
        dut.io.result_out.expect("h102C".U)
        dut.io.is_store.expect(true.B)
      }
    }
  }

  // valid和flush控制测试
  it should "正确响应valid和flush信号" in {
    test(new ALU) { dut =>
      import RV32IInstructions._

      // 正常计算
      setupALU(dut, ADD, 10.U, 20.U)
      dut.io.result_out.expect(30.U)
      dut.io.valid_out.expect(true.B)

      // flush时应该无效
      setupALU(dut, ADD, 10.U, 20.U)
      dut.io.flush_in.poke(true.B)
      dut.io.result_out.expect(0.U)
      dut.io.valid_out.expect(false.B)

      // invalid时应该无效
      setupALU(dut, ADD, 10.U, 20.U)
      dut.io.flush_in.poke(false.B)
      dut.io.valid_in.poke(false.B)
      dut.io.result_out.expect(0.U)
      dut.io.valid_out.expect(false.B)
    }
  }
}