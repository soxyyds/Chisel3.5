package riscv_core

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class ForwardTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "ForwardingUnit"

  it should "forward data correctly from execution stage" in {
    test(new Forward) { dut =>
      // 设置译码阶段寄存器信息
      dut.io.id_rs1_0.poke(1.U)  // 第一条指令 rs1 = x1
      dut.io.id_rs2_0.poke(2.U)  // 第一条指令 rs2 = x2
      dut.io.id_rs1_1.poke(3.U)  // 第二条指令 rs1 = x3
      dut.io.id_rs2_1.poke(4.U)  // 第二条指令 rs2 = x4

      // 寄存器文件中的原始数据
      dut.io.rs1_data_0.poke(10.U)
      dut.io.rs2_data_0.poke(20.U)
      dut.io.rs1_data_1.poke(30.U)
      dut.io.rs2_data_1.poke(40.U)

      // EX阶段有 rd1 = x1 的结果
      dut.io.ex_rd_0.poke(1.U)
      dut.io.ex_rdWen_0.poke(true.B)
      dut.io.ex_result_0.poke(100.U)
      dut.io.ex_is_load_0.poke(false.B)

      // 验证前馈逻辑
      dut.io.fwd_rs1_data_0.expect(100.U)  // 应该前馈EX阶段的结果
      dut.io.fwd_rs2_data_0.expect(20.U)   // 没有依赖,使用原始值
      dut.io.fwd_rs1_data_1.expect(30.U)   // 没有依赖,使用原始值
      dut.io.fwd_rs2_data_1.expect(40.U)   // 没有依赖,使用原始值
      dut.io.dual_issue.expect(true.B)     // 可以双发射
    }
  }

  it should "detect RAW dependency between two instructions" in {
    test(new Forward) { dut =>
      // 第一条指令写x5, 第二条指令读x5
      dut.io.id_rd_0.poke(5.U)    // 第一条指令 rd = x5
      dut.io.id_rdWen_0.poke(true.B)
      dut.io.id_rs1_1.poke(5.U)   // 第二条指令 rs1 = x5

      // 应检测到写后读依赖
      dut.io.dual_issue.expect(false.B)  // 不能双发射
    }
  }

  it should "stall pipeline for load-use hazards" in {
    test(new Forward) { dut =>
      dut.io.id_rs1_0.poke(6.U)  // 译码阶段指令使用x6

      // EX阶段有加载指令,目标是x6
      dut.io.ex_rd_0.poke(6.U)
      dut.io.ex_rdWen_0.poke(true.B)
      dut.io.ex_is_load_0.poke(true.B)

      // 应该请求停顿
      dut.io.stall_req.expect(true.B)
    }
  }
}
