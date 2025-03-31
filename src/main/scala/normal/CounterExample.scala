package normal

import chisel3._
import chisel3.util._

class CounterExample extends Module {
  val io = IO(new Bundle {
    val count = Output(UInt(4.W))
    val wrap = Output(Bool())
  })

  // 创建一个计数器，每次时钟周期递增，计数范围为0到15
  val (counterValue, counterWrap) = Counter(true.B, 16)//入参是一个使能信号和一个复位条件；出参是输出信号和一个是否停机的bool值

  io.count := counterValue
  io.wrap := counterWrap
}