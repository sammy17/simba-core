#-----------------------------------------------------------
# Vivado v2018.3 (64-bit)
# SW Build 2405991 on Thu Dec  6 23:36:41 MST 2018
# IP Build 2404404 on Fri Dec  7 01:43:56 MST 2018
# Start of session at: Fri Mar 29 22:09:40 2019
# Process ID: 20823
# Current directory: ../vivado
# Command line: vivado
# Log file: ../vivado/vivado.log
# Journal file: ../vivado/vivado.jou
#-----------------------------------------------------------
create_project riscv ./tmp_project -part xc7z010iclg400-1L
add_files -norecurse {../src/design/newcache/i_cache_inst.vh ../src/design/common/PipelineConnections.vh ../src/design/common/PipelineParams.vh ../src/design/common/peripheral_master.v}
add_files -norecurse {../src/design/pipeline/PIPELINE.v ../src/design/pipeline/CSR_FILE.v ../src/design/pipeline/DECODE_UNIT.v ../src/design/pipeline/EXSTAGE.v ../src/design/tlb/DTLB.v ../src/design/m_standard/Division.v ../src/design/common/Multiplexer.v ../src/design/newcache/myip_v1_0_S00_AXI.v ../src/design/pipeline/STATE_REG.v ../axi_interconnect_v1_7_vl_rfs.v ../src/design/newcache/memory.v ../src/design/common/RISCV_PROCESSOR.v ../src/design/m_standard/RV32M.v ../src/design/tlb/ITLB.v ../src/design/pipeline/CONTROL_UNIT.v ../src/simulation/TEST_RISCV_PROCESSOR.v ../axi_interconnect_0.v ../src/design/newcache/Dcache.v ../src/design/m_standard/Multiplication.v ../src/design/m_standard/mul_top.v ../src/design/newcache/state_mem.v ../src/design/pipeline/BHT.v ../src/design/newcache/cache.v ../src/design/pipeline/IMM_EXT.v ../src/design/pipeline/Peripheral.v ../src/design/pipeline/INS_TYPE_ROM.v ../src/design/pipeline/REG_ARRAY.v ../src/design/newcache/myip_v1_0.v ../src/design/newcache/myip_v1_0_M00_AXI.v ../src/design/wrapper/PERIPHERAL_INTERFACE.v ../src/design/newcache/myip_slave_lite.v}
set_property compxlib.vcs_compiled_library_dir /global/apps/vcs_2017.12-SP2-2/bin [current_project]
update_compile_order -fileset sources_1
update_compile_order -fileset sources_1
# Disabling source management mode.  This is to allow the top design properties to be set without GUI intervention.
set_property source_mgmt_mode None [current_project]
set_property top RISCV_PROCESSOR [current_fileset]
# Re-enabling previously disabled source management mode.
set_property source_mgmt_mode All [current_project]
update_compile_order -fileset sources_1
move_files -fileset sim_1 [get_files  ../src/simulation/TEST_RISCV_PROCESSOR.v]
update_compile_order -fileset sim_1
move_files -fileset sim_1 [get_files  ../axi_interconnect_v1_7_vl_rfs.v]
update_compile_order -fileset sim_1
move_files -fileset sim_1 [get_files  ../axi_interconnect_0.v]
update_compile_order -fileset sim_1
export_ip_user_files -of_objects  [get_files ../src/design/newcache/myip_v1_0.v] -no_script -reset -force -quiet
remove_files  ../src/design/newcache/myip_v1_0.v
export_ip_user_files -of_objects  [get_files ../src/design/m_standard/Multiplication.v] -no_script -reset -force -quiet
remove_files  ../src/design/m_standard/Multiplication.v
move_files -fileset sim_1 [get_files  {../src/design/newcache/myip_slave_lite.v ../src/design/newcache/myip_v1_0_S00_AXI.v}]
update_compile_order -fileset sim_1
set_property SOURCE_SET sources_1 [get_filesets sim_1]
update_compile_order -fileset sources_1
export_ip_user_files -of_objects  [get_files ../axi_interconnect_v1_7_vl_rfs.v] -no_script -reset -force -quiet
remove_files  -fileset sim_1 ../axi_interconnect_v1_7_vl_rfs.v
set_property file_type SystemVerilog [get_files  ../src/simulation/TEST_RISCV_PROCESSOR.v]
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse ../axi_interconnect_v1_7_vl_rfs.v
update_compile_order -fileset sim_1
update_compile_order -fileset sources_1
ipx::package_project -root_dir ../ip -vendor user.org -library user -taxonomy /UserIP -import_files -set_current false
ipx::unload_core ../ip/component.xml
ipx::edit_ip_in_project -upgrade true -name tmp_edit_project -directory ../ip/
update_compile_order -fileset sources_1
set_property supported_families {kintex7 Production kintex7l Production artix7 Production artix7l Production aartix7 Production zynq Production azynq Production spartan7 Production aspartan7 Production zynquplus Production artix7 Beta artix7l Beta kintex7 Beta kintex7l Beta spartan7 Beta aartix7 Beta aspartan7 Beta azynq Beta zynquplus Beta zynq Beta} [ipx::current_core]
set_property core_revision 2 [ipx::current_core]
ipx::update_source_project_archive -component [ipx::current_core]
ipx::create_xgui_files [ipx::current_core]
ipx::update_checksums [ipx::current_core]
ipx::save_core [ipx::current_core]
ipx::move_temp_component_back -component [ipx::current_core]
close_project -delete
set_property  ip_repo_paths  ../ip [current_project]
update_ip_catalog
start_gui
create_project riscv_soc ./soc -part xc7z020clg484-1
set_property board_part em.avnet.com:zed:part0:1.4 [current_project]
create_bd_design "risv_soc"
update_compile_order -fileset sources_1
set_property  ip_repo_paths  ../ip [current_project]
update_ip_catalog
update_ip_catalog
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0
endgroup
apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO, DDR" apply_board_preset "1" Master "Disable" Slave "Disable" }  [get_bd_cells processing_system7_0]
startgroup
set_property -dict [list CONFIG.PCW_USE_S_AXI_GP0 {1} CONFIG.PCW_USE_S_AXI_HP0 {1}] [get_bd_cells processing_system7_0]
endgroup
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_0
endgroup
set_property -dict [list CONFIG.C_GPIO_WIDTH {1} CONFIG.C_ALL_OUTPUTS {1}] [get_bd_cells axi_gpio_0]
startgroup
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {Auto} Clk_slave {Auto} Clk_xbar {Auto} Master {/processing_system7_0/M_AXI_GP0} Slave {/axi_gpio_0/S_AXI} intc_ip {New AXI Interconnect} master_apm {0}}  [get_bd_intf_pins axi_gpio_0/S_AXI]
apply_bd_automation -rule xilinx.com:bd_rule:board -config { Board_Interface {btns_5bits ( Push buttons ) } Manual_Source {Auto}}  [get_bd_intf_pins axi_gpio_0/GPIO]
endgroup
startgroup
create_bd_cell -type ip -vlnv user.org:user:RISCV_PROCESSOR:1.0 RISCV_PROCESSOR_0
endgroup
startgroup
set_property -dict [list CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {40.000000}] [get_bd_cells processing_system7_0]
endgroup
delete_bd_objs [get_bd_intf_nets axi_gpio_0_GPIO]
delete_bd_objs [get_bd_intf_ports btns_5bits]
startgroup
set_property -dict [list CONFIG.C_GPIO_WIDTH {1} CONFIG.C_ALL_INPUTS {0} CONFIG.GPIO_BOARD_INTERFACE {Custom} CONFIG.C_ALL_OUTPUTS {1}] [get_bd_cells axi_gpio_0]
endgroup
set_property location {2 425 293} [get_bd_cells RISCV_PROCESSOR_0]
connect_bd_net [get_bd_pins axi_gpio_0/gpio_io_o] [get_bd_pins RISCV_PROCESSOR_0/RSTN]
connect_bd_net [get_bd_pins RISCV_PROCESSOR_0/m00_axi_init_axi_txn] [get_bd_pins RISCV_PROCESSOR_0/MEIP]
connect_bd_net [get_bd_pins RISCV_PROCESSOR_0/MSIP] [get_bd_pins RISCV_PROCESSOR_0/m00_axi_init_axi_txn]
connect_bd_net [get_bd_pins RISCV_PROCESSOR_0/m01_axi_init_axi_txn] [get_bd_pins RISCV_PROCESSOR_0/m00_axi_init_axi_txn]
connect_bd_net [get_bd_pins RISCV_PROCESSOR_0/peripheral_interface_init_axi_txn] [get_bd_pins RISCV_PROCESSOR_0/m00_axi_init_axi_txn]
connect_bd_net [get_bd_pins RISCV_PROCESSOR_0/m00_axi_aresetn] [get_bd_pins axi_gpio_0/gpio_io_o]
connect_bd_net [get_bd_pins RISCV_PROCESSOR_0/peripheral_interface_aresetn] [get_bd_pins axi_gpio_0/gpio_io_o]
connect_bd_net [get_bd_pins RISCV_PROCESSOR_0/MTIP] [get_bd_pins RISCV_PROCESSOR_0/m00_axi_init_axi_txn]
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0
endgroup
connect_bd_net [get_bd_pins xlconstant_0/dout] [get_bd_pins RISCV_PROCESSOR_0/m00_axi_init_axi_txn]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {Auto} Clk_slave {Auto} Clk_xbar {Auto} Master {/RISCV_PROCESSOR_0/peripheral_interface} Slave {/processing_system7_0/S_AXI_GP0} intc_ip {Auto} master_apm {0}}  [get_bd_intf_pins processing_system7_0/S_AXI_GP0]
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0
endgroup
set_property -dict [list CONFIG.NUM_SI {2} CONFIG.NUM_MI {1}] [get_bd_cells axi_interconnect_0]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins axi_interconnect_0/M00_AXI] [get_bd_intf_pins processing_system7_0/S_AXI_HP0]
startgroup
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config {Clk "/processing_system7_0/FCLK_CLK0 (40 MHz)" }  [get_bd_pins processing_system7_0/S_AXI_HP0_ACLK]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {/processing_system7_0/FCLK_CLK0 (40 MHz)} Clk_slave {Auto} Clk_xbar {Auto} Master {/RISCV_PROCESSOR_0/m00_axi} Slave {/processing_system7_0/S_AXI_HP0} intc_ip {/axi_interconnect_0} master_apm {0}}  [get_bd_intf_pins RISCV_PROCESSOR_0/m00_axi]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {/processing_system7_0/FCLK_CLK0 (40 MHz)} Clk_slave {Auto} Clk_xbar {Auto} Master {/RISCV_PROCESSOR_0/m01_axi} Slave {/processing_system7_0/S_AXI_HP0} intc_ip {/axi_interconnect_0} master_apm {0}}  [get_bd_intf_pins RISCV_PROCESSOR_0/m01_axi]
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config {Clk "/processing_system7_0/FCLK_CLK0 (40 MHz)" }  [get_bd_pins RISCV_PROCESSOR_0/m00_axi_aclk]
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config {Clk "/processing_system7_0/FCLK_CLK0 (40 MHz)" }  [get_bd_pins RISCV_PROCESSOR_0/m01_axi_aclk]
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config {Clk "/processing_system7_0/FCLK_CLK0 (40 MHz)" }  [get_bd_pins RISCV_PROCESSOR_0/peripheral_interface_aclk]
endgroup
regenerate_bd_layout -routing
set_property offset 0x20000000 [get_bd_addr_segs {RISCV_PROCESSOR_0/m00_axi/SEG_processing_system7_0_HP0_DDR_LOWOCM}]
set_property offset 0x20000000 [get_bd_addr_segs {RISCV_PROCESSOR_0/m01_axi/SEG_processing_system7_0_HP0_DDR_LOWOCM}]
set_property offset 0x20000000 [get_bd_addr_segs {RISCV_PROCESSOR_0/peripheral_interface/SEG_processing_system7_0_GP0_DDR_LOWOCM}]
save_bd_design
regenerate_bd_layout
disconnect_bd_net /rst_ps7_0_100M_peripheral_aresetn [get_bd_pins RISCV_PROCESSOR_0/m01_axi_aresetn]
connect_bd_net [get_bd_pins RISCV_PROCESSOR_0/m01_axi_aresetn] [get_bd_pins axi_gpio_0/gpio_io_o]
update_compile_order -fileset sources_1
startgroup
set_property -dict [list CONFIG.CONST_VAL {0}] [get_bd_cells xlconstant_0]
endgroup
startgroup
set_property -dict [list CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100.000000}] [get_bd_cells processing_system7_0]
endgroup
save_bd_design
make_wrapper -files [get_files ./soc/riscv_soc.srcs/sources_1/bd/risv_soc/risv_soc.bd] -top
add_files -norecurse ./soc/riscv_soc.srcs/sources_1/bd/risv_soc/hdl/risv_soc_wrapper.v
launch_runs impl_1 -to_step write_bitstream -jobs 6
wait_on_run impl_1
file mkdir ./soc/riscv_soc.sdk
file copy -force ./soc/riscv_soc.runs/impl_1/risv_soc_wrapper.sysdef ./soc/riscv_soc.sdk/risv_soc_wrapper.hdf
launch_sdk -workspace ./soc/riscv_soc.sdk -hwspec ./soc/riscv_soc.sdk/risv_soc_wrapper.hdf
