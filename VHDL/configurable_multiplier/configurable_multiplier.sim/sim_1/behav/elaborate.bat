@echo off
set xv_path=C:\\Xilinx\\Vivado\\2017.2\\bin
call %xv_path%/xelab  -wto 0f18eb9230bd4ac193df06178bca73c1 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip -L xpm --snapshot configurable_multiplier_tb_behav xil_defaultlib.configurable_multiplier_tb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
