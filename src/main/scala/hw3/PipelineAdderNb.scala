package hw3

import chisel3._
import chisel3.util._

class PipelineAdderNb(val width: Int,val pipes: Int) extends Module {
  require(width % pipes == 0, "Width must be a multiple of  pipes")

  val io = IO(new Bundle {
    val a    = Input(UInt(width.W))
    val b    = Input(UInt(width.W))
    val cin  = Input(Bool())
    val s    = Output(UInt(width.W))
    val cout = Output(Bool())
  })
  // 计算每个加法器的长度
  val lengthofadd  = width / pipes
  // 寄存输入进位值
  val regCin0 = RegInit(0.U(1.W))

  //各级寄存器构造
  val regAmid = (0 until pipes).map { i =>
    RegInit(0.U(((pipes - i) * lengthofadd).W))
  }
  val regBmid = (0 until pipes).map { i =>
    RegInit(0.U(((pipes - i) * lengthofadd).W))
  }
  val regSummid = (0 until pipes).map { i =>
    RegInit(0.U(((i + 1) * lengthofadd).W))
  }
  val regCoutmid = Seq.fill(pipes)(RegInit(false.B))

  //初始寄存器赋值
  regAmid(0) := io.a
  regBmid(0) := io.b
  regCin0 := io.cin
  //构造加法器
  val adder = Seq.fill(pipes)(Module(new CLACBANb(lengthofadd)))
  //循环连接各级加法器和寄存器
  for( i <- 0 until pipes) {

    adder(i).io.a := regAmid(i)(lengthofadd - 1, 0)
    adder(i).io.b := regBmid(i)(lengthofadd - 1, 0)
    if (i == 0) {
      adder(i).io.cin := regCin0
      regSummid(i) := adder(i).io.s
    } else {
      adder(i).io.cin := regCoutmid(i - 1)
      regSummid(i) := Cat(adder(i).io.s, regSummid(i - 1))
    }
    if (i < pipes - 1) {
      regAmid(i + 1) := regAmid(i)(lengthofadd * (pipes - i) - 1, lengthofadd)
      regBmid(i + 1) := regBmid(i)(lengthofadd * (pipes - i) - 1, lengthofadd)
    }
    regCoutmid(i) := adder(i).io.cout

  }
  //求和和进位结果输出
  io.s := regSummid(pipes - 1)
  io.cout := regCoutmid(pipes - 1)
}
