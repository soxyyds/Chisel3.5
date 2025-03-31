package hw2_3
import chisel3._

class top3 extends Module {
  val io = IO(
    new Bundle {
      val in0 = Input(UInt(32.W))
      val in1 = Input(UInt(32.W))
      val in2 = Input(UInt(32.W))
      val in3 = Input(UInt(32.W))
      val out = Output(UInt(32.W))
    })

  val adder = (a: UInt, b: UInt) => a + b

  val a1 = adder(io.in0, io.in1)
  val a2 = adder(io.in2, io.in3)

  io.out := adder(a1, a2)
}
