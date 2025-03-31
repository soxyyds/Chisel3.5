circuit Adder_Nb :
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

    inst cla_0 of CLA_4b @[ADDER.scala 146:31]
    inst cla_1 of CLA_4b @[ADDER.scala 146:31]
    inst cla_2 of CLA_4b @[ADDER.scala 146:31]
    inst cla_3 of CLA_4b @[ADDER.scala 146:31]
    node _cla_0_io_a_T = bits(io_a, 3, 0) @[ADDER.scala 153:24]
    node _cla_0_io_b_T = bits(io_b, 3, 0) @[ADDER.scala 154:24]
    node _cla_1_io_a_T = bits(io_a, 7, 4) @[ADDER.scala 153:24]
    node _cla_1_io_b_T = bits(io_b, 7, 4) @[ADDER.scala 154:24]
    node _cla_2_io_a_T = bits(io_a, 11, 8) @[ADDER.scala 153:24]
    node _cla_2_io_b_T = bits(io_b, 11, 8) @[ADDER.scala 154:24]
    node _cla_3_io_a_T = bits(io_a, 15, 12) @[ADDER.scala 153:24]
    node _cla_3_io_b_T = bits(io_b, 15, 12) @[ADDER.scala 154:24]
    node _c_1_T = and(io_cin, cla_0.io_cp4) @[ADDER.scala 160:35]
    node _c_1_T_1 = or(cla_0.io_cg4, _c_1_T) @[ADDER.scala 160:25]
    node _c_2_T = and(cla_1.io_cp4, cla_0.io_cg4) @[ADDER.scala 161:42]
    node _c_2_T_1 = or(cla_1.io_cg4, _c_2_T) @[ADDER.scala 161:25]
    node _c_2_T_2 = and(cla_1.io_cp4, cla_0.io_cp4) @[ADDER.scala 161:77]
    node _c_2_T_3 = and(_c_2_T_2, io_cin) @[ADDER.scala 161:93]
    node _c_2_T_4 = or(_c_2_T_1, _c_2_T_3) @[ADDER.scala 161:60]
    node _c_3_T = and(cla_2.io_cp4, cla_1.io_cg4) @[ADDER.scala 162:42]
    node _c_3_T_1 = or(cla_2.io_cg4, _c_3_T) @[ADDER.scala 162:25]
    node _c_3_T_2 = and(cla_2.io_cp4, cla_1.io_cp4) @[ADDER.scala 162:76]
    node _c_3_T_3 = and(_c_3_T_2, cla_0.io_cg4) @[ADDER.scala 162:92]
    node _c_3_T_4 = or(_c_3_T_1, _c_3_T_3) @[ADDER.scala 162:59]
    node _c_3_T_5 = and(cla_2.io_cp4, cla_1.io_cp4) @[ADDER.scala 162:126]
    node _c_3_T_6 = and(_c_3_T_5, cla_0.io_cp4) @[ADDER.scala 162:142]
    node _c_3_T_7 = and(_c_3_T_6, io_cin) @[ADDER.scala 162:158]
    node _c_3_T_8 = or(_c_3_T_4, _c_3_T_7) @[ADDER.scala 162:109]
    node _c_4_T = and(cla_3.io_cp4, cla_2.io_cg4) @[ADDER.scala 163:43]
    node _c_4_T_1 = or(cla_3.io_cg4, _c_4_T) @[ADDER.scala 163:26]
    node _c_4_T_2 = and(cla_3.io_cp4, cla_2.io_cp4) @[ADDER.scala 163:77]
    node _c_4_T_3 = and(_c_4_T_2, cla_1.io_cg4) @[ADDER.scala 163:93]
    node _c_4_T_4 = or(_c_4_T_1, _c_4_T_3) @[ADDER.scala 163:60]
    node _c_4_T_5 = and(cla_3.io_cp4, cla_2.io_cp4) @[ADDER.scala 163:127]
    node _c_4_T_6 = and(_c_4_T_5, cla_1.io_cp4) @[ADDER.scala 163:143]
    node _c_4_T_7 = and(_c_4_T_6, cla_0.io_cg4) @[ADDER.scala 163:159]
    node _c_4_T_8 = or(_c_4_T_4, _c_4_T_7) @[ADDER.scala 163:110]
    node _c_4_T_9 = and(cla_3.io_cp4, cla_2.io_cp4) @[ADDER.scala 163:194]
    node _c_4_T_10 = and(_c_4_T_9, cla_1.io_cp4) @[ADDER.scala 163:210]
    node _c_4_T_11 = and(_c_4_T_10, cla_0.io_cp4) @[ADDER.scala 163:226]
    node _c_4_T_12 = and(_c_4_T_11, io_cin) @[ADDER.scala 163:242]
    node _c_4_T_13 = or(_c_4_T_8, _c_4_T_12) @[ADDER.scala 163:177]
    node io_s_lo = cat(cla_1.io_s, cla_0.io_s) @[Cat.scala 33:92]
    node io_s_hi = cat(cla_3.io_s, cla_2.io_s) @[Cat.scala 33:92]
    node _io_s_T = cat(io_s_hi, io_s_lo) @[Cat.scala 33:92]
    node c_0 = io_cin @[ADDER.scala 148:15 149:8]
    node c_1 = _c_1_T_1 @[ADDER.scala 148:15 160:8]
    node c_2 = _c_2_T_4 @[ADDER.scala 148:15 161:8]
    node c_3 = _c_3_T_8 @[ADDER.scala 148:15 162:8]
    node c_4 = _c_4_T_13 @[ADDER.scala 148:15 163:8]
    io_s <= _io_s_T @[ADDER.scala 164:8]
    io_cout <= c_4 @[ADDER.scala 165:11]
    cla_0.clock <= clock
    cla_0.reset <= reset
    cla_0.io_a <= _cla_0_io_a_T @[ADDER.scala 153:17]
    cla_0.io_b <= _cla_0_io_b_T @[ADDER.scala 154:17]
    cla_0.io_c_i <= c_0 @[ADDER.scala 155:19]
    cla_1.clock <= clock
    cla_1.reset <= reset
    cla_1.io_a <= _cla_1_io_a_T @[ADDER.scala 153:17]
    cla_1.io_b <= _cla_1_io_b_T @[ADDER.scala 154:17]
    cla_1.io_c_i <= c_1 @[ADDER.scala 155:19]
    cla_2.clock <= clock
    cla_2.reset <= reset
    cla_2.io_a <= _cla_2_io_a_T @[ADDER.scala 153:17]
    cla_2.io_b <= _cla_2_io_b_T @[ADDER.scala 154:17]
    cla_2.io_c_i <= c_2 @[ADDER.scala 155:19]
    cla_3.clock <= clock
    cla_3.reset <= reset
    cla_3.io_a <= _cla_3_io_a_T @[ADDER.scala 153:17]
    cla_3.io_b <= _cla_3_io_b_T @[ADDER.scala 154:17]
    cla_3.io_c_i <= c_3 @[ADDER.scala 155:19]

  module Adder_Nb :
    input clock : Clock
    input reset : UInt<1>
    input io_a : UInt<64>
    input io_b : UInt<64>
    output io_s : UInt<64>
    input io_cin : UInt<1>
    output io_cout : UInt<1>

    inst claStages_0 of CLA_16b @[ADDER_Nb.scala 18:42]
    inst claStages_1 of CLA_16b @[ADDER_Nb.scala 18:42]
    inst claStages_2 of CLA_16b @[ADDER_Nb.scala 18:42]
    inst claStages_3 of CLA_16b @[ADDER_Nb.scala 18:42]
    reg carryRegs_0 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), carryRegs_0) @[ADDER_Nb.scala 19:26]
    reg carryRegs_1 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), carryRegs_1) @[ADDER_Nb.scala 19:26]
    reg carryRegs_2 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), carryRegs_2) @[ADDER_Nb.scala 19:26]
    reg carryRegs_3 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), carryRegs_3) @[ADDER_Nb.scala 19:26]
    reg carryRegs_4 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), carryRegs_4) @[ADDER_Nb.scala 19:26]
    reg sumRegs_0 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), sumRegs_0) @[ADDER_Nb.scala 20:20]
    reg sumRegs_1 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), sumRegs_1) @[ADDER_Nb.scala 20:20]
    reg sumRegs_2 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), sumRegs_2) @[ADDER_Nb.scala 20:20]
    reg sumRegs_3 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), sumRegs_3) @[ADDER_Nb.scala 20:20]
    node _claStages_0_io_a_T = bits(io_a, 15, 0) @[ADDER_Nb.scala 25:30]
    node _claStages_0_io_b_T = bits(io_b, 15, 0) @[ADDER_Nb.scala 26:30]
    reg sumRegs_0_REG : UInt<16>, clock with :
      reset => (UInt<1>("h0"), sumRegs_0_REG) @[ADDER_Nb.scala 29:26]
    reg carryRegs_1_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), carryRegs_1_REG) @[ADDER_Nb.scala 30:32]
    node _claStages_1_io_a_T = bits(io_a, 31, 16) @[ADDER_Nb.scala 25:30]
    node _claStages_1_io_b_T = bits(io_b, 31, 16) @[ADDER_Nb.scala 26:30]
    reg sumRegs_1_REG : UInt<16>, clock with :
      reset => (UInt<1>("h0"), sumRegs_1_REG) @[ADDER_Nb.scala 29:26]
    reg carryRegs_2_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), carryRegs_2_REG) @[ADDER_Nb.scala 30:32]
    node _claStages_2_io_a_T = bits(io_a, 47, 32) @[ADDER_Nb.scala 25:30]
    node _claStages_2_io_b_T = bits(io_b, 47, 32) @[ADDER_Nb.scala 26:30]
    reg sumRegs_2_REG : UInt<16>, clock with :
      reset => (UInt<1>("h0"), sumRegs_2_REG) @[ADDER_Nb.scala 29:26]
    reg carryRegs_3_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), carryRegs_3_REG) @[ADDER_Nb.scala 30:32]
    node _claStages_3_io_a_T = bits(io_a, 63, 48) @[ADDER_Nb.scala 25:30]
    node _claStages_3_io_b_T = bits(io_b, 63, 48) @[ADDER_Nb.scala 26:30]
    reg sumRegs_3_REG : UInt<16>, clock with :
      reset => (UInt<1>("h0"), sumRegs_3_REG) @[ADDER_Nb.scala 29:26]
    reg carryRegs_4_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), carryRegs_4_REG) @[ADDER_Nb.scala 30:32]
    node _io_s_T = cat(sumRegs_3, sumRegs_2) @[Cat.scala 33:92]
    node _io_s_T_1 = cat(_io_s_T, sumRegs_1) @[Cat.scala 33:92]
    node _io_s_T_2 = cat(_io_s_T_1, sumRegs_0) @[Cat.scala 33:92]
    node _carryRegs_WIRE_0 = UInt<1>("h0") @[ADDER_Nb.scala 19:{34,34}]
    node _carryRegs_WIRE_1 = UInt<1>("h0") @[ADDER_Nb.scala 19:{34,34}]
    node _carryRegs_WIRE_2 = UInt<1>("h0") @[ADDER_Nb.scala 19:{34,34}]
    node _carryRegs_WIRE_3 = UInt<1>("h0") @[ADDER_Nb.scala 19:{34,34}]
    node _carryRegs_WIRE_4 = UInt<1>("h0") @[ADDER_Nb.scala 19:{34,34}]
    io_s <= _io_s_T_2 @[ADDER_Nb.scala 33:8]
    io_cout <= carryRegs_4 @[ADDER_Nb.scala 34:11]
    claStages_0.clock <= clock
    claStages_0.reset <= reset
    claStages_0.io_a <= _claStages_0_io_a_T @[ADDER_Nb.scala 25:23]
    claStages_0.io_b <= _claStages_0_io_b_T @[ADDER_Nb.scala 26:23]
    claStages_0.io_cin <= carryRegs_0 @[ADDER_Nb.scala 27:25]
    claStages_1.clock <= clock
    claStages_1.reset <= reset
    claStages_1.io_a <= _claStages_1_io_a_T @[ADDER_Nb.scala 25:23]
    claStages_1.io_b <= _claStages_1_io_b_T @[ADDER_Nb.scala 26:23]
    claStages_1.io_cin <= carryRegs_1 @[ADDER_Nb.scala 27:25]
    claStages_2.clock <= clock
    claStages_2.reset <= reset
    claStages_2.io_a <= _claStages_2_io_a_T @[ADDER_Nb.scala 25:23]
    claStages_2.io_b <= _claStages_2_io_b_T @[ADDER_Nb.scala 26:23]
    claStages_2.io_cin <= carryRegs_2 @[ADDER_Nb.scala 27:25]
    claStages_3.clock <= clock
    claStages_3.reset <= reset
    claStages_3.io_a <= _claStages_3_io_a_T @[ADDER_Nb.scala 25:23]
    claStages_3.io_b <= _claStages_3_io_b_T @[ADDER_Nb.scala 26:23]
    claStages_3.io_cin <= carryRegs_3 @[ADDER_Nb.scala 27:25]
    carryRegs_0 <= mux(reset, _carryRegs_WIRE_0, io_cin) @[ADDER_Nb.scala 19:{26,26} 22:16]
    carryRegs_1 <= mux(reset, _carryRegs_WIRE_1, carryRegs_1_REG) @[ADDER_Nb.scala 19:{26,26} 30:22]
    carryRegs_2 <= mux(reset, _carryRegs_WIRE_2, carryRegs_2_REG) @[ADDER_Nb.scala 19:{26,26} 30:22]
    carryRegs_3 <= mux(reset, _carryRegs_WIRE_3, carryRegs_3_REG) @[ADDER_Nb.scala 19:{26,26} 30:22]
    carryRegs_4 <= mux(reset, _carryRegs_WIRE_4, carryRegs_4_REG) @[ADDER_Nb.scala 19:{26,26} 30:22]
    sumRegs_0 <= sumRegs_0_REG @[ADDER_Nb.scala 29:16]
    sumRegs_1 <= sumRegs_1_REG @[ADDER_Nb.scala 29:16]
    sumRegs_2 <= sumRegs_2_REG @[ADDER_Nb.scala 29:16]
    sumRegs_3 <= sumRegs_3_REG @[ADDER_Nb.scala 29:16]
    sumRegs_0_REG <= claStages_0.io_s @[ADDER_Nb.scala 29:26]
    carryRegs_1_REG <= claStages_0.io_cout @[ADDER_Nb.scala 30:32]
    sumRegs_1_REG <= claStages_1.io_s @[ADDER_Nb.scala 29:26]
    carryRegs_2_REG <= claStages_1.io_cout @[ADDER_Nb.scala 30:32]
    sumRegs_2_REG <= claStages_2.io_s @[ADDER_Nb.scala 29:26]
    carryRegs_3_REG <= claStages_2.io_cout @[ADDER_Nb.scala 30:32]
    sumRegs_3_REG <= claStages_3.io_s @[ADDER_Nb.scala 29:26]
    carryRegs_4_REG <= claStages_3.io_cout @[ADDER_Nb.scala 30:32]
