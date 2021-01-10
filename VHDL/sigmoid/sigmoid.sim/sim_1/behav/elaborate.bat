@echo off
set xv_path=C:\\Xilinx\\Vivado\\2017.2\\bin
call %xv_path%/xelab  -wto ac9c15a52f1f408391f00d8a35bf3779 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip -L xpm --snapshot sigmoid_tb_behav xil_defaultlib.sigmoid_tb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
