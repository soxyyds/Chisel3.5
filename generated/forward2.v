module forward2(
  input        clock,
  input        reset,
  input  [4:0] io_id_rs1_1,
  input  [4:0] io_id_rs2_1,
  input  [4:0] io_id_rd_0,
  input        io_id_rdwen_0,
  output       io_stallex
);
  wire  _sel1_T_1 = io_id_rdwen_0 & io_id_rd_0 != 5'h0; // @[forward2.scala 19:28]
  wire  sel1 = io_id_rdwen_0 & io_id_rd_0 != 5'h0 & io_id_rd_0 == io_id_rs1_1; // @[forward2.scala 19:52]
  wire  sel2 = _sel1_T_1 & io_id_rd_0 == io_id_rs2_1; // @[forward2.scala 20:52]
  assign io_stallex = sel1 | sel2; // @[forward2.scala 21:22]
endmodule
