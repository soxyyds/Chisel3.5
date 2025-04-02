package hw3

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import scala.util.Random

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import scala.util.Random

class CLA_4b_Test extends AnyFlatSpec with ChiselScalatestTester {
  "CLA_4b" should "pass random test cases" in {
    test(new CLA_4b) { c =>
      // 设置随机种子，确保测试可重复
      val rand = new Random(42)

      // 进行多次随机测试
      for (_ <- 0 until 100) {
        val aVal = rand.nextInt(16)  // 随机生成 4 位数（0 到 15）
        val bVal = rand.nextInt(16)  // 随机生成 4 位数（0 到 15）
        val c_iVal = rand.nextInt(2) // 随机生成进位输入，0 或 1

        // 设置输入
        c.io.a.poke(aVal.U)
        c.io.b.poke(bVal.U)
        c.io.c_i.poke(c_iVal.U)

        // 计算预期输出
        val sum = aVal + bVal + c_iVal
        val expectedS = (sum % 16).U // 计算和的低 4 位


        // 使用 expect 验证输出
        c.io.s.expect(expectedS)

      }
    }
  }
}

//我更新了一下

//我更新了两下

//我更新了三下

//我更新了四下

//我更新了五下

//我更新了六下

//我更新了七下

//我更新了八下