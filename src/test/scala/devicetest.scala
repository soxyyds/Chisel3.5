import chisel3._
import chiseltest._
import normal.DeviceUnderTest
import org.scalatest.flatspec.AnyFlatSpec

class devicetest extends AnyFlatSpec with ChiselScalatestTester {
  "DUT" should "pass" in {
    test(new DeviceUnderTest) { dut =>
      for (a <- 0 until 4) {
        for (b <- 0 until 4) {
          dut.io.a.poke(a.U)
          dut.io.b.poke(b.U)
          dut.clock.step()
        }
      }
    }
  }
}