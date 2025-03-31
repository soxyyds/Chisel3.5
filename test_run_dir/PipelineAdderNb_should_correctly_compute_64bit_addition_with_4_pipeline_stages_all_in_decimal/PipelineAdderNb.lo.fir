circuit PipelineAdderNb :
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

  module CLACSANb :
    input clock : Clock
    input reset : UInt<1>
    input io_a : UInt<16>
    input io_b : UInt<16>
    input io_cin : UInt<1>
    output io_s : UInt<16>
    output io_cout : UInt<1>

    inst claFirst of CLA_4b @[CLACSANb.scala 33:24]
    inst cba of CBA_4b @[CLACSANb.scala 42:21]
    inst cba_1 of CBA_4b @[CLACSANb.scala 42:21]
    inst claLast of CLA_4b @[CLACSANb.scala 52:23]
    node _claFirst_io_a_T = bits(io_a, 3, 0) @[CLACSANb.scala 34:27]
    node _claFirst_io_b_T = bits(io_b, 3, 0) @[CLACSANb.scala 35:27]
    node carries_0 = io_cin @[CLACSANb.scala 29:21 30:14]
    node _carries_1_T = and(claFirst.io_cp4, carries_0) @[CLACSANb.scala 38:57]
    node _carries_1_T_1 = or(claFirst.io_cg4, _carries_1_T) @[CLACSANb.scala 38:38]
    node _cba_io_a_T = bits(io_a, 7, 4) @[CLACSANb.scala 43:24]
    node _cba_io_b_T = bits(io_b, 7, 4) @[CLACSANb.scala 44:24]
    node _cba_io_a_T_1 = bits(io_a, 11, 8) @[CLACSANb.scala 43:24]
    node _cba_io_b_T_1 = bits(io_b, 11, 8) @[CLACSANb.scala 44:24]
    node _claLast_io_a_T = bits(io_a, 15, 12) @[CLACSANb.scala 53:26]
    node _claLast_io_b_T = bits(io_b, 15, 12) @[CLACSANb.scala 54:26]
    node carries_3 = cba_1.io_cout @[CLACSANb.scala 29:21 47:18]
    node _carries_4_T = and(claLast.io_cp4, carries_3) @[CLACSANb.scala 57:57]
    node _carries_4_T_1 = or(claLast.io_cg4, _carries_4_T) @[CLACSANb.scala 57:39]
    node sums_3 = claLast.io_s @[CLACSANb.scala 28:21 56:21]
    node sums_2 = cba_1.io_s @[CLACSANb.scala 28:21 46:16]
    node _fullSum_T = cat(sums_3, sums_2) @[Cat.scala 33:92]
    node sums_1 = cba.io_s @[CLACSANb.scala 28:21 46:16]
    node _fullSum_T_1 = cat(_fullSum_T, sums_1) @[Cat.scala 33:92]
    node sums_0 = claFirst.io_s @[CLACSANb.scala 28:21 37:19]
    node fullSum = cat(_fullSum_T_1, sums_0) @[Cat.scala 33:92]
    node _io_s_T = bits(fullSum, 15, 0) @[CLACSANb.scala 64:18]
    node carries_1 = _carries_1_T_1 @[CLACSANb.scala 29:21 38:19]
    node carries_2 = cba.io_cout @[CLACSANb.scala 29:21 47:18]
    node carries_4 = _carries_4_T_1 @[CLACSANb.scala 29:21 57:21]
    io_s <= _io_s_T @[CLACSANb.scala 64:8]
    io_cout <= carries_4 @[CLACSANb.scala 66:11]
    claFirst.clock <= clock
    claFirst.reset <= reset
    claFirst.io_a <= _claFirst_io_a_T @[CLACSANb.scala 34:19]
    claFirst.io_b <= _claFirst_io_b_T @[CLACSANb.scala 35:19]
    claFirst.io_c_i <= carries_0 @[CLACSANb.scala 36:19]
    cba.clock <= clock
    cba.reset <= reset
    cba.io_a <= _cba_io_a_T @[CLACSANb.scala 43:16]
    cba.io_b <= _cba_io_b_T @[CLACSANb.scala 44:16]
    cba.io_cin <= carries_1 @[CLACSANb.scala 45:16]
    cba_1.clock <= clock
    cba_1.reset <= reset
    cba_1.io_a <= _cba_io_a_T_1 @[CLACSANb.scala 43:16]
    cba_1.io_b <= _cba_io_b_T_1 @[CLACSANb.scala 44:16]
    cba_1.io_cin <= carries_2 @[CLACSANb.scala 45:16]
    claLast.clock <= clock
    claLast.reset <= reset
    claLast.io_a <= _claLast_io_a_T @[CLACSANb.scala 53:18]
    claLast.io_b <= _claLast_io_b_T @[CLACSANb.scala 54:18]
    claLast.io_c_i <= carries_3 @[CLACSANb.scala 55:18]

  module PipelineAdderNb :
    input clock : Clock
    input reset : UInt<1>
    input io_a : UInt<64>
    input io_b : UInt<64>
    input io_cin : UInt<1>
    output io_s : UInt<64>
    output io_cout : UInt<1>

    inst adder_0 of CLACSANb @[PipelineAdderNb.scala 38:37]
    inst adder_1 of CLACSANb @[PipelineAdderNb.scala 38:37]
    inst adder_2 of CLACSANb @[PipelineAdderNb.scala 38:37]
    inst adder_3 of CLACSANb @[PipelineAdderNb.scala 38:37]
    reg regA0 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), regA0) @[PipelineAdderNb.scala 19:22]
    reg regB0 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), regB0) @[PipelineAdderNb.scala 20:22]
    reg regCin0 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), regCin0) @[PipelineAdderNb.scala 21:24]
    reg regAmid_0 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), regAmid_0) @[PipelineAdderNb.scala 24:12]
    reg regAmid_1 : UInt<48>, clock with :
      reset => (UInt<1>("h0"), regAmid_1) @[PipelineAdderNb.scala 24:12]
    reg regAmid_2 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regAmid_2) @[PipelineAdderNb.scala 24:12]
    reg regAmid_3 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), regAmid_3) @[PipelineAdderNb.scala 24:12]
    reg regBmid_0 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), regBmid_0) @[PipelineAdderNb.scala 27:12]
    reg regBmid_1 : UInt<48>, clock with :
      reset => (UInt<1>("h0"), regBmid_1) @[PipelineAdderNb.scala 27:12]
    reg regBmid_2 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regBmid_2) @[PipelineAdderNb.scala 27:12]
    reg regBmid_3 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), regBmid_3) @[PipelineAdderNb.scala 27:12]
    reg regSummid_0 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), regSummid_0) @[PipelineAdderNb.scala 30:12]
    reg regSummid_1 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regSummid_1) @[PipelineAdderNb.scala 30:12]
    reg regSummid_2 : UInt<48>, clock with :
      reset => (UInt<1>("h0"), regSummid_2) @[PipelineAdderNb.scala 30:12]
    reg regSummid_3 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), regSummid_3) @[PipelineAdderNb.scala 30:12]
    reg regCoutmid_0 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), regCoutmid_0) @[PipelineAdderNb.scala 32:43]
    reg regCoutmid_1 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), regCoutmid_1) @[PipelineAdderNb.scala 32:43]
    reg regCoutmid_2 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), regCoutmid_2) @[PipelineAdderNb.scala 32:43]
    reg regCoutmid_3 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), regCoutmid_3) @[PipelineAdderNb.scala 32:43]
    node _adder_0_io_a_T = bits(regAmid_0, 15, 0) @[PipelineAdderNb.scala 42:32]
    node _adder_0_io_b_T = bits(regBmid_0, 15, 0) @[PipelineAdderNb.scala 43:32]
    node _regAmid_1_T = bits(regAmid_0, 63, 16) @[PipelineAdderNb.scala 52:35]
    node _regBmid_1_T = bits(regBmid_0, 63, 16) @[PipelineAdderNb.scala 53:35]
    node _adder_1_io_a_T = bits(regAmid_1, 15, 0) @[PipelineAdderNb.scala 42:32]
    node _adder_1_io_b_T = bits(regBmid_1, 15, 0) @[PipelineAdderNb.scala 43:32]
    node _regSummid_1_T = cat(adder_1.io_s, regSummid_0) @[Cat.scala 33:92]
    node _regAmid_2_T = bits(regAmid_1, 47, 16) @[PipelineAdderNb.scala 52:35]
    node _regBmid_2_T = bits(regBmid_1, 47, 16) @[PipelineAdderNb.scala 53:35]
    node _adder_2_io_a_T = bits(regAmid_2, 15, 0) @[PipelineAdderNb.scala 42:32]
    node _adder_2_io_b_T = bits(regBmid_2, 15, 0) @[PipelineAdderNb.scala 43:32]
    node _regSummid_2_T = cat(adder_2.io_s, regSummid_1) @[Cat.scala 33:92]
    node _regAmid_3_T = bits(regAmid_2, 31, 16) @[PipelineAdderNb.scala 52:35]
    node _regBmid_3_T = bits(regBmid_2, 31, 16) @[PipelineAdderNb.scala 53:35]
    node _adder_3_io_a_T = bits(regAmid_3, 15, 0) @[PipelineAdderNb.scala 42:32]
    node _adder_3_io_b_T = bits(regBmid_3, 15, 0) @[PipelineAdderNb.scala 43:32]
    node _regSummid_3_T = cat(adder_3.io_s, regSummid_2) @[Cat.scala 33:92]
    io_s <= regSummid_3 @[PipelineAdderNb.scala 57:10]
    io_cout <= regCoutmid_3 @[PipelineAdderNb.scala 58:13]
    regA0 <= mux(reset, UInt<64>("h0"), regA0) @[PipelineAdderNb.scala 19:{22,22,22}]
    regB0 <= mux(reset, UInt<64>("h0"), regB0) @[PipelineAdderNb.scala 20:{22,22,22}]
    regCin0 <= mux(reset, UInt<1>("h0"), io_cin) @[PipelineAdderNb.scala 21:{24,24} 36:11]
    regAmid_0 <= mux(reset, UInt<64>("h0"), io_a) @[PipelineAdderNb.scala 24:{12,12} 34:14]
    regAmid_1 <= mux(reset, UInt<48>("h0"), _regAmid_1_T) @[PipelineAdderNb.scala 24:{12,12} 52:22]
    regAmid_2 <= mux(reset, UInt<32>("h0"), _regAmid_2_T) @[PipelineAdderNb.scala 24:{12,12} 52:22]
    regAmid_3 <= mux(reset, UInt<16>("h0"), _regAmid_3_T) @[PipelineAdderNb.scala 24:{12,12} 52:22]
    regBmid_0 <= mux(reset, UInt<64>("h0"), io_b) @[PipelineAdderNb.scala 27:{12,12} 35:14]
    regBmid_1 <= mux(reset, UInt<48>("h0"), _regBmid_1_T) @[PipelineAdderNb.scala 27:{12,12} 53:22]
    regBmid_2 <= mux(reset, UInt<32>("h0"), _regBmid_2_T) @[PipelineAdderNb.scala 27:{12,12} 53:22]
    regBmid_3 <= mux(reset, UInt<16>("h0"), _regBmid_3_T) @[PipelineAdderNb.scala 27:{12,12} 53:22]
    regSummid_0 <= mux(reset, UInt<16>("h0"), adder_0.io_s) @[PipelineAdderNb.scala 30:{12,12} 46:20]
    regSummid_1 <= mux(reset, UInt<32>("h0"), _regSummid_1_T) @[PipelineAdderNb.scala 30:{12,12} 49:20]
    regSummid_2 <= mux(reset, UInt<48>("h0"), _regSummid_2_T) @[PipelineAdderNb.scala 30:{12,12} 49:20]
    regSummid_3 <= mux(reset, UInt<64>("h0"), _regSummid_3_T) @[PipelineAdderNb.scala 30:{12,12} 49:20]
    regCoutmid_0 <= mux(reset, UInt<1>("h0"), adder_0.io_cout) @[PipelineAdderNb.scala 32:{43,43} 55:19]
    regCoutmid_1 <= mux(reset, UInt<1>("h0"), adder_1.io_cout) @[PipelineAdderNb.scala 32:{43,43} 55:19]
    regCoutmid_2 <= mux(reset, UInt<1>("h0"), adder_2.io_cout) @[PipelineAdderNb.scala 32:{43,43} 55:19]
    regCoutmid_3 <= mux(reset, UInt<1>("h0"), adder_3.io_cout) @[PipelineAdderNb.scala 32:{43,43} 55:19]
    adder_0.clock <= clock
    adder_0.reset <= reset
    adder_0.io_a <= _adder_0_io_a_T @[PipelineAdderNb.scala 42:19]
    adder_0.io_b <= _adder_0_io_b_T @[PipelineAdderNb.scala 43:19]
    adder_0.io_cin <= regCin0 @[PipelineAdderNb.scala 45:23]
    adder_1.clock <= clock
    adder_1.reset <= reset
    adder_1.io_a <= _adder_1_io_a_T @[PipelineAdderNb.scala 42:19]
    adder_1.io_b <= _adder_1_io_b_T @[PipelineAdderNb.scala 43:19]
    adder_1.io_cin <= regCoutmid_0 @[PipelineAdderNb.scala 48:23]
    adder_2.clock <= clock
    adder_2.reset <= reset
    adder_2.io_a <= _adder_2_io_a_T @[PipelineAdderNb.scala 42:19]
    adder_2.io_b <= _adder_2_io_b_T @[PipelineAdderNb.scala 43:19]
    adder_2.io_cin <= regCoutmid_1 @[PipelineAdderNb.scala 48:23]
    adder_3.clock <= clock
    adder_3.reset <= reset
    adder_3.io_a <= _adder_3_io_a_T @[PipelineAdderNb.scala 42:19]
    adder_3.io_b <= _adder_3_io_b_T @[PipelineAdderNb.scala 43:19]
    adder_3.io_cin <= regCoutmid_2 @[PipelineAdderNb.scala 48:23]
