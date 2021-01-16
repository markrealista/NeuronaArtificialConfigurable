# 
# Synthesis run script generated by Vivado
# 

create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/Users/markr/Documents/sigmoid/sigmoid.cache/wt [current_project]
set_property parent.project_path C:/Users/markr/Documents/sigmoid/sigmoid.xpr [current_project]
set_property XPM_LIBRARIES XPM_CDC [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property board_part digilentinc.com:nexys4_ddr:part0:1.1 [current_project]
set_property ip_output_repo c:/Users/markr/Documents/sigmoid/sigmoid.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {
  C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/imports/new/FF_D.vhd
  C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/imports/new/PE.vhd
  C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/imports/new/package_CM.vhd
  C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/imports/new/PIPO.vhd
  C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/imports/new/PISO_M.vhd
  C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/imports/new/PISO_N.vhd
  C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/imports/new/SIPO.vhd
  C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/imports/new/and2.vhd
  C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/imports/new/bit4_multiplier_PEs.vhd
  C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/imports/new/configurable_multiplier.vhd
  C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/imports/new/controller_sig_left.vhd
  C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/imports/new/controller_sig_midd.vhd
  C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/imports/new/controller_sig_right.vhd
  C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/imports/new/package_sigmoid.vhd
  C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/imports/new/dp_sig_left.vhd
  C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/imports/new/dp_sig_midd.vhd
  C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/imports/new/dp_sig_right.vhd
  C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/imports/new/fa_block.vhd
  C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/imports/new/full_adder.vhd
  C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/imports/new/mult_controller.vhd
  C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/imports/new/mux_left.vhd
  C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/imports/new/mux_midd.vhd
  C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/imports/new/mux_right.vhd
  C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/imports/new/mux_select.vhd
  C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/imports/new/registro.vhd
  C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/imports/new/shifter_in.vhd
  C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/imports/new/shifter_out.vhd
  C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/imports/new/sig_left.vhd
  C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/imports/new/sig_midd.vhd
  C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/imports/new/sig_mux.vhd
  C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/imports/new/sig_mux_2.vhd
  C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/imports/new/sig_right.vhd
  C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/imports/new/sigmoid.vhd
  C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/imports/new/sigmoid_controller.vhd
  C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/imports/new/xor3.vhd
  C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/imports/new/top.vhd
}
read_ip -quiet C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/ip/clk_mod/clk_mod.xci
set_property used_in_implementation false [get_files -all c:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/ip/clk_mod/clk_mod_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/ip/clk_mod/clk_mod.xdc]
set_property used_in_implementation false [get_files -all c:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/ip/clk_mod/clk_mod_ooc.xdc]
set_property is_locked true [get_files C:/Users/markr/Documents/sigmoid/sigmoid.srcs/sources_1/ip/clk_mod/clk_mod.xci]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/markr/Documents/sigmoid/sigmoid.srcs/constrs_1/imports/Vivado_TFG/Nexys4DDR_Master.xdc
set_property used_in_implementation false [get_files C:/Users/markr/Documents/sigmoid/sigmoid.srcs/constrs_1/imports/Vivado_TFG/Nexys4DDR_Master.xdc]


synth_design -top top -part xc7a100tcsg324-1


write_checkpoint -force -noxdef top.dcp

catch { report_utilization -file top_utilization_synth.rpt -pb top_utilization_synth.pb }