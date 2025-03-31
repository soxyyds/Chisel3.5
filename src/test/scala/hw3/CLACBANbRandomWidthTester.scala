package hw3

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import scala.util.Random

class CLACBANbRandomWidthTester extends AnyFlatSpec with ChiselScalatestTester {
  "CLACSANb" should "pass random tests with I/O printing" in {
    test({
      val rand = new Random()
      //生成大于等于2小于128的随机数
     val width = rand.nextInt(126) + 2
      new CLACBANb(width)
    }) { dut =>
      println(s"Selected width: ${dut.width}")
      val rand = new Random()
      for (_ <- 0 until 10) {
        val a = BigInt(dut.width, rand)
        val b = BigInt(dut.width, rand)
        val cin = rand.nextBoolean()

        dut.io.a.poke(a.U)
        dut.io.b.poke(b.U)
        dut.io.cin.poke(cin.B)

        // Calculate expected results
        val result = a + b + (if (cin) 1 else 0)
        val expSum = result & ((BigInt(1) << dut.width) - 1)
        val expCout = (result >> dut.width) & 1

        dut.clock.step(1)

        // Print both inputs and outputs for inspection
        println(s"Input: a = 0x${a.toString(16)}, b = 0x${b.toString(16)}, cin = $cin")
        println(s"Output: s = 0x${dut.io.s.peek().litValue.toString(16)}, cout = ${dut.io.cout.peek().litValue}")

        dut.io.s.expect(expSum.U, s"Expected output s: 0x${expSum.toString(16)}")
        dut.io.cout.expect(expCout.B, s"Expected output cout: $expCout")
      }
    }
  }
}