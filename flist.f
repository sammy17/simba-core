-y $XILINX_VIVADO/data/verilog/src/unisims
-y $XILINX_VIVADO/data/verilog/src/unimacro
-y $XILINX_VIVADO/data/verilog/src/retarget
-v $XILINX_VIVADO/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv
+incdir+$XILINX_VIVADO/data/verilog/src +libext+.v
$XILINX_VIVADO/data/verilog/src/glbl.v
./src/design/common/Multiplexer.v
./src/design/common/RISCV_PROCESSOR.v
./src/design/common/peripheral_master.v
./src/design/m_standard/Division.v
./src/design/m_standard/Multiplication.v
./src/design/m_standard/RV32M.v
./src/design/newcache/Dcache.v
./src/design/newcache/cache.v
./src/design/newcache/memory.v
./src/design/newcache/myip_v1_0_M00_AXI.v
./src/design/newcache/myip_v1_0_S00_AXI.v
./src/design/newcache/state_mem.v
./src/design/pipeline/BHT.v
./src/design/pipeline/CONTROL_UNIT.v
./src/design/pipeline/CSR_FILE.v
./src/design/pipeline/DECODE_UNIT.v
./src/design/pipeline/EXSTAGE.v
./src/design/pipeline/IMM_EXT.v
./src/design/pipeline/INS_TYPE_ROM.v
./src/design/pipeline/PIPELINE.v
//./src/design/pipeline/Peripheral.v
./src/design/pipeline/REG_ARRAY.v
./src/design/pipeline/STATE_REG.v
./src/simulation/TEST_RISCV_PROCESSOR.v
./src/design/newcache/myip_slave_lite.v
./src/design/tlb/DTLB.v
./src/design/tlb/ITLB.v
./src/design/m_standard/mul_top.v
./src/design/wrapper/PERIPHERAL_INTERFACE.v
./axi_interconnect_0.v  
./axi_interconnect_v1_7_vl_rfs.v
./fifo_generator_v13_2_rfs.v
