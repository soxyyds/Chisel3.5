circuit PipeLineAdder32b :
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

  module CLA_16b :
    input clock : Clock
    input reset : UInt<1>
    input io_a : UInt<16>
    input io_b : UInt<16>
    input io_cin : UInt<1>
    output io_s : UInt<16>
    output io_cout : UInt<1>

    inst cla_0 of CLA_4b @[ADDER.scala 147:31]
    inst cla_1 of CLA_4b @[ADDER.scala 147:31]
    inst cla_2 of CLA_4b @[ADDER.scala 147:31]
    inst cla_3 of CLA_4b @[ADDER.scala 147:31]
    node _cla_0_io_a_T = bits(io_a, 3, 0) @[ADDER.scala 154:24]
    node _cla_0_io_b_T = bits(io_b, 3, 0) @[ADDER.scala 155:24]
    node _cla_1_io_a_T = bits(io_a, 7, 4) @[ADDER.scala 154:24]
    node _cla_1_io_b_T = bits(io_b, 7, 4) @[ADDER.scala 155:24]
    node _cla_2_io_a_T = bits(io_a, 11, 8) @[ADDER.scala 154:24]
    node _cla_2_io_b_T = bits(io_b, 11, 8) @[ADDER.scala 155:24]
    node _cla_3_io_a_T = bits(io_a, 15, 12) @[ADDER.scala 154:24]
    node _cla_3_io_b_T = bits(io_b, 15, 12) @[ADDER.scala 155:24]
    node _c_1_T = and(io_cin, cla_0.io_cp4) @[ADDER.scala 161:35]
    node _c_1_T_1 = or(cla_0.io_cg4, _c_1_T) @[ADDER.scala 161:25]
    node _c_2_T = and(cla_1.io_cp4, cla_0.io_cg4) @[ADDER.scala 162:42]
    node _c_2_T_1 = or(cla_1.io_cg4, _c_2_T) @[ADDER.scala 162:25]
    node _c_2_T_2 = and(cla_1.io_cp4, cla_0.io_cp4) @[ADDER.scala 162:77]
    node _c_2_T_3 = and(_c_2_T_2, io_cin) @[ADDER.scala 162:93]
    node _c_2_T_4 = or(_c_2_T_1, _c_2_T_3) @[ADDER.scala 162:60]
    node _c_3_T = and(cla_2.io_cp4, cla_1.io_cg4) @[ADDER.scala 163:42]
    node _c_3_T_1 = or(cla_2.io_cg4, _c_3_T) @[ADDER.scala 163:25]
    node _c_3_T_2 = and(cla_2.io_cp4, cla_1.io_cp4) @[ADDER.scala 163:76]
    node _c_3_T_3 = and(_c_3_T_2, cla_0.io_cg4) @[ADDER.scala 163:92]
    node _c_3_T_4 = or(_c_3_T_1, _c_3_T_3) @[ADDER.scala 163:59]
    node _c_3_T_5 = and(cla_2.io_cp4, cla_1.io_cp4) @[ADDER.scala 163:126]
    node _c_3_T_6 = and(_c_3_T_5, cla_0.io_cp4) @[ADDER.scala 163:142]
    node _c_3_T_7 = and(_c_3_T_6, io_cin) @[ADDER.scala 163:158]
    node _c_3_T_8 = or(_c_3_T_4, _c_3_T_7) @[ADDER.scala 163:109]
    node _c_4_T = and(cla_3.io_cp4, cla_2.io_cg4) @[ADDER.scala 164:43]
    node _c_4_T_1 = or(cla_3.io_cg4, _c_4_T) @[ADDER.scala 164:26]
    node _c_4_T_2 = and(cla_3.io_cp4, cla_2.io_cp4) @[ADDER.scala 164:77]
    node _c_4_T_3 = and(_c_4_T_2, cla_1.io_cg4) @[ADDER.scala 164:93]
    node _c_4_T_4 = or(_c_4_T_1, _c_4_T_3) @[ADDER.scala 164:60]
    node _c_4_T_5 = and(cla_3.io_cp4, cla_2.io_cp4) @[ADDER.scala 164:127]
    node _c_4_T_6 = and(_c_4_T_5, cla_1.io_cp4) @[ADDER.scala 164:143]
    node _c_4_T_7 = and(_c_4_T_6, cla_0.io_cg4) @[ADDER.scala 164:159]
    node _c_4_T_8 = or(_c_4_T_4, _c_4_T_7) @[ADDER.scala 164:110]
    node _c_4_T_9 = and(cla_3.io_cp4, cla_2.io_cp4) @[ADDER.scala 164:194]
    node _c_4_T_10 = and(_c_4_T_9, cla_1.io_cp4) @[ADDER.scala 164:210]
    node _c_4_T_11 = and(_c_4_T_10, cla_0.io_cp4) @[ADDER.scala 164:226]
    node _c_4_T_12 = and(_c_4_T_11, io_cin) @[ADDER.scala 164:242]
    node _c_4_T_13 = or(_c_4_T_8, _c_4_T_12) @[ADDER.scala 164:177]
    node io_s_lo = cat(cla_1.io_s, cla_0.io_s) @[Cat.scala 33:92]
    node io_s_hi = cat(cla_3.io_s, cla_2.io_s) @[Cat.scala 33:92]
    node _io_s_T = cat(io_s_hi, io_s_lo) @[Cat.scala 33:92]
    node c_0 = io_cin @[ADDER.scala 149:15 150:8]
    node c_1 = _c_1_T_1 @[ADDER.scala 149:15 161:8]
    node c_2 = _c_2_T_4 @[ADDER.scala 149:15 162:8]
    node c_3 = _c_3_T_8 @[ADDER.scala 149:15 163:8]
    node c_4 = _c_4_T_13 @[ADDER.scala 149:15 164:8]
    io_s <= _io_s_T @[ADDER.scala 165:8]
    io_cout <= c_4 @[ADDER.scala 166:11]
    cla_0.clock <= clock
    cla_0.reset <= reset
    cla_0.io_a <= _cla_0_io_a_T @[ADDER.scala 154:17]
    cla_0.io_b <= _cla_0_io_b_T @[ADDER.scala 155:17]
    cla_0.io_c_i <= c_0 @[ADDER.scala 156:19]
    cla_1.clock <= clock
    cla_1.reset <= reset
    cla_1.io_a <= _cla_1_io_a_T @[ADDER.scala 154:17]
    cla_1.io_b <= _cla_1_io_b_T @[ADDER.scala 155:17]
    cla_1.io_c_i <= c_1 @[ADDER.scala 156:19]
    cla_2.clock <= clock
    cla_2.reset <= reset
    cla_2.io_a <= _cla_2_io_a_T @[ADDER.scala 154:17]
    cla_2.io_b <= _cla_2_io_b_T @[ADDER.scala 155:17]
    cla_2.io_c_i <= c_2 @[ADDER.scala 156:19]
    cla_3.clock <= clock
    cla_3.reset <= reset
    cla_3.io_a <= _cla_3_io_a_T @[ADDER.scala 154:17]
    cla_3.io_b <= _cla_3_io_b_T @[ADDER.scala 155:17]
    cla_3.io_c_i <= c_3 @[ADDER.scala 156:19]

  module PipeLineAdder32b :
    input clock : Clock
    input reset : UInt<1>
    input io_a : UInt<32>
    input io_b : UInt<32>
    input io_cin : UInt<1>
    output io_s : UInt<32>
    output io_cout : UInt<1>

    inst cla0 of CLA_16b @[PipeLineAdder32b.scala 14:20]
    inst cla1 of CLA_16b @[PipeLineAdder32b.scala 15:20]
    node _regA0_T = bits(io_a, 31, 0) @[PipeLineAdder32b.scala 18:29]
    reg regA0 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regA0) @[PipeLineAdder32b.scala 18:24]
    node _regB0_T = bits(io_b, 31, 0) @[PipeLineAdder32b.scala 19:29]
    reg regB0 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regB0) @[PipeLineAdder32b.scala 19:24]
    reg regCin0 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), regCin0) @[PipeLineAdder32b.scala 20:24]
    node _cla0_io_a_T = bits(regA0, 15, 0) @[PipeLineAdder32b.scala 22:21]
    node _cla0_io_b_T = bits(regB0, 15, 0) @[PipeLineAdder32b.scala 23:21]
    reg regSum0 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), regSum0) @[PipeLineAdder32b.scala 27:24]
    reg regCout0 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), regCout0) @[PipeLineAdder32b.scala 28:25]
    reg regSum1 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), regSum1) @[PipeLineAdder32b.scala 29:24]
    reg regSum00 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), regSum00) @[PipeLineAdder32b.scala 30:25]
    node _regA1_T = bits(regA0, 31, 16) @[PipeLineAdder32b.scala 33:28]
    reg regA1 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), regA1) @[PipeLineAdder32b.scala 33:22]
    node _regB1_T = bits(regB0, 31, 16) @[PipeLineAdder32b.scala 34:28]
    reg regB1 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), regB1) @[PipeLineAdder32b.scala 34:22]
    reg regCout1 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), regCout1) @[PipeLineAdder32b.scala 40:25]
    node _io_s_T = cat(cla1.io_s, regSum0) @[Cat.scala 33:92]
    node _io_s_T_1 = cat(regSum1, regSum00) @[Cat.scala 33:92]
    io_s <= _io_s_T_1 @[PipeLineAdder32b.scala 46:8]
    io_cout <= regCout1 @[PipeLineAdder32b.scala 47:11]
    cla0.clock <= clock
    cla0.reset <= reset
    cla0.io_a <= _cla0_io_a_T @[PipeLineAdder32b.scala 22:13]
    cla0.io_b <= _cla0_io_b_T @[PipeLineAdder32b.scala 23:13]
    cla0.io_cin <= regCin0 @[PipeLineAdder32b.scala 24:15]
    cla1.clock <= clock
    cla1.reset <= reset
    cla1.io_a <= regA1 @[PipeLineAdder32b.scala 36:13]
    cla1.io_b <= regB1 @[PipeLineAdder32b.scala 37:13]
    cla1.io_cin <= regCout0 @[PipeLineAdder32b.scala 38:15]
    regA0 <= _regA0_T @[PipeLineAdder32b.scala 18:24]
    regB0 <= _regB0_T @[PipeLineAdder32b.scala 19:24]
    regCin0 <= io_cin @[PipeLineAdder32b.scala 20:24]
    regSum0 <= cla0.io_s @[PipeLineAdder32b.scala 27:24]
    regCout0 <= cla0.io_cout @[PipeLineAdder32b.scala 28:25]
    regSum1 <= cla1.io_s @[PipeLineAdder32b.scala 29:24]
    regSum00 <= regSum0 @[PipeLineAdder32b.scala 30:25]
    regA1 <= _regA1_T @[PipeLineAdder32b.scala 33:22]
    regB1 <= _regB1_T @[PipeLineAdder32b.scala 34:22]
    regCout1 <= cla1.io_cout @[PipeLineAdder32b.scala 40:25]
