package riscv_core

import chisel3._
import chisel3.stage.ChiselStage
import chisel3.util._

// 从指令缓存接收到的指令包
class FetchBundle extends Bundle {
  val pc    = UInt(32.W)      // 指令地址
  val instr = UInt(32.W)      // 指令内容
  val valid = Bool()          // 指令有效标志
}

class ID extends Module {
  val io = IO(new Bundle {
    // 取指阶段输入（双发射）
    val fetch_in_0 = Input(new FetchBundle)
    val fetch_in_1 = Input(new FetchBundle)

    // 寄存器文件接口
    val reg_read_addr_0_0 = Output(UInt(5.W))  // 第一条指令rs1
    val reg_read_addr_0_1 = Output(UInt(5.W))  // 第一条指令rs2
    val reg_read_addr_1_0 = Output(UInt(5.W))  // 第二条指令rs1
    val reg_read_addr_1_1 = Output(UInt(5.W))  // 第二条指令rs2
    val reg_data_0_0 = Input(UInt(32.W))       // 第一条指令rs1数据
    val reg_data_0_1 = Input(UInt(32.W))       // 第一条指令rs2数据
    val reg_data_1_0 = Input(UInt(32.W))       // 第二条指令rs1数据
    val reg_data_1_1 = Input(UInt(32.W))       // 第二条指令rs2数据

    // 执行阶段输出（双发射）
    val decode_out_0 = Output(new DecodeBundle)
    val decode_out_1 = Output(new DecodeBundle)
    val valid_out_0 = Output(Bool())
    val valid_out_1 = Output(Bool())

    // 前馈来源（从EX和MEM阶段）
    val ex_forward_0 = Input(new ForwardBundle)
    val ex_forward_1 = Input(new ForwardBundle)
    val mem_forward_0 = Input(new ForwardBundle)
    val mem_forward_1 = Input(new ForwardBundle)

    // 流水线控制
    val flush_in = Input(Bool())   // 刷新信号
    val stall_in = Input(Bool())   // 停顿信号
    val stall_req = Output(Bool()) // 请求停顿
  })

  // 指令解码器实例化（双发射）
  val decoder_0 = Module(new InstructionDecoder())
  val decoder_1 = Module(new InstructionDecoder())

  // 前馈单元实例化
  val forward_unit = Module(new Forward())

  // 连接指令解码器输入
  decoder_0.io.instr_in := io.fetch_in_0.instr
  decoder_0.io.pc_in := io.fetch_in_0.pc

  decoder_1.io.instr_in := io.fetch_in_1.instr
  decoder_1.io.pc_in := io.fetch_in_1.pc

  // 从解码器获取源寄存器地址
  io.reg_read_addr_0_0 := decoder_0.io.rs1_addr
  io.reg_read_addr_0_1 := decoder_0.io.rs2_addr
  io.reg_read_addr_1_0 := decoder_1.io.rs1_addr
  io.reg_read_addr_1_1 := decoder_1.io.rs2_addr

  // 连接前馈单元输入
  forward_unit.io.id_rs1_0 := decoder_0.io.rs1_addr
  forward_unit.io.id_rs2_0 := decoder_0.io.rs2_addr
  forward_unit.io.id_rs1_1 := decoder_1.io.rs1_addr
  forward_unit.io.id_rs2_1 := decoder_1.io.rs2_addr
  forward_unit.io.id_rd_0 := decoder_0.io.rd_addr
  forward_unit.io.id_rdWen_0 := decoder_0.io.rd_wen

  // 连接寄存器文件读取的原始数据
  forward_unit.io.rs1_data_0 := io.reg_data_0_0
  forward_unit.io.rs2_data_0 := io.reg_data_0_1
  forward_unit.io.rs1_data_1 := io.reg_data_1_0
  forward_unit.io.rs2_data_1 := io.reg_data_1_1

  // 连接执行阶段前馈
  forward_unit.io.ex_rd_0 := io.ex_forward_0.rd
  forward_unit.io.ex_rd_1 := io.ex_forward_1.rd
  forward_unit.io.ex_rdWen_0 := io.ex_forward_0.rdWen
  forward_unit.io.ex_rdWen_1 := io.ex_forward_1.rdWen
  forward_unit.io.ex_result_0 := io.ex_forward_0.result
  forward_unit.io.ex_result_1 := io.ex_forward_1.result
  forward_unit.io.ex_is_load_0 := io.ex_forward_0.is_load
  forward_unit.io.ex_is_load_1 := io.ex_forward_1.is_load

  // 连接访存阶段前馈
  forward_unit.io.mem_rd_0 := io.mem_forward_0.rd
  forward_unit.io.mem_rd_1 := io.mem_forward_1.rd
  forward_unit.io.mem_rdWen_0 := io.mem_forward_0.rdWen
  forward_unit.io.mem_rdWen_1 := io.mem_forward_1.rdWen
  forward_unit.io.mem_result_0 := io.mem_forward_0.result
  forward_unit.io.mem_result_1 := io.mem_forward_1.result

  // 检测停顿需求
  io.stall_req := forward_unit.io.stall_req

  // 根据前馈单元输出和双发射状态生成最终输出
  val dual_issue = forward_unit.io.dual_issue && io.fetch_in_0.valid && io.fetch_in_1.valid && !io.stall_in && !io.flush_in

  // 准备第一条指令输出
  io.decode_out_0.instr_id := decoder_0.io.instr_type
  io.decode_out_0.rs1 := decoder_0.io.rs1_addr
  io.decode_out_0.rs2 := decoder_0.io.rs2_addr
  io.decode_out_0.rd := decoder_0.io.rd_addr
  io.decode_out_0.rs1_data := forward_unit.io.fwd_rs1_data_0
  io.decode_out_0.rs2_data := forward_unit.io.fwd_rs2_data_0
  io.decode_out_0.imm := decoder_0.io.imm
  io.decode_out_0.pc := io.fetch_in_0.pc
  io.decode_out_0.rdWen := decoder_0.io.rd_wen

  // 准备第二条指令输出
  io.decode_out_1.instr_id := decoder_1.io.instr_type
  io.decode_out_1.rs1 := decoder_1.io.rs1_addr
  io.decode_out_1.rs2 := decoder_1.io.rs2_addr
  io.decode_out_1.rd := decoder_1.io.rd_addr
  io.decode_out_1.rs1_data := forward_unit.io.fwd_rs1_data_1
  io.decode_out_1.rs2_data := forward_unit.io.fwd_rs2_data_1
  io.decode_out_1.imm := decoder_1.io.imm
  io.decode_out_1.pc := io.fetch_in_1.pc
  io.decode_out_1.rdWen := decoder_1.io.rd_wen

  // 设置输出有效信号
  io.valid_out_0 := io.fetch_in_0.valid && !io.stall_in && !io.flush_in
  io.valid_out_1 := dual_issue
}

// 指令解码器模块 - 使用switch-is重构
class InstructionDecoder extends Module {
  val io = IO(new Bundle {
    val instr_in = Input(UInt(32.W))  // 输入指令
    val pc_in = Input(UInt(32.W))     // 当前PC

    val rs1_addr = Output(UInt(5.W))  // 源寄存器1地址
    val rs2_addr = Output(UInt(5.W))  // 源寄存器2地址
    val rd_addr = Output(UInt(5.W))   // 目标寄存器地址
    val imm = Output(UInt(32.W))      // 立即数
    val instr_type = Output(UInt(6.W)) // 指令类型
    val rd_wen = Output(Bool())       // 寄存器写使能
    val is_branch = Output(Bool())    // 分支指令标志
    val is_jump = Output(Bool())      // 跳转指令标志
  })

  // 提取指令字段
  val opcode = io.instr_in(6, 0)
  val rd = io.instr_in(11, 7)
  val rs1 = io.instr_in(19, 15)
  val rs2 = io.instr_in(24, 20)
  val funct3 = io.instr_in(14, 12)
  val funct7 = io.instr_in(31, 25)

  // 默认输出
  io.rs1_addr := rs1
  io.rs2_addr := rs2
  io.rd_addr := rd
  io.imm := 0.U
  io.instr_type := RV32IInstructions.NOP
  io.rd_wen := false.B
  io.is_branch := false.B
  io.is_jump := false.B

  // 指令解码逻辑 - 使用switch-is结构
  switch(opcode) {
    // R-type 指令
    is("b0110011".U) { // ADD/SUB/AND/OR/XOR/SLL/SRL/SRA/SLT/SLTU
      io.rd_wen := true.B

      // 使用嵌套的 switch 结构代替 Cat
      switch(funct7) {
        is("b0000000".U) {
          switch(funct3) {
            is("b000".U) {
              io.instr_type := RV32IInstructions.ADD
            }
            is("b001".U) {
              io.instr_type := RV32IInstructions.SLL
            }
            is("b010".U) {
              io.instr_type := RV32IInstructions.SLT
            }
            is("b011".U) {
              io.instr_type := RV32IInstructions.SLTU
            }
            is("b100".U) {
              io.instr_type := RV32IInstructions.XOR
            }
            is("b101".U) {
              io.instr_type := RV32IInstructions.SRL
            }
            is("b110".U) {
              io.instr_type := RV32IInstructions.OR
            }
            is("b111".U) {
              io.instr_type := RV32IInstructions.AND
            }
          }
        }
        is("b0100000".U) {
          switch(funct3) {
            is("b000".U) {
              io.instr_type := RV32IInstructions.SUB
            }
            is("b101".U) {
              io.instr_type := RV32IInstructions.SRA
            }
          }
        }
      }
    }

    // I-type 指令
    is("b0010011".U) { // ADDI/SLTI/SLTIU/XORI/ORI/ANDI/SLLI/SRLI/SRAI
      io.rd_wen := true.B

      // 立即数提取与符号扩展
      val imm_i = Cat(Fill(20, io.instr_in(31)), io.instr_in(31, 20))
      io.imm := imm_i

      switch(funct3) {
        is("b000".U) { io.instr_type := RV32IInstructions.ADDI }
        is("b010".U) { io.instr_type := RV32IInstructions.SLTI }
        is("b011".U) { io.instr_type := RV32IInstructions.SLTIU }
        is("b100".U) { io.instr_type := RV32IInstructions.XORI }
        is("b110".U) { io.instr_type := RV32IInstructions.ORI }
        is("b111".U) { io.instr_type := RV32IInstructions.ANDI }
        is("b001".U) { io.instr_type := RV32IInstructions.SLLI }
        is("b101".U) {
          switch(funct7(6, 1)) {
            is("b000000".U) { io.instr_type := RV32IInstructions.SRLI }
            is("b010000".U) { io.instr_type := RV32IInstructions.SRAI }
          }
        }
      }
    }

    // 加载指令
    is("b0000011".U) { // LB/LH/LW/LBU/LHU
      io.rd_wen := true.B
      val imm_i = Cat(Fill(20, io.instr_in(31)), io.instr_in(31, 20))
      io.imm := imm_i

      switch(funct3) {
        is("b000".U) { io.instr_type := RV32IInstructions.LB }
        is("b001".U) { io.instr_type := RV32IInstructions.LH }
        is("b010".U) { io.instr_type := RV32IInstructions.LW }
        is("b100".U) { io.instr_type := RV32IInstructions.LBU }
        is("b101".U) { io.instr_type := RV32IInstructions.LHU }
      }
    }

    // 存储指令
    is("b0100011".U) { // SB/SH/SW
      val imm_s = Cat(Fill(20, io.instr_in(31)), io.instr_in(31, 25), io.instr_in(11, 7))
      io.imm := imm_s

      switch(funct3) {
        is("b000".U) { io.instr_type := RV32IInstructions.SB }
        is("b001".U) { io.instr_type := RV32IInstructions.SH }
        is("b010".U) { io.instr_type := RV32IInstructions.SW }
      }
    }

    // 分支指令
    is("b1100011".U) { // BEQ/BNE/BLT/BGE/BLTU/BGEU
      val imm_b = Cat(Fill(19, io.instr_in(31)), io.instr_in(31), io.instr_in(7),
        io.instr_in(30, 25), io.instr_in(11, 8), 0.U(1.W))
      io.imm := imm_b
      io.is_branch := true.B

      switch(funct3) {
        is("b000".U) { io.instr_type := RV32IInstructions.BEQ }
        is("b001".U) { io.instr_type := RV32IInstructions.BNE }
        is("b100".U) { io.instr_type := RV32IInstructions.BLT }
        is("b101".U) { io.instr_type := RV32IInstructions.BGE }
        is("b110".U) { io.instr_type := RV32IInstructions.BLTU }
        is("b111".U) { io.instr_type := RV32IInstructions.BGEU }
      }
    }

    // JAL指令
    is("b1101111".U) { // JAL
      val imm_j = Cat(Fill(11, io.instr_in(31)), io.instr_in(31), io.instr_in(19, 12),
        io.instr_in(20), io.instr_in(30, 21), 0.U(1.W))
      io.imm := imm_j
      io.rd_wen := true.B
      io.is_jump := true.B
      io.instr_type := RV32IInstructions.JAL
    }

    // JALR指令
    is("b1100111".U) { // JALR
      val imm_i = Cat(Fill(20, io.instr_in(31)), io.instr_in(31, 20))
      io.imm := imm_i
      io.rd_wen := true.B
      io.is_jump := true.B
      io.instr_type := RV32IInstructions.JALR
    }

    // LUI指令
    is("b0110111".U) { // LUI
      val imm_u = Cat(io.instr_in(31, 12), 0.U(12.W))
      io.imm := imm_u
      io.rd_wen := true.B
      io.instr_type := RV32IInstructions.LUI
    }

    // AUIPC指令
    is("b0010111".U) { // AUIPC
      val imm_u = Cat(io.instr_in(31, 12), 0.U(12.W))
      io.imm := imm_u
      io.rd_wen := true.B
      io.instr_type := RV32IInstructions.AUIPC
    }
  }
}

object GenerateIDVerilog extends App {
  (new ChiselStage).emitVerilog(new ID(), Array("--target-dir", "generated"))
}
  
