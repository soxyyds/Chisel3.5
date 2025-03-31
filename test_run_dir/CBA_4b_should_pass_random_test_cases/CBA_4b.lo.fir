circuit CBA_4b :
  module RCA_4b :
    input clock : Clock
    input reset : UInt<1>
    input io_a : UInt<4>
    input io_b : UInt<4>
    input io_cin : UInt<1>
    output io_s : UInt<4>
    output io_cout : UInt<1>

    node _c_1_T = bits(io_a, 0, 0) @[ADDER.scala 36:22]
    node _c_1_T_1 = bits(io_b, 0, 0) @[ADDER.scala 36:32]
    node _c_1_T_2 = and(_c_1_T, _c_1_T_1) @[ADDER.scala 36:26]
    node _c_1_T_3 = bits(io_a, 0, 0) @[ADDER.scala 36:52]
    node _c_1_T_4 = bits(io_b, 0, 0) @[ADDER.scala 36:62]
    node _c_1_T_5 = xor(_c_1_T_3, _c_1_T_4) @[ADDER.scala 36:56]
    node c_0 = io_cin @[ADDER.scala 31:15 33:8]
    node _c_1_T_6 = and(c_0, _c_1_T_5) @[ADDER.scala 36:45]
    node _c_1_T_7 = or(_c_1_T_2, _c_1_T_6) @[ADDER.scala 36:37]
    node _c_2_T = bits(io_a, 1, 1) @[ADDER.scala 36:22]
    node _c_2_T_1 = bits(io_b, 1, 1) @[ADDER.scala 36:32]
    node _c_2_T_2 = and(_c_2_T, _c_2_T_1) @[ADDER.scala 36:26]
    node _c_2_T_3 = bits(io_a, 1, 1) @[ADDER.scala 36:52]
    node _c_2_T_4 = bits(io_b, 1, 1) @[ADDER.scala 36:62]
    node _c_2_T_5 = xor(_c_2_T_3, _c_2_T_4) @[ADDER.scala 36:56]
    node c_1 = _c_1_T_7 @[ADDER.scala 31:15 36:14]
    node _c_2_T_6 = and(c_1, _c_2_T_5) @[ADDER.scala 36:45]
    node _c_2_T_7 = or(_c_2_T_2, _c_2_T_6) @[ADDER.scala 36:37]
    node _c_3_T = bits(io_a, 2, 2) @[ADDER.scala 36:22]
    node _c_3_T_1 = bits(io_b, 2, 2) @[ADDER.scala 36:32]
    node _c_3_T_2 = and(_c_3_T, _c_3_T_1) @[ADDER.scala 36:26]
    node _c_3_T_3 = bits(io_a, 2, 2) @[ADDER.scala 36:52]
    node _c_3_T_4 = bits(io_b, 2, 2) @[ADDER.scala 36:62]
    node _c_3_T_5 = xor(_c_3_T_3, _c_3_T_4) @[ADDER.scala 36:56]
    node c_2 = _c_2_T_7 @[ADDER.scala 31:15 36:14]
    node _c_3_T_6 = and(c_2, _c_3_T_5) @[ADDER.scala 36:45]
    node _c_3_T_7 = or(_c_3_T_2, _c_3_T_6) @[ADDER.scala 36:37]
    node _c_4_T = bits(io_a, 3, 3) @[ADDER.scala 36:22]
    node _c_4_T_1 = bits(io_b, 3, 3) @[ADDER.scala 36:32]
    node _c_4_T_2 = and(_c_4_T, _c_4_T_1) @[ADDER.scala 36:26]
    node _c_4_T_3 = bits(io_a, 3, 3) @[ADDER.scala 36:52]
    node _c_4_T_4 = bits(io_b, 3, 3) @[ADDER.scala 36:62]
    node _c_4_T_5 = xor(_c_4_T_3, _c_4_T_4) @[ADDER.scala 36:56]
    node c_3 = _c_3_T_7 @[ADDER.scala 31:15 36:14]
    node _c_4_T_6 = and(c_3, _c_4_T_5) @[ADDER.scala 36:45]
    node _c_4_T_7 = or(_c_4_T_2, _c_4_T_6) @[ADDER.scala 36:37]
    node _io_s_T = xor(io_a, io_b) @[ADDER.scala 40:16]
    node io_s_lo = cat(c_1, c_0) @[Cat.scala 33:92]
    node c_4 = _c_4_T_7 @[ADDER.scala 31:15 36:14]
    node io_s_hi_hi = cat(c_4, c_3) @[Cat.scala 33:92]
    node io_s_hi = cat(io_s_hi_hi, c_2) @[Cat.scala 33:92]
    node _io_s_T_1 = cat(io_s_hi, io_s_lo) @[Cat.scala 33:92]
    node _io_s_T_2 = xor(_io_s_T, _io_s_T_1) @[ADDER.scala 40:23]
    io_s <= bits(_io_s_T_2, 3, 0) @[ADDER.scala 40:8]
    io_cout <= c_4 @[ADDER.scala 39:11]

  module CBA_4b :
    input clock : Clock
    input reset : UInt<1>
    input io_a : UInt<4>
    input io_b : UInt<4>
    input io_cin : UInt<1>
    output io_s : UInt<4>
    output io_cout : UInt<1>

    inst rca0 of RCA_4b @[ADDER.scala 123:20]
    node _sel_T = bits(io_a, 1, 1) @[ADDER.scala 133:16]
    node _sel_T_1 = bits(io_b, 1, 1) @[ADDER.scala 133:24]
    node _sel_T_2 = xor(_sel_T, _sel_T_1) @[ADDER.scala 133:19]
    node _sel_T_3 = bits(io_a, 2, 2) @[ADDER.scala 133:36]
    node _sel_T_4 = bits(io_b, 2, 2) @[ADDER.scala 133:44]
    node _sel_T_5 = xor(_sel_T_3, _sel_T_4) @[ADDER.scala 133:39]
    node _sel_T_6 = and(_sel_T_2, _sel_T_5) @[ADDER.scala 133:29]
    node _sel_T_7 = bits(io_a, 3, 3) @[ADDER.scala 133:56]
    node _sel_T_8 = bits(io_b, 3, 3) @[ADDER.scala 133:64]
    node _sel_T_9 = xor(_sel_T_7, _sel_T_8) @[ADDER.scala 133:59]
    node _sel_T_10 = and(_sel_T_6, _sel_T_9) @[ADDER.scala 133:49]
    node _sel_T_11 = bits(io_a, 0, 0) @[ADDER.scala 133:76]
    node _sel_T_12 = bits(io_b, 0, 0) @[ADDER.scala 133:84]
    node _sel_T_13 = xor(_sel_T_11, _sel_T_12) @[ADDER.scala 133:79]
    node _sel_T_14 = and(_sel_T_10, _sel_T_13) @[ADDER.scala 133:69]
    node sel = _sel_T_14 @[ADDER.scala 132:17 133:7]
    node _io_cout_T = mux(sel, io_cin, rca0.io_cout) @[ADDER.scala 134:17]
    io_s <= rca0.io_s @[ADDER.scala 129:8]
    io_cout <= _io_cout_T @[ADDER.scala 134:11]
    rca0.clock <= clock
    rca0.reset <= reset
    rca0.io_a <= io_a @[ADDER.scala 126:13]
    rca0.io_b <= io_b @[ADDER.scala 127:13]
    rca0.io_cin <= io_cin @[ADDER.scala 128:15]
