package hw3

import chisel3._
import chisel3.util._

class PipeLineAdder32b extends Module {
  val io=IO(new Bundle{
    val a = Input(UInt(32.W))
    val b = Input(UInt(32.W))
    val cin = Input(Bool())
    val s = Output(UInt(32.W))
    val cout = Output(Bool())
  })
  val cla0 = Module(new CLA_16b)
  val cla1 = Module(new CLA_16b)

  // 低16位输入寄存器
  val regA0   = RegNext(io.a(31, 0))
  val regB0   = RegNext(io.b(31, 0))
  val regCin0 = RegNext(io.cin)

  cla0.io.a := regA0(15, 0)
  cla0.io.b := regB0(15, 0)
  cla0.io.cin := regCin0

  // 低16位结果寄存器
  val regSum0 = RegNext(cla0.io.s)
  val regCout0 = RegNext(cla0.io.cout)
  val regSum1 = RegNext(cla1.io.s)
  val regSum00 = RegNext(regSum0)

  // 高16位输入寄存器
  val regA1 = RegNext(regA0(31, 16))
  val regB1 = RegNext(regB0(31, 16))

  cla1.io.a := regA1
  cla1.io.b := regB1
  cla1.io.cin := regCout0

  val regCout1 = RegNext(cla1.io.cout)

  io.s := Cat(cla1.io.s, regSum0)
  io.cout := cla1.io.cout

  //求和和进位结果输出
  io.s := Cat(regSum1,regSum00)
  io.cout := regCout1
}