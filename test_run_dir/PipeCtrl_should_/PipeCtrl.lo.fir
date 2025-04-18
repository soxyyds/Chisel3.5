circuit PipeCtrl :
  module PipeCtrl :
    input clock : Clock
    input reset : UInt<1>
    input io_DatHzdBlkP0 : UInt<1>
    input io_DatHzdBlkP1 : UInt<1>
    input io_MultiMemBlk0 : UInt<1>
    input io_MultiMemBlk1 : UInt<1>
    input io_ImissVld : UInt<1>
    input io_DmissVld : UInt<1>
    input io_IoBlk : UInt<1>
    input io_BufStl : UInt<1>
    input io_BjEn0 : UInt<1>
    input io_PreTaken0 : UInt<1>
    input io_BjTypeVld0 : UInt<1>
    input io_BjEn1 : UInt<1>
    input io_PreTaken1 : UInt<1>
    input io_BjTypeVld1 : UInt<1>
    input io_RstingBlk : UInt<1>
    output io_ExMem1Fls0 : UInt<1>
    output io_ExMem1Fls1 : UInt<1>
    output io_FeDeStl_MemMem2Stl_Mem2WbStl : UInt<1>
    output io_FeStl : UInt<1>
    output io_DataBlk0 : UInt<1>
    output io_DataBlk1 : UInt<1>
    output io_FeDeFls : UInt<1>
    output io_DeEXFls : UInt<1>

    node Blk0 = or(io_DatHzdBlkP0, io_MultiMemBlk0) @[PipeCtrl.scala 37:29]
    node Blk1 = or(io_DatHzdBlkP1, io_MultiMemBlk1) @[PipeCtrl.scala 38:29]
    node _Freeze_T = or(io_ImissVld, io_DmissVld) @[PipeCtrl.scala 39:28]
    node Freeze = or(_Freeze_T, io_IoBlk) @[PipeCtrl.scala 39:43]
    node DeExBlk0 = or(Blk0, Freeze) @[PipeCtrl.scala 40:23]
    node DeExBlk1 = or(Blk1, Freeze) @[PipeCtrl.scala 41:23]
    node _BjEnVld0_T = eq(io_DatHzdBlkP0, UInt<1>("h0")) @[PipeCtrl.scala 42:31]
    node BjEnVld0 = and(io_BjEn0, _BjEnVld0_T) @[PipeCtrl.scala 42:27]
    node _BjEnVld1_T = eq(io_DatHzdBlkP1, UInt<1>("h0")) @[PipeCtrl.scala 43:31]
    node _BjEnVld1_T_1 = and(io_BjEn1, _BjEnVld1_T) @[PipeCtrl.scala 43:27]
    node _BjEnVld1_T_2 = eq(Blk0, UInt<1>("h0")) @[PipeCtrl.scala 43:52]
    node BjEnVld1 = and(_BjEnVld1_T_1, _BjEnVld1_T_2) @[PipeCtrl.scala 43:48]
    node _PreMissP0_T = eq(io_PreTaken0, UInt<1>("h0")) @[PipeCtrl.scala 44:32]
    node _PreMissP0_T_1 = and(BjEnVld0, _PreMissP0_T) @[PipeCtrl.scala 44:28]
    node _PreMissP0_T_2 = eq(BjEnVld0, UInt<1>("h0")) @[PipeCtrl.scala 44:51]
    node _PreMissP0_T_3 = and(_PreMissP0_T_2, io_BjTypeVld0) @[PipeCtrl.scala 44:62]
    node _PreMissP0_T_4 = and(_PreMissP0_T_3, io_PreTaken0) @[PipeCtrl.scala 44:79]
    node PreMissP0 = or(_PreMissP0_T_1, _PreMissP0_T_4) @[PipeCtrl.scala 44:47]
    node _PreMissP1_T = eq(io_PreTaken1, UInt<1>("h0")) @[PipeCtrl.scala 45:32]
    node _PreMissP1_T_1 = and(BjEnVld1, _PreMissP1_T) @[PipeCtrl.scala 45:28]
    node _PreMissP1_T_2 = eq(BjEnVld1, UInt<1>("h0")) @[PipeCtrl.scala 45:51]
    node _PreMissP1_T_3 = and(_PreMissP1_T_2, io_BjTypeVld1) @[PipeCtrl.scala 45:62]
    node _PreMissP1_T_4 = and(_PreMissP1_T_3, io_PreTaken1) @[PipeCtrl.scala 45:79]
    node PreMissP1 = or(_PreMissP1_T_1, _PreMissP1_T_4) @[PipeCtrl.scala 45:47]
    node PreMiss = or(PreMissP0, PreMissP1) @[PipeCtrl.scala 46:27]
    node _io_FeStl_T = or(io_BufStl, Freeze) @[PipeCtrl.scala 50:25]
    node _io_ExMem1Fls0_T = eq(Freeze, UInt<1>("h0")) @[PipeCtrl.scala 52:33]
    node _io_ExMem1Fls0_T_1 = and(DeExBlk0, _io_ExMem1Fls0_T) @[PipeCtrl.scala 52:29]
    node _io_FeDeFls_T = or(PreMiss, io_RstingBlk) @[PipeCtrl.scala 54:25]
    node _io_ExMem1Fls1_T = or(DeExBlk0, DeExBlk1) @[PipeCtrl.scala 55:30]
    node _io_ExMem1Fls1_T_1 = eq(Freeze, UInt<1>("h0")) @[PipeCtrl.scala 55:47]
    node _io_ExMem1Fls1_T_2 = and(_io_ExMem1Fls1_T, _io_ExMem1Fls1_T_1) @[PipeCtrl.scala 55:43]
    node _io_ExMem1Fls1_T_3 = or(_io_ExMem1Fls1_T_2, PreMissP0) @[PipeCtrl.scala 55:56]
    node _io_DataBlk0_T = or(io_DatHzdBlkP0, Freeze) @[PipeCtrl.scala 56:33]
    node _io_DataBlk1_T = or(io_DatHzdBlkP1, Freeze) @[PipeCtrl.scala 57:33]
    node _io_DataBlk1_T_1 = or(_io_DataBlk1_T, io_DatHzdBlkP0) @[PipeCtrl.scala 57:43]
    io_ExMem1Fls0 <= _io_ExMem1Fls0_T_1 @[PipeCtrl.scala 52:17]
    io_ExMem1Fls1 <= _io_ExMem1Fls1_T_3 @[PipeCtrl.scala 55:17]
    io_FeDeStl_MemMem2Stl_Mem2WbStl <= Freeze @[PipeCtrl.scala 51:35]
    io_FeStl <= _io_FeStl_T @[PipeCtrl.scala 50:12]
    io_DataBlk0 <= _io_DataBlk0_T @[PipeCtrl.scala 56:15]
    io_DataBlk1 <= _io_DataBlk1_T_1 @[PipeCtrl.scala 57:15]
    io_FeDeFls <= _io_FeDeFls_T @[PipeCtrl.scala 54:14]
    io_DeEXFls <= PreMiss @[PipeCtrl.scala 53:14]
