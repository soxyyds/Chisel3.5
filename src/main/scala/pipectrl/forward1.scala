package pipectrl

import chisel3._
import chisel3.stage.ChiselStage
import chisel3.util._

class forward1 extends Module {
  val io = IO(new Bundle {
    // 译码阶段的寄存器地址（需要用于判断是否需要前馈）
    val id_rs1_0 = Input(UInt(5.W)) // 第一条指令的源寄存器1
    val id_rs2_0 = Input(UInt(5.W)) // 第一条指令的源寄存器2
    val id_rs1_1 = Input(UInt(5.W)) // 第二条指令的源寄存器1
    val id_rs2_1 = Input(UInt(5.W)) // 第二条指令的源寄存器2
    val id_rs1_data_0 = Input(UInt(32.W)) // 第一条指令的源寄存器1的数据
    val id_rs2_data_0 = Input(UInt(32.W)) // 第一条指令的源寄存器2的数据
    val id_rs1_data_1 = Input(UInt(32.W)) // 第二条指令的源寄存器1的数据
    val id_rs2_data_1 = Input(UInt(32.W)) // 第二条指令的源寄存器2的数据

    // 执行访存1阶段的寄存器写信息
    val exmem_rd_0 = Input(UInt(5.W)) // 第一条指令的目标寄存器
    val exmem_rd_1 = Input(UInt(5.W)) // 第二条指令的目标寄存器
    val exmem_rdwen_0 = Input(Bool()) // 第一条指令是否写寄存器
    val exmem_rdwen_1 = Input(Bool()) // 第二条指令是否写寄存器
    val exmem_rdlden_0 = Input(Bool()) // 第一条指令是否加载
    val exmem_rdlden_1 = Input(Bool()) // 第二条指令是否加载
    val exmem_data_0 = Input(UInt(32.W)) // 第一条指令的执行结果
    val exmem_data_1 = Input(UInt(32.W)) // 第二条指令的执行结果

    // 访存阶段的寄存器写信息
    val mem_rd_0 = Input(UInt(5.W)) // 访存阶段的目标寄存器
    val mem_rd_1 = Input(UInt(5.W))
    val mem_rdwen_0 = Input(Bool()) // 是否写寄存器
    val mem_rdwen_1 = Input(Bool())
    val mem_data_0 = Input(UInt(32.W)) // 访存阶段的数据
    val mem_data_1 = Input(UInt(32.W))

    //访存写回阶段的寄存器写信息
    val memwb_rd_0 = Input(UInt(5.W)) // 访存写回阶段的目标寄存器
    val memwb_rd_1 = Input(UInt(5.W))
    val memwb_rdwen_0 = Input(Bool()) // 是否写寄存器
    val memwb_rdwen_1 = Input(Bool())
    val memwb_data_0 = Input(UInt(32.W))
    val memwb_data_1 = Input(UInt(32.W))

    // 前馈后的数据（输出）
    val fwd_data_rs1_0 = Output(UInt(32.W))
    val fwd_data_rs2_0 = Output(UInt(32.W))
    val fwd_data_rs1_1 = Output(UInt(32.W))
    val fwd_data_rs2_1 = Output(UInt(32.W))

    val stall_req = Output(Bool()) // 流水线停顿请求

  })

  //默认使用寄存器堆中的数据
  io.fwd_data_rs2_1 := io.id_rs2_data_1
  io.fwd_data_rs1_1 := io.id_rs1_data_1
  io.fwd_data_rs2_0 := io.id_rs2_data_0
  io.fwd_data_rs1_0 := io.id_rs1_data_0



  // 默认不需要停顿
  io.stall_req := false.B

  // 检测加载指令导致的数据冒险
  when(io.exmem_rdlden_0 && io.exmem_rd_0 =/= 0.U && (
    (io.id_rs1_0 =/= 0.U && io.exmem_rd_0 === io.id_rs1_0) ||
      (io.id_rs2_0 =/= 0.U && io.exmem_rd_0 === io.id_rs2_0) ||
      (io.id_rs1_1 =/= 0.U && io.exmem_rd_0 === io.id_rs1_1) ||
      (io.id_rs2_1 =/= 0.U && io.exmem_rd_0 === io.id_rs2_1)
    )) {
    io.stall_req := true.B
  }

  when(io.exmem_rdlden_1 && io.exmem_rd_1 =/= 0.U && (
    (io.id_rs1_0 =/= 0.U && io.exmem_rd_1 === io.id_rs1_0) ||
      (io.id_rs2_0 =/= 0.U && io.exmem_rd_1 === io.id_rs2_0) ||
      (io.id_rs1_1 =/= 0.U && io.exmem_rd_1 === io.id_rs1_1) ||
      (io.id_rs2_1 =/= 0.U && io.exmem_rd_1 === io.id_rs2_1)
    )) {
    io.stall_req := true.B
  }



  // 第一条指令rs1前馈逻辑
  when(io.id_rs1_0 =/= 0.U) {
    // 执行访存1阶段前馈 (优先级最高)
    when(io.exmem_rdwen_0 && (io.exmem_rd_0 === io.id_rs1_0)) {
      io.fwd_data_rs1_0 := io.exmem_data_0
    }.elsewhen(io.exmem_rdwen_1 && (io.exmem_rd_1 === io.id_rs1_0)) {
        io.fwd_data_rs1_0 := io.exmem_data_1
      }
      // 访存阶段前馈 (优先级中等)
      .elsewhen(io.mem_rdwen_0 && (io.mem_rd_0 === io.id_rs1_0)) {
        io.fwd_data_rs1_0 := io.mem_data_0
      }.elsewhen(io.mem_rdwen_1 && (io.mem_rd_1 === io.id_rs1_0)) {
        io.fwd_data_rs1_0 := io.mem_data_1
      }
      // 访存写回阶段前馈 (优先级最低)
      .elsewhen(io.memwb_rdwen_0 && (io.memwb_rd_0 === io.id_rs1_0)) {
        io.fwd_data_rs1_0 := io.memwb_data_0
      }.elsewhen(io.memwb_rdwen_1 && (io.memwb_rd_1 === io.id_rs1_0)) {
        io.fwd_data_rs1_0 := io.memwb_data_1
      }
  }

  // 第一条指令rs2前馈逻辑
  when(io.id_rs2_0 =/= 0.U) {
    // 执行访存1阶段前馈 (优先级最高)
    when(io.exmem_rdwen_0 && (io.exmem_rd_0 === io.id_rs2_0)) {
      io.fwd_data_rs2_0 := io.exmem_data_0
    }.elsewhen(io.exmem_rdwen_1 && (io.exmem_rd_1 === io.id_rs2_0)) {
        io.fwd_data_rs2_0 := io.exmem_data_1
      }
      // 访存阶段前馈 (优先级中等)
      .elsewhen(io.mem_rdwen_0 && (io.mem_rd_0 === io.id_rs2_0)) {
        io.fwd_data_rs2_0 := io.mem_data_0
      }.elsewhen(io.mem_rdwen_1 && (io.mem_rd_1 === io.id_rs2_0)) {
        io.fwd_data_rs2_0 := io.mem_data_1
      }
      // 访存写回阶段前馈 (优先级最低)
      .elsewhen(io.memwb_rdwen_0 && (io.memwb_rd_0 === io.id_rs2_0)) {
        io.fwd_data_rs2_0 := io.memwb_data_0
      }.elsewhen(io.memwb_rdwen_1 && (io.memwb_rd_1 === io.id_rs2_0)) {
        io.fwd_data_rs2_0 := io.memwb_data_1
      }
  }

  // 第二条指令rs1前馈逻辑
  when(io.id_rs1_1 =/= 0.U) {
    // 执行访存1阶段前馈 (优先级最高)
    when(io.exmem_rdwen_0 && (io.exmem_rd_0 === io.id_rs1_1)) {
      io.fwd_data_rs1_1 := io.exmem_data_0
    }.elsewhen(io.exmem_rdwen_1 && (io.exmem_rd_1 === io.id_rs1_1)) {
        io.fwd_data_rs1_1 := io.exmem_data_1
      }
      // 访存阶段前馈 (优先级中等)
      .elsewhen(io.mem_rdwen_0 && (io.mem_rd_0 === io.id_rs1_1)) {
        io.fwd_data_rs1_1 := io.mem_data_0
      }.elsewhen(io.mem_rdwen_1 && (io.mem_rd_1 === io.id_rs1_1)) {
        io.fwd_data_rs1_1 := io.mem_data_1
      }
      // 访存写回阶段前馈 (优先级最低)
      .elsewhen(io.memwb_rdwen_0 && (io.memwb_rd_0 === io.id_rs1_1)) {
        io.fwd_data_rs1_1 := io.memwb_data_0
      }.elsewhen(io.memwb_rdwen_1 && (io.memwb_rd_1 === io.id_rs1_1)) {
        io.fwd_data_rs1_1 := io.memwb_data_1
      }
  }

  // 第二条指令rs2前馈逻辑
  when(io.id_rs2_1 =/= 0.U) {
    // 执行访存1阶段前馈 (优先级最高)
    when(io.exmem_rdwen_0 && (io.exmem_rd_0 === io.id_rs2_1)) {
      io.fwd_data_rs2_1 := io.exmem_data_0
    }.elsewhen(io.exmem_rdwen_1 && (io.exmem_rd_1 === io.id_rs2_1)) {
        io.fwd_data_rs2_1 := io.exmem_data_1
      }
      // 访存阶段前馈 (优先级中等)
      .elsewhen(io.mem_rdwen_0 && (io.mem_rd_0 === io.id_rs2_1)) {
        io.fwd_data_rs2_1 := io.mem_data_0
      }.elsewhen(io.mem_rdwen_1 && (io.mem_rd_1 === io.id_rs2_1)) {
        io.fwd_data_rs2_1 := io.mem_data_1
      }
      // 访存写回阶段前馈 (优先级最低)
      .elsewhen(io.memwb_rdwen_0 && (io.memwb_rd_0 === io.id_rs2_1)) {
        io.fwd_data_rs2_1 := io.memwb_data_0
      }.elsewhen(io.memwb_rdwen_1 && (io.memwb_rd_1 === io.id_rs2_1)) {
        io.fwd_data_rs2_1 := io.memwb_data_1
      }
  }

}

object Generateforward1Verilog extends App {
  (new ChiselStage).emitVerilog(new forward1(), Array("--target-dir", "generated"))
}
