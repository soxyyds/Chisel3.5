package pipectrl
import chisel3._
import chisel3.stage.{ChiselStage, ChiselGeneratorAnnotation}


class PipeCtrl extends Module{
  val io = IO(new Bundle{
    val DatHzdBlkP0 =  Input(Bool())
    val DatHzdBlkP1 =  Input(Bool())
    val MultiMemBlk0 = Input(Bool())
    val MultiMemBlk1 = Input(Bool())

    val ImissVld = Input(Bool())
    val DmissVld = Input(Bool())
    val IoBlk = Input(Bool())
    val BufStl = Input(Bool())

    val BjEn0 = Input(Bool())
    val PreTaken0 = Input(Bool())
    val BjTypeVld0 = Input(Bool())
    val BjEn1 = Input(Bool())
    val PreTaken1 = Input(Bool())
    val BjTypeVld1 = Input(Bool())
    val RstingBlk = Input(Bool())

    val ExMem1Fls0 = Output(Bool())
    val ExMem1Fls1 = Output(Bool())

    val FeDeStl_MemMem2Stl_Mem2WbStl = Output(Bool())
    val FeStl = Output(Bool())

    val DataBlk0 = Output(Bool())
    val DataBlk1 = Output(Bool())

    val FeDeFls = Output(Bool())
    val DeEXFls = Output(Bool())
  })

  val Blk0 = io.DatHzdBlkP0 || io.MultiMemBlk0
  val Blk1 = io.DatHzdBlkP1 || io.MultiMemBlk1
  val Freeze = io.ImissVld || io.DmissVld || io.IoBlk
  val DeExBlk0 = Blk0 || Freeze
  val DeExBlk1 = Blk1 || Freeze
  val BjEnVld0 = io.BjEn0 && (!io.DatHzdBlkP0)
  val BjEnVld1 = io.BjEn1 && (!io.DatHzdBlkP1) && (!Blk0)
  val PreMissP0 = BjEnVld0 && (!io.PreTaken0) || (!BjEnVld0) && io.BjTypeVld0 && io.PreTaken0
  val PreMissP1 = BjEnVld1 && (!io.PreTaken1) || (!BjEnVld1) && io.BjTypeVld1 && io.PreTaken1
  val PreMiss = PreMissP0 || PreMissP1



  io.FeStl := io.BufStl || Freeze
  io.FeDeStl_MemMem2Stl_Mem2WbStl := Freeze
  io.ExMem1Fls0 := DeExBlk0 && (!Freeze)
  io.DeEXFls := PreMiss
  io.FeDeFls := PreMiss || io.RstingBlk
  io.ExMem1Fls1 := (DeExBlk0 || DeExBlk1) && (!Freeze) || PreMissP0
  io.DataBlk0 := io.DatHzdBlkP0 || Freeze
  io.DataBlk1 := io.DatHzdBlkP1 || Freeze || io.DatHzdBlkP0
}

object PipeCtrlVerilog extends App {
  (new chisel3.stage.ChiselStage).execute(
    Array("-X", "verilog"),
    Seq(ChiselGeneratorAnnotation(() => new PipeCtrl))
  )
}


