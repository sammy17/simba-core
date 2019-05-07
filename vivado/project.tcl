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
start_gui
create_project riscv . -part xc7z010iclg400-1L
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
add_files -fileset sim_1 -norecurse ../data_hex.txt
update_compile_order -fileset sources_1
export_ip_user_files -of_objects  [get_files ../axi_interconnect_v1_7_vl_rfs.v] -no_script -reset -force -quiet
remove_files  -fileset sim_1 ../axi_interconnect_v1_7_vl_rfs.v
set_property file_type SystemVerilog [get_files  ../src/simulation/TEST_RISCV_PROCESSOR.v]
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse ../axi_interconnect_v1_7_vl_rfs.v
update_compile_order -fileset sim_1
