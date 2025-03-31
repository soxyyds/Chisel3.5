circuit top1 :
  module top1 :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in0 : UInt<32>, flip in1 : UInt<32>, flip in2 : UInt<32>, flip in3 : UInt<32>, out : UInt<32>}

    node _a1_T = add(io.in0, io.in1) @[2.3ADDER01.scala 27:6]
    node a1 = tail(_a1_T, 1) @[2.3ADDER01.scala 27:6]
    node _a2_T = add(io.in2, io.in3) @[2.3ADDER01.scala 27:6]
    node a2 = tail(_a2_T, 1) @[2.3ADDER01.scala 27:6]
    node _io_out_T = add(a1, a2) @[2.3ADDER01.scala 27:6]
    node _io_out_T_1 = tail(_io_out_T, 1) @[2.3ADDER01.scala 27:6]
    io.out <= _io_out_T_1 @[2.3ADDER01.scala 19:10]

