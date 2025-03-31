package hw3

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import scala.util.Random

class PipeLineAdder32bTester extends AnyFlatSpec with ChiselScalatestTester {
  "PipeLineAdder32b" should "process new inputs every cycle with 2-cycle delay" in {
    test(new PipeLineAdder32b) { dut =>
      val rand = new Random()
      val inputs = scala.collection.mutable.Queue[(BigInt, BigInt, Boolean)]()

      for (cycle <- 0 until 10) {
        // Generate random inputs for each cycle
        val a = BigInt(32, rand)
        val b = BigInt(32, rand)
        val cin = rand.nextBoolean()
        inputs.enqueue((a, b, cin))
        println(s"Cycle $cycle -> a = 0x${a.toString(16)}, b = 0x${b.toString(16)}, cin = $cin")

        // Apply new inputs
        dut.io.a.poke(a.U)
        dut.io.b.poke(b.U)
        dut.io.cin.poke(cin.B)

        // Step the clock
        dut.clock.step(1)

         //After two cycles, check output for the earliest enqueued input
        if (cycle >= 2) {
          val (oldA, oldB, oldCin) = inputs.dequeue()
          val expected = oldA + oldB + (if (oldCin) 1 else 0)
          val expSum = expected & ((BigInt(1) << 32) - 1)
          val expCout = (expected >> 32) & 1
          println(s"Cycle $cycle -> s = 0x${dut.io.s.peek().litValue.toString(16)}, " +
            s"cout = ${dut.io.cout.peek().litValue}")
//           Optional checks
          dut.io.s.expect(expSum.U)
          dut.io.cout.expect(expCout.B)
        }
      }
    }
  }
}