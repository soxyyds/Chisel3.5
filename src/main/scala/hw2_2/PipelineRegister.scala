package hw2_2

import chisel3._

class PipelineRegister(width: Int) extends Module {
  val io = IO(new Bundle {
    val stall_in = Input(Bool())
    val data_in = Input(UInt(width.W))
    val data_out = Output(UInt(width.W))
  })

  val reg = RegInit(1.U(width.W))

  when(io.stall_in) {
    // 当stall_in为高时，保持寄存器原值
    reg := reg
  } .otherwise {
    // 当stall_in为低时，寄存data_in信号
    reg := io.data_in
  }

  io.data_out := reg
}