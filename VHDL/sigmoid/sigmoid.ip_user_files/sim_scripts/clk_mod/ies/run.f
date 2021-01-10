-makelib ies/xil_defaultlib -sv \
  "C:/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib ies/xpm \
  "C:/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies/xil_defaultlib \
  "../../../../sigmoid.srcs/sources_1/ip/clk_mod/clk_mod_sim_netlist.vhdl" \
-endlib
-makelib ies/xil_defaultlib \
  glbl.v
-endlib

