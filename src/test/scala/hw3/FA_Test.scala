package hw3

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import scala.util.Random

class FA_Test extends AnyFlatSpec with ChiselScalatestTester {
  "FA" should "pass random tests" in {
    test(new FA()) { c =>
      // 设置随机种子，确保测试可重复
      val rand = new Random(42)

      // 进行多次随机测试
      for (_ <- 0 until 100) {
        val aVal = rand.nextBoolean() // 随机布尔值
        val bVal = rand.nextBoolean()
        val cinVal = rand.nextBoolean()

        // 设置输入
        c.io.a.poke(aVal.B)
        c.io.b.poke(bVal.B)
        c.io.cin.poke(cinVal.B)

        // 计算预期输出
        val sum = (if (aVal) 1 else 0) + (if (bVal) 1 else 0) + (if (cinVal) 1 else 0)
        val expectedS = (sum % 2) == 1 // 和的低位
        val expectedCout = sum >= 2 // 进位

        // 验证输出
        c.io.s.expect(expectedS.B)
        c.io.cout.expect(expectedCout.B)
      }
    }
  }
}