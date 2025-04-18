package riscv_core

import chisel3._
import chisel3.util._
import chisel3.stage.ChiselStage

object ALUOps {
  // 基本算术逻辑运算 (0xxx)
  val ADD   = "b0000".U(4.W)  // add, addi, load, store
  val SUB   = "b0001".U(4.W)  // sub
  val SLL   = "b0010".U(4.W)  // sll, slli
  val SRL   = "b0011".U(4.W)  // srl, srli
  val SRA   = "b0100".U(4.W)  // sra, srai
  val OR    = "b0101".U(4.W)  // or, ori
  val AND   = "b0110".U(4.W)  // and, andi
  val XOR   = "b0111".U(4.W)  // xor, xori

  // 比较操作 (10xx)
  val SLT   = "b1000".U(4.W)  // slt, slti
  val SLTU  = "b1001".U(4.W)  // sltu, sltui

  // 分支操作 (11xx)
  val BEQ   = "b1100".U(4.W)  // beq
  val BNE   = "b1101".U(4.W)  // bne
  val BLT   = "b1110".U(4.W)  // blt, bltu
  val BGE   = "b1111".U(4.W)  // bge, bgeu

  // 跳转指令使用ADD操作码配合控制信号
  // JAL/JALR将在ExSof中翻译为ADD操作，但会设置特殊标志
}

class ALU extends Module {
  val io = IO(new Bundle {
    val src1_in    = Input(UInt(32.W))
    val src2_in    = Input(UInt(32.W))
    val op_in      = Input(UInt(4.W))
    val valid_in   = Input(Bool())
    val flush_in   = Input(Bool())
    val pc_in      = Input(UInt(32.W))
    val imm_in     = Input(UInt(32.W))
    val is_branch  = Input(Bool())
    val is_jump    = Input(Bool())
    val result_out = Output(UInt(32.W))
    val valid_out  = Output(Bool())
    val branch_out = Output(Bool())
    val jump_addr  = Output(UInt(32.W))
  })

  val result = Wire(UInt(32.W))
  val branch_taken = Wire(Bool())
  val next_pc = Wire(UInt(32.W))

  // 初始化线网
  result := 0.U
  branch_taken := false.B
  next_pc := 0.U

  // 基本ALU操作
  switch(io.op_in) {
    is(ALUOps.ADD)  { result := io.src1_in + io.src2_in }
    is(ALUOps.SUB)  { result := io.src1_in - io.src2_in }
    is(ALUOps.SLL)  { result := io.src1_in << io.src2_in(4, 0) }
    is(ALUOps.SRL)  { result := io.src1_in >> io.src2_in(4, 0) }
    is(ALUOps.SRA)  { result := (io.src1_in.asSInt >> io.src2_in(4, 0)).asUInt }
    is(ALUOps.OR)   { result := io.src1_in | io.src2_in }
    is(ALUOps.AND)  { result := io.src1_in & io.src2_in }
    is(ALUOps.XOR)  { result := io.src1_in ^ io.src2_in }
    is(ALUOps.SLT)  { result := (io.src1_in.asSInt < io.src2_in.asSInt).asUInt }
    is(ALUOps.SLTU) { result := (io.src1_in < io.src2_in).asUInt }
  }

  // 分支指令处理
  when(io.is_branch) {
    switch(io.op_in) {
      is(ALUOps.BEQ)  { branch_taken := io.src1_in === io.src2_in }
      is(ALUOps.BNE)  { branch_taken := io.src1_in =/= io.src2_in }
      is(ALUOps.BLT)  {
        when(io.op_in(0)) {
          branch_taken := io.src1_in < io.src2_in // BLTU
        }.otherwise {
          branch_taken := io.src1_in.asSInt < io.src2_in.asSInt // BLT
        }
      }
      is(ALUOps.BGE)  {
        when(io.op_in(0)) {
          branch_taken := io.src1_in >= io.src2_in // BGEU
        }.otherwise {
          branch_taken := io.src1_in.asSInt >= io.src2_in.asSInt // BGE
        }
      }
    }
    next_pc := Mux(branch_taken, io.pc_in + io.imm_in, 0.U)
  }

  // 修复跳转指令处理
  when(io.is_jump) {
    result := io.pc_in + 4.U  // 返回地址
    branch_taken := true.B

    when(io.op_in(0)) { // JALR (操作码最低位为1)
      next_pc := (io.src1_in + io.imm_in) & "hFFFFFFFE".U  ;  // 计算目标地址并确保最低位为0
    }.otherwise { // JAL
      next_pc := io.pc_in + io.imm_in
    }
  }

  // 输出结果
  io.result_out := Mux(io.valid_in && !io.flush_in, result, 0.U)
  io.valid_out  := io.valid_in && !io.flush_in
  io.branch_out := io.valid_in && !io.flush_in && branch_taken
  io.jump_addr  := Mux(io.valid_in && !io.flush_in && branch_taken, next_pc, 0.U)
}

object GenerateALUVerilog extends App {
  (new ChiselStage).emitVerilog(new ALU(), Array("--target-dir", "generated"))
}