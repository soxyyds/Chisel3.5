circuit Blinky :
  module Blinky :
    input clock : Clock
    input reset : UInt<1>
    output io : { led0 : UInt<1>}

    reg led : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Main.scala 9:20]
    reg counterWrap_c_value : UInt<6>, clock with :
      reset => (reset, UInt<6>("h0")) @[Counter.scala 61:40]
    wire counterWrap : UInt<1>
    counterWrap <= UInt<1>("h0")
    when UInt<1>("h1") : @[Counter.scala 118:16]
      node counterWrap_wrap_wrap = eq(counterWrap_c_value, UInt<6>("h31")) @[Counter.scala 73:24]
      node _counterWrap_wrap_value_T = add(counterWrap_c_value, UInt<1>("h1")) @[Counter.scala 77:24]
      node _counterWrap_wrap_value_T_1 = tail(_counterWrap_wrap_value_T, 1) @[Counter.scala 77:24]
      counterWrap_c_value <= _counterWrap_wrap_value_T_1 @[Counter.scala 77:15]
      when counterWrap_wrap_wrap : @[Counter.scala 87:20]
        counterWrap_c_value <= UInt<1>("h0") @[Counter.scala 87:28]
      counterWrap <= counterWrap_wrap_wrap @[Counter.scala 118:23]
    when counterWrap : @[Main.scala 11:21]
      node _led_T = not(led) @[Main.scala 12:12]
      led <= _led_T @[Main.scala 12:9]
    io.led0 <= led @[Main.scala 14:11]

