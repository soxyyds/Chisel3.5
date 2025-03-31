package normal

import chisel3._
import chisel3.util._

class OHUInt extends Module {//one-hot信号所有位上只有一位有效信号
  val io = IO(new Bundle {
    val in = Input(UInt(4.W))
    val outOH = Output(UInt(4.W))
    val outUInt = Output(UInt(4.W))
  })

  // UInt to One-Hot (转换为 one-hot 编码)
  io.outOH := UIntToOH(io.in)//入参是一个UInt类型的输入信号，出参是对应的one-hot编码信号，只有一个位是1，其他位都是0

  // One-Hot to UInt (转换为普通二进制数值)
  io.outUInt := OHToUInt(io.outOH)//入参是one-hot信号，出参是UInt型表示one-hot信号对应的二进制
}//输入为3.U的情况下，io.outUInt值是3.U，io.outOH值是1000.
