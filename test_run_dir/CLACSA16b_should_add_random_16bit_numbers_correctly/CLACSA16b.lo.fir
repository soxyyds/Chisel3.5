circuit CLACSA16b :
  module CLA_4b :
    input clock : Clock
    input reset : UInt<1>
    input io_a : UInt<4>
    input io_b : UInt<4>
    input io_c_i : UInt<1>
    output io_cp4 : UInt<1>
    output io_cg4 : UInt<1>
    output io_s : UInt<4>

    node _cp_T = or(io_a, io_b) @[ADDER.scala 63:14]
    node _cg_T = and(io_a, io_b) @[ADDER.scala 64:14]
    node cg = _cg_T @[ADDER.scala 60:16 64:6]
    node _c_1_T = bits(cg, 0, 0) @[ADDER.scala 70:13]
    node cp = _cp_T @[ADDER.scala 59:16 63:6]
    node _c_1_T_1 = bits(cp, 0, 0) @[ADDER.scala 70:31]
    node _c_1_T_2 = and(io_c_i, _c_1_T_1) @[ADDER.scala 70:27]
    node _c_1_T_3 = or(_c_1_T, _c_1_T_2) @[ADDER.scala 70:17]
    node _c_2_T = bits(cg, 1, 1) @[ADDER.scala 71:13]
    node _c_2_T_1 = bits(cp, 1, 1) @[ADDER.scala 71:22]
    node _c_2_T_2 = bits(cg, 0, 0) @[ADDER.scala 71:30]
    node _c_2_T_3 = and(_c_2_T_1, _c_2_T_2) @[ADDER.scala 71:26]
    node _c_2_T_4 = or(_c_2_T, _c_2_T_3) @[ADDER.scala 71:17]
    node _c_2_T_5 = bits(cp, 1, 1) @[ADDER.scala 71:40]
    node _c_2_T_6 = bits(cp, 0, 0) @[ADDER.scala 71:48]
    node _c_2_T_7 = and(_c_2_T_5, _c_2_T_6) @[ADDER.scala 71:44]
    node _c_2_T_8 = and(_c_2_T_7, io_c_i) @[ADDER.scala 71:52]
    node _c_2_T_9 = or(_c_2_T_4, _c_2_T_8) @[ADDER.scala 71:35]
    node _c_3_T = bits(cg, 2, 2) @[ADDER.scala 72:13]
    node _c_3_T_1 = bits(cp, 2, 2) @[ADDER.scala 72:22]
    node _c_3_T_2 = bits(cg, 1, 1) @[ADDER.scala 72:30]
    node _c_3_T_3 = and(_c_3_T_1, _c_3_T_2) @[ADDER.scala 72:26]
    node _c_3_T_4 = or(_c_3_T, _c_3_T_3) @[ADDER.scala 72:17]
    node _c_3_T_5 = bits(cp, 2, 2) @[ADDER.scala 72:40]
    node _c_3_T_6 = bits(cp, 1, 1) @[ADDER.scala 72:48]
    node _c_3_T_7 = and(_c_3_T_5, _c_3_T_6) @[ADDER.scala 72:44]
    node _c_3_T_8 = bits(cg, 0, 0) @[ADDER.scala 72:56]
    node _c_3_T_9 = and(_c_3_T_7, _c_3_T_8) @[ADDER.scala 72:52]
    node _c_3_T_10 = or(_c_3_T_4, _c_3_T_9) @[ADDER.scala 72:35]
    node _c_3_T_11 = bits(cp, 2, 2) @[ADDER.scala 72:66]
    node _c_3_T_12 = bits(cp, 1, 1) @[ADDER.scala 72:74]
    node _c_3_T_13 = and(_c_3_T_11, _c_3_T_12) @[ADDER.scala 72:70]
    node _c_3_T_14 = bits(cp, 0, 0) @[ADDER.scala 72:82]
    node _c_3_T_15 = and(_c_3_T_13, _c_3_T_14) @[ADDER.scala 72:78]
    node _c_3_T_16 = and(_c_3_T_15, io_c_i) @[ADDER.scala 72:86]
    node _c_3_T_17 = or(_c_3_T_10, _c_3_T_16) @[ADDER.scala 72:61]
    node _io_s_T = xor(io_a, io_b) @[ADDER.scala 75:16]
    node c_1 = _c_1_T_3 @[ADDER.scala 66:15 70:8]
    node c_0 = io_c_i @[ADDER.scala 66:15 69:8]
    node io_s_lo = cat(c_1, c_0) @[Cat.scala 33:92]
    node c_3 = _c_3_T_17 @[ADDER.scala 66:15 72:8]
    node c_2 = _c_2_T_9 @[ADDER.scala 66:15 71:8]
    node io_s_hi = cat(c_3, c_2) @[Cat.scala 33:92]
    node _io_s_T_1 = cat(io_s_hi, io_s_lo) @[Cat.scala 33:92]
    node _io_s_T_2 = xor(_io_s_T, _io_s_T_1) @[ADDER.scala 75:23]
    node _io_cp4_T = bits(cp, 3, 3) @[ADDER.scala 78:16]
    node _io_cp4_T_1 = bits(cp, 2, 2) @[ADDER.scala 78:24]
    node _io_cp4_T_2 = and(_io_cp4_T, _io_cp4_T_1) @[ADDER.scala 78:20]
    node _io_cp4_T_3 = bits(cp, 1, 1) @[ADDER.scala 78:32]
    node _io_cp4_T_4 = and(_io_cp4_T_2, _io_cp4_T_3) @[ADDER.scala 78:28]
    node _io_cp4_T_5 = bits(cp, 0, 0) @[ADDER.scala 78:40]
    node _io_cp4_T_6 = and(_io_cp4_T_4, _io_cp4_T_5) @[ADDER.scala 78:36]
    node _io_cg4_T = bits(cg, 3, 3) @[ADDER.scala 79:16]
    node _io_cg4_T_1 = bits(cp, 3, 3) @[ADDER.scala 79:25]
    node _io_cg4_T_2 = bits(cg, 2, 2) @[ADDER.scala 79:33]
    node _io_cg4_T_3 = and(_io_cg4_T_1, _io_cg4_T_2) @[ADDER.scala 79:29]
    node _io_cg4_T_4 = or(_io_cg4_T, _io_cg4_T_3) @[ADDER.scala 79:20]
    node _io_cg4_T_5 = bits(cp, 3, 3) @[ADDER.scala 79:43]
    node _io_cg4_T_6 = bits(cp, 2, 2) @[ADDER.scala 79:51]
    node _io_cg4_T_7 = and(_io_cg4_T_5, _io_cg4_T_6) @[ADDER.scala 79:47]
    node _io_cg4_T_8 = bits(cg, 1, 1) @[ADDER.scala 79:59]
    node _io_cg4_T_9 = and(_io_cg4_T_7, _io_cg4_T_8) @[ADDER.scala 79:55]
    node _io_cg4_T_10 = or(_io_cg4_T_4, _io_cg4_T_9) @[ADDER.scala 79:38]
    node _io_cg4_T_11 = bits(cp, 3, 3) @[ADDER.scala 79:69]
    node _io_cg4_T_12 = bits(cp, 2, 2) @[ADDER.scala 79:77]
    node _io_cg4_T_13 = and(_io_cg4_T_11, _io_cg4_T_12) @[ADDER.scala 79:73]
    node _io_cg4_T_14 = bits(cp, 1, 1) @[ADDER.scala 79:85]
    node _io_cg4_T_15 = and(_io_cg4_T_13, _io_cg4_T_14) @[ADDER.scala 79:81]
    node _io_cg4_T_16 = bits(cg, 0, 0) @[ADDER.scala 79:93]
    node _io_cg4_T_17 = and(_io_cg4_T_15, _io_cg4_T_16) @[ADDER.scala 79:89]
    node _io_cg4_T_18 = or(_io_cg4_T_10, _io_cg4_T_17) @[ADDER.scala 79:64]
    io_cp4 <= _io_cp4_T_6 @[ADDER.scala 78:10]
    io_cg4 <= _io_cg4_T_18 @[ADDER.scala 79:10]
    io_s <= _io_s_T_2 @[ADDER.scala 75:8]

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

  module CLACSA16b :
    input clock : Clock
    input reset : UInt<1>
    input io_a : UInt<16>
    input io_b : UInt<16>
    input io_cin : UInt<1>
    output io_s : UInt<16>
    output io_cout : UInt<1>

    inst cla0 of CLA_4b @[CLACSA16b.scala 16:20]
    inst cba1 of CBA_4b @[CLACSA16b.scala 23:20]
    inst cba2 of CBA_4b @[CLACSA16b.scala 30:20]
    inst cla3 of CLA_4b @[CLACSA16b.scala 37:20]
    node _cla0_io_a_T = bits(io_a, 3, 0) @[CLACSA16b.scala 17:20]
    node _cla0_io_b_T = bits(io_b, 3, 0) @[CLACSA16b.scala 18:20]
    node _carryOut0_T = and(cla0.io_cp4, io_cin) @[CLACSA16b.scala 20:46]
    node carryOut0 = or(cla0.io_cg4, _carryOut0_T) @[CLACSA16b.scala 20:31]
    node _cba1_io_a_T = bits(io_a, 7, 4) @[CLACSA16b.scala 24:20]
    node _cba1_io_b_T = bits(io_b, 7, 4) @[CLACSA16b.scala 25:20]
    node _cba2_io_a_T = bits(io_a, 11, 8) @[CLACSA16b.scala 31:20]
    node _cba2_io_b_T = bits(io_b, 11, 8) @[CLACSA16b.scala 32:20]
    node _cla3_io_a_T = bits(io_a, 15, 12) @[CLACSA16b.scala 38:20]
    node _cla3_io_b_T = bits(io_b, 15, 12) @[CLACSA16b.scala 39:20]
    node _carryOut3_T = and(cla3.io_cp4, cba2.io_cout) @[CLACSA16b.scala 41:46]
    node carryOut3 = or(cla3.io_cg4, _carryOut3_T) @[CLACSA16b.scala 41:31]
    node io_s_lo = cat(cba1.io_s, cla0.io_s) @[Cat.scala 33:92]
    node io_s_hi = cat(cla3.io_s, cba2.io_s) @[Cat.scala 33:92]
    node _io_s_T = cat(io_s_hi, io_s_lo) @[Cat.scala 33:92]
    io_s <= _io_s_T @[CLACSA16b.scala 44:8]
    io_cout <= carryOut3 @[CLACSA16b.scala 45:11]
    cla0.clock <= clock
    cla0.reset <= reset
    cla0.io_a <= _cla0_io_a_T @[CLACSA16b.scala 17:13]
    cla0.io_b <= _cla0_io_b_T @[CLACSA16b.scala 18:13]
    cla0.io_c_i <= io_cin @[CLACSA16b.scala 19:15]
    cba1.clock <= clock
    cba1.reset <= reset
    cba1.io_a <= _cba1_io_a_T @[CLACSA16b.scala 24:13]
    cba1.io_b <= _cba1_io_b_T @[CLACSA16b.scala 25:13]
    cba1.io_cin <= carryOut0 @[CLACSA16b.scala 26:15]
    cba2.clock <= clock
    cba2.reset <= reset
    cba2.io_a <= _cba2_io_a_T @[CLACSA16b.scala 31:13]
    cba2.io_b <= _cba2_io_b_T @[CLACSA16b.scala 32:13]
    cba2.io_cin <= cba1.io_cout @[CLACSA16b.scala 33:15]
    cla3.clock <= clock
    cla3.reset <= reset
    cla3.io_a <= _cla3_io_a_T @[CLACSA16b.scala 38:13]
    cla3.io_b <= _cla3_io_b_T @[CLACSA16b.scala 39:13]
    cla3.io_c_i <= cba2.io_cout @[CLACSA16b.scala 40:15]
