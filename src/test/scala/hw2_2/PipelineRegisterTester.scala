package hw2_2

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class PipelineRegisterTester extends AnyFlatSpec with ChiselScalatestTester {
  "PipelineRegister" should "work correctly" in {
    test(new PipelineRegister(8)).withAnnotations(Seq(WriteVcdAnnotation)) { c =>
      // 初始化
      c.io.stall_in.poke(true.B)
      c.io.data_in.poke(0xAA.U)
      c.clock.step(1)
      c.io.data_out.expect(1.U) // 复位值为1

      // 测试stall_in为低时，data_in被寄存
      c.io.stall_in.poke(false.B)
      c.io.data_in.poke(0x55.U)
      c.clock.step(1)
      c.io.data_out.expect(0x55.U)

      // 测试stall_in为高时，寄存器保持原值
      c.io.stall_in.poke(true.B)
      c.io.data_in.poke(0xAA.U)
      c.clock.step(1)
      c.io.data_out.expect(0x55.U)
    }
  }
}
