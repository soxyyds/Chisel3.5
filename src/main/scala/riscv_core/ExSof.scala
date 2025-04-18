package riscv_core

import chisel3._
import chisel3.util._
import chisel3.stage.ChiselStage

class IssueBundle extends Bundle {
  val rs1    = UInt(32.W)  // 源操作数1
  val rs2    = UInt(32.W)  // 源操作数2
  val imm    = UInt(32.W)  // 立即数
  val op     = UInt(4.W)   // ALU操作类型
  val isMem  = Bool()      // 是否为访存操作
  val memOp  = UInt(2.W)   // 访存操作类型 (0: 无操作, 1: 读, 2: 写)
  val rd     = UInt(5.W)   // 写回寄存器编号
  val rdWen  = Bool()      // 是否写回寄存器
}

class ExCtrlBundle extends Bundle {
  val writeEnable = Bool()     // 指令执行结果是否有效
  val isALU       = Bool()     // 是否为ALU操作
  val isMem       = Bool()     // 是否为内存操作
  val rd          = UInt(5.W)  // 目标寄存器编号
  val rdWen       = Bool()     // 是否写回寄存器
}

class ALUDataBundle extends Bundle {
  val src1        = UInt(32.W) // 第一个源操作数
  val src2        = UInt(32.W) // 第二个源操作数
  val op          = UInt(4.W)  // ALU操作类型
}

class MemOpBundle extends Bundle {
  val isMem       = Bool()     // 是否为内存操作
  val memOp       = UInt(2.W)  // 内存操作类型 (0: 无操作, 1: 读, 2: 写)
}

class ExSof extends Module {
  val io = IO(new Bundle {
    // 双发射的输入
    val issue_in_0      = Input(new IssueBundle)
    val issue_in_1      = Input(new IssueBundle)
    val valid_in_0      = Input(Bool())
    val valid_in_1      = Input(Bool())
    val alu_ready_in_0  = Input(Bool())
    val alu_ready_in_1  = Input(Bool())

    // 双发射的输出
    val result_ready_out_0 = Output(Bool())
    val result_ready_out_1 = Output(Bool())

    // 第一个执行单元的控制和数据输出
    val ex_ctrl_out_0      = Output(new ExCtrlBundle)
    val alu_data_out_0     = Output(new ALUDataBundle)
    val mem_op_out_0       = Output(new MemOpBundle)

    // 第二个执行单元的控制和数据输出
    val ex_ctrl_out_1      = Output(new ExCtrlBundle)
    val alu_data_out_1     = Output(new ALUDataBundle)
    val mem_op_out_1       = Output(new MemOpBundle)
  })

  // 确定两条指令是否可以进入执行阶段
  val execute_fire_0 = io.valid_in_0 && io.alu_ready_in_0
  val execute_fire_1 = io.valid_in_1 && io.alu_ready_in_1

  // ALU 0 数据打包
  io.alu_data_out_0.src1 := io.issue_in_0.rs1
  io.alu_data_out_0.src2 := Mux(io.issue_in_0.isMem, io.issue_in_0.imm, io.issue_in_0.rs2)
  io.alu_data_out_0.op   := io.issue_in_0.op

  // ALU 1 数据打包
  io.alu_data_out_1.src1 := io.issue_in_1.rs1
  io.alu_data_out_1.src2 := Mux(io.issue_in_1.isMem, io.issue_in_1.imm, io.issue_in_1.rs2)
  io.alu_data_out_1.op   := io.issue_in_1.op

  // 执行控制信号打包 - ALU 0
  io.ex_ctrl_out_0.writeEnable := execute_fire_0
  io.ex_ctrl_out_0.isALU       := true.B
  io.ex_ctrl_out_0.isMem       := io.issue_in_0.isMem
  io.ex_ctrl_out_0.rd          := io.issue_in_0.rd
  io.ex_ctrl_out_0.rdWen       := io.issue_in_0.rdWen

  // 执行控制信号打包 - ALU 1
  io.ex_ctrl_out_1.writeEnable := execute_fire_1
  io.ex_ctrl_out_1.isALU       := true.B
  io.ex_ctrl_out_1.isMem       := io.issue_in_1.isMem
  io.ex_ctrl_out_1.rd          := io.issue_in_1.rd
  io.ex_ctrl_out_1.rdWen       := io.issue_in_1.rdWen

  // 访存控制信息打包 - ALU 0
  io.mem_op_out_0.isMem := io.issue_in_0.isMem
  io.mem_op_out_0.memOp := io.issue_in_0.memOp

  // 访存控制信息打包 - ALU 1
  io.mem_op_out_1.isMem := io.issue_in_1.isMem
  io.mem_op_out_1.memOp := io.issue_in_1.memOp

  // 执行完成标志
  io.result_ready_out_0 := execute_fire_0
  io.result_ready_out_1 := execute_fire_1
}

object GenerateExSofVerilog extends App {
  (new ChiselStage).emitVerilog(new ExSof(), Array("--target-dir", "generated"))
}