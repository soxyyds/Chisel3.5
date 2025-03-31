package hw3

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import scala.util.Random

class PipelineAdderNbRandomTest extends AnyFlatSpec with ChiselScalatestTester {
  "PipelineAdderNb" should "pass random tests with random width and valid pipes (all printed in decimal)" in {
    test({
      val rand = new Random()
      // Select a width between 16 and 128 that has at least one valid pipes (>=2 and yields lengthofadd >=2)
      var width = 0
      var validPipes: Seq[Int] = Seq.empty
      do {
        width = rand.nextInt(128 - 16 + 1) + 16
        validPipes = (2 to 8).filter(x => width % x == 0 && (width / x >= 2))
      } while (validPipes.isEmpty)
      // Choose a random pipes value from the valid ones
      val pipes = validPipes(rand.nextInt(validPipes.length))

      println(s"Selected width: $width")
      println(s"Selected pipes: $pipes")
      new PipelineAdderNb(width, pipes)
    }) { dut =>
      val rand = new Random()
      // Queue to save inputs for later comparison (pipeline delay of 'pipes' cycles)
      val inputs = scala.collection.mutable.Queue[(BigInt, BigInt, Boolean)]()
      println("Starting PipelineAdderNb random test (all values in decimal):")
      // Run for a number of cycles
      for (cycle <- 0 until 10) {
        // Generate random inputs matching the DUT width
        val a = BigInt(dut.width, rand)
        val b = BigInt(dut.width, rand)
        val cin = rand.nextBoolean()
        inputs.enqueue((a, b, cin))

        dut.io.a.poke(a.U)
        dut.io.b.poke(b.U)
        dut.io.cin.poke(cin.B)
        println(s"Cycle $cycle -> Input: a = ${a.toString}, b = ${b.toString}, cin = ${if (cin) 1 else 0}")
        dut.clock.step(1)

        // After 'pipes' cycles, dequeue the earliest inputs and check the outputs.
        if (cycle >= dut.asInstanceOf[PipelineAdderNb].pipes) {
          val (oldA, oldB, oldCin) = inputs.dequeue()
          val expected = oldA + oldB + (if (oldCin) 1 else 0)
          val expSum = expected & ((BigInt(1) << dut.width) - 1)
          val expCout = (expected >> dut.width) & 1

          val actualSum = dut.io.s.peek().litValue
          val actualCout = dut.io.cout.peek().litValue
          println(s"Cycle $cycle -> Output: sum = ${actualSum.toString}, cout = ${actualCout.toString} | Expected: sum = ${expSum.toString}, cout = ${expCout.toString}")

          dut.io.s.expect(expSum.U, s"Cycle $cycle: Sum mismatch")
          dut.io.cout.expect(expCout.B, s"Cycle $cycle: Carry mismatch")
        }
      }
    }
  }
}