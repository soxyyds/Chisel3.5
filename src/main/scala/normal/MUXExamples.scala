package normal

import chisel3._
import chisel3.util._

class MUXExamples extends Module {
  val io = IO(new Bundle {
    val sel = Input(UInt(2.W))
    val in0 = Input(UInt(8.W))
    val in1 = Input(UInt(8.W))
    val in2 = Input(UInt(8.W))
    val in3 = Input(UInt(8.W))
    val out_mux = Output(UInt(8.W))
    val out_muxLookup = Output(UInt(8.W))
    val out_muxCase = Output(UInt(8.W))
    val out_priorityMux = Output(UInt(8.W))
  })

  // Mux (二选一) 入参有选择信号和两种带选择信号，出参为胜选信号
  io.out_mux := Mux(io.sel === 0.U, io.in0, io.in1)

  // MuxLookup (查找表方式)入参有选择信号，默认信号，映射表，出参为胜选信号
  io.out_muxLookup := MuxLookup(io.sel, io.in0, Array(
    0.U -> io.in0,
    1.U -> io.in1,
    2.U -> io.in2,
    3.U -> io.in3
  ))

  // MuxCase (类似case语句) 入参有默认信号和 case表，出参为胜选信号，等价于MUX的嵌套实现，匹配的第一个输出
  io.out_muxCase := MuxCase(io.in0, Array(
    (io.sel === 1.U) -> io.in1,
    (io.sel === 2.U) -> io.in2,
    (io.sel === 3.U) -> io.in3
  ))

  // PriorityMux (优先级多路选择器) 入参为条件与输出的映射关系，出参是根据第一个匹配的条件胜选的信号，所有条件均不成立默认最后一个。
  io.out_priorityMux := PriorityMux(Seq(
    (io.sel === 3.U) -> io.in3,
    (io.sel === 2.U) -> io.in2,
    (io.sel === 1.U) -> io.in1,
    (io.sel === 0.U) -> io.in0
  ))
  
}
