circuit forward2 :
  module forward2 :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip id_rs1_1 : UInt<5>, flip id_rs2_1 : UInt<5>, flip id_rd_0 : UInt<5>, flip id_rdwen_0 : UInt<1>, stallex : UInt<1>}

    node _sel1_T = neq(io.id_rd_0, UInt<1>("h0")) @[forward2.scala 19:43]
    node _sel1_T_1 = and(io.id_rdwen_0, _sel1_T) @[forward2.scala 19:28]
    node _sel1_T_2 = eq(io.id_rd_0, io.id_rs1_1) @[forward2.scala 19:67]
    node sel1 = and(_sel1_T_1, _sel1_T_2) @[forward2.scala 19:52]
    node _sel2_T = neq(io.id_rd_0, UInt<1>("h0")) @[forward2.scala 20:43]
    node _sel2_T_1 = and(io.id_rdwen_0, _sel2_T) @[forward2.scala 20:28]
    node _sel2_T_2 = eq(io.id_rd_0, io.id_rs2_1) @[forward2.scala 20:67]
    node sel2 = and(_sel2_T_1, _sel2_T_2) @[forward2.scala 20:52]
    node _io_stallex_T = or(sel1, sel2) @[forward2.scala 21:22]
    io.stallex <= _io_stallex_T @[forward2.scala 21:14]

