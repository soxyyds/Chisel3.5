package hw3

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import scala.util.Random

class CBA_4b_Test extends AnyFlatSpec with ChiselScalatestTester {
  "CBA_4b" should "pass random test cases" in {
    test(new CBA_4b) { c =>
      // 设置随机种子，确保测试可重复
      val rand = new Random(42)

      // 进行多次随机测试
      for (_ <- 0 until 100) {
        val aVal = rand.nextInt(16)  // 随机生成 4 位数（0 到 15）
        val bVal = rand.nextInt(16)  // 随机生成 4 位数（0 到 15）
        val cinVal = rand.nextInt(2) // 随机生成进位输入，0 或 1

        // 设置输入
        c.io.a.poke(aVal.U)
        c.io.b.poke(bVal.U)
        c.io.cin.poke(cinVal.B)

        // 计算预期输出
        val sum = aVal + bVal + cinVal
        val expectedS = (sum % 16).U // 计算和的低 4 位
        val expectedCout = (sum >= 16).B // 计算进位输出

        // 使用 expect 验证输出
        c.io.s.expect(expectedS)
        c.io.cout.expect(expectedCout)
      }
    }
  }
}