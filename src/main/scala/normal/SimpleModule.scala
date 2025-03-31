package normal

import chisel3._

//class Reg1 extends  Module{
//  val io = IO(new Bundle{
//    val d = Input(UInt(8.W))
//    val q = Output(UInt(8.W))
//  })
//  val reg = RegInit(0.U)
//  io.q :=reg
//  reg := io.d
//}
//
//class Adder1 extends Module{
//  val io = IO(new Bundle{
//    val a = Input(UInt(8.W))
//    val b = Input(UInt(8.W))
//    val y = Output(UInt(8.W))
//  })
//  io.y := io.a + io.b
//}
//
//class Count10 extends  Module{
//  val io = IO(new Bundle{
//    val dout = Output(UInt(8.W))
//  })
//  val add = Module(new Adder1())
//  val reg = Module(new Reg1())
//  val count = reg.io.q
//  add.io.a := 1.U
//  add.io.b := count
//  val result = add.io.y
//  val next = Mux(result === 10.U, 0.U, result )
//  reg.io.d := next
//  io.dout := count
//}


//class ALU extends Module{
//  val io = IO(new Bundle{
//    val a = Input(UInt(16.W))
//    val b = Input(UInt(16.W))
//    val fn = Input(UInt(2.W))
//    val y = Output(UInt(16.W))
//  })
//  io.y :=0.U
//  switch(io.fn){
//    is(0.U) {io.y := io.a + io.b}
//    is(1.U) {io.y := io.a - io.b}
//    is(2.U) {io.y := io.a | io.b}
//    is(3.U) {io.y := io.a & io.b}
//  }
//}
//
//object ALU extends App{
//  emitVerilog(new ALU())
//}

class FetchDecodeIO extends Bundle {
  val instr = Output(UInt(32.W))
  val pc = Output(UInt(32.W))
}

class Fetch extends Module {
  val io = IO(new Bundle {
    val fetchdecodeIO = new FetchDecodeIO()
    val a = Input(UInt(32.W))
    val b = Input(UInt(32.W))
  })
  // fetch阶段的实现省略
  io.fetchdecodeIO.instr := io.a
  io.fetchdecodeIO.pc := io.b
}

class DecodeExecuteIO extends Bundle {
  val aluOp = Output(UInt(5.W))
  val regA = Output(UInt(32.W))
  val regB = Output(UInt(32.W))
}

class Decode extends Module {
  val io = IO(new Bundle {
    val fetchdecodeIO = Flipped(new FetchDecodeIO())
    val decodeexecuteIO = new DecodeExecuteIO()
  })
  // decode阶段的实现省略
  io.decodeexecuteIO.aluOp := io.fetchdecodeIO.instr(5, 0)
  io.decodeexecuteIO.regA := io.fetchdecodeIO.instr
  io.decodeexecuteIO.regB := io.fetchdecodeIO.pc
}

class ExecuteTopIO extends Bundle {
  val result1 = Output(UInt(32.W))
  val result2 = Output(UInt(32.W))
}

class Execute extends Module {
  val io = IO(new Bundle {
    val decodeexecuteIO = Flipped(new DecodeExecuteIO())
    val executetopIO = new ExecuteTopIO()
  })
  // execute阶段的实现省略
  io.executetopIO.result1 := io.decodeexecuteIO.regA
  io.executetopIO.result2 := io.decodeexecuteIO.regB
}

class Top extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(32.W))
    val b = Input(UInt(32.W))
    val executetopIO = new ExecuteTopIO()
  })

  val fetch = Module(new Fetch())
  val decode = Module(new Decode())
  val execute = Module(new Execute())

  fetch.io.a := io.a
  fetch.io.b := io.b
  fetch.io.fetchdecodeIO <> decode.io.fetchdecodeIO
  decode.io.decodeexecuteIO <> execute.io.decodeexecuteIO
  io.executetopIO <> execute.io.executetopIO
}

object MyModule extends App {
  // emitVerilog(new Count10(), Array("--target-dir", "generated"))
}
