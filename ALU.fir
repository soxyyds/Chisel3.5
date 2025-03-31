circuit ALU :
  module ALU :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip a : UInt<16>, flip b : UInt<16>, flip fn : UInt<2>, y : UInt<16>}

    io.y <= UInt<1>("h0") @[SimpleModule.scala 46:8]
    node _T = eq(UInt<1>("h0"), io.fn) @[SimpleModule.scala 47:16]
    when _T : @[SimpleModule.scala 47:16]
      node _io_y_T = add(io.a, io.b) @[SimpleModule.scala 48:27]
      node _io_y_T_1 = tail(_io_y_T, 1) @[SimpleModule.scala 48:27]
      io.y <= _io_y_T_1 @[SimpleModule.scala 48:19]
    else :
      node _T_1 = eq(UInt<1>("h1"), io.fn) @[SimpleModule.scala 47:16]
      when _T_1 : @[SimpleModule.scala 47:16]
        node _io_y_T_2 = sub(io.a, io.b) @[SimpleModule.scala 49:27]
        node _io_y_T_3 = tail(_io_y_T_2, 1) @[SimpleModule.scala 49:27]
        io.y <= _io_y_T_3 @[SimpleModule.scala 49:19]
      else :
        node _T_2 = eq(UInt<2>("h2"), io.fn) @[SimpleModule.scala 47:16]
        when _T_2 : @[SimpleModule.scala 47:16]
          node _io_y_T_4 = or(io.a, io.b) @[SimpleModule.scala 50:27]
          io.y <= _io_y_T_4 @[SimpleModule.scala 50:19]
        else :
          node _T_3 = eq(UInt<2>("h3"), io.fn) @[SimpleModule.scala 47:16]
          when _T_3 : @[SimpleModule.scala 47:16]
            node _io_y_T_5 = and(io.a, io.b) @[SimpleModule.scala 51:27]
            io.y <= _io_y_T_5 @[SimpleModule.scala 51:19]

