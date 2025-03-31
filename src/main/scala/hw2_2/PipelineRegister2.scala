package hw2_2

import chisel3._
import chisel3.util._

class PipelineRegister2(width: Int) extends Module {
  val io = IO(new Bundle {
    val stall_in = Input(Bool())
    val data_in = Input(UInt(width.W))
    val data_out = Output(UInt(width.W))
  })

  val reg = RegEnable(io.data_in,1.U(width.W),io.stall_in)

  io.data_out := reg
}

//val reg = RegEnable(next = io.data_in, enable = !io.stall_in, init = 1.U(width.W))