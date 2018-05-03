connect -url tcp:127.0.0.1:3121
source /home/userfs/m/ms1516/w2k/embs_open2/particle_sim_lab/particle_sim_lab.sdk/design_1_wrapper_hw_platform_0/ps7_init.tcl
targets -set -filter {name =~"APU" && jtag_cable_name =~ "Digilent Zybo 210279759725A"} -index 0
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Digilent Zybo 210279759725A" && level==0} -index 1
fpga -file /home/userfs/m/ms1516/w2k/embs_open2/particle_sim_lab/particle_sim_lab.sdk/design_1_wrapper_hw_platform_0/design_1_wrapper.bit
targets -set -filter {name =~"APU" && jtag_cable_name =~ "Digilent Zybo 210279759725A"} -index 0
loadhw /home/userfs/m/ms1516/w2k/embs_open2/particle_sim_lab/particle_sim_lab.sdk/design_1_wrapper_hw_platform_0/system.hdf
targets -set -filter {name =~"APU" && jtag_cable_name =~ "Digilent Zybo 210279759725A"} -index 0
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Digilent Zybo 210279759725A"} -index 0
dow /home/userfs/m/ms1516/w2k/embs_open2/particle_sim_lab/particle_sim_lab.sdk/particle_sim/Debug/particle_sim.elf
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Digilent Zybo 210279759725A"} -index 0
con
