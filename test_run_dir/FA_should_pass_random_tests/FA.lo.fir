circuit FA :
  module FA :
    input clock : Clock
    input reset : UInt<1>
    input io_a : UInt<1>
    input io_b : UInt<1>
    input io_cin : UInt<1>
    output io_s : UInt<1>
    output io_cout : UInt<1>

    node _io_s_T = xor(io_a, io_b) @[ADDER.scala 16:16]
    node _io_s_T_1 = xor(_io_s_T, io_cin) @[ADDER.scala 16:23]
    node _io_cout_T = and(io_a, io_b) @[ADDER.scala 17:20]
    node _io_cout_T_1 = xor(io_a, io_b) @[ADDER.scala 17:46]
    node _io_cout_T_2 = and(io_cin, _io_cout_T_1) @[ADDER.scala 17:38]
    node _io_cout_T_3 = or(_io_cout_T, _io_cout_T_2) @[ADDER.scala 17:28]
    io_s <= _io_s_T_1 @[ADDER.scala 16:8]
    io_cout <= _io_cout_T_3 @[ADDER.scala 17:11]
