package riscv_core

import chisel3._
import chisel3.util._
import chisel3.stage.ChiselStage

// 从译码阶段传入的指令包
class DecodeBundle extends Bundle {
  val instr_id = UInt(6.W)       // 指令ID
  val rs1      = UInt(5.W)       // 源寄存器1
  val rs2      = UInt(5.W)       // 源寄存器2
  val rd       = UInt(5.W)       // 目标寄存器
  val rs1_data = UInt(32.W)      // 源寄存器1数据
  val rs2_data = UInt(32.W)      // 源寄存器2数据
  val imm      = UInt(32.W)      // 立即数值
  val pc       = UInt(32.W)      // 程序计数器
  val rdWen    = Bool()          // 寄存器写使能

}

// 前馈信息包（发送到译码阶段）
class ForwardBundle extends Bundle {
  val rd       = UInt(5.W)       // 目标寄存器
  val rdWen    = Bool()          // 写使能
  val result   = UInt(32.W)      // 结果数据
  val valid    = Bool()          // 数据有效
  val is_load  = Bool()          // 是否为加载指令
}

// 双发射执行单元
class Ex extends Module {
  val io = IO(new Bundle {
    // 来自译码阶段的两条指令
    val decode_in_0 = Input(new DecodeBundle)
    val decode_in_1 = Input(new DecodeBundle)
    val valid_in_0  = Input(Bool())
    val valid_in_1  = Input(Bool())
    val flush_in    = Input(Bool())

    // 前馈到译码阶段
    val forward_0 = Output(new ForwardBundle)
    val forward_1 = Output(new ForwardBundle)

    // 传递到访存阶段的结果
    val result_out_0 = Output(UInt(32.W))
    val result_out_1 = Output(UInt(32.W))
    val rd_out_0     = Output(UInt(5.W))
    val rd_out_1     = Output(UInt(5.W))
    val rdWen_out_0  = Output(Bool())
    val rdWen_out_1  = Output(Bool())
    val valid_out_0  = Output(Bool())
    val valid_out_1  = Output(Bool())

    // 内存访问信号
    val mem_addr_0   = Output(UInt(32.W))
    val mem_addr_1   = Output(UInt(32.W))
    val mem_wdata_0  = Output(UInt(32.W))
    val mem_wdata_1  = Output(UInt(32.W))
    val is_load_0    = Output(Bool())
    val is_load_1    = Output(Bool())
    val is_store_0   = Output(Bool())
    val is_store_1   = Output(Bool())

    // 分支结果
    val branch_taken_0 = Output(Bool())
    val branch_taken_1 = Output(Bool())
    val jump_addr_0    = Output(UInt(32.W))
    val jump_addr_1    = Output(UInt(32.W))
  })

  // 实例化两个ALU
  val alu_0 = Module(new ALU())
  val alu_1 = Module(new ALU())

  // 初始化ALU 0 输入
  alu_0.io.src1_in  := io.decode_in_0.rs1_data
  alu_0.io.src2_in  := io.decode_in_0.rs2_data
  alu_0.io.instr_id := io.decode_in_0.instr_id
  alu_0.io.valid_in := io.valid_in_0
  alu_0.io.flush_in := io.flush_in
  alu_0.io.pc_in    := io.decode_in_0.pc
  alu_0.io.imm_in   := io.decode_in_0.imm

  // 检查ALU 1的执行是否被分支影响
  val alu0_causes_flush = alu_0.io.branch_out

  // 初始化ALU 1 输入
  alu_1.io.src1_in  := io.decode_in_1.rs1_data
  alu_1.io.src2_in  := io.decode_in_1.rs2_data
  alu_1.io.instr_id := io.decode_in_1.instr_id
  alu_1.io.valid_in := io.valid_in_1
  alu_1.io.flush_in := io.flush_in || alu0_causes_flush // ALU0分支成功会刷新ALU1
  alu_1.io.pc_in    := io.decode_in_1.pc
  alu_1.io.imm_in   := io.decode_in_1.imm

  // 生成前馈信号0
  io.forward_0.rd     := io.decode_in_0.rd
  io.forward_0.rdWen  := io.decode_in_0.rdWen && alu_0.io.valid_out
  io.forward_0.result := alu_0.io.result_out
  io.forward_0.valid  := alu_0.io.valid_out && (io.decode_in_0.rd =/= 0.U)
  io.forward_0.is_load := alu_0.io.is_load

  // 生成前馈信号1
  io.forward_1.rd     := io.decode_in_1.rd
  io.forward_1.rdWen  := io.decode_in_1.rdWen && alu_1.io.valid_out
  io.forward_1.result := alu_1.io.result_out
  io.forward_1.valid  := alu_1.io.valid_out && (io.decode_in_1.rd =/= 0.U)
  io.forward_1.is_load := alu_1.io.is_load

  // 连接输出结果
  io.result_out_0 := alu_0.io.result_out
  io.result_out_1 := alu_1.io.result_out
  io.rd_out_0     := io.decode_in_0.rd
  io.rd_out_1     := io.decode_in_1.rd
  io.rdWen_out_0  := io.decode_in_0.rdWen && alu_0.io.valid_out
  io.rdWen_out_1  := io.decode_in_1.rdWen && alu_1.io.valid_out
  io.valid_out_0  := alu_0.io.valid_out
  io.valid_out_1  := alu_1.io.valid_out

  // 内存访问信号
  io.mem_addr_0  := alu_0.io.result_out
  io.mem_addr_1  := alu_1.io.result_out
  io.mem_wdata_0 := io.decode_in_0.rs2_data
  io.mem_wdata_1 := io.decode_in_1.rs2_data
  io.is_load_0   := alu_0.io.is_load
  io.is_load_1   := alu_1.io.is_load
  io.is_store_0  := alu_0.io.is_store
  io.is_store_1  := alu_1.io.is_store

  // 分支/跳转结果
  io.branch_taken_0 := alu_0.io.branch_out
  io.branch_taken_1 := alu_1.io.branch_out
  io.jump_addr_0    := alu_0.io.jump_addr
  io.jump_addr_1    := alu_1.io.jump_addr
}

object GenerateExVerilog extends App {
  (new ChiselStage).emitVerilog(new Ex(), Array("--target-dir", "generated"))
}