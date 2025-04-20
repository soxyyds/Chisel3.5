package riscv_core

import chisel3._
import chisel3.util._
import chisel3.stage.ChiselStage

object RV32IInstructions {
  // 算术与逻辑指令 (0-19)
  val ADD    = 0.U(6.W)
  val ADDI   = 1.U(6.W)
  val SUB    = 2.U(6.W)
  val LUI    = 3.U(6.W)
  val AUIPC  = 4.U(6.W)
  val SLL    = 5.U(6.W)
  val SLLI   = 6.U(6.W)
  val SRL    = 7.U(6.W)
  val SRLI   = 8.U(6.W)
  val SRA    = 9.U(6.W)
  val SRAI   = 10.U(6.W)
  val OR     = 11.U(6.W)
  val ORI    = 12.U(6.W)
  val AND    = 13.U(6.W)
  val ANDI   = 14.U(6.W)
  val XOR    = 15.U(6.W)
  val XORI   = 16.U(6.W)
  val SLT    = 17.U(6.W)
  val SLTI   = 18.U(6.W)
  val SLTU   = 19.U(6.W)
  val SLTIU  = 20.U(6.W)

  // 跳转指令 (21-22)
  val JAL    = 21.U(6.W)
  val JALR   = 22.U(6.W)

  // 分支指令 (23-28)
  val BEQ    = 23.U(6.W)
  val BNE    = 24.U(6.W)
  val BLT    = 25.U(6.W)
  val BGE    = 26.U(6.W)
  val BLTU   = 27.U(6.W)
  val BGEU   = 28.U(6.W)

  // 访存指令 (29-36)
  val LB     = 29.U(6.W)
  val LH     = 30.U(6.W)
  val LW     = 31.U(6.W)
  val LBU    = 32.U(6.W)
  val LHU    = 33.U(6.W)
  val SB     = 34.U(6.W)
  val SH     = 35.U(6.W)
  val SW     = 36.U(6.W)
  val NOP    = 37.U(6.W) // 什么都没有
}


class ALU extends Module {
  val io = IO(new Bundle {
    val src1_in    = Input(UInt(32.W))
    val src2_in    = Input(UInt(32.W))
    val instr_id   = Input(UInt(6.W))   // 使用指令ID代替操作码
    val valid_in   = Input(Bool())
    val flush_in   = Input(Bool())
    val pc_in      = Input(UInt(32.W))
    val imm_in     = Input(UInt(32.W))
    val result_out = Output(UInt(32.W))
    val valid_out  = Output(Bool())
    val branch_out = Output(Bool())
    val jump_addr  = Output(UInt(32.W))
    val is_load    = Output(Bool())
    val is_store   = Output(Bool())
  })

  import RV32IInstructions._

  val result = Wire(UInt(32.W))
  val branch_taken = Wire(Bool())
  val next_pc = Wire(UInt(32.W))
  val is_load = Wire(Bool())
  val is_store = Wire(Bool())

  // 初始化
  result := 0.U
  branch_taken := false.B
  next_pc := io.pc_in + 4.U
  is_load := false.B
  is_store := false.B

  // 根据指令ID执行相应操作
  switch(io.instr_id) {
    // 算术与逻辑指令
    is(ADD)   { result := io.src1_in + io.src2_in }
    is(ADDI)  { result := io.src1_in + io.imm_in }
    is(SUB)   { result := io.src1_in - io.src2_in }
    is(LUI)   { result := io.imm_in }
    is(AUIPC) { result := io.pc_in + io.imm_in }
    is(SLL)   { result := io.src1_in << io.src2_in(4, 0) }
    is(SLLI)  { result := io.src1_in << io.imm_in(4, 0) }
    is(SRL)   { result := io.src1_in >> io.src2_in(4, 0) }
    is(SRLI)  { result := io.src1_in >> io.imm_in(4, 0) }
    is(SRA)   { result := (io.src1_in.asSInt >> io.src2_in(4, 0)).asUInt }
    is(SRAI)  { result := (io.src1_in.asSInt >> io.imm_in(4, 0)).asUInt }
    is(OR)    { result := io.src1_in | io.src2_in }
    is(ORI)   { result := io.src1_in | io.imm_in }
    is(AND)   { result := io.src1_in & io.src2_in }
    is(ANDI)  { result := io.src1_in & io.imm_in }
    is(XOR)   { result := io.src1_in ^ io.src2_in }
    is(XORI)  { result := io.src1_in ^ io.imm_in }
    is(SLT)   { result := (io.src1_in.asSInt < io.src2_in.asSInt).asUInt }
    is(SLTI)  { result := (io.src1_in.asSInt < io.imm_in.asSInt).asUInt }
    is(SLTU)  { result := (io.src1_in < io.src2_in).asUInt }
    is(SLTIU) { result := (io.src1_in < io.imm_in).asUInt }

    // 跳转指令
    is(JAL) {
      result := io.pc_in + 4.U
      next_pc := io.pc_in + io.imm_in
      branch_taken := true.B
    }
    is(JALR) {
      result := io.pc_in + 4.U
      next_pc := (io.src1_in + io.imm_in) & "hFFFFFFFE".U
      branch_taken := true.B
    }

    // 分支指令
    is(BEQ)  {
      branch_taken := (io.src1_in === io.src2_in)
      next_pc := Mux(branch_taken, io.pc_in + io.imm_in, io.pc_in + 4.U)
    }
    is(BNE)  {
      branch_taken := io.src1_in =/= io.src2_in
      next_pc := Mux(branch_taken, io.pc_in + io.imm_in, io.pc_in + 4.U)
    }
    is(BLT)  {
      branch_taken := io.src1_in.asSInt < io.src2_in.asSInt
      next_pc := Mux(branch_taken, io.pc_in + io.imm_in, io.pc_in + 4.U)
    }
    is(BGE)  {
      branch_taken := io.src1_in.asSInt >= io.src2_in.asSInt
      next_pc := Mux(branch_taken, io.pc_in + io.imm_in, io.pc_in + 4.U)
    }
    is(BLTU) {
      branch_taken := io.src1_in < io.src2_in
      next_pc := Mux(branch_taken, io.pc_in + io.imm_in, io.pc_in + 4.U)
    }
    is(BGEU) {
      branch_taken := io.src1_in >= io.src2_in
      next_pc := Mux(branch_taken, io.pc_in + io.imm_in, io.pc_in + 4.U)
    }

    // 访存指令 - 计算地址
    is(LB, LH, LW, LBU, LHU) {
      result := io.src1_in + io.imm_in  // 内存地址
      is_load := true.B
    }

    is(SB, SH, SW) {
      result := io.src1_in + io.imm_in  // 内存地址
      is_store := true.B
    }
  }

  // 输出结果
  val valid = io.valid_in && !io.flush_in
  io.result_out := Mux(valid, result, 0.U)
  io.valid_out  := valid
  io.branch_out := valid && branch_taken
  io.jump_addr  := Mux(valid && branch_taken, next_pc, io.pc_in + 4.U)
  io.is_load    := valid && is_load
  io.is_store   := valid && is_store
}

object GenerateALUVerilog extends App {
  (new ChiselStage).emitVerilog(new ALU(), Array("--target-dir", "generated"))
}