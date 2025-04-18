module PipeCtrl(
  input   clock,
  input   reset,
  input   io_DatHzdBlkP0,
  input   io_DatHzdBlkP1,
  input   io_MultiMemBlk0,
  input   io_MultiMemBlk1,
  input   io_ImissVld,
  input   io_DmissVld,
  input   io_IoBlk,
  input   io_BufStl,
  input   io_BjEn0,
  input   io_PreTaken0,
  input   io_BjTypeVld0,
  input   io_BjEn1,
  input   io_PreTaken1,
  input   io_BjTypeVld1,
  input   io_RstingBlk,
  output  io_ExMem1Fls0,
  output  io_ExMem1Fls1,
  output  io_FeDeStl_MemMem2Stl_Mem2WbStl,
  output  io_FeStl,
  output  io_DataBlk0,
  output  io_DataBlk1,
  output  io_FeDeFls,
  output  io_DeEXFls
);
  wire  Blk0 = io_DatHzdBlkP0 | io_MultiMemBlk0; // @[PipeCtrl.scala 39:29]
  wire  Blk1 = io_DatHzdBlkP1 | io_MultiMemBlk1; // @[PipeCtrl.scala 40:29]
  wire  Freeze = io_ImissVld | io_DmissVld | io_IoBlk; // @[PipeCtrl.scala 41:43]
  wire  DeExBlk0 = Blk0 | Freeze; // @[PipeCtrl.scala 42:23]
  wire  DeExBlk1 = Blk1 | Freeze; // @[PipeCtrl.scala 43:23]
  wire  BjEnVld0 = io_BjEn0 & ~io_DatHzdBlkP0; // @[PipeCtrl.scala 44:27]
  wire  BjEnVld1 = io_BjEn1 & ~io_DatHzdBlkP1 & ~Blk0; // @[PipeCtrl.scala 45:48]
  wire  PreMissP0 = BjEnVld0 & ~io_PreTaken0 | ~BjEnVld0 & io_BjTypeVld0 & io_PreTaken0; // @[PipeCtrl.scala 46:47]
  wire  PreMissP1 = BjEnVld1 & ~io_PreTaken1 | ~BjEnVld1 & io_BjTypeVld1 & io_PreTaken1; // @[PipeCtrl.scala 47:47]
  wire  PreMiss = PreMissP0 | PreMissP1; // @[PipeCtrl.scala 48:27]
  wire  _io_ExMem1Fls0_T = ~Freeze; // @[PipeCtrl.scala 54:33]
  assign io_ExMem1Fls0 = DeExBlk0 & ~Freeze; // @[PipeCtrl.scala 54:29]
  assign io_ExMem1Fls1 = (DeExBlk0 | DeExBlk1) & _io_ExMem1Fls0_T | PreMissP0; // @[PipeCtrl.scala 57:56]
  assign io_FeDeStl_MemMem2Stl_Mem2WbStl = io_ImissVld | io_DmissVld | io_IoBlk; // @[PipeCtrl.scala 41:43]
  assign io_FeStl = io_BufStl | Freeze; // @[PipeCtrl.scala 52:25]
  assign io_DataBlk0 = io_DatHzdBlkP0 | Freeze; // @[PipeCtrl.scala 58:33]
  assign io_DataBlk1 = io_DatHzdBlkP1 | Freeze | io_DatHzdBlkP0; // @[PipeCtrl.scala 59:43]
  assign io_FeDeFls = PreMiss | io_RstingBlk; // @[PipeCtrl.scala 56:25]
  assign io_DeEXFls = PreMissP0 | PreMissP1; // @[PipeCtrl.scala 48:27]
endmodule
