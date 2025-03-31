module ALU(
  input         clock,
  input         reset,
  input  [15:0] io_a,
  input  [15:0] io_b,
  input  [1:0]  io_fn,
  output [15:0] io_y
);
  wire [15:0] _io_y_T_1 = io_a + io_b; // @[SimpleModule.scala 48:27]
  wire [15:0] _io_y_T_3 = io_a - io_b; // @[SimpleModule.scala 49:27]
  wire [15:0] _io_y_T_4 = io_a | io_b; // @[SimpleModule.scala 50:27]
  wire [15:0] _io_y_T_5 = io_a & io_b; // @[SimpleModule.scala 51:27]
  wire [15:0] _GEN_0 = 2'h3 == io_fn ? _io_y_T_5 : 16'h0; // @[SimpleModule.scala 47:16 51:19 46:8]
  wire [15:0] _GEN_1 = 2'h2 == io_fn ? _io_y_T_4 : _GEN_0; // @[SimpleModule.scala 47:16 50:19]
  wire [15:0] _GEN_2 = 2'h1 == io_fn ? _io_y_T_3 : _GEN_1; // @[SimpleModule.scala 47:16 49:19]
  assign io_y = 2'h0 == io_fn ? _io_y_T_1 : _GEN_2; // @[SimpleModule.scala 47:16 48:19]
endmodule
