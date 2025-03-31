package hw3

import chisel3._
import chisel3.util._


// 1-bit全加器单元
class FA extends Module {
  val io = IO(new Bundle {
    val a   = Input(Bool())
    val b   = Input(Bool())
    val cin = Input(Bool())
    val s = Output(Bool())
    val cout = Output(Bool())
  })
  io.s := io.a ^ io.b ^ io.cin
  io.cout := (io.a & io.b) | (io.cin & (io.a ^ io.b))
}

//4bit行波进位加法器
class RCA_4b extends Module{
  val io =IO(new Bundle{
    val a = Input(UInt(4.W))
    val b = Input(UInt(4.W))
    val cin = Input(Bool())
    val s = Output(UInt(4.W))
    val cout = Output(Bool())
  })


  val c = Wire(Vec(5, Bool()))

  c(0) := io.cin

  for(i <- 0 until 4 ){
    c(i + 1) := (io.a(i) & io.b(i)) | (c(i) & (io.a(i) ^ io.b(i)))
  }

  io.cout := c(4)
  io.s := io.a ^ io.b ^ Cat(c.reverse)

}




//4bit超前进位加法器
class CLA_4b extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(4.W))
    val b = Input(UInt(4.W))
    val c_i = Input(UInt(1.W))
    val cp4 = Output(UInt(1.W))
    val cg4 = Output(UInt(1.W))
    val s = Output(UInt(4.W))
  })

  // 修改cp和cg为UInt类型
  val cp = Wire(UInt(4.W)) // 修改为UInt(4.W)
  val cg = Wire(UInt(4.W)) // 修改为UInt(4.W)

  // 计算cp和cg
  cp := io.a | io.b
  cg := io.a & io.b

  val c = Wire(Vec(4, UInt(1.W)))

  // 更新进位计算公式
  c(0) := io.c_i
  c(1) := cg(0) | (io.c_i & cp(0))
  c(2) := cg(1) | (cp(1) & cg(0)) | (cp(1) & cp(0) & io.c_i)
  c(3) := cg(2) | (cp(2) & cg(1)) | (cp(2) & cp(1) & cg(0)) | (cp(2) & cp(1) & cp(0) & io.c_i)

  // 计算输出s
  io.s := io.a ^ io.b ^ Cat(c.reverse)

  // 输出cp4和cg4
  io.cp4 := (cp(3) & cp(2) & cp(1) & cp(0))
  io.cg4 := (cg(3) | (cp(3) & cg(2)) | (cp(3) & cp(2) & cg(1)) | (cp(3) & cp(2) & cp(1) & cg(0)))
}



//4bit选择进位加法器
class CSA_4b extends Module{
  val io = IO(new Bundle{
    val cin = Input(Bool())
    val a = Input(UInt(4.W))
    val b = Input(UInt(4.W))
    val s = Output(UInt(4.W))
    val cout = Output(Bool())
  })

  // 实例化两个4位行波进位加法器
  val rca0 = Module(new RCA_4b())
  val rca1 = Module(new RCA_4b())

  // 连接输入
  rca0.io.a   := io.a
  rca0.io.b   := io.b
  rca0.io.cin := 0.B

  rca1.io.a   := io.a
  rca1.io.b   := io.b
  rca1.io.cin := 1.B

  // 根据cin选择正确的部分和与进位
  io.s    := Mux(io.cin, rca1.io.s, rca0.io.s)
  io.cout := Mux(io.cin, rca1.io.cout, rca0.io.cout)
}


//4bit进位旁路加法器
class CBA_4b extends Module{
  val io = IO(new Bundle{
    val a = Input(UInt(4.W))
    val b = Input(UInt(4.W))
    val cin = Input(Bool())
    val s = Output(UInt(4.W))
    val cout = Output(Bool())
  })

  val rca0 = Module(new RCA_4b)


  rca0.io.a := io.a
  rca0.io.b := io.b
  rca0.io.cin := io.cin
  io.s := rca0.io.s


  val sel = Wire(Bool())
  sel := ((io.a(1)^io.b(1)) & (io.a(2)^io.b(2)) & (io.a(3)^io.b(3)) & (io.a(0)^io.b(0)))
  io.cout := Mux(sel, io.cin ,rca0.io.cout)
}

//16bit超前进位加法器
class CLA_16b extends Module{
  val io = IO(new Bundle{
    val a = Input(UInt(16.W))
    val b = Input(UInt(16.W))
    val cin = Input(Bool())
    val s = Output(UInt(16.W))
    val cout = Output(Bool())
  })

  val cla = Seq.fill(4)(Module(new CLA_4b()))

  val c = Wire(Vec(5, UInt(1.W)))
  c(0) := io.cin


  for(i <- 0 until 4){
    cla(i).io.a := io.a((i + 1) * 4 - 1, i * 4)
    cla(i).io.b := io.b((i + 1) * 4 - 1, i * 4)
    cla(i).io.c_i := c(i)
//    c(i+1) := cla(i).io.cg4 | (cla(i).io.cp4 & c(i))
  }


  c(1) := cla(0).io.cg4 | (io.cin & cla(0).io.cp4)
  c(2) := cla(1).io.cg4 | (cla(1).io.cp4 & cla(0).io.cg4)  | (cla(1).io.cp4 & cla(0).io.cp4 & io.cin)
  c(3) := cla(2).io.cg4 | (cla(2).io.cp4 & cla(1).io.cg4) | (cla(2).io.cp4 & cla(1).io.cp4 & cla(0).io.cg4) | (cla(2).io.cp4 & cla(1).io.cp4 & cla(0).io.cp4 & io.cin)
  c(4) := (cla(3).io.cg4 | (cla(3).io.cp4 & cla(2).io.cg4) | (cla(3).io.cp4 & cla(2).io.cp4 & cla(1).io.cg4) | (cla(3).io.cp4 & cla(2).io.cp4 & cla(1).io.cp4 & cla(0).io.cg4)) | (cla(3).io.cp4 & cla(2).io.cp4 & cla(1).io.cp4 & cla(0).io.cp4 & io.cin)
  io.s := Cat(cla(3).io.s, cla(2).io.s, cla(1).io.s, cla(0).io.s)
  io.cout := c(4)
}

