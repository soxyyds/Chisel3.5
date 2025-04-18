package pipectrl

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class forward2Test extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "forward2"

  it should "不产生停顿当无依赖时" in {
    test(new forward2) { dut =>
      // 第一条指令写r1
      dut.io.id_rd_0.poke(1.U)
      dut.io.id_rdwen_0.poke(true.B)

      // 第二条指令使用r2和r3
      dut.io.id_rs1_1.poke(2.U)
      dut.io.id_rs2_1.poke(3.U)

      dut.io.stallex.expect(false.B)
    }
  }

  it should "产生停顿当第二条指令rs1依赖第一条指令rd时" in {
    test(new forward2) { dut =>
      // 第一条指令写r5
      dut.io.id_rd_0.poke(5.U)
      dut.io.id_rdwen_0.poke(true.B)

      // 第二条指令使用r5
      dut.io.id_rs1_1.poke(5.U)
      dut.io.id_rs2_1.poke(6.U)

      dut.io.stallex.expect(true.B)
    }
  }

  it should "产生停顿当第二条指令rs2依赖第一条指令rd时" in {
    test(new forward2) { dut =>
      // 第一条指令写r7
      dut.io.id_rd_0.poke(7.U)
      dut.io.id_rdwen_0.poke(true.B)

      // 第二条指令使用r7
      dut.io.id_rs1_1.poke(8.U)
      dut.io.id_rs2_1.poke(7.U)

      dut.io.stallex.expect(true.B)
    }
  }

  it should "产生停顿当第二条指令rs1和rs2都依赖第一条指令rd时" in {
    test(new forward2) { dut =>
      // 第一条指令写r4
      dut.io.id_rd_0.poke(4.U)
      dut.io.id_rdwen_0.poke(true.B)

      // 第二条指令rs1和rs2都使用r4
      dut.io.id_rs1_1.poke(4.U)
      dut.io.id_rs2_1.poke(4.U)

      dut.io.stallex.expect(true.B)
    }
  }

  it should "不产生停顿当目标寄存器是x0时" in {
    test(new forward2) { dut =>
      // 第一条指令写x0（实际上x0不可写）
      dut.io.id_rd_0.poke(0.U)
      dut.io.id_rdwen_0.poke(true.B)

      // 第二条指令使用x0
      dut.io.id_rs1_1.poke(0.U)
      dut.io.id_rs2_1.poke(0.U)

      dut.io.stallex.expect(false.B)
    }
  }

  it should "不产生停顿当第一条指令不写寄存器时" in {
    test(new forward2) { dut =>
      // 第一条指令不写寄存器
      dut.io.id_rd_0.poke(5.U)
      dut.io.id_rdwen_0.poke(false.B)

      // 第二条指令使用r5
      dut.io.id_rs1_1.poke(5.U)
      dut.io.id_rs2_1.poke(5.U)

      dut.io.stallex.expect(false.B)
    }
  }
}