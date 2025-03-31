package hw2_3
import chisel3._
import chiseltest._
import org.scalatest.flatspec._
import org.scalatest.matchers.should.Matchers

class addtesterbench extends AnyFlatSpec with ChiselScalatestTester with Matchers {
  "Top Module" should "correctly add inputs" in {
    test(new top1()) { c =>
      // 设置输入值
      c.io.in0.poke(10.U)
      c.io.in1.poke(20.U)
      c.io.in2.poke(30.U)
      c.io.in3.poke(40.U)

      // 运行仿真
      c.clock.step(1)

      // 获取输出值并转换为 BigInt
      val outputValue = BigInt(c.io.out.peek().litValue.toString)

      // 验证输出
      outputValue should be (100)
    }
  }
}