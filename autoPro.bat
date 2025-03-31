:: 防止中文乱码
chcp 65001
:: 输出当前工作路径
echo 当前仿真路径为：%~dp0

:: 采用Icarus Verilog工具生成a.out文件
iverilog Blinky.v tb_Blinky.v
:: 采用a.out文件生成xxxx.vcd波形文件
vvp a.out
:: 采用gtk工具对生成的xxxx.vcd波形文件进行显示
gtkwave tb_Blinky.vcd

pause