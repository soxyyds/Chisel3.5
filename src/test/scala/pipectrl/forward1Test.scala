package pipectrl

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class forward1Test extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "forward1"

  it should "不需要前馈时使用原始寄存器值" in {
    test(new forward1) { dut =>
      // 设置寄存器原始值
      dut.io.id_rs1_data_0.poke(10.U)
      dut.io.id_rs2_data_0.poke(20.U)
      dut.io.id_rs1_data_1.poke(30.U)
      dut.io.id_rs2_data_1.poke(40.U)

      // 设置寄存器地址 (与前馈源不同)
      dut.io.id_rs1_0.poke(1.U)
      dut.io.id_rs2_0.poke(2.U)
      dut.io.id_rs1_1.poke(3.U)
      dut.io.id_rs2_1.poke(4.U)

      // 设置前馈源寄存器 (与需求不匹配)
      dut.io.exmem_rd_0.poke(5.U)
      dut.io.exmem_rd_1.poke(6.U)
      dut.io.exmem_rdwen_0.poke(true.B)
      dut.io.exmem_rdwen_1.poke(true.B)
      dut.io.exmem_data_0.poke(100.U)
      dut.io.exmem_data_1.poke(200.U)

      // 检查输出 - 应该使用原始值
      dut.io.fwd_data_rs1_0.expect(10.U)
      dut.io.fwd_data_rs2_0.expect(20.U)
      dut.io.fwd_data_rs1_1.expect(30.U)
      dut.io.fwd_data_rs2_1.expect(40.U)
    }
  }

  it should "从执行访存阶段进行前馈" in {
    test(new forward1) { dut =>
      // 设置寄存器原始值
      dut.io.id_rs1_data_0.poke(10.U)
      dut.io.id_rs2_data_0.poke(20.U)

      // 设置寄存器地址
      dut.io.id_rs1_0.poke(5.U) // 需要前馈
      dut.io.id_rs2_0.poke(6.U) // 需要前馈

      // 设置前馈源寄存器
      dut.io.exmem_rd_0.poke(5.U) // 匹配rs1_0
      dut.io.exmem_rd_1.poke(6.U) // 匹配rs2_0
      dut.io.exmem_rdwen_0.poke(true.B)
      dut.io.exmem_rdwen_1.poke(true.B)
      dut.io.exmem_data_0.poke(100.U)
      dut.io.exmem_data_1.poke(200.U)

      // 检查输出 - 应该使用前馈值
      dut.io.fwd_data_rs1_0.expect(100.U)
      dut.io.fwd_data_rs2_0.expect(200.U)
    }
  }

  it should "从访存阶段进行前馈" in {
    test(new forward1) { dut =>
      // 设置寄存器原始值
      dut.io.id_rs1_data_1.poke(30.U)
      dut.io.id_rs2_1.poke(31.U)

      // 设置寄存器地址
      dut.io.id_rs1_1.poke(7.U) // 需要前馈
      dut.io.id_rs2_1.poke(8.U) // 需要前馈

      // 设置前馈源寄存器
      dut.io.mem_rd_0.poke(7.U) // 匹配rs1_1
      dut.io.mem_rd_1.poke(8.U) // 匹配rs2_1
      dut.io.mem_rdwen_0.poke(true.B)
      dut.io.mem_rdwen_1.poke(true.B)
      dut.io.mem_data_0.poke(300.U)
      dut.io.mem_data_1.poke(400.U)

      // 检查输出 - 应该使用前馈值
      dut.io.fwd_data_rs1_1.expect(300.U)
      dut.io.fwd_data_rs2_1.expect(400.U)
    }
  }

  it should "尊重前馈优先级 (执行>访存>写回)" in {
    test(new forward1) { dut =>
      // 设置寄存器原始值
      dut.io.id_rs1_data_0.poke(10.U)

      // 设置寄存器地址
      dut.io.id_rs1_0.poke(1.U) // 需要前馈

      // 多个阶段都有同一寄存器的数据
      dut.io.exmem_rd_0.poke(1.U)
      dut.io.exmem_rdwen_0.poke(true.B)
      dut.io.exmem_data_0.poke(100.U)

      dut.io.mem_rd_0.poke(1.U)
      dut.io.mem_rdwen_0.poke(true.B)
      dut.io.mem_data_0.poke(200.U)

      dut.io.memwb_rd_0.poke(1.U)
      dut.io.memwb_rdwen_0.poke(true.B)
      dut.io.memwb_data_0.poke(300.U)

      // 检查输出 - 应该选择优先级最高的 (执行阶段)
      dut.io.fwd_data_rs1_0.expect(100.U)
    }
  }

  it should "不对零寄存器(x0)进行前馈" in {
    test(new forward1) { dut =>
      // 设置寄存器地址为x0
      dut.io.id_rs1_0.poke(0.U)
      dut.io.id_rs1_data_0.poke(0.U)

      // 设置前馈源
      dut.io.exmem_rd_0.poke(0.U)
      dut.io.exmem_rdwen_0.poke(true.B)
      dut.io.exmem_data_0.poke(100.U)

      // 零寄存器应始终为0
      dut.io.fwd_data_rs1_0.expect(0.U)
    }
  }

  it should "处理双发射指令间的前馈" in {
    test(new forward1) { dut =>
      // 测试第一条指令和第二条指令间的前馈

      // 设置第二条指令的源寄存器
      dut.io.id_rs1_1.poke(5.U)
      dut.io.id_rs1_data_1.poke(10.U)  // 原始值

      // 第一条和第二条指令都在执行阶段
      dut.io.exmem_rd_0.poke(5.U)      // 第一条指令的目标寄存器
      dut.io.exmem_rdwen_0.poke(true.B)
      dut.io.exmem_data_0.poke(100.U)   // 第一条指令的结果

      // 检查第二条指令是否正确接收第一条指令的结果
      dut.io.fwd_data_rs1_1.expect(100.U)
    }
  }

  it should "处理多级流水线阶段的前馈" in {
    test(new forward1) { dut =>
      // 同时设置所有前馈路径

      // 设置源寄存器
      dut.io.id_rs1_0.poke(1.U)
      dut.io.id_rs2_0.poke(2.U)
      dut.io.id_rs1_1.poke(3.U)
      dut.io.id_rs2_1.poke(4.U)

      // 源寄存器原始值
      dut.io.id_rs1_data_0.poke(10.U)
      dut.io.id_rs2_data_0.poke(20.U)
      dut.io.id_rs1_data_1.poke(30.U)
      dut.io.id_rs2_data_1.poke(40.U)

      // 设置各阶段前馈源
      dut.io.exmem_rd_0.poke(1.U)
      dut.io.exmem_rdwen_0.poke(true.B)
      dut.io.exmem_data_0.poke(100.U)

      dut.io.mem_rd_0.poke(2.U)
      dut.io.mem_rdwen_0.poke(true.B)
      dut.io.mem_data_0.poke(200.U)

      dut.io.memwb_rd_0.poke(3.U)
      dut.io.memwb_rdwen_0.poke(true.B)
      dut.io.memwb_data_0.poke(300.U)

      dut.io.memwb_rd_1.poke(4.U)
      dut.io.memwb_rdwen_1.poke(true.B)
      dut.io.memwb_data_1.poke(400.U)

      // 检查所有前馈路径
      dut.io.fwd_data_rs1_0.expect(100.U)  // 从执行阶段
      dut.io.fwd_data_rs2_0.expect(200.U)  // 从访存阶段
      dut.io.fwd_data_rs1_1.expect(300.U)  // 从写回阶段
      dut.io.fwd_data_rs2_1.expect(400.U)  // 从写回阶段
    }
  }
  it should "检测加载指令导致的数据冒险并请求停顿" in {
    test(new forward1) { dut =>
      // 第一条指令是加载指令，目标寄存器为5
      dut.io.exmem_rd_0.poke(5.U)
      dut.io.exmem_rdwen_0.poke(true.B)
      dut.io.exmem_rdlden_0.poke(true.B)  // 这是加载指令

      // 第二条指令使用r5作为源寄存器
      dut.io.id_rs1_0.poke(5.U)

      // 应该产生停顿请求
      dut.io.stall_req.expect(true.B)
    }
  }

  it should "检测第二条加载指令导致的数据冒险" in {
    test(new forward1) { dut =>
      // 第二条指令是加载指令，目标寄存器为6
      dut.io.exmem_rd_1.poke(6.U)
      dut.io.exmem_rdwen_1.poke(true.B)
      dut.io.exmem_rdlden_1.poke(true.B)  // 这是加载指令

      // 某条指令使用r6作为源寄存器
      dut.io.id_rs2_1.poke(6.U)

      // 应该产生停顿请求
      dut.io.stall_req.expect(true.B)
    }
  }

  it should "当多个寄存器依赖加载指令时请求停顿" in {
    test(new forward1) { dut =>
      // 加载指令，目标寄存器为7
      dut.io.exmem_rd_0.poke(7.U)
      dut.io.exmem_rdwen_0.poke(true.B)
      dut.io.exmem_rdlden_0.poke(true.B)

      // 多个寄存器依赖r7
      dut.io.id_rs1_0.poke(7.U)
      dut.io.id_rs2_1.poke(7.U)

      // 应该产生停顿请求
      dut.io.stall_req.expect(true.B)
    }
  }

  it should "不对零寄存器依赖生成停顿请求" in {
    test(new forward1) { dut =>
      // 加载指令，目标寄存器为x0
      dut.io.exmem_rd_0.poke(0.U)
      dut.io.exmem_rdwen_0.poke(true.B)
      dut.io.exmem_rdlden_0.poke(true.B)

      // 某条指令使用x0作为源
      dut.io.id_rs1_0.poke(0.U)

      // 不应产生停顿请求
      dut.io.stall_req.expect(false.B)
    }
  }

  it should "当没有加载指令时不产生停顿" in {
    test(new forward1) { dut =>
      // 非加载指令，目标寄存器为5
      dut.io.exmem_rd_0.poke(5.U)
      dut.io.exmem_rdwen_0.poke(true.B)
      dut.io.exmem_rdlden_0.poke(false.B)  // 不是加载指令

      // 某条指令使用r5作为源寄存器
      dut.io.id_rs1_0.poke(5.U)

      // 不应产生停顿请求
      dut.io.stall_req.expect(false.B)
    }
  }

  it should "停顿和前馈功能同时工作" in {
    test(new forward1) { dut =>
      // 设置前馈源和原始值
      dut.io.id_rs1_0.poke(5.U)
      dut.io.id_rs1_data_0.poke(10.U)

      // 执行访存阶段指令是加载指令
      dut.io.exmem_rd_0.poke(5.U)
      dut.io.exmem_rdwen_0.poke(true.B)
      dut.io.exmem_rdlden_0.poke(true.B)
      dut.io.exmem_data_0.poke(100.U)

      // 应该同时产生前馈和停顿请求
      dut.io.fwd_data_rs1_0.expect(100.U)  // 前馈数据已更新
      dut.io.stall_req.expect(true.B)      // 同时请求停顿
    }
  }
}