module Blinky(
  input   clock,
  input   reset,
  output  io_led0
);
  reg  led; // @[Main.scala 9:20]
  reg [5:0] counterWrap_c_value; // @[Counter.scala 61:40]
  wire  counterWrap_wrap_wrap = counterWrap_c_value == 6'h31; // @[Counter.scala 73:24]
  wire [5:0] _counterWrap_wrap_value_T_1 = counterWrap_c_value + 6'h1; // @[Counter.scala 77:24]
  assign io_led0 = led; // @[Main.scala 14:11]
  always @(posedge clock) begin
    if (reset) begin // @[Main.scala 9:20]
      led <= 1'h0; // @[Main.scala 9:20]
    end else if (counterWrap_wrap_wrap) begin // @[Main.scala 11:21]
      led <= ~led; // @[Main.scala 12:9]
    end
    if (reset) begin // @[Counter.scala 61:40]
      counterWrap_c_value <= 6'h0; // @[Counter.scala 61:40]
    end else if (counterWrap_wrap_wrap) begin // @[Counter.scala 87:20]
      counterWrap_c_value <= 6'h0; // @[Counter.scala 87:28]
    end else begin
      counterWrap_c_value <= _counterWrap_wrap_value_T_1; // @[Counter.scala 77:15]
    end
  end
endmodule
