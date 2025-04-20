package riscv_core

import chisel3._
import chisel3.stage.ChiselStage

class Forward extends Module {
  val io = IO(new Bundle {
    // 译码阶段的寄存器信息
    val id_rs1_0 = Input(UInt(5.W))  // 第一条指令的rs1
    val id_rs2_0 = Input(UInt(5.W))  // 第一条指令的rs2
    val id_rs1_1 = Input(UInt(5.W))  // 第二条指令的rs1
    val id_rs2_1 = Input(UInt(5.W))  // 第二条指令的rs2
    val id_rd_0  = Input(UInt(5.W))  // 第一条指令的rd
    val id_rdWen_0 = Input(Bool())   // 第一条指令的写使能

    // 寄存器文件读取的原始数据
    val rs1_data_0 = Input(UInt(32.W))
    val rs2_data_0 = Input(UInt(32.W))
    val rs1_data_1 = Input(UInt(32.W))
    val rs2_data_1 = Input(UInt(32.W))

    // 执行阶段前馈
    val ex_rd_0 = Input(UInt(5.W))
    val ex_rd_1 = Input(UInt(5.W))
    val ex_rdWen_0 = Input(Bool())
    val ex_rdWen_1 = Input(Bool())
    val ex_result_0 = Input(UInt(32.W))
    val ex_result_1 = Input(UInt(32.W))
    val ex_is_load_0 = Input(Bool())  // 加载指令需特殊处理
    val ex_is_load_1 = Input(Bool())

    // 访存阶段前馈
    val mem_rd_0 = Input(UInt(5.W))
    val mem_rd_1 = Input(UInt(5.W))
    val mem_rdWen_0 = Input(Bool())
    val mem_rdWen_1 = Input(Bool())
    val mem_result_0 = Input(UInt(32.W))
    val mem_result_1 = Input(UInt(32.W))

    // 前馈后的数据输出
    val fwd_rs1_data_0 = Output(UInt(32.W))
    val fwd_rs2_data_0 = Output(UInt(32.W))
    val fwd_rs1_data_1 = Output(UInt(32.W))
    val fwd_rs2_data_1 = Output(UInt(32.W))

    // 控制信号
    val stall_req = Output(Bool())  // 需要阻塞流水线
    val dual_issue = Output(Bool()) // 是否可以双发射
  })

  // 初始化所有输出
  io.fwd_rs1_data_0 := io.rs1_data_0
  io.fwd_rs2_data_0 := io.rs2_data_0
  io.fwd_rs1_data_1 := io.rs1_data_1
  io.fwd_rs2_data_1 := io.rs2_data_1
  io.stall_req := false.B
  io.dual_issue := true.B

  // 处理前馈逻辑 - 第一条指令的rs1
  when(io.id_rs1_0 =/= 0.U) { // 零寄存器不需要前馈
    // 执行阶段前馈 - 优先级高
    when(io.ex_rdWen_0 && (io.ex_rd_0 === io.id_rs1_0)) {
      io.fwd_rs1_data_0 := io.ex_result_0
      // 如果是加载指令,需要插入气泡等待数据就绪
      io.stall_req := io.ex_is_load_0
    }.elsewhen(io.ex_rdWen_1 && (io.ex_rd_1 === io.id_rs1_0)) {
        io.fwd_rs1_data_0 := io.ex_result_1
        io.stall_req := io.ex_is_load_1
      }
      // 访存阶段前馈 - 优先级其次
      .elsewhen(io.mem_rdWen_0 && (io.mem_rd_0 === io.id_rs1_0)) {
        io.fwd_rs1_data_0 := io.mem_result_0
      }.elsewhen(io.mem_rdWen_1 && (io.mem_rd_1 === io.id_rs1_0)) {
        io.fwd_rs1_data_0 := io.mem_result_1
      }
  }

  // 处理前馈逻辑 - 第一条指令的rs2
  when(io.id_rs2_0 =/= 0.U) {
    // 执行阶段前馈
    when(io.ex_rdWen_0 && (io.ex_rd_0 === io.id_rs2_0)) {
      io.fwd_rs2_data_0 := io.ex_result_0
      io.stall_req := io.ex_is_load_0
    }.elsewhen(io.ex_rdWen_1 && (io.ex_rd_1 === io.id_rs2_0)) {
        io.fwd_rs2_data_0 := io.ex_result_1
        io.stall_req := io.ex_is_load_1
      }
      // 访存阶段前馈
      .elsewhen(io.mem_rdWen_0 && (io.mem_rd_0 === io.id_rs2_0)) {
        io.fwd_rs2_data_0 := io.mem_result_0
      }.elsewhen(io.mem_rdWen_1 && (io.mem_rd_1 === io.id_rs2_0)) {
        io.fwd_rs2_data_0 := io.mem_result_1
      }
  }

  // 处理前馈逻辑 - 第二条指令的rs1
  when(io.id_rs1_1 =/= 0.U) {
    // 先检查与第一条指令的依赖
    when(io.id_rdWen_0 && (io.id_rd_0 === io.id_rs1_1)) {
      // 写后读依赖，不能双发射
      io.dual_issue := false.B
    }.otherwise {
      // 检查与执行阶段的依赖
      when(io.ex_rdWen_0 && (io.ex_rd_0 === io.id_rs1_1)) {
        io.fwd_rs1_data_1 := io.ex_result_0
        io.stall_req := io.ex_is_load_0
      }.elsewhen(io.ex_rdWen_1 && (io.ex_rd_1 === io.id_rs1_1)) {
          io.fwd_rs1_data_1 := io.ex_result_1
          io.stall_req := io.ex_is_load_1
        }
        // 访存阶段前馈
        .elsewhen(io.mem_rdWen_0 && (io.mem_rd_0 === io.id_rs1_1)) {
          io.fwd_rs1_data_1 := io.mem_result_0
        }.elsewhen(io.mem_rdWen_1 && (io.mem_rd_1 === io.id_rs1_1)) {
          io.fwd_rs1_data_1 := io.mem_result_1
        }
    }
  }

  // 处理前馈逻辑 - 第二条指令的rs2
  when(io.id_rs2_1 =/= 0.U) {
    // 检查与第一条指令的依赖
    when(io.id_rdWen_0 && (io.id_rd_0 === io.id_rs2_1)) {
      // 写后读依赖，不能双发射
      io.dual_issue := false.B
    }.otherwise {
      // 检查与执行阶段的依赖
      when(io.ex_rdWen_0 && (io.ex_rd_0 === io.id_rs2_1)) {
        io.fwd_rs2_data_1 := io.ex_result_0
        io.stall_req := io.ex_is_load_0
      }.elsewhen(io.ex_rdWen_1 && (io.ex_rd_1 === io.id_rs2_1)) {
          io.fwd_rs2_data_1 := io.ex_result_1
          io.stall_req := io.ex_is_load_1
        }
        // 访存阶段前馈
        .elsewhen(io.mem_rdWen_0 && (io.mem_rd_0 === io.id_rs2_1)) {
          io.fwd_rs2_data_1 := io.mem_result_0
        }.elsewhen(io.mem_rdWen_1 && (io.mem_rd_1 === io.id_rs2_1)) {
          io.fwd_rs2_data_1 := io.mem_result_1
        }
    }
  }
}

object GenerateForwardVerilog extends App {
  (new ChiselStage).emitVerilog(new Forward(), Array("--target-dir", "generated"))
}
