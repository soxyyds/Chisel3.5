module top1(
  input         clock,
  input         reset,
  input  [31:0] io_in0,
  input  [31:0] io_in1,
  input  [31:0] io_in2,
  input  [31:0] io_in3,
  output [31:0] io_out
);
  wire [31:0] a1 = io_in0 + io_in1; // @[2.3ADDER01.scala 27:6]
  wire [31:0] a2 = io_in2 + io_in3; // @[2.3ADDER01.scala 27:6]
  assign io_out = a1 + a2; // @[2.3ADDER01.scala 27:6]
endmodule
