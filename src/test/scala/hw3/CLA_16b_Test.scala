package hw3

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import scala.util.Random

class CLA_16b_Test extends AnyFlatSpec with ChiselScalatestTester {
  "CLA_16b" should "correctly compute sum and carry-out" in {
    test(new CLA_16b()) { dut =>
      val rand = new Random()

      for (_ <- 0 until 1000) { // 进行1000次随机测试
        val a = rand.nextInt(65536) // 16位无符号整数
        val b = rand.nextInt(65536) // 16位无符号整数
        val cin = rand.nextInt(2)   // 0或1

        val expectedSum = (a + b + cin) & 0xFFFF // 16位加法取低16位
        val expectedCout = ((a + b + cin) >> 16) & 0x1 // 进位位

        // 施加输入信号
        dut.io.a.poke(a.U)
        dut.io.b.poke(b.U)
        dut.io.cin.poke(cin.B)

        // 运行一个周期
        dut.clock.step()

        // 断言输出
        dut.io.s.expect(expectedSum.U)
        dut.io.cout.expect(expectedCout.B)
      }
    }
  }
}
