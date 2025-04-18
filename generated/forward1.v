module forward1(
  input         clock,
  input         reset,
  input  [4:0]  io_id_rs1_0,
  input  [4:0]  io_id_rs2_0,
  input  [4:0]  io_id_rs1_1,
  input  [4:0]  io_id_rs2_1,
  input  [31:0] io_id_rs1_data_0,
  input  [31:0] io_id_rs2_data_0,
  input  [31:0] io_id_rs1_data_1,
  input  [31:0] io_id_rs2_data_1,
  input  [4:0]  io_exmem_rd_0,
  input  [4:0]  io_exmem_rd_1,
  input         io_exmem_rdwen_0,
  input         io_exmem_rdwen_1,
  input         io_exmem_rdlden_0,
  input         io_exmem_rdlden_1,
  input  [31:0] io_exmem_data_0,
  input  [31:0] io_exmem_data_1,
  input  [4:0]  io_mem_rd_0,
  input  [4:0]  io_mem_rd_1,
  input         io_mem_rdwen_0,
  input         io_mem_rdwen_1,
  input  [31:0] io_mem_data_0,
  input  [31:0] io_mem_data_1,
  input  [4:0]  io_memwb_rd_0,
  input  [4:0]  io_memwb_rd_1,
  input         io_memwb_rdwen_0,
  input         io_memwb_rdwen_1,
  input  [31:0] io_memwb_data_0,
  input  [31:0] io_memwb_data_1,
  output [31:0] io_fwd_data_rs1_0,
  output [31:0] io_fwd_data_rs2_0,
  output [31:0] io_fwd_data_rs1_1,
  output [31:0] io_fwd_data_rs2_1,
  output        io_stall_req
);
  wire  _T_2 = io_id_rs1_0 != 5'h0; // @[forward1.scala 68:18]
  wire  _T_3 = io_exmem_rd_0 == io_id_rs1_0; // @[forward1.scala 68:43]
  wire  _T_5 = io_id_rs2_0 != 5'h0; // @[forward1.scala 69:20]
  wire  _T_6 = io_exmem_rd_0 == io_id_rs2_0; // @[forward1.scala 69:45]
  wire  _T_7 = io_id_rs2_0 != 5'h0 & io_exmem_rd_0 == io_id_rs2_0; // @[forward1.scala 69:28]
  wire  _T_8 = io_id_rs1_0 != 5'h0 & io_exmem_rd_0 == io_id_rs1_0 | _T_7; // @[forward1.scala 68:60]
  wire  _T_9 = io_id_rs1_1 != 5'h0; // @[forward1.scala 70:20]
  wire  _T_10 = io_exmem_rd_0 == io_id_rs1_1; // @[forward1.scala 70:45]
  wire  _T_11 = io_id_rs1_1 != 5'h0 & io_exmem_rd_0 == io_id_rs1_1; // @[forward1.scala 70:28]
  wire  _T_12 = _T_8 | _T_11; // @[forward1.scala 69:62]
  wire  _T_13 = io_id_rs2_1 != 5'h0; // @[forward1.scala 71:20]
  wire  _T_14 = io_exmem_rd_0 == io_id_rs2_1; // @[forward1.scala 71:45]
  wire  _T_15 = io_id_rs2_1 != 5'h0 & io_exmem_rd_0 == io_id_rs2_1; // @[forward1.scala 71:28]
  wire  _T_16 = _T_12 | _T_15; // @[forward1.scala 70:62]
  wire  _T_17 = io_exmem_rdlden_0 & io_exmem_rd_0 != 5'h0 & _T_16; // @[forward1.scala 67:51]
  wire  _T_21 = io_exmem_rd_1 == io_id_rs1_0; // @[forward1.scala 77:43]
  wire  _T_24 = io_exmem_rd_1 == io_id_rs2_0; // @[forward1.scala 78:45]
  wire  _T_25 = _T_5 & io_exmem_rd_1 == io_id_rs2_0; // @[forward1.scala 78:28]
  wire  _T_26 = _T_2 & io_exmem_rd_1 == io_id_rs1_0 | _T_25; // @[forward1.scala 77:60]
  wire  _T_28 = io_exmem_rd_1 == io_id_rs1_1; // @[forward1.scala 79:45]
  wire  _T_29 = _T_9 & io_exmem_rd_1 == io_id_rs1_1; // @[forward1.scala 79:28]
  wire  _T_30 = _T_26 | _T_29; // @[forward1.scala 78:62]
  wire  _T_32 = io_exmem_rd_1 == io_id_rs2_1; // @[forward1.scala 80:45]
  wire  _T_33 = _T_13 & io_exmem_rd_1 == io_id_rs2_1; // @[forward1.scala 80:28]
  wire  _T_34 = _T_30 | _T_33; // @[forward1.scala 79:62]
  wire  _T_35 = io_exmem_rdlden_1 & io_exmem_rd_1 != 5'h0 & _T_34; // @[forward1.scala 76:51]
  wire [31:0] _GEN_2 = io_memwb_rdwen_1 & io_memwb_rd_1 == io_id_rs1_0 ? io_memwb_data_1 : io_id_rs1_data_0; // @[forward1.scala 104:71 105:27 59:21]
  wire [31:0] _GEN_3 = io_memwb_rdwen_0 & io_memwb_rd_0 == io_id_rs1_0 ? io_memwb_data_0 : _GEN_2; // @[forward1.scala 102:70 103:27]
  wire [31:0] _GEN_4 = io_mem_rdwen_1 & io_mem_rd_1 == io_id_rs1_0 ? io_mem_data_1 : _GEN_3; // @[forward1.scala 98:67 99:27]
  wire [31:0] _GEN_5 = io_mem_rdwen_0 & io_mem_rd_0 == io_id_rs1_0 ? io_mem_data_0 : _GEN_4; // @[forward1.scala 96:66 97:27]
  wire [31:0] _GEN_6 = io_exmem_rdwen_1 & _T_21 ? io_exmem_data_1 : _GEN_5; // @[forward1.scala 92:69 93:27]
  wire [31:0] _GEN_7 = io_exmem_rdwen_0 & _T_3 ? io_exmem_data_0 : _GEN_6; // @[forward1.scala 90:63 91:25]
  wire [31:0] _GEN_9 = io_memwb_rdwen_1 & io_memwb_rd_1 == io_id_rs2_0 ? io_memwb_data_1 : io_id_rs2_data_0; // @[forward1.scala 126:71 127:27 58:21]
  wire [31:0] _GEN_10 = io_memwb_rdwen_0 & io_memwb_rd_0 == io_id_rs2_0 ? io_memwb_data_0 : _GEN_9; // @[forward1.scala 124:70 125:27]
  wire [31:0] _GEN_11 = io_mem_rdwen_1 & io_mem_rd_1 == io_id_rs2_0 ? io_mem_data_1 : _GEN_10; // @[forward1.scala 120:67 121:27]
  wire [31:0] _GEN_12 = io_mem_rdwen_0 & io_mem_rd_0 == io_id_rs2_0 ? io_mem_data_0 : _GEN_11; // @[forward1.scala 118:66 119:27]
  wire [31:0] _GEN_13 = io_exmem_rdwen_1 & _T_24 ? io_exmem_data_1 : _GEN_12; // @[forward1.scala 114:69 115:27]
  wire [31:0] _GEN_14 = io_exmem_rdwen_0 & _T_6 ? io_exmem_data_0 : _GEN_13; // @[forward1.scala 112:63 113:25]
  wire [31:0] _GEN_16 = io_memwb_rdwen_1 & io_memwb_rd_1 == io_id_rs1_1 ? io_memwb_data_1 : io_id_rs1_data_1; // @[forward1.scala 148:71 149:27 57:21]
  wire [31:0] _GEN_17 = io_memwb_rdwen_0 & io_memwb_rd_0 == io_id_rs1_1 ? io_memwb_data_0 : _GEN_16; // @[forward1.scala 146:70 147:27]
  wire [31:0] _GEN_18 = io_mem_rdwen_1 & io_mem_rd_1 == io_id_rs1_1 ? io_mem_data_1 : _GEN_17; // @[forward1.scala 142:67 143:27]
  wire [31:0] _GEN_19 = io_mem_rdwen_0 & io_mem_rd_0 == io_id_rs1_1 ? io_mem_data_0 : _GEN_18; // @[forward1.scala 140:66 141:27]
  wire [31:0] _GEN_20 = io_exmem_rdwen_1 & _T_28 ? io_exmem_data_1 : _GEN_19; // @[forward1.scala 136:69 137:27]
  wire [31:0] _GEN_21 = io_exmem_rdwen_0 & _T_10 ? io_exmem_data_0 : _GEN_20; // @[forward1.scala 134:63 135:25]
  wire [31:0] _GEN_23 = io_memwb_rdwen_1 & io_memwb_rd_1 == io_id_rs2_1 ? io_memwb_data_1 : io_id_rs2_data_1; // @[forward1.scala 170:71 171:27 56:21]
  wire [31:0] _GEN_24 = io_memwb_rdwen_0 & io_memwb_rd_0 == io_id_rs2_1 ? io_memwb_data_0 : _GEN_23; // @[forward1.scala 168:70 169:27]
  wire [31:0] _GEN_25 = io_mem_rdwen_1 & io_mem_rd_1 == io_id_rs2_1 ? io_mem_data_1 : _GEN_24; // @[forward1.scala 164:67 165:27]
  wire [31:0] _GEN_26 = io_mem_rdwen_0 & io_mem_rd_0 == io_id_rs2_1 ? io_mem_data_0 : _GEN_25; // @[forward1.scala 162:66 163:27]
  wire [31:0] _GEN_27 = io_exmem_rdwen_1 & _T_32 ? io_exmem_data_1 : _GEN_26; // @[forward1.scala 158:69 159:27]
  wire [31:0] _GEN_28 = io_exmem_rdwen_0 & _T_14 ? io_exmem_data_0 : _GEN_27; // @[forward1.scala 156:63 157:25]
  assign io_fwd_data_rs1_0 = _T_2 ? _GEN_7 : io_id_rs1_data_0; // @[forward1.scala 59:21 88:29]
  assign io_fwd_data_rs2_0 = _T_5 ? _GEN_14 : io_id_rs2_data_0; // @[forward1.scala 110:29 58:21]
  assign io_fwd_data_rs1_1 = _T_9 ? _GEN_21 : io_id_rs1_data_1; // @[forward1.scala 132:29 57:21]
  assign io_fwd_data_rs2_1 = _T_13 ? _GEN_28 : io_id_rs2_data_1; // @[forward1.scala 154:29 56:21]
  assign io_stall_req = _T_35 | _T_17; // @[forward1.scala 81:8 82:18]
endmodule
