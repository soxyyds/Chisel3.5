circuit forward1 :
  module forward1 :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip id_rs1_0 : UInt<5>, flip id_rs2_0 : UInt<5>, flip id_rs1_1 : UInt<5>, flip id_rs2_1 : UInt<5>, flip id_rs1_data_0 : UInt<32>, flip id_rs2_data_0 : UInt<32>, flip id_rs1_data_1 : UInt<32>, flip id_rs2_data_1 : UInt<32>, flip exmem_rd_0 : UInt<5>, flip exmem_rd_1 : UInt<5>, flip exmem_rdwen_0 : UInt<1>, flip exmem_rdwen_1 : UInt<1>, flip exmem_rdlden_0 : UInt<1>, flip exmem_rdlden_1 : UInt<1>, flip exmem_data_0 : UInt<32>, flip exmem_data_1 : UInt<32>, flip mem_rd_0 : UInt<5>, flip mem_rd_1 : UInt<5>, flip mem_rdwen_0 : UInt<1>, flip mem_rdwen_1 : UInt<1>, flip mem_data_0 : UInt<32>, flip mem_data_1 : UInt<32>, flip memwb_rd_0 : UInt<5>, flip memwb_rd_1 : UInt<5>, flip memwb_rdwen_0 : UInt<1>, flip memwb_rdwen_1 : UInt<1>, flip memwb_data_0 : UInt<32>, flip memwb_data_1 : UInt<32>, fwd_data_rs1_0 : UInt<32>, fwd_data_rs2_0 : UInt<32>, fwd_data_rs1_1 : UInt<32>, fwd_data_rs2_1 : UInt<32>, stall_req : UInt<1>}

    io.fwd_data_rs2_1 <= io.id_rs2_data_1 @[forward1.scala 56:21]
    io.fwd_data_rs1_1 <= io.id_rs1_data_1 @[forward1.scala 57:21]
    io.fwd_data_rs2_0 <= io.id_rs2_data_0 @[forward1.scala 58:21]
    io.fwd_data_rs1_0 <= io.id_rs1_data_0 @[forward1.scala 59:21]
    io.stall_req <= UInt<1>("h0") @[forward1.scala 64:16]
    node _T = neq(io.exmem_rd_0, UInt<1>("h0")) @[forward1.scala 67:43]
    node _T_1 = and(io.exmem_rdlden_0, _T) @[forward1.scala 67:26]
    node _T_2 = neq(io.id_rs1_0, UInt<1>("h0")) @[forward1.scala 68:18]
    node _T_3 = eq(io.exmem_rd_0, io.id_rs1_0) @[forward1.scala 68:43]
    node _T_4 = and(_T_2, _T_3) @[forward1.scala 68:26]
    node _T_5 = neq(io.id_rs2_0, UInt<1>("h0")) @[forward1.scala 69:20]
    node _T_6 = eq(io.exmem_rd_0, io.id_rs2_0) @[forward1.scala 69:45]
    node _T_7 = and(_T_5, _T_6) @[forward1.scala 69:28]
    node _T_8 = or(_T_4, _T_7) @[forward1.scala 68:60]
    node _T_9 = neq(io.id_rs1_1, UInt<1>("h0")) @[forward1.scala 70:20]
    node _T_10 = eq(io.exmem_rd_0, io.id_rs1_1) @[forward1.scala 70:45]
    node _T_11 = and(_T_9, _T_10) @[forward1.scala 70:28]
    node _T_12 = or(_T_8, _T_11) @[forward1.scala 69:62]
    node _T_13 = neq(io.id_rs2_1, UInt<1>("h0")) @[forward1.scala 71:20]
    node _T_14 = eq(io.exmem_rd_0, io.id_rs2_1) @[forward1.scala 71:45]
    node _T_15 = and(_T_13, _T_14) @[forward1.scala 71:28]
    node _T_16 = or(_T_12, _T_15) @[forward1.scala 70:62]
    node _T_17 = and(_T_1, _T_16) @[forward1.scala 67:51]
    when _T_17 : @[forward1.scala 72:8]
      io.stall_req <= UInt<1>("h1") @[forward1.scala 73:18]
    node _T_18 = neq(io.exmem_rd_1, UInt<1>("h0")) @[forward1.scala 76:43]
    node _T_19 = and(io.exmem_rdlden_1, _T_18) @[forward1.scala 76:26]
    node _T_20 = neq(io.id_rs1_0, UInt<1>("h0")) @[forward1.scala 77:18]
    node _T_21 = eq(io.exmem_rd_1, io.id_rs1_0) @[forward1.scala 77:43]
    node _T_22 = and(_T_20, _T_21) @[forward1.scala 77:26]
    node _T_23 = neq(io.id_rs2_0, UInt<1>("h0")) @[forward1.scala 78:20]
    node _T_24 = eq(io.exmem_rd_1, io.id_rs2_0) @[forward1.scala 78:45]
    node _T_25 = and(_T_23, _T_24) @[forward1.scala 78:28]
    node _T_26 = or(_T_22, _T_25) @[forward1.scala 77:60]
    node _T_27 = neq(io.id_rs1_1, UInt<1>("h0")) @[forward1.scala 79:20]
    node _T_28 = eq(io.exmem_rd_1, io.id_rs1_1) @[forward1.scala 79:45]
    node _T_29 = and(_T_27, _T_28) @[forward1.scala 79:28]
    node _T_30 = or(_T_26, _T_29) @[forward1.scala 78:62]
    node _T_31 = neq(io.id_rs2_1, UInt<1>("h0")) @[forward1.scala 80:20]
    node _T_32 = eq(io.exmem_rd_1, io.id_rs2_1) @[forward1.scala 80:45]
    node _T_33 = and(_T_31, _T_32) @[forward1.scala 80:28]
    node _T_34 = or(_T_30, _T_33) @[forward1.scala 79:62]
    node _T_35 = and(_T_19, _T_34) @[forward1.scala 76:51]
    when _T_35 : @[forward1.scala 81:8]
      io.stall_req <= UInt<1>("h1") @[forward1.scala 82:18]
    node _T_36 = neq(io.id_rs1_0, UInt<1>("h0")) @[forward1.scala 88:20]
    when _T_36 : @[forward1.scala 88:29]
      node _T_37 = eq(io.exmem_rd_0, io.id_rs1_0) @[forward1.scala 90:45]
      node _T_38 = and(io.exmem_rdwen_0, _T_37) @[forward1.scala 90:27]
      when _T_38 : @[forward1.scala 90:63]
        io.fwd_data_rs1_0 <= io.exmem_data_0 @[forward1.scala 91:25]
      else :
        node _T_39 = eq(io.exmem_rd_1, io.id_rs1_0) @[forward1.scala 92:51]
        node _T_40 = and(io.exmem_rdwen_1, _T_39) @[forward1.scala 92:33]
        when _T_40 : @[forward1.scala 92:69]
          io.fwd_data_rs1_0 <= io.exmem_data_1 @[forward1.scala 93:27]
        else :
          node _T_41 = eq(io.mem_rd_0, io.id_rs1_0) @[forward1.scala 96:48]
          node _T_42 = and(io.mem_rdwen_0, _T_41) @[forward1.scala 96:32]
          when _T_42 : @[forward1.scala 96:66]
            io.fwd_data_rs1_0 <= io.mem_data_0 @[forward1.scala 97:27]
          else :
            node _T_43 = eq(io.mem_rd_1, io.id_rs1_0) @[forward1.scala 98:49]
            node _T_44 = and(io.mem_rdwen_1, _T_43) @[forward1.scala 98:33]
            when _T_44 : @[forward1.scala 98:67]
              io.fwd_data_rs1_0 <= io.mem_data_1 @[forward1.scala 99:27]
            else :
              node _T_45 = eq(io.memwb_rd_0, io.id_rs1_0) @[forward1.scala 102:52]
              node _T_46 = and(io.memwb_rdwen_0, _T_45) @[forward1.scala 102:34]
              when _T_46 : @[forward1.scala 102:70]
                io.fwd_data_rs1_0 <= io.memwb_data_0 @[forward1.scala 103:27]
              else :
                node _T_47 = eq(io.memwb_rd_1, io.id_rs1_0) @[forward1.scala 104:53]
                node _T_48 = and(io.memwb_rdwen_1, _T_47) @[forward1.scala 104:35]
                when _T_48 : @[forward1.scala 104:71]
                  io.fwd_data_rs1_0 <= io.memwb_data_1 @[forward1.scala 105:27]
    node _T_49 = neq(io.id_rs2_0, UInt<1>("h0")) @[forward1.scala 110:20]
    when _T_49 : @[forward1.scala 110:29]
      node _T_50 = eq(io.exmem_rd_0, io.id_rs2_0) @[forward1.scala 112:45]
      node _T_51 = and(io.exmem_rdwen_0, _T_50) @[forward1.scala 112:27]
      when _T_51 : @[forward1.scala 112:63]
        io.fwd_data_rs2_0 <= io.exmem_data_0 @[forward1.scala 113:25]
      else :
        node _T_52 = eq(io.exmem_rd_1, io.id_rs2_0) @[forward1.scala 114:51]
        node _T_53 = and(io.exmem_rdwen_1, _T_52) @[forward1.scala 114:33]
        when _T_53 : @[forward1.scala 114:69]
          io.fwd_data_rs2_0 <= io.exmem_data_1 @[forward1.scala 115:27]
        else :
          node _T_54 = eq(io.mem_rd_0, io.id_rs2_0) @[forward1.scala 118:48]
          node _T_55 = and(io.mem_rdwen_0, _T_54) @[forward1.scala 118:32]
          when _T_55 : @[forward1.scala 118:66]
            io.fwd_data_rs2_0 <= io.mem_data_0 @[forward1.scala 119:27]
          else :
            node _T_56 = eq(io.mem_rd_1, io.id_rs2_0) @[forward1.scala 120:49]
            node _T_57 = and(io.mem_rdwen_1, _T_56) @[forward1.scala 120:33]
            when _T_57 : @[forward1.scala 120:67]
              io.fwd_data_rs2_0 <= io.mem_data_1 @[forward1.scala 121:27]
            else :
              node _T_58 = eq(io.memwb_rd_0, io.id_rs2_0) @[forward1.scala 124:52]
              node _T_59 = and(io.memwb_rdwen_0, _T_58) @[forward1.scala 124:34]
              when _T_59 : @[forward1.scala 124:70]
                io.fwd_data_rs2_0 <= io.memwb_data_0 @[forward1.scala 125:27]
              else :
                node _T_60 = eq(io.memwb_rd_1, io.id_rs2_0) @[forward1.scala 126:53]
                node _T_61 = and(io.memwb_rdwen_1, _T_60) @[forward1.scala 126:35]
                when _T_61 : @[forward1.scala 126:71]
                  io.fwd_data_rs2_0 <= io.memwb_data_1 @[forward1.scala 127:27]
    node _T_62 = neq(io.id_rs1_1, UInt<1>("h0")) @[forward1.scala 132:20]
    when _T_62 : @[forward1.scala 132:29]
      node _T_63 = eq(io.exmem_rd_0, io.id_rs1_1) @[forward1.scala 134:45]
      node _T_64 = and(io.exmem_rdwen_0, _T_63) @[forward1.scala 134:27]
      when _T_64 : @[forward1.scala 134:63]
        io.fwd_data_rs1_1 <= io.exmem_data_0 @[forward1.scala 135:25]
      else :
        node _T_65 = eq(io.exmem_rd_1, io.id_rs1_1) @[forward1.scala 136:51]
        node _T_66 = and(io.exmem_rdwen_1, _T_65) @[forward1.scala 136:33]
        when _T_66 : @[forward1.scala 136:69]
          io.fwd_data_rs1_1 <= io.exmem_data_1 @[forward1.scala 137:27]
        else :
          node _T_67 = eq(io.mem_rd_0, io.id_rs1_1) @[forward1.scala 140:48]
          node _T_68 = and(io.mem_rdwen_0, _T_67) @[forward1.scala 140:32]
          when _T_68 : @[forward1.scala 140:66]
            io.fwd_data_rs1_1 <= io.mem_data_0 @[forward1.scala 141:27]
          else :
            node _T_69 = eq(io.mem_rd_1, io.id_rs1_1) @[forward1.scala 142:49]
            node _T_70 = and(io.mem_rdwen_1, _T_69) @[forward1.scala 142:33]
            when _T_70 : @[forward1.scala 142:67]
              io.fwd_data_rs1_1 <= io.mem_data_1 @[forward1.scala 143:27]
            else :
              node _T_71 = eq(io.memwb_rd_0, io.id_rs1_1) @[forward1.scala 146:52]
              node _T_72 = and(io.memwb_rdwen_0, _T_71) @[forward1.scala 146:34]
              when _T_72 : @[forward1.scala 146:70]
                io.fwd_data_rs1_1 <= io.memwb_data_0 @[forward1.scala 147:27]
              else :
                node _T_73 = eq(io.memwb_rd_1, io.id_rs1_1) @[forward1.scala 148:53]
                node _T_74 = and(io.memwb_rdwen_1, _T_73) @[forward1.scala 148:35]
                when _T_74 : @[forward1.scala 148:71]
                  io.fwd_data_rs1_1 <= io.memwb_data_1 @[forward1.scala 149:27]
    node _T_75 = neq(io.id_rs2_1, UInt<1>("h0")) @[forward1.scala 154:20]
    when _T_75 : @[forward1.scala 154:29]
      node _T_76 = eq(io.exmem_rd_0, io.id_rs2_1) @[forward1.scala 156:45]
      node _T_77 = and(io.exmem_rdwen_0, _T_76) @[forward1.scala 156:27]
      when _T_77 : @[forward1.scala 156:63]
        io.fwd_data_rs2_1 <= io.exmem_data_0 @[forward1.scala 157:25]
      else :
        node _T_78 = eq(io.exmem_rd_1, io.id_rs2_1) @[forward1.scala 158:51]
        node _T_79 = and(io.exmem_rdwen_1, _T_78) @[forward1.scala 158:33]
        when _T_79 : @[forward1.scala 158:69]
          io.fwd_data_rs2_1 <= io.exmem_data_1 @[forward1.scala 159:27]
        else :
          node _T_80 = eq(io.mem_rd_0, io.id_rs2_1) @[forward1.scala 162:48]
          node _T_81 = and(io.mem_rdwen_0, _T_80) @[forward1.scala 162:32]
          when _T_81 : @[forward1.scala 162:66]
            io.fwd_data_rs2_1 <= io.mem_data_0 @[forward1.scala 163:27]
          else :
            node _T_82 = eq(io.mem_rd_1, io.id_rs2_1) @[forward1.scala 164:49]
            node _T_83 = and(io.mem_rdwen_1, _T_82) @[forward1.scala 164:33]
            when _T_83 : @[forward1.scala 164:67]
              io.fwd_data_rs2_1 <= io.mem_data_1 @[forward1.scala 165:27]
            else :
              node _T_84 = eq(io.memwb_rd_0, io.id_rs2_1) @[forward1.scala 168:52]
              node _T_85 = and(io.memwb_rdwen_0, _T_84) @[forward1.scala 168:34]
              when _T_85 : @[forward1.scala 168:70]
                io.fwd_data_rs2_1 <= io.memwb_data_0 @[forward1.scala 169:27]
              else :
                node _T_86 = eq(io.memwb_rd_1, io.id_rs2_1) @[forward1.scala 170:53]
                node _T_87 = and(io.memwb_rdwen_1, _T_86) @[forward1.scala 170:35]
                when _T_87 : @[forward1.scala 170:71]
                  io.fwd_data_rs2_1 <= io.memwb_data_1 @[forward1.scala 171:27]

