package riscv_core

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class IDTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "ID Module"

  // 创建固定的指令编码
  val ADD_INSTR = "b00000000001100010000000010110011".U   // add x1, x2, x3
  val SUB_INSTR = "b01000000010000010000001000110011".U   // sub x4, x2, x4
  val LW_INSTR  = "b00000000010000100010001010000011".U   // lw x5, 8(x4)
  val SW_INSTR  = "b00000000010100100010000000100011".U   // sw x5, 0(x4)
  val BEQ_INSTR = "b00000000010101010000010001100011".U   // beq x10, x5, 8

  it should "decode basic instructions correctly" in {
    test(new ID) { dut =>
      // 设置第一条指令为ADD
      dut.io.fetch_in_0.instr.poke(ADD_INSTR)
      dut.io.fetch_in_0.pc.poke(0x100.U)
      dut.io.fetch_in_0.valid.poke(true.B)

      // 设置第二条指令为SUB
      dut.io.fetch_in_1.instr.poke(SUB_INSTR)
      dut.io.fetch_in_1.pc.poke(0x104.U)
      dut.io.fetch_in_1.valid.poke(true.B)

      // 设置寄存器值
      dut.io.reg_data_0_0.poke(10.U)  // rs1 = x2 = 10
      dut.io.reg_data_0_1.poke(20.U)  // rs2 = x3 = 20
      dut.io.reg_data_1_0.poke(30.U)  // rs1 = x2 = 30
      dut.io.reg_data_1_1.poke(40.U)  // rs2 = x4 = 40

      // 流水线控制
      dut.io.flush_in.poke(false.B)
      dut.io.stall_in.poke(false.B)

      // 验证寄存器读地址
      dut.io.reg_read_addr_0_0.expect(2.U)  // ADD的rs1为x2
      dut.io.reg_read_addr_0_1.expect(3.U)  // ADD的rs2为x3
      dut.io.reg_read_addr_1_0.expect(2.U)  // SUB的rs1为x2
      dut.io.reg_read_addr_1_1.expect(4.U)  // SUB的rs2为x4

      // 验证解码结果
      dut.io.decode_out_0.instr_id.expect(RV32IInstructions.ADD)
      dut.io.decode_out_0.rd.expect(1.U)
      dut.io.decode_out_0.rdWen.expect(true.B)

      dut.io.decode_out_1.instr_id.expect(RV32IInstructions.SUB)
      dut.io.decode_out_1.rd.expect(4.U)
      dut.io.decode_out_1.rdWen.expect(true.B)

      // 验证有效信号
      dut.io.valid_out_0.expect(true.B)
      dut.io.valid_out_1.expect(true.B)  // 双发射有效
    }
  }

  it should "handle data forwarding correctly" in {
    test(new ID) { dut =>
      // 设置LW指令
      dut.io.fetch_in_0.instr.poke(LW_INSTR)
      dut.io.fetch_in_0.pc.poke(0x100.U)
      dut.io.fetch_in_0.valid.poke(true.B)

      // 寄存器值
      dut.io.reg_data_0_0.poke(100.U)  // rs1 = x4 = 100

      // 来自EX阶段的前馈
      dut.io.ex_forward_0.rd.poke(4.U)       // EX阶段正在写x4
      dut.io.ex_forward_0.rdWen.poke(true.B)
      dut.io.ex_forward_0.result.poke(200.U)  // 新值为200
      dut.io.ex_forward_0.is_load.poke(false.B)

      // 验证前馈生效
      dut.clock.step()
      dut.io.decode_out_0.rs1_data.expect(200.U)  // 应该使用EX阶段的前馈值
    }
  }

  it should "detect and handle load-use hazards" in {
    test(new ID) { dut =>
      // 第一条指令是LW
      dut.io.fetch_in_0.instr.poke(LW_INSTR) // lw x5, 8(x4)
      dut.io.fetch_in_0.valid.poke(true.B)

      // 第二条指令需要使用x5
      dut.io.fetch_in_1.instr.poke(BEQ_INSTR) // beq x10, x5, 8
      dut.io.fetch_in_1.valid.poke(true.B)

      // 设置EX阶段有加载指令
      dut.io.ex_forward_0.rd.poke(5.U)       // EX阶段正在加载到x5
      dut.io.ex_forward_0.rdWen.poke(true.B)
      dut.io.ex_forward_0.is_load.poke(true.B)

      // 验证单发射请求
      dut.io.valid_out_1.expect(false.B) // 第二条指令不能发射
    }
  }

  it should "disable dual-issue when RAW dependency exists" in {
    test(new ID) { dut =>
      // 更清晰的替代方案
      val ADD_X5_INSTR = "b00000000000100010000001010110011".U  // add x5, x2, x3
      val SUB_X5_RS1_INSTR = "b01000000010000101000001000110011".U  // sub x4, x5, x4

      // 第一条指令写入x5
      dut.io.fetch_in_0.instr.poke(ADD_X5_INSTR)
      dut.io.fetch_in_0.valid.poke(true.B)

      // 第二条指令读取x5
      dut.io.fetch_in_1.instr.poke(SUB_X5_RS1_INSTR)
      dut.io.fetch_in_1.valid.poke(true.B)

      // 验证不能双发射
      dut.io.valid_out_1.expect(false.B)
    }
  }

  it should "respect flush and stall signals" in {
    test(new ID) { dut =>
      // 设置有效指令
      dut.io.fetch_in_0.instr.poke(ADD_INSTR)
      dut.io.fetch_in_0.valid.poke(true.B)
      dut.io.fetch_in_1.instr.poke(SUB_INSTR)
      dut.io.fetch_in_1.valid.poke(true.B)

      // 设置刷新信号
      dut.io.flush_in.poke(true.B)

      // 验证输出无效
      dut.io.valid_out_0.expect(false.B)
      dut.io.valid_out_1.expect(false.B)

      // 切换到停顿信号
      dut.io.flush_in.poke(false.B)
      dut.io.stall_in.poke(true.B)

      // 验证输出无效
      dut.io.valid_out_0.expect(false.B)
      dut.io.valid_out_1.expect(false.B)
    }
  }
}
