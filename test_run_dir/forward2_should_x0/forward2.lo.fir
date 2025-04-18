circuit forward2 :
  module forward2 :
    input clock : Clock
    input reset : UInt<1>
    input io_id_rs1_1 : UInt<5>
    input io_id_rs2_1 : UInt<5>
    input io_id_rd_0 : UInt<5>
    input io_id_rdwen_0 : UInt<1>
    output io_stallex : UInt<1>

    node _sel1_T = neq(io_id_rd_0, UInt<1>("h0")) @[forward2.scala 16:43]
    node _sel1_T_1 = and(io_id_rdwen_0, _sel1_T) @[forward2.scala 16:28]
    node _sel1_T_2 = eq(io_id_rd_0, io_id_rs1_1) @[forward2.scala 16:67]
    node sel1 = and(_sel1_T_1, _sel1_T_2) @[forward2.scala 16:52]
    node _sel2_T = neq(io_id_rd_0, UInt<1>("h0")) @[forward2.scala 17:43]
    node _sel2_T_1 = and(io_id_rdwen_0, _sel2_T) @[forward2.scala 17:28]
    node _sel2_T_2 = eq(io_id_rd_0, io_id_rs2_1) @[forward2.scala 17:67]
    node sel2 = and(_sel2_T_1, _sel2_T_2) @[forward2.scala 17:52]
    node _io_stallex_T = or(sel1, sel2) @[forward2.scala 18:22]
    io_stallex <= _io_stallex_T @[forward2.scala 18:14]
