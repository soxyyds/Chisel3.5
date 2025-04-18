package pipectrl

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class PipeCtrlTester extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "PipeCtrl"

  it should "正确处理数据冒险" in {
    test(new PipeCtrl()) { dut =>
      // 测试数据冒险阻塞
      dut.io.DatHzdBlkP0.poke(true.B)
      dut.io.DataBlk0.expect(true.B)
      dut.io.DataBlk1.expect(true.B)  // P1也应该被阻塞

      dut.io.DatHzdBlkP1.poke(true.B)
      dut.io.DataBlk1.expect(true.B)

      // 清除数据冒险
      dut.io.DatHzdBlkP0.poke(false.B)
      dut.io.DatHzdBlkP1.poke(false.B)
      dut.io.DataBlk0.expect(false.B)
      dut.io.DataBlk1.expect(false.B)
    }
  }

  it should "正确处理多重内存访问冲突" in {
    test(new PipeCtrl()) { dut =>
      dut.io.MultiMemBlk0.poke(true.B)
      dut.io.MultiMemBlk1.poke(true.B)
      dut.io.ExMem1Fls0.expect(true.B)
      dut.io.ExMem1Fls1.expect(true.B)
    }
  }

  it should "正确处理Cache缺失" in {
    test(new PipeCtrl()) { dut =>
      // 测试指令Cache缺失
      dut.io.ImissVld.poke(true.B)
      dut.io.FeStl.expect(true.B)
      dut.io.FeDeStl_MemMem2Stl_Mem2WbStl.expect(true.B)

      // 测试数据Cache缺失
      dut.io.DmissVld.poke(true.B)
      dut.io.FeStl.expect(true.B)
      dut.io.FeDeStl_MemMem2Stl_Mem2WbStl.expect(true.B)
    }
  }

  it should "正确处理分支预测" in {
    test(new PipeCtrl()) { dut =>
      // 测试分支预测失败
      dut.io.BjEn0.poke(true.B)
      dut.io.PreTaken0.poke(false.B)
      dut.io.BjTypeVld0.poke(true.B)
      dut.io.FeDeFls.expect(true.B)
      dut.io.DeEXFls.expect(true.B)

      // 测试P1分支
      dut.io.BjEn1.poke(true.B)
      dut.io.PreTaken1.poke(false.B)
      dut.io.BjTypeVld1.poke(true.B)
      dut.io.FeDeFls.expect(true.B)
      dut.io.DeEXFls.expect(true.B)
    }
  }

  it should "正确处理复位阻塞" in {
    test(new PipeCtrl()) { dut =>
      dut.io.RstingBlk.poke(true.B)
      dut.io.FeDeFls.expect(true.B)
    }
  }
}