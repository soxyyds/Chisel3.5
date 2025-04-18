package pipectrl

import chisel3._
import chisel3.stage.ChiselStage
import chisel3.util._



class forward2 extends Module {
  val io = IO(new Bundle {
    val id_rs1_1 = Input(UInt(5.W)) // 第二条指令的源寄存器1
    val id_rs2_1 = Input(UInt(5.W)) // 第二条指令的源寄存器2
    val id_rd_0 = Input(UInt(5.W)) // 第一条指令的目标寄存器
    val id_rdwen_0 = Input(Bool()) // 第一条指令是否写寄存器

    val stallex = Output(Bool()) // 流水线停顿请求
  })

  val sel1 = io.id_rdwen_0 && (io.id_rd_0 =/= 0.U) && (io.id_rd_0 === io.id_rs1_1)
  val sel2 = io.id_rdwen_0 && (io.id_rd_0 =/= 0.U) && (io.id_rd_0 === io.id_rs2_1)
  io.stallex := sel1 || sel2

}

object Generateforward2Verilog extends App {
  (new ChiselStage).emitVerilog(new forward2(), Array("--target-dir", "generated"))
}



