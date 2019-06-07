all: clean vcs
vcs:
	vcs -full64 -top glbl -top Test_RISCV_PROCESSOR -f flist.f -sverilog +incdir+./src/design/common +incdir+./src/design/newcache  -fgp -debug_access+all -kdb -lca -l vcs.log +define+SIM  -j4; ./simv -fgp=num_cores:8 -fgp=num_fsdb_threads:1 -fgp=sync:busywait -l run.log 
vcs_xprop:
	vcs -full64 -top glbl -top Test_RISCV_PROCESSOR -f flist.f -sverilog +incdir+./src/design/common +incdir+./src/design/newcache -fgp -debug_access+all +vcs+fsdbon+mda -kdb -lca -l vcs.log -xprop=xprop.config; ./simv -fgp:numcores=10 -l run.log 
vcs1:
	vcs -full64 -f flist.f -sverilog +incdir+./src/design/common +incdir+./src/design/newcache -fgp; ./simv -fgp:numcores=10  
clean:
	rm -rf coverage.vdb csrc DVEfiles inter.vpd simv* simv.daidir ucli.key vc_hdrs.h vcs.log .inter.vpd.uvm  novas* run.log *.vpd nWaveLog BSS* urg* verdiLog comp.log
hawk: hawk1	hawk2
hawk1:
	vcs -full64 -Xhwcosimtest=v2hx -Xzebu_opt=enable_hwtop_ports -Xhdl_cosim_dut Test_RISCV_PROCESSOR.uut\
	+incdir+./src/design/common +incdir+./src/design/newcache  -f flist.f -o ./simv_hawk -Mdir=csrc_hawk -sverilog -debug_access+all
hawk2:
	$(VCS_HOME)/bin/hcs -simv simv_hawk -fsdb
