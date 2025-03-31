package hw3

import chisel3._
import chisel3.util._

class CLACBANb(val width: Int) extends Module {
  require(width > 0, "Width must be positive")

  val io = IO(new Bundle {
    val a    = Input(UInt(width.W))
    val b    = Input(UInt(width.W))
    val cin  = Input(Bool())
    val s    = Output(UInt(width.W))
    val cout = Output(Bool())
  })

  // 计算所需要的模块数
  val nBlocks = if (width % 4 == 0) width / 4 else (width / 4 + 1)
  val extWidth = nBlocks * 4
  val extra = extWidth - width

  // 拓展输入至四的整数倍

  val a_ext = if(extra > 0) Cat(0.U(extra.W), io.a) else io.a
  val b_ext = if(extra > 0) Cat(0.U(extra.W), io.b) else io.b

  // 生成求和和进位的向量组
  val sums    = Wire(Vec(nBlocks, UInt(4.W)))
  val carries = Wire(Vec(nBlocks + 1, Bool()))
  carries(0) := io.cin

  // 第一部分是超前进位加法器单元
  val claFirst = Module(new CLA_4b)
  claFirst.io.a   := a_ext(3, 0)
  claFirst.io.b   := b_ext(3, 0)
  claFirst.io.c_i := carries(0)
  sums(0)         := claFirst.io.s
  carries(1)      := claFirst.io.cg4 | (claFirst.io.cp4 & carries(0))

  // 中间部分是旁路进位加法器单元
  for (i <- 1 until nBlocks - 1) {
    val cba = Module(new CBA_4b)
    cba.io.a   := a_ext(4*i+3, 4*i)
    cba.io.b   := b_ext(4*i+3, 4*i)
    cba.io.cin := carries(i)
    sums(i)    := cba.io.s
    carries(i+1) := cba.io.cout
  }

  // 最后一个也是超前进位加法器单元

  val claLast = Module(new CLA_4b)
  claLast.io.a   := a_ext(4*(nBlocks-1)+3, 4*(nBlocks-1))
  claLast.io.b   := b_ext(4*(nBlocks-1)+3, 4*(nBlocks-1))
  claLast.io.c_i := carries(nBlocks - 1)
  sums(nBlocks - 1) := claLast.io.s
  carries(nBlocks)  := claLast.io.cg4 | (claLast.io.cp4 & carries(nBlocks - 1))



  // 求和结果
  val fullSum = sums.reverse.reduce(Cat(_, _))
  io.s := fullSum( (extWidth - extra) - 1, 0)

  //进位结果
  val finalCout = if (extra > 0) fullSum(extWidth - extra) else carries(nBlocks)
  io.cout := finalCout
}