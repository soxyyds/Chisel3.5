package normal

import chisel3._
import chisel3.util.random.LFSR

class LFSRExample extends Module {
  val io = IO(new Bundle {
    val randomOut = Output(UInt(16.W))
  })

  // 创建一个 16 位宽度的 LFSR 实例，使用递增模式和种子值 1
  val lfsr = LFSR(16, increment = true.B, seed = Some(1))//true.B递增，false.B递减；

  // 将 LFSR 的输出连接到模块的输出端口
  io.randomOut := lfsr
}