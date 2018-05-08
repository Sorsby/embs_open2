#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
# 

if [ -z "$PATH" ]; then
  PATH=/opt/york/cs/net/xilinx_vivado-2016.2_ise-14.7_x86-64-1/SDK/2016.2/bin:/opt/york/cs/net/xilinx_vivado-2016.2_ise-14.7_x86-64-1/Vivado/2016.2/ids_lite/ISE/bin/lin64:/opt/york/cs/net/xilinx_vivado-2016.2_ise-14.7_x86-64-1/Vivado/2016.2/bin
else
  PATH=/opt/york/cs/net/xilinx_vivado-2016.2_ise-14.7_x86-64-1/SDK/2016.2/bin:/opt/york/cs/net/xilinx_vivado-2016.2_ise-14.7_x86-64-1/Vivado/2016.2/ids_lite/ISE/bin/lin64:/opt/york/cs/net/xilinx_vivado-2016.2_ise-14.7_x86-64-1/Vivado/2016.2/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=/opt/york/cs/net/xilinx_vivado-2016.2_ise-14.7_x86-64-1/Vivado/2016.2/ids_lite/ISE/lib/lin64
else
  LD_LIBRARY_PATH=/opt/york/cs/net/xilinx_vivado-2016.2_ise-14.7_x86-64-1/Vivado/2016.2/ids_lite/ISE/lib/lin64:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='/home/userfs/m/ms1516/w2k/embs_open2/particle_sim_lab/particle_sim_lab.runs/impl_1'
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

# pre-commands:
/bin/touch .write_bitstream.begin.rst
EAStep vivado -log design_1_wrapper.vdi -applog -m64 -messageDb vivado.pb -mode batch -source design_1_wrapper.tcl -notrace


