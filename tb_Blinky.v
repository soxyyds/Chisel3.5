`timescale 1ns/100ps

module tb_Blinky;

parameter SYSCLK_PERIOD = 10;

reg SYSCLK;
reg NSYSRESET;

wire O_led;

integer i ;

initial
begin
    SYSCLK = 1'b0;
    NSYSRESET = 1'b1;
	
	#30;
	NSYSRESET = 1'b0;
end

/*iverilog */
initial
begin            
    $dumpfile("tb_Blinky.vcd");        //生成的vcd文件名称
    $dumpvars(0, tb_Blinky);    //tb模块名称
end
/*iverilog */
	
	initial begin
		#0;
		for(i = 0; i < 4000;i = i + 1)begin
			SYSCLK = !SYSCLK;
			#5;
		end
	end

Blinky Blinky_ut0 (
    // Inputs
    .reset( NSYSRESET ),
    .clock( SYSCLK ),

    // Outputs
    .io_led0( O_led )
);

endmodule