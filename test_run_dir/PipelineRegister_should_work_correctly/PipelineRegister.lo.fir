circuit PipelineRegister :
  module PipelineRegister :
    input clock : Clock
    input reset : UInt<1>
    input io_stall_in : UInt<1>
    input io_data_in : UInt<8>
    output io_data_out : UInt<8>

    reg reg : UInt<8>, clock with :
      reset => (UInt<1>("h0"), reg) @[PipelineRegister.scala 12:20]
    node _GEN_0 = mux(io_stall_in, reg, io_data_in) @[PipelineRegister.scala 14:21 16:9 19:9]
    io_data_out <= reg @[PipelineRegister.scala 22:15]
    reg <= mux(reset, UInt<8>("h1"), _GEN_0) @[PipelineRegister.scala 12:{20,20}]
