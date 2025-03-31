package hw2_3
import chisel3._



class top1 extends Module {
  val io = IO(
    new Bundle {
      val in0 = Input(UInt(32.W))
      val in1 = Input(UInt(32.W))
      val in2 = Input(UInt(32.W))
      val in3 = Input(UInt(32.W))
      val out = Output(UInt(32.W))
    })

  val a1 = adder(io.in0, io.in1)
  val a2 = adder(io.in2, io.in3)

  io.out := adder(a1, a2)


}

object adder {

  def apply(a: UInt, b: UInt): UInt = {
    a+b
  }
}

object top1 extends App{
  emitVerilog(new top1())
}





