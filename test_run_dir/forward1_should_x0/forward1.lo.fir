circuit forward1 :
  module forward1 :
    input clock : Clock
    input reset : UInt<1>
    input io_id_rs1_0 : UInt<5>
    input io_id_rs2_0 : UInt<5>
    input io_id_rs1_1 : UInt<5>
    input io_id_rs2_1 : UInt<5>
    input io_id_rs1_data_0 : UInt<32>
    input io_id_rs2_data_0 : UInt<32>
    input io_id_rs1_data_1 : UInt<32>
    input io_id_rs2_data_1 : UInt<32>
    input io_exmem_rd_0 : UInt<5>
    input io_exmem_rd_1 : UInt<5>
    input io_exmem_rdwen_0 : UInt<1>
    input io_exmem_rdwen_1 : UInt<1>
    input io_exmem_rdlden_0 : UInt<1>
    input io_exmem_rdlden_1 : UInt<1>
    input io_exmem_data_0 : UInt<32>
    input io_exmem_data_1 : UInt<32>
    input io_mem_rd_0 : UInt<5>
    input io_mem_rd_1 : UInt<5>
    input io_mem_rdwen_0 : UInt<1>
    input io_mem_rdwen_1 : UInt<1>
    input io_mem_data_0 : UInt<32>
    input io_mem_data_1 : UInt<32>
    input io_memwb_rd_0 : UInt<5>
    input io_memwb_rd_1 : UInt<5>
    input io_memwb_rdwen_0 : UInt<1>
    input io_memwb_rdwen_1 : UInt<1>
    input io_memwb_data_0 : UInt<32>
    input io_memwb_data_1 : UInt<32>
    output io_fwd_data_rs1_0 : UInt<32>
    output io_fwd_data_rs2_0 : UInt<32>
    output io_fwd_data_rs1_1 : UInt<32>
    output io_fwd_data_rs2_1 : UInt<32>
    output io_stall_req : UInt<1>

    node _T = neq(io_exmem_rd_0, UInt<1>("h0")) @[forward1.scala 66:43]
    node _T_1 = and(io_exmem_rdlden_0, _T) @[forward1.scala 66:26]
    node _T_2 = neq(io_id_rs1_0, UInt<1>("h0")) @[forward1.scala 67:18]
    node _T_3 = eq(io_exmem_rd_0, io_id_rs1_0) @[forward1.scala 67:43]
    node _T_4 = and(_T_2, _T_3) @[forward1.scala 67:26]
    node _T_5 = neq(io_id_rs2_0, UInt<1>("h0")) @[forward1.scala 68:20]
    node _T_6 = eq(io_exmem_rd_0, io_id_rs2_0) @[forward1.scala 68:45]
    node _T_7 = and(_T_5, _T_6) @[forward1.scala 68:28]
    node _T_8 = or(_T_4, _T_7) @[forward1.scala 67:60]
    node _T_9 = neq(io_id_rs1_1, UInt<1>("h0")) @[forward1.scala 69:20]
    node _T_10 = eq(io_exmem_rd_0, io_id_rs1_1) @[forward1.scala 69:45]
    node _T_11 = and(_T_9, _T_10) @[forward1.scala 69:28]
    node _T_12 = or(_T_8, _T_11) @[forward1.scala 68:62]
    node _T_13 = neq(io_id_rs2_1, UInt<1>("h0")) @[forward1.scala 70:20]
    node _T_14 = eq(io_exmem_rd_0, io_id_rs2_1) @[forward1.scala 70:45]
    node _T_15 = and(_T_13, _T_14) @[forward1.scala 70:28]
    node _T_16 = or(_T_12, _T_15) @[forward1.scala 69:62]
    node _T_17 = and(_T_1, _T_16) @[forward1.scala 66:51]
    node _GEN_0 = mux(_T_17, UInt<1>("h1"), UInt<1>("h0")) @[forward1.scala 63:16 71:8 72:18]
    node _T_18 = neq(io_exmem_rd_1, UInt<1>("h0")) @[forward1.scala 75:43]
    node _T_19 = and(io_exmem_rdlden_1, _T_18) @[forward1.scala 75:26]
    node _T_20 = neq(io_id_rs1_0, UInt<1>("h0")) @[forward1.scala 76:18]
    node _T_21 = eq(io_exmem_rd_1, io_id_rs1_0) @[forward1.scala 76:43]
    node _T_22 = and(_T_20, _T_21) @[forward1.scala 76:26]
    node _T_23 = neq(io_id_rs2_0, UInt<1>("h0")) @[forward1.scala 77:20]
    node _T_24 = eq(io_exmem_rd_1, io_id_rs2_0) @[forward1.scala 77:45]
    node _T_25 = and(_T_23, _T_24) @[forward1.scala 77:28]
    node _T_26 = or(_T_22, _T_25) @[forward1.scala 76:60]
    node _T_27 = neq(io_id_rs1_1, UInt<1>("h0")) @[forward1.scala 78:20]
    node _T_28 = eq(io_exmem_rd_1, io_id_rs1_1) @[forward1.scala 78:45]
    node _T_29 = and(_T_27, _T_28) @[forward1.scala 78:28]
    node _T_30 = or(_T_26, _T_29) @[forward1.scala 77:62]
    node _T_31 = neq(io_id_rs2_1, UInt<1>("h0")) @[forward1.scala 79:20]
    node _T_32 = eq(io_exmem_rd_1, io_id_rs2_1) @[forward1.scala 79:45]
    node _T_33 = and(_T_31, _T_32) @[forward1.scala 79:28]
    node _T_34 = or(_T_30, _T_33) @[forward1.scala 78:62]
    node _T_35 = and(_T_19, _T_34) @[forward1.scala 75:51]
    node _GEN_1 = mux(_T_35, UInt<1>("h1"), _GEN_0) @[forward1.scala 80:8 81:18]
    node _T_36 = neq(io_id_rs1_0, UInt<1>("h0")) @[forward1.scala 87:20]
    node _T_37 = eq(io_exmem_rd_0, io_id_rs1_0) @[forward1.scala 89:45]
    node _T_38 = and(io_exmem_rdwen_0, _T_37) @[forward1.scala 89:27]
    node _T_39 = eq(io_exmem_rd_1, io_id_rs1_0) @[forward1.scala 91:51]
    node _T_40 = and(io_exmem_rdwen_1, _T_39) @[forward1.scala 91:33]
    node _T_41 = eq(io_mem_rd_0, io_id_rs1_0) @[forward1.scala 95:48]
    node _T_42 = and(io_mem_rdwen_0, _T_41) @[forward1.scala 95:32]
    node _T_43 = eq(io_mem_rd_1, io_id_rs1_0) @[forward1.scala 97:49]
    node _T_44 = and(io_mem_rdwen_1, _T_43) @[forward1.scala 97:33]
    node _T_45 = eq(io_memwb_rd_0, io_id_rs1_0) @[forward1.scala 101:52]
    node _T_46 = and(io_memwb_rdwen_0, _T_45) @[forward1.scala 101:34]
    node _T_47 = eq(io_memwb_rd_1, io_id_rs1_0) @[forward1.scala 103:53]
    node _T_48 = and(io_memwb_rdwen_1, _T_47) @[forward1.scala 103:35]
    node _GEN_2 = mux(_T_48, io_memwb_data_1, io_id_rs1_data_0) @[forward1.scala 103:71 104:27 58:21]
    node _GEN_3 = mux(_T_46, io_memwb_data_0, _GEN_2) @[forward1.scala 101:70 102:27]
    node _GEN_4 = mux(_T_44, io_mem_data_1, _GEN_3) @[forward1.scala 97:67 98:27]
    node _GEN_5 = mux(_T_42, io_mem_data_0, _GEN_4) @[forward1.scala 95:66 96:27]
    node _GEN_6 = mux(_T_40, io_exmem_data_1, _GEN_5) @[forward1.scala 91:69 92:27]
    node _GEN_7 = mux(_T_38, io_exmem_data_0, _GEN_6) @[forward1.scala 89:63 90:25]
    node _GEN_8 = mux(_T_36, _GEN_7, io_id_rs1_data_0) @[forward1.scala 58:21 87:29]
    node _T_49 = neq(io_id_rs2_0, UInt<1>("h0")) @[forward1.scala 109:20]
    node _T_50 = eq(io_exmem_rd_0, io_id_rs2_0) @[forward1.scala 111:45]
    node _T_51 = and(io_exmem_rdwen_0, _T_50) @[forward1.scala 111:27]
    node _T_52 = eq(io_exmem_rd_1, io_id_rs2_0) @[forward1.scala 113:51]
    node _T_53 = and(io_exmem_rdwen_1, _T_52) @[forward1.scala 113:33]
    node _T_54 = eq(io_mem_rd_0, io_id_rs2_0) @[forward1.scala 117:48]
    node _T_55 = and(io_mem_rdwen_0, _T_54) @[forward1.scala 117:32]
    node _T_56 = eq(io_mem_rd_1, io_id_rs2_0) @[forward1.scala 119:49]
    node _T_57 = and(io_mem_rdwen_1, _T_56) @[forward1.scala 119:33]
    node _T_58 = eq(io_memwb_rd_0, io_id_rs2_0) @[forward1.scala 123:52]
    node _T_59 = and(io_memwb_rdwen_0, _T_58) @[forward1.scala 123:34]
    node _T_60 = eq(io_memwb_rd_1, io_id_rs2_0) @[forward1.scala 125:53]
    node _T_61 = and(io_memwb_rdwen_1, _T_60) @[forward1.scala 125:35]
    node _GEN_9 = mux(_T_61, io_memwb_data_1, io_id_rs2_data_0) @[forward1.scala 125:71 126:27 57:21]
    node _GEN_10 = mux(_T_59, io_memwb_data_0, _GEN_9) @[forward1.scala 123:70 124:27]
    node _GEN_11 = mux(_T_57, io_mem_data_1, _GEN_10) @[forward1.scala 119:67 120:27]
    node _GEN_12 = mux(_T_55, io_mem_data_0, _GEN_11) @[forward1.scala 117:66 118:27]
    node _GEN_13 = mux(_T_53, io_exmem_data_1, _GEN_12) @[forward1.scala 113:69 114:27]
    node _GEN_14 = mux(_T_51, io_exmem_data_0, _GEN_13) @[forward1.scala 111:63 112:25]
    node _GEN_15 = mux(_T_49, _GEN_14, io_id_rs2_data_0) @[forward1.scala 109:29 57:21]
    node _T_62 = neq(io_id_rs1_1, UInt<1>("h0")) @[forward1.scala 131:20]
    node _T_63 = eq(io_exmem_rd_0, io_id_rs1_1) @[forward1.scala 133:45]
    node _T_64 = and(io_exmem_rdwen_0, _T_63) @[forward1.scala 133:27]
    node _T_65 = eq(io_exmem_rd_1, io_id_rs1_1) @[forward1.scala 135:51]
    node _T_66 = and(io_exmem_rdwen_1, _T_65) @[forward1.scala 135:33]
    node _T_67 = eq(io_mem_rd_0, io_id_rs1_1) @[forward1.scala 139:48]
    node _T_68 = and(io_mem_rdwen_0, _T_67) @[forward1.scala 139:32]
    node _T_69 = eq(io_mem_rd_1, io_id_rs1_1) @[forward1.scala 141:49]
    node _T_70 = and(io_mem_rdwen_1, _T_69) @[forward1.scala 141:33]
    node _T_71 = eq(io_memwb_rd_0, io_id_rs1_1) @[forward1.scala 145:52]
    node _T_72 = and(io_memwb_rdwen_0, _T_71) @[forward1.scala 145:34]
    node _T_73 = eq(io_memwb_rd_1, io_id_rs1_1) @[forward1.scala 147:53]
    node _T_74 = and(io_memwb_rdwen_1, _T_73) @[forward1.scala 147:35]
    node _GEN_16 = mux(_T_74, io_memwb_data_1, io_id_rs1_data_1) @[forward1.scala 147:71 148:27 56:21]
    node _GEN_17 = mux(_T_72, io_memwb_data_0, _GEN_16) @[forward1.scala 145:70 146:27]
    node _GEN_18 = mux(_T_70, io_mem_data_1, _GEN_17) @[forward1.scala 141:67 142:27]
    node _GEN_19 = mux(_T_68, io_mem_data_0, _GEN_18) @[forward1.scala 139:66 140:27]
    node _GEN_20 = mux(_T_66, io_exmem_data_1, _GEN_19) @[forward1.scala 135:69 136:27]
    node _GEN_21 = mux(_T_64, io_exmem_data_0, _GEN_20) @[forward1.scala 133:63 134:25]
    node _GEN_22 = mux(_T_62, _GEN_21, io_id_rs1_data_1) @[forward1.scala 131:29 56:21]
    node _T_75 = neq(io_id_rs2_1, UInt<1>("h0")) @[forward1.scala 153:20]
    node _T_76 = eq(io_exmem_rd_0, io_id_rs2_1) @[forward1.scala 155:45]
    node _T_77 = and(io_exmem_rdwen_0, _T_76) @[forward1.scala 155:27]
    node _T_78 = eq(io_exmem_rd_1, io_id_rs2_1) @[forward1.scala 157:51]
    node _T_79 = and(io_exmem_rdwen_1, _T_78) @[forward1.scala 157:33]
    node _T_80 = eq(io_mem_rd_0, io_id_rs2_1) @[forward1.scala 161:48]
    node _T_81 = and(io_mem_rdwen_0, _T_80) @[forward1.scala 161:32]
    node _T_82 = eq(io_mem_rd_1, io_id_rs2_1) @[forward1.scala 163:49]
    node _T_83 = and(io_mem_rdwen_1, _T_82) @[forward1.scala 163:33]
    node _T_84 = eq(io_memwb_rd_0, io_id_rs2_1) @[forward1.scala 167:52]
    node _T_85 = and(io_memwb_rdwen_0, _T_84) @[forward1.scala 167:34]
    node _T_86 = eq(io_memwb_rd_1, io_id_rs2_1) @[forward1.scala 169:53]
    node _T_87 = and(io_memwb_rdwen_1, _T_86) @[forward1.scala 169:35]
    node _GEN_23 = mux(_T_87, io_memwb_data_1, io_id_rs2_data_1) @[forward1.scala 169:71 170:27 55:21]
    node _GEN_24 = mux(_T_85, io_memwb_data_0, _GEN_23) @[forward1.scala 167:70 168:27]
    node _GEN_25 = mux(_T_83, io_mem_data_1, _GEN_24) @[forward1.scala 163:67 164:27]
    node _GEN_26 = mux(_T_81, io_mem_data_0, _GEN_25) @[forward1.scala 161:66 162:27]
    node _GEN_27 = mux(_T_79, io_exmem_data_1, _GEN_26) @[forward1.scala 157:69 158:27]
    node _GEN_28 = mux(_T_77, io_exmem_data_0, _GEN_27) @[forward1.scala 155:63 156:25]
    node _GEN_29 = mux(_T_75, _GEN_28, io_id_rs2_data_1) @[forward1.scala 153:29 55:21]
    io_fwd_data_rs1_0 <= _GEN_8
    io_fwd_data_rs2_0 <= _GEN_15
    io_fwd_data_rs1_1 <= _GEN_22
    io_fwd_data_rs2_1 <= _GEN_29
    io_stall_req <= _GEN_1
