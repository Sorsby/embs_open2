
################################################################
# This is a generated script based on design: design_1
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2016.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source design_1_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7z010clg400-1
   set_property BOARD_PART digilentinc.com:zybo:part0:1.0 [current_project]
}


# CHANGE DESIGN NAME HERE
set design_name design_1

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: vga
proc create_hier_cell_vga { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" create_hier_cell_vga() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_LITE
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 ctrl
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s00_axi

  # Create pins
  create_bd_pin -dir I -from 0 -to 0 -type rst ARESETN
  create_bd_pin -dir I -from 0 -to 0 -type rst S00_ARESETN
  create_bd_pin -dir I -type clk m_axi_mm2s_aclk
  create_bd_pin -dir O -from 4 -to 0 vga_blue
  create_bd_pin -dir O -from 5 -to 0 vga_green
  create_bd_pin -dir O vga_hsync
  create_bd_pin -dir O -from 4 -to 0 vga_red
  create_bd_pin -dir O vga_vsync

  # Create instance: axi_dynclk_0, and set properties
  set axi_dynclk_0 [ create_bd_cell -type ip -vlnv digilentinc.com:ip:axi_dynclk:1.0 axi_dynclk_0 ]

  # Create instance: axi_mem_intercon, and set properties
  set axi_mem_intercon [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_mem_intercon ]
  set_property -dict [ list \
CONFIG.NUM_MI {1} \
 ] $axi_mem_intercon

  # Create instance: axi_vdma_0, and set properties
  set axi_vdma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma:6.2 axi_vdma_0 ]
  set_property -dict [ list \
CONFIG.c_include_s2mm {0} \
CONFIG.c_m_axi_mm2s_data_width {64} \
CONFIG.c_m_axis_mm2s_tdata_width {32} \
CONFIG.c_mm2s_genlock_mode {0} \
CONFIG.c_mm2s_linebuffer_depth {4096} \
CONFIG.c_mm2s_max_burst_length {32} \
CONFIG.c_num_fstores {2} \
CONFIG.c_s2mm_genlock_mode {0} \
 ] $axi_vdma_0

  # Create instance: rgb2vga_0, and set properties
  set rgb2vga_0 [ create_bd_cell -type ip -vlnv digilentinc.com:ip:rgb2vga:1.0 rgb2vga_0 ]

  # Create instance: v_axi4s_vid_out_0, and set properties
  set v_axi4s_vid_out_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_axi4s_vid_out:4.0 v_axi4s_vid_out_0 ]
  set_property -dict [ list \
CONFIG.C_ADDR_WIDTH {5} \
CONFIG.C_S_AXIS_VIDEO_DATA_WIDTH {8} \
CONFIG.C_S_AXIS_VIDEO_FORMAT {2} \
CONFIG.C_VTG_MASTER_SLAVE {1} \
 ] $v_axi4s_vid_out_0

  # Create instance: v_tc_0, and set properties
  set v_tc_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_tc:6.1 v_tc_0 ]
  set_property -dict [ list \
CONFIG.enable_detection {false} \
 ] $v_tc_0

  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0 ]
  set_property -dict [ list \
CONFIG.DIN_FROM {23} \
CONFIG.DOUT_WIDTH {24} \
 ] $xlslice_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins M00_AXI] [get_bd_intf_pins axi_mem_intercon/M00_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins s00_axi] [get_bd_intf_pins axi_dynclk_0/s00_axi]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins S_AXI_LITE] [get_bd_intf_pins axi_vdma_0/S_AXI_LITE]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins ctrl] [get_bd_intf_pins v_tc_0/ctrl]
  connect_bd_intf_net -intf_net axi_vdma_0_M_AXI_MM2S [get_bd_intf_pins axi_mem_intercon/S00_AXI] [get_bd_intf_pins axi_vdma_0/M_AXI_MM2S]
  connect_bd_intf_net -intf_net v_axi4s_vid_out_0_vid_io_out [get_bd_intf_pins rgb2vga_0/vid_in] [get_bd_intf_pins v_axi4s_vid_out_0/vid_io_out]
  connect_bd_intf_net -intf_net v_tc_0_vtiming_out [get_bd_intf_pins v_axi4s_vid_out_0/vtiming_in] [get_bd_intf_pins v_tc_0/vtiming_out]

  # Create port connections
  connect_bd_net -net ARESETN_1 [get_bd_pins ARESETN] [get_bd_pins axi_mem_intercon/ARESETN]
  connect_bd_net -net S00_ARESETN_1 [get_bd_pins S00_ARESETN] [get_bd_pins axi_dynclk_0/s00_axi_aresetn] [get_bd_pins axi_mem_intercon/M00_ARESETN] [get_bd_pins axi_mem_intercon/S00_ARESETN] [get_bd_pins axi_vdma_0/axi_resetn] [get_bd_pins v_tc_0/s_axi_aresetn]
  connect_bd_net -net axi_dynclk_0_PXL_CLK_O [get_bd_pins axi_dynclk_0/PXL_CLK_O] [get_bd_pins axi_vdma_0/m_axis_mm2s_aclk] [get_bd_pins rgb2vga_0/PixelClk] [get_bd_pins v_axi4s_vid_out_0/aclk] [get_bd_pins v_tc_0/clk]
  connect_bd_net -net axi_vdma_0_m_axis_mm2s_tdata [get_bd_pins axi_vdma_0/m_axis_mm2s_tdata] [get_bd_pins xlslice_0/Din]
  connect_bd_net -net axi_vdma_0_m_axis_mm2s_tlast [get_bd_pins axi_vdma_0/m_axis_mm2s_tlast] [get_bd_pins v_axi4s_vid_out_0/s_axis_video_tlast]
  connect_bd_net -net axi_vdma_0_m_axis_mm2s_tuser [get_bd_pins axi_vdma_0/m_axis_mm2s_tuser] [get_bd_pins v_axi4s_vid_out_0/s_axis_video_tuser]
  connect_bd_net -net axi_vdma_0_m_axis_mm2s_tvalid [get_bd_pins axi_vdma_0/m_axis_mm2s_tvalid] [get_bd_pins v_axi4s_vid_out_0/s_axis_video_tvalid]
  connect_bd_net -net m_axi_mm2s_aclk_1 [get_bd_pins m_axi_mm2s_aclk] [get_bd_pins axi_dynclk_0/REF_CLK_I] [get_bd_pins axi_dynclk_0/s00_axi_aclk] [get_bd_pins axi_mem_intercon/ACLK] [get_bd_pins axi_mem_intercon/M00_ACLK] [get_bd_pins axi_mem_intercon/S00_ACLK] [get_bd_pins axi_vdma_0/m_axi_mm2s_aclk] [get_bd_pins axi_vdma_0/s_axi_lite_aclk] [get_bd_pins v_tc_0/s_axi_aclk]
  connect_bd_net -net rgb2vga_0_vga_pBlue [get_bd_pins vga_blue] [get_bd_pins rgb2vga_0/vga_pBlue]
  connect_bd_net -net rgb2vga_0_vga_pGreen [get_bd_pins vga_green] [get_bd_pins rgb2vga_0/vga_pGreen]
  connect_bd_net -net rgb2vga_0_vga_pHSync [get_bd_pins vga_hsync] [get_bd_pins rgb2vga_0/vga_pHSync]
  connect_bd_net -net rgb2vga_0_vga_pRed [get_bd_pins vga_red] [get_bd_pins rgb2vga_0/vga_pRed]
  connect_bd_net -net rgb2vga_0_vga_pVSync [get_bd_pins vga_vsync] [get_bd_pins rgb2vga_0/vga_pVSync]
  connect_bd_net -net v_axi4s_vid_out_0_s_axis_video_tready [get_bd_pins axi_vdma_0/m_axis_mm2s_tready] [get_bd_pins v_axi4s_vid_out_0/s_axis_video_tready]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins v_axi4s_vid_out_0/s_axis_video_tdata] [get_bd_pins xlslice_0/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set DDR [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR ]
  set FIXED_IO [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO ]

  # Create ports
  set vga_blue [ create_bd_port -dir O -from 4 -to 0 vga_blue ]
  set vga_green [ create_bd_port -dir O -from 5 -to 0 vga_green ]
  set vga_hsync [ create_bd_port -dir O vga_hsync ]
  set vga_red [ create_bd_port -dir O -from 4 -to 0 vga_red ]
  set vga_vsync [ create_bd_port -dir O vga_vsync ]

  # Create instance: processing_system7_0, and set properties
  set processing_system7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0 ]
  set_property -dict [ list \
CONFIG.PCW_ACT_APU_PERIPHERAL_FREQMHZ {650.000000} \
CONFIG.PCW_ACT_CAN_PERIPHERAL_FREQMHZ {10.000000} \
CONFIG.PCW_ACT_DCI_PERIPHERAL_FREQMHZ {10.096154} \
CONFIG.PCW_ACT_ENET0_PERIPHERAL_FREQMHZ {125.000000} \
CONFIG.PCW_ACT_ENET1_PERIPHERAL_FREQMHZ {10.000000} \
CONFIG.PCW_ACT_FPGA0_PERIPHERAL_FREQMHZ {100.000000} \
CONFIG.PCW_ACT_FPGA1_PERIPHERAL_FREQMHZ {10.000000} \
CONFIG.PCW_ACT_FPGA2_PERIPHERAL_FREQMHZ {10.000000} \
CONFIG.PCW_ACT_FPGA3_PERIPHERAL_FREQMHZ {10.000000} \
CONFIG.PCW_ACT_PCAP_PERIPHERAL_FREQMHZ {200.000000} \
CONFIG.PCW_ACT_QSPI_PERIPHERAL_FREQMHZ {200.000000} \
CONFIG.PCW_ACT_SDIO_PERIPHERAL_FREQMHZ {50.000000} \
CONFIG.PCW_ACT_SMC_PERIPHERAL_FREQMHZ {10.000000} \
CONFIG.PCW_ACT_SPI_PERIPHERAL_FREQMHZ {10.000000} \
CONFIG.PCW_ACT_TPIU_PERIPHERAL_FREQMHZ {200.000000} \
CONFIG.PCW_ACT_TTC0_CLK0_PERIPHERAL_FREQMHZ {108.333336} \
CONFIG.PCW_ACT_TTC0_CLK1_PERIPHERAL_FREQMHZ {108.333336} \
CONFIG.PCW_ACT_TTC0_CLK2_PERIPHERAL_FREQMHZ {108.333336} \
CONFIG.PCW_ACT_TTC1_CLK0_PERIPHERAL_FREQMHZ {108.333336} \
CONFIG.PCW_ACT_TTC1_CLK1_PERIPHERAL_FREQMHZ {108.333336} \
CONFIG.PCW_ACT_TTC1_CLK2_PERIPHERAL_FREQMHZ {108.333336} \
CONFIG.PCW_ACT_UART_PERIPHERAL_FREQMHZ {100.000000} \
CONFIG.PCW_ACT_WDT_PERIPHERAL_FREQMHZ {108.333336} \
CONFIG.PCW_APU_CLK_RATIO_ENABLE {6:2:1} \
CONFIG.PCW_APU_PERIPHERAL_FREQMHZ {650} \
CONFIG.PCW_ARMPLL_CTRL_FBDIV {26} \
CONFIG.PCW_CAN0_CAN0_IO {<Select>} \
CONFIG.PCW_CAN0_GRP_CLK_ENABLE {0} \
CONFIG.PCW_CAN0_GRP_CLK_IO {<Select>} \
CONFIG.PCW_CAN0_PERIPHERAL_CLKSRC {External} \
CONFIG.PCW_CAN0_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_CAN1_CAN1_IO {<Select>} \
CONFIG.PCW_CAN1_GRP_CLK_ENABLE {0} \
CONFIG.PCW_CAN1_GRP_CLK_IO {<Select>} \
CONFIG.PCW_CAN1_PERIPHERAL_CLKSRC {External} \
CONFIG.PCW_CAN1_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_CAN_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_CAN_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_CAN_PERIPHERAL_DIVISOR1 {1} \
CONFIG.PCW_CAN_PERIPHERAL_FREQMHZ {100} \
CONFIG.PCW_CLK0_FREQ {100000000} \
CONFIG.PCW_CLK1_FREQ {10000000} \
CONFIG.PCW_CLK2_FREQ {10000000} \
CONFIG.PCW_CLK3_FREQ {10000000} \
CONFIG.PCW_CPU_CPU_6X4X_MAX_RANGE {667} \
CONFIG.PCW_CPU_CPU_PLL_FREQMHZ {1300.000} \
CONFIG.PCW_CPU_PERIPHERAL_CLKSRC {ARM PLL} \
CONFIG.PCW_CPU_PERIPHERAL_DIVISOR0 {2} \
CONFIG.PCW_CRYSTAL_PERIPHERAL_FREQMHZ {50.000000} \
CONFIG.PCW_DCI_PERIPHERAL_CLKSRC {DDR PLL} \
CONFIG.PCW_DCI_PERIPHERAL_DIVISOR0 {52} \
CONFIG.PCW_DCI_PERIPHERAL_DIVISOR1 {2} \
CONFIG.PCW_DCI_PERIPHERAL_FREQMHZ {10.159} \
CONFIG.PCW_DDRPLL_CTRL_FBDIV {21} \
CONFIG.PCW_DDR_DDR_PLL_FREQMHZ {1050.000} \
CONFIG.PCW_DDR_HPRLPR_QUEUE_PARTITION {HPR(0)/LPR(32)} \
CONFIG.PCW_DDR_HPR_TO_CRITICAL_PRIORITY_LEVEL {15} \
CONFIG.PCW_DDR_LPR_TO_CRITICAL_PRIORITY_LEVEL {2} \
CONFIG.PCW_DDR_PERIPHERAL_CLKSRC {DDR PLL} \
CONFIG.PCW_DDR_PERIPHERAL_DIVISOR0 {2} \
CONFIG.PCW_DDR_PORT0_HPR_ENABLE {0} \
CONFIG.PCW_DDR_PORT1_HPR_ENABLE {0} \
CONFIG.PCW_DDR_PORT2_HPR_ENABLE {0} \
CONFIG.PCW_DDR_PORT3_HPR_ENABLE {0} \
CONFIG.PCW_DDR_PRIORITY_READPORT_0 {<Select>} \
CONFIG.PCW_DDR_PRIORITY_READPORT_1 {<Select>} \
CONFIG.PCW_DDR_PRIORITY_READPORT_2 {<Select>} \
CONFIG.PCW_DDR_PRIORITY_READPORT_3 {<Select>} \
CONFIG.PCW_DDR_PRIORITY_WRITEPORT_0 {<Select>} \
CONFIG.PCW_DDR_PRIORITY_WRITEPORT_1 {<Select>} \
CONFIG.PCW_DDR_PRIORITY_WRITEPORT_2 {<Select>} \
CONFIG.PCW_DDR_PRIORITY_WRITEPORT_3 {<Select>} \
CONFIG.PCW_DDR_RAM_HIGHADDR {0x1FFFFFFF} \
CONFIG.PCW_DDR_WRITE_TO_CRITICAL_PRIORITY_LEVEL {2} \
CONFIG.PCW_ENET0_ENET0_IO {MIO 16 .. 27} \
CONFIG.PCW_ENET0_GRP_MDIO_ENABLE {1} \
CONFIG.PCW_ENET0_GRP_MDIO_IO {MIO 52 .. 53} \
CONFIG.PCW_ENET0_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_ENET0_PERIPHERAL_DIVISOR0 {8} \
CONFIG.PCW_ENET0_PERIPHERAL_DIVISOR1 {1} \
CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_ENET0_PERIPHERAL_FREQMHZ {1000 Mbps} \
CONFIG.PCW_ENET0_RESET_ENABLE {0} \
CONFIG.PCW_ENET0_RESET_IO {<Select>} \
CONFIG.PCW_ENET1_ENET1_IO {<Select>} \
CONFIG.PCW_ENET1_GRP_MDIO_ENABLE {0} \
CONFIG.PCW_ENET1_GRP_MDIO_IO {<Select>} \
CONFIG.PCW_ENET1_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_ENET1_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_ENET1_PERIPHERAL_DIVISOR1 {1} \
CONFIG.PCW_ENET1_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_ENET1_PERIPHERAL_FREQMHZ {1000 Mbps} \
CONFIG.PCW_ENET1_RESET_ENABLE {0} \
CONFIG.PCW_ENET1_RESET_IO {<Select>} \
CONFIG.PCW_ENET_RESET_ENABLE {0} \
CONFIG.PCW_ENET_RESET_POLARITY {Active Low} \
CONFIG.PCW_ENET_RESET_SELECT {<Select>} \
CONFIG.PCW_EN_4K_TIMER {0} \
CONFIG.PCW_EN_EMIO_TTC0 {1} \
CONFIG.PCW_EN_EMIO_WP_SDIO0 {1} \
CONFIG.PCW_EN_ENET0 {1} \
CONFIG.PCW_EN_QSPI {1} \
CONFIG.PCW_EN_SDIO0 {1} \
CONFIG.PCW_EN_TTC0 {1} \
CONFIG.PCW_EN_UART1 {1} \
CONFIG.PCW_EN_USB0 {1} \
CONFIG.PCW_FCLK0_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_FCLK0_PERIPHERAL_DIVISOR0 {5} \
CONFIG.PCW_FCLK0_PERIPHERAL_DIVISOR1 {2} \
CONFIG.PCW_FCLK1_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_FCLK1_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_FCLK1_PERIPHERAL_DIVISOR1 {1} \
CONFIG.PCW_FCLK2_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_FCLK2_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_FCLK2_PERIPHERAL_DIVISOR1 {1} \
CONFIG.PCW_FCLK3_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_FCLK3_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_FCLK3_PERIPHERAL_DIVISOR1 {1} \
CONFIG.PCW_FCLK_CLK0_BUF {true} \
CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100} \
CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {50} \
CONFIG.PCW_FPGA2_PERIPHERAL_FREQMHZ {50} \
CONFIG.PCW_FPGA3_PERIPHERAL_FREQMHZ {50} \
CONFIG.PCW_FPGA_FCLK0_ENABLE {1} \
CONFIG.PCW_GPIO_EMIO_GPIO_ENABLE {0} \
CONFIG.PCW_GPIO_EMIO_GPIO_IO {<Select>} \
CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {1} \
CONFIG.PCW_GPIO_MIO_GPIO_IO {MIO} \
CONFIG.PCW_GPIO_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_I2C0_GRP_INT_ENABLE {0} \
CONFIG.PCW_I2C0_GRP_INT_IO {<Select>} \
CONFIG.PCW_I2C0_I2C0_IO {<Select>} \
CONFIG.PCW_I2C0_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_I2C0_RESET_ENABLE {0} \
CONFIG.PCW_I2C0_RESET_IO {<Select>} \
CONFIG.PCW_I2C1_GRP_INT_ENABLE {0} \
CONFIG.PCW_I2C1_GRP_INT_IO {<Select>} \
CONFIG.PCW_I2C1_I2C1_IO {<Select>} \
CONFIG.PCW_I2C1_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_I2C1_RESET_ENABLE {0} \
CONFIG.PCW_I2C1_RESET_IO {<Select>} \
CONFIG.PCW_I2C_PERIPHERAL_FREQMHZ {25} \
CONFIG.PCW_I2C_RESET_ENABLE {0} \
CONFIG.PCW_I2C_RESET_POLARITY {Active Low} \
CONFIG.PCW_I2C_RESET_SELECT {<Select>} \
CONFIG.PCW_IOPLL_CTRL_FBDIV {20} \
CONFIG.PCW_IO_IO_PLL_FREQMHZ {1000.000} \
CONFIG.PCW_MIO_0_DIRECTION {inout} \
CONFIG.PCW_MIO_0_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_0_PULLUP {enabled} \
CONFIG.PCW_MIO_0_SLEW {slow} \
CONFIG.PCW_MIO_10_DIRECTION {inout} \
CONFIG.PCW_MIO_10_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_10_PULLUP {enabled} \
CONFIG.PCW_MIO_10_SLEW {slow} \
CONFIG.PCW_MIO_11_DIRECTION {inout} \
CONFIG.PCW_MIO_11_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_11_PULLUP {enabled} \
CONFIG.PCW_MIO_11_SLEW {slow} \
CONFIG.PCW_MIO_12_DIRECTION {inout} \
CONFIG.PCW_MIO_12_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_12_PULLUP {enabled} \
CONFIG.PCW_MIO_12_SLEW {slow} \
CONFIG.PCW_MIO_13_DIRECTION {inout} \
CONFIG.PCW_MIO_13_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_13_PULLUP {enabled} \
CONFIG.PCW_MIO_13_SLEW {slow} \
CONFIG.PCW_MIO_14_DIRECTION {inout} \
CONFIG.PCW_MIO_14_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_14_PULLUP {enabled} \
CONFIG.PCW_MIO_14_SLEW {slow} \
CONFIG.PCW_MIO_15_DIRECTION {inout} \
CONFIG.PCW_MIO_15_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_15_PULLUP {enabled} \
CONFIG.PCW_MIO_15_SLEW {slow} \
CONFIG.PCW_MIO_16_DIRECTION {out} \
CONFIG.PCW_MIO_16_IOTYPE {HSTL 1.8V} \
CONFIG.PCW_MIO_16_PULLUP {disabled} \
CONFIG.PCW_MIO_16_SLEW {fast} \
CONFIG.PCW_MIO_17_DIRECTION {out} \
CONFIG.PCW_MIO_17_IOTYPE {HSTL 1.8V} \
CONFIG.PCW_MIO_17_PULLUP {disabled} \
CONFIG.PCW_MIO_17_SLEW {fast} \
CONFIG.PCW_MIO_18_DIRECTION {out} \
CONFIG.PCW_MIO_18_IOTYPE {HSTL 1.8V} \
CONFIG.PCW_MIO_18_PULLUP {disabled} \
CONFIG.PCW_MIO_18_SLEW {fast} \
CONFIG.PCW_MIO_19_DIRECTION {out} \
CONFIG.PCW_MIO_19_IOTYPE {HSTL 1.8V} \
CONFIG.PCW_MIO_19_PULLUP {disabled} \
CONFIG.PCW_MIO_19_SLEW {fast} \
CONFIG.PCW_MIO_1_DIRECTION {out} \
CONFIG.PCW_MIO_1_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_1_PULLUP {disabled} \
CONFIG.PCW_MIO_1_SLEW {fast} \
CONFIG.PCW_MIO_20_DIRECTION {out} \
CONFIG.PCW_MIO_20_IOTYPE {HSTL 1.8V} \
CONFIG.PCW_MIO_20_PULLUP {disabled} \
CONFIG.PCW_MIO_20_SLEW {fast} \
CONFIG.PCW_MIO_21_DIRECTION {out} \
CONFIG.PCW_MIO_21_IOTYPE {HSTL 1.8V} \
CONFIG.PCW_MIO_21_PULLUP {disabled} \
CONFIG.PCW_MIO_21_SLEW {fast} \
CONFIG.PCW_MIO_22_DIRECTION {in} \
CONFIG.PCW_MIO_22_IOTYPE {HSTL 1.8V} \
CONFIG.PCW_MIO_22_PULLUP {disabled} \
CONFIG.PCW_MIO_22_SLEW {fast} \
CONFIG.PCW_MIO_23_DIRECTION {in} \
CONFIG.PCW_MIO_23_IOTYPE {HSTL 1.8V} \
CONFIG.PCW_MIO_23_PULLUP {disabled} \
CONFIG.PCW_MIO_23_SLEW {fast} \
CONFIG.PCW_MIO_24_DIRECTION {in} \
CONFIG.PCW_MIO_24_IOTYPE {HSTL 1.8V} \
CONFIG.PCW_MIO_24_PULLUP {disabled} \
CONFIG.PCW_MIO_24_SLEW {fast} \
CONFIG.PCW_MIO_25_DIRECTION {in} \
CONFIG.PCW_MIO_25_IOTYPE {HSTL 1.8V} \
CONFIG.PCW_MIO_25_PULLUP {disabled} \
CONFIG.PCW_MIO_25_SLEW {fast} \
CONFIG.PCW_MIO_26_DIRECTION {in} \
CONFIG.PCW_MIO_26_IOTYPE {HSTL 1.8V} \
CONFIG.PCW_MIO_26_PULLUP {disabled} \
CONFIG.PCW_MIO_26_SLEW {fast} \
CONFIG.PCW_MIO_27_DIRECTION {in} \
CONFIG.PCW_MIO_27_IOTYPE {HSTL 1.8V} \
CONFIG.PCW_MIO_27_PULLUP {disabled} \
CONFIG.PCW_MIO_27_SLEW {fast} \
CONFIG.PCW_MIO_28_DIRECTION {inout} \
CONFIG.PCW_MIO_28_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_28_PULLUP {disabled} \
CONFIG.PCW_MIO_28_SLEW {fast} \
CONFIG.PCW_MIO_29_DIRECTION {in} \
CONFIG.PCW_MIO_29_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_29_PULLUP {disabled} \
CONFIG.PCW_MIO_29_SLEW {fast} \
CONFIG.PCW_MIO_2_DIRECTION {inout} \
CONFIG.PCW_MIO_2_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_2_PULLUP {disabled} \
CONFIG.PCW_MIO_2_SLEW {fast} \
CONFIG.PCW_MIO_30_DIRECTION {out} \
CONFIG.PCW_MIO_30_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_30_PULLUP {disabled} \
CONFIG.PCW_MIO_30_SLEW {fast} \
CONFIG.PCW_MIO_31_DIRECTION {in} \
CONFIG.PCW_MIO_31_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_31_PULLUP {disabled} \
CONFIG.PCW_MIO_31_SLEW {fast} \
CONFIG.PCW_MIO_32_DIRECTION {inout} \
CONFIG.PCW_MIO_32_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_32_PULLUP {disabled} \
CONFIG.PCW_MIO_32_SLEW {fast} \
CONFIG.PCW_MIO_33_DIRECTION {inout} \
CONFIG.PCW_MIO_33_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_33_PULLUP {disabled} \
CONFIG.PCW_MIO_33_SLEW {fast} \
CONFIG.PCW_MIO_34_DIRECTION {inout} \
CONFIG.PCW_MIO_34_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_34_PULLUP {disabled} \
CONFIG.PCW_MIO_34_SLEW {fast} \
CONFIG.PCW_MIO_35_DIRECTION {inout} \
CONFIG.PCW_MIO_35_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_35_PULLUP {disabled} \
CONFIG.PCW_MIO_35_SLEW {fast} \
CONFIG.PCW_MIO_36_DIRECTION {in} \
CONFIG.PCW_MIO_36_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_36_PULLUP {disabled} \
CONFIG.PCW_MIO_36_SLEW {fast} \
CONFIG.PCW_MIO_37_DIRECTION {inout} \
CONFIG.PCW_MIO_37_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_37_PULLUP {disabled} \
CONFIG.PCW_MIO_37_SLEW {fast} \
CONFIG.PCW_MIO_38_DIRECTION {inout} \
CONFIG.PCW_MIO_38_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_38_PULLUP {disabled} \
CONFIG.PCW_MIO_38_SLEW {fast} \
CONFIG.PCW_MIO_39_DIRECTION {inout} \
CONFIG.PCW_MIO_39_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_39_PULLUP {disabled} \
CONFIG.PCW_MIO_39_SLEW {fast} \
CONFIG.PCW_MIO_3_DIRECTION {inout} \
CONFIG.PCW_MIO_3_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_3_PULLUP {disabled} \
CONFIG.PCW_MIO_3_SLEW {fast} \
CONFIG.PCW_MIO_40_DIRECTION {inout} \
CONFIG.PCW_MIO_40_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_40_PULLUP {disabled} \
CONFIG.PCW_MIO_40_SLEW {fast} \
CONFIG.PCW_MIO_41_DIRECTION {inout} \
CONFIG.PCW_MIO_41_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_41_PULLUP {disabled} \
CONFIG.PCW_MIO_41_SLEW {fast} \
CONFIG.PCW_MIO_42_DIRECTION {inout} \
CONFIG.PCW_MIO_42_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_42_PULLUP {disabled} \
CONFIG.PCW_MIO_42_SLEW {fast} \
CONFIG.PCW_MIO_43_DIRECTION {inout} \
CONFIG.PCW_MIO_43_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_43_PULLUP {disabled} \
CONFIG.PCW_MIO_43_SLEW {fast} \
CONFIG.PCW_MIO_44_DIRECTION {inout} \
CONFIG.PCW_MIO_44_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_44_PULLUP {disabled} \
CONFIG.PCW_MIO_44_SLEW {fast} \
CONFIG.PCW_MIO_45_DIRECTION {inout} \
CONFIG.PCW_MIO_45_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_45_PULLUP {disabled} \
CONFIG.PCW_MIO_45_SLEW {fast} \
CONFIG.PCW_MIO_46_DIRECTION {inout} \
CONFIG.PCW_MIO_46_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_46_PULLUP {enabled} \
CONFIG.PCW_MIO_46_SLEW {slow} \
CONFIG.PCW_MIO_47_DIRECTION {in} \
CONFIG.PCW_MIO_47_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_47_PULLUP {disabled} \
CONFIG.PCW_MIO_47_SLEW {slow} \
CONFIG.PCW_MIO_48_DIRECTION {out} \
CONFIG.PCW_MIO_48_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_48_PULLUP {disabled} \
CONFIG.PCW_MIO_48_SLEW {slow} \
CONFIG.PCW_MIO_49_DIRECTION {in} \
CONFIG.PCW_MIO_49_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_49_PULLUP {disabled} \
CONFIG.PCW_MIO_49_SLEW {slow} \
CONFIG.PCW_MIO_4_DIRECTION {inout} \
CONFIG.PCW_MIO_4_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_4_PULLUP {disabled} \
CONFIG.PCW_MIO_4_SLEW {fast} \
CONFIG.PCW_MIO_50_DIRECTION {inout} \
CONFIG.PCW_MIO_50_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_50_PULLUP {disabled} \
CONFIG.PCW_MIO_50_SLEW {slow} \
CONFIG.PCW_MIO_51_DIRECTION {inout} \
CONFIG.PCW_MIO_51_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_51_PULLUP {disabled} \
CONFIG.PCW_MIO_51_SLEW {slow} \
CONFIG.PCW_MIO_52_DIRECTION {out} \
CONFIG.PCW_MIO_52_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_52_PULLUP {disabled} \
CONFIG.PCW_MIO_52_SLEW {slow} \
CONFIG.PCW_MIO_53_DIRECTION {inout} \
CONFIG.PCW_MIO_53_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_53_PULLUP {disabled} \
CONFIG.PCW_MIO_53_SLEW {slow} \
CONFIG.PCW_MIO_5_DIRECTION {inout} \
CONFIG.PCW_MIO_5_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_5_PULLUP {disabled} \
CONFIG.PCW_MIO_5_SLEW {fast} \
CONFIG.PCW_MIO_6_DIRECTION {out} \
CONFIG.PCW_MIO_6_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_6_PULLUP {disabled} \
CONFIG.PCW_MIO_6_SLEW {fast} \
CONFIG.PCW_MIO_7_DIRECTION {out} \
CONFIG.PCW_MIO_7_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_7_PULLUP {disabled} \
CONFIG.PCW_MIO_7_SLEW {slow} \
CONFIG.PCW_MIO_8_DIRECTION {out} \
CONFIG.PCW_MIO_8_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_8_PULLUP {disabled} \
CONFIG.PCW_MIO_8_SLEW {fast} \
CONFIG.PCW_MIO_9_DIRECTION {inout} \
CONFIG.PCW_MIO_9_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_9_PULLUP {enabled} \
CONFIG.PCW_MIO_9_SLEW {slow} \
CONFIG.PCW_MIO_TREE_PERIPHERALS {GPIO#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#GPIO#Quad SPI Flash#GPIO#GPIO#GPIO#GPIO#GPIO#GPIO#GPIO#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#SD 0#SD 0#SD 0#SD 0#SD 0#SD 0#GPIO#SD 0#UART 1#UART 1#GPIO#GPIO#Enet 0#Enet 0} \
CONFIG.PCW_MIO_TREE_SIGNALS {gpio[0]#qspi0_ss_b#qspi0_io[0]#qspi0_io[1]#qspi0_io[2]#qspi0_io[3]#qspi0_sclk#gpio[7]#qspi_fbclk#gpio[9]#gpio[10]#gpio[11]#gpio[12]#gpio[13]#gpio[14]#gpio[15]#tx_clk#txd[0]#txd[1]#txd[2]#txd[3]#tx_ctl#rx_clk#rxd[0]#rxd[1]#rxd[2]#rxd[3]#rx_ctl#data[4]#dir#stp#nxt#data[0]#data[1]#data[2]#data[3]#clk#data[5]#data[6]#data[7]#clk#cmd#data[0]#data[1]#data[2]#data[3]#gpio[46]#cd#tx#rx#gpio[50]#gpio[51]#mdc#mdio} \
CONFIG.PCW_NAND_CYCLES_T_AR {1} \
CONFIG.PCW_NAND_CYCLES_T_CLR {1} \
CONFIG.PCW_NAND_CYCLES_T_RC {11} \
CONFIG.PCW_NAND_CYCLES_T_REA {1} \
CONFIG.PCW_NAND_CYCLES_T_RR {1} \
CONFIG.PCW_NAND_CYCLES_T_WC {11} \
CONFIG.PCW_NAND_CYCLES_T_WP {1} \
CONFIG.PCW_NAND_GRP_D8_ENABLE {0} \
CONFIG.PCW_NAND_GRP_D8_IO {<Select>} \
CONFIG.PCW_NAND_NAND_IO {<Select>} \
CONFIG.PCW_NAND_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_NOR_CS0_T_CEOE {1} \
CONFIG.PCW_NOR_CS0_T_PC {1} \
CONFIG.PCW_NOR_CS0_T_RC {11} \
CONFIG.PCW_NOR_CS0_T_TR {1} \
CONFIG.PCW_NOR_CS0_T_WC {11} \
CONFIG.PCW_NOR_CS0_T_WP {1} \
CONFIG.PCW_NOR_CS0_WE_TIME {0} \
CONFIG.PCW_NOR_CS1_T_CEOE {1} \
CONFIG.PCW_NOR_CS1_T_PC {1} \
CONFIG.PCW_NOR_CS1_T_RC {11} \
CONFIG.PCW_NOR_CS1_T_TR {1} \
CONFIG.PCW_NOR_CS1_T_WC {11} \
CONFIG.PCW_NOR_CS1_T_WP {1} \
CONFIG.PCW_NOR_CS1_WE_TIME {0} \
CONFIG.PCW_NOR_GRP_A25_ENABLE {0} \
CONFIG.PCW_NOR_GRP_A25_IO {<Select>} \
CONFIG.PCW_NOR_GRP_CS0_ENABLE {0} \
CONFIG.PCW_NOR_GRP_CS0_IO {<Select>} \
CONFIG.PCW_NOR_GRP_CS1_ENABLE {0} \
CONFIG.PCW_NOR_GRP_CS1_IO {<Select>} \
CONFIG.PCW_NOR_GRP_SRAM_CS0_ENABLE {0} \
CONFIG.PCW_NOR_GRP_SRAM_CS0_IO {<Select>} \
CONFIG.PCW_NOR_GRP_SRAM_CS1_ENABLE {0} \
CONFIG.PCW_NOR_GRP_SRAM_CS1_IO {<Select>} \
CONFIG.PCW_NOR_GRP_SRAM_INT_ENABLE {0} \
CONFIG.PCW_NOR_GRP_SRAM_INT_IO {<Select>} \
CONFIG.PCW_NOR_NOR_IO {<Select>} \
CONFIG.PCW_NOR_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_NOR_SRAM_CS0_T_CEOE {1} \
CONFIG.PCW_NOR_SRAM_CS0_T_PC {1} \
CONFIG.PCW_NOR_SRAM_CS0_T_RC {11} \
CONFIG.PCW_NOR_SRAM_CS0_T_TR {1} \
CONFIG.PCW_NOR_SRAM_CS0_T_WC {11} \
CONFIG.PCW_NOR_SRAM_CS0_T_WP {1} \
CONFIG.PCW_NOR_SRAM_CS0_WE_TIME {0} \
CONFIG.PCW_NOR_SRAM_CS1_T_CEOE {1} \
CONFIG.PCW_NOR_SRAM_CS1_T_PC {1} \
CONFIG.PCW_NOR_SRAM_CS1_T_RC {11} \
CONFIG.PCW_NOR_SRAM_CS1_T_TR {1} \
CONFIG.PCW_NOR_SRAM_CS1_T_WC {11} \
CONFIG.PCW_NOR_SRAM_CS1_T_WP {1} \
CONFIG.PCW_NOR_SRAM_CS1_WE_TIME {0} \
CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY0 {0.080} \
CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY1 {0.063} \
CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY2 {0.057} \
CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY3 {0.068} \
CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_0 {-0.047} \
CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_1 {-0.025} \
CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_2 {-0.006} \
CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_3 {-0.017} \
CONFIG.PCW_PACKAGE_NAME {clg400} \
CONFIG.PCW_PCAP_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_PCAP_PERIPHERAL_DIVISOR0 {5} \
CONFIG.PCW_PCAP_PERIPHERAL_FREQMHZ {200} \
CONFIG.PCW_PERIPHERAL_BOARD_PRESET {part0} \
CONFIG.PCW_PJTAG_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_PJTAG_PJTAG_IO {<Select>} \
CONFIG.PCW_PLL_BYPASSMODE_ENABLE {0} \
CONFIG.PCW_PRESET_BANK0_VOLTAGE {LVCMOS 3.3V} \
CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 1.8V} \
CONFIG.PCW_QSPI_GRP_FBCLK_ENABLE {1} \
CONFIG.PCW_QSPI_GRP_FBCLK_IO {MIO 8} \
CONFIG.PCW_QSPI_GRP_IO1_ENABLE {0} \
CONFIG.PCW_QSPI_GRP_IO1_IO {<Select>} \
CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {1} \
CONFIG.PCW_QSPI_GRP_SINGLE_SS_IO {MIO 1 .. 6} \
CONFIG.PCW_QSPI_GRP_SS1_ENABLE {0} \
CONFIG.PCW_QSPI_GRP_SS1_IO {<Select>} \
CONFIG.PCW_QSPI_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_QSPI_PERIPHERAL_DIVISOR0 {5} \
CONFIG.PCW_QSPI_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_QSPI_PERIPHERAL_FREQMHZ {200} \
CONFIG.PCW_QSPI_QSPI_IO {MIO 1 .. 6} \
CONFIG.PCW_SD0_GRP_CD_ENABLE {1} \
CONFIG.PCW_SD0_GRP_CD_IO {MIO 47} \
CONFIG.PCW_SD0_GRP_POW_ENABLE {0} \
CONFIG.PCW_SD0_GRP_POW_IO {<Select>} \
CONFIG.PCW_SD0_GRP_WP_ENABLE {1} \
CONFIG.PCW_SD0_GRP_WP_IO {EMIO} \
CONFIG.PCW_SD0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_SD0_SD0_IO {MIO 40 .. 45} \
CONFIG.PCW_SD1_GRP_CD_ENABLE {0} \
CONFIG.PCW_SD1_GRP_CD_IO {<Select>} \
CONFIG.PCW_SD1_GRP_POW_ENABLE {0} \
CONFIG.PCW_SD1_GRP_POW_IO {<Select>} \
CONFIG.PCW_SD1_GRP_WP_ENABLE {0} \
CONFIG.PCW_SD1_GRP_WP_IO {<Select>} \
CONFIG.PCW_SD1_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_SD1_SD1_IO {<Select>} \
CONFIG.PCW_SDIO_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_SDIO_PERIPHERAL_DIVISOR0 {20} \
CONFIG.PCW_SDIO_PERIPHERAL_FREQMHZ {50} \
CONFIG.PCW_SDIO_PERIPHERAL_VALID {1} \
CONFIG.PCW_SMC_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_SMC_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_SMC_PERIPHERAL_FREQMHZ {100} \
CONFIG.PCW_SPI0_GRP_SS0_ENABLE {0} \
CONFIG.PCW_SPI0_GRP_SS0_IO {<Select>} \
CONFIG.PCW_SPI0_GRP_SS1_ENABLE {0} \
CONFIG.PCW_SPI0_GRP_SS1_IO {<Select>} \
CONFIG.PCW_SPI0_GRP_SS2_ENABLE {0} \
CONFIG.PCW_SPI0_GRP_SS2_IO {<Select>} \
CONFIG.PCW_SPI0_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_SPI0_SPI0_IO {<Select>} \
CONFIG.PCW_SPI1_GRP_SS0_ENABLE {0} \
CONFIG.PCW_SPI1_GRP_SS0_IO {<Select>} \
CONFIG.PCW_SPI1_GRP_SS1_ENABLE {0} \
CONFIG.PCW_SPI1_GRP_SS1_IO {<Select>} \
CONFIG.PCW_SPI1_GRP_SS2_ENABLE {0} \
CONFIG.PCW_SPI1_GRP_SS2_IO {<Select>} \
CONFIG.PCW_SPI1_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_SPI1_SPI1_IO {<Select>} \
CONFIG.PCW_SPI_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_SPI_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_SPI_PERIPHERAL_FREQMHZ {166.666666} \
CONFIG.PCW_S_AXI_HP0_DATA_WIDTH {64} \
CONFIG.PCW_S_AXI_HP1_DATA_WIDTH {64} \
CONFIG.PCW_S_AXI_HP2_DATA_WIDTH {64} \
CONFIG.PCW_S_AXI_HP3_DATA_WIDTH {64} \
CONFIG.PCW_TPIU_PERIPHERAL_CLKSRC {External} \
CONFIG.PCW_TPIU_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_TPIU_PERIPHERAL_FREQMHZ {200} \
CONFIG.PCW_TRACE_GRP_16BIT_ENABLE {0} \
CONFIG.PCW_TRACE_GRP_16BIT_IO {<Select>} \
CONFIG.PCW_TRACE_GRP_2BIT_ENABLE {0} \
CONFIG.PCW_TRACE_GRP_2BIT_IO {<Select>} \
CONFIG.PCW_TRACE_GRP_32BIT_ENABLE {0} \
CONFIG.PCW_TRACE_GRP_32BIT_IO {<Select>} \
CONFIG.PCW_TRACE_GRP_4BIT_ENABLE {0} \
CONFIG.PCW_TRACE_GRP_4BIT_IO {<Select>} \
CONFIG.PCW_TRACE_GRP_8BIT_ENABLE {0} \
CONFIG.PCW_TRACE_GRP_8BIT_IO {<Select>} \
CONFIG.PCW_TRACE_INTERNAL_WIDTH {2} \
CONFIG.PCW_TRACE_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_TRACE_TRACE_IO {<Select>} \
CONFIG.PCW_TTC0_CLK0_PERIPHERAL_CLKSRC {CPU_1X} \
CONFIG.PCW_TTC0_CLK0_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_TTC0_CLK0_PERIPHERAL_FREQMHZ {133.333333} \
CONFIG.PCW_TTC0_CLK1_PERIPHERAL_CLKSRC {CPU_1X} \
CONFIG.PCW_TTC0_CLK1_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_TTC0_CLK1_PERIPHERAL_FREQMHZ {133.333333} \
CONFIG.PCW_TTC0_CLK2_PERIPHERAL_CLKSRC {CPU_1X} \
CONFIG.PCW_TTC0_CLK2_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_TTC0_CLK2_PERIPHERAL_FREQMHZ {133.333333} \
CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_TTC0_TTC0_IO {EMIO} \
CONFIG.PCW_TTC1_CLK0_PERIPHERAL_CLKSRC {CPU_1X} \
CONFIG.PCW_TTC1_CLK0_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_TTC1_CLK0_PERIPHERAL_FREQMHZ {133.333333} \
CONFIG.PCW_TTC1_CLK1_PERIPHERAL_CLKSRC {CPU_1X} \
CONFIG.PCW_TTC1_CLK1_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_TTC1_CLK1_PERIPHERAL_FREQMHZ {133.333333} \
CONFIG.PCW_TTC1_CLK2_PERIPHERAL_CLKSRC {CPU_1X} \
CONFIG.PCW_TTC1_CLK2_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_TTC1_CLK2_PERIPHERAL_FREQMHZ {133.333333} \
CONFIG.PCW_TTC1_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_TTC1_TTC1_IO {<Select>} \
CONFIG.PCW_TTC_PERIPHERAL_FREQMHZ {50} \
CONFIG.PCW_UART0_BAUD_RATE {115200} \
CONFIG.PCW_UART0_GRP_FULL_ENABLE {0} \
CONFIG.PCW_UART0_GRP_FULL_IO {<Select>} \
CONFIG.PCW_UART0_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_UART0_UART0_IO {<Select>} \
CONFIG.PCW_UART1_BAUD_RATE {115200} \
CONFIG.PCW_UART1_GRP_FULL_ENABLE {0} \
CONFIG.PCW_UART1_GRP_FULL_IO {<Select>} \
CONFIG.PCW_UART1_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_UART1_UART1_IO {MIO 48 .. 49} \
CONFIG.PCW_UART_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_UART_PERIPHERAL_DIVISOR0 {10} \
CONFIG.PCW_UART_PERIPHERAL_FREQMHZ {100} \
CONFIG.PCW_UART_PERIPHERAL_VALID {1} \
CONFIG.PCW_UIPARAM_ACT_DDR_FREQ_MHZ {525.000000} \
CONFIG.PCW_UIPARAM_DDR_ADV_ENABLE {0} \
CONFIG.PCW_UIPARAM_DDR_AL {0} \
CONFIG.PCW_UIPARAM_DDR_BANK_ADDR_COUNT {3} \
CONFIG.PCW_UIPARAM_DDR_BL {8} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY0 {0.176} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY1 {0.159} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY2 {0.162} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY3 {0.187} \
CONFIG.PCW_UIPARAM_DDR_BUS_WIDTH {32 Bit} \
CONFIG.PCW_UIPARAM_DDR_CL {7} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_0_LENGTH_MM {0} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_0_PACKAGE_LENGTH {54.563} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_0_PROPOGATION_DELAY {160} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_1_LENGTH_MM {0} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_1_PACKAGE_LENGTH {54.563} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_1_PROPOGATION_DELAY {160} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_2_LENGTH_MM {0} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_2_PACKAGE_LENGTH {54.563} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_2_PROPOGATION_DELAY {160} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_3_LENGTH_MM {0} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_3_PACKAGE_LENGTH {54.563} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_3_PROPOGATION_DELAY {160} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_STOP_EN {0} \
CONFIG.PCW_UIPARAM_DDR_COL_ADDR_COUNT {10} \
CONFIG.PCW_UIPARAM_DDR_CWL {6} \
CONFIG.PCW_UIPARAM_DDR_DEVICE_CAPACITY {2048 MBits} \
CONFIG.PCW_UIPARAM_DDR_DQS_0_LENGTH_MM {0} \
CONFIG.PCW_UIPARAM_DDR_DQS_0_PACKAGE_LENGTH {101.239} \
CONFIG.PCW_UIPARAM_DDR_DQS_0_PROPOGATION_DELAY {160} \
CONFIG.PCW_UIPARAM_DDR_DQS_1_LENGTH_MM {0} \
CONFIG.PCW_UIPARAM_DDR_DQS_1_PACKAGE_LENGTH {79.5025} \
CONFIG.PCW_UIPARAM_DDR_DQS_1_PROPOGATION_DELAY {160} \
CONFIG.PCW_UIPARAM_DDR_DQS_2_LENGTH_MM {0} \
CONFIG.PCW_UIPARAM_DDR_DQS_2_PACKAGE_LENGTH {60.536} \
CONFIG.PCW_UIPARAM_DDR_DQS_2_PROPOGATION_DELAY {160} \
CONFIG.PCW_UIPARAM_DDR_DQS_3_LENGTH_MM {0} \
CONFIG.PCW_UIPARAM_DDR_DQS_3_PACKAGE_LENGTH {71.7715} \
CONFIG.PCW_UIPARAM_DDR_DQS_3_PROPOGATION_DELAY {160} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_0 {-0.073} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_1 {-0.034} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_2 {-0.03} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_3 {-0.082} \
CONFIG.PCW_UIPARAM_DDR_DQ_0_LENGTH_MM {0} \
CONFIG.PCW_UIPARAM_DDR_DQ_0_PACKAGE_LENGTH {104.5365} \
CONFIG.PCW_UIPARAM_DDR_DQ_0_PROPOGATION_DELAY {160} \
CONFIG.PCW_UIPARAM_DDR_DQ_1_LENGTH_MM {0} \
CONFIG.PCW_UIPARAM_DDR_DQ_1_PACKAGE_LENGTH {70.676} \
CONFIG.PCW_UIPARAM_DDR_DQ_1_PROPOGATION_DELAY {160} \
CONFIG.PCW_UIPARAM_DDR_DQ_2_LENGTH_MM {0} \
CONFIG.PCW_UIPARAM_DDR_DQ_2_PACKAGE_LENGTH {59.1615} \
CONFIG.PCW_UIPARAM_DDR_DQ_2_PROPOGATION_DELAY {160} \
CONFIG.PCW_UIPARAM_DDR_DQ_3_LENGTH_MM {0} \
CONFIG.PCW_UIPARAM_DDR_DQ_3_PACKAGE_LENGTH {81.319} \
CONFIG.PCW_UIPARAM_DDR_DQ_3_PROPOGATION_DELAY {160} \
CONFIG.PCW_UIPARAM_DDR_DRAM_WIDTH {16 Bits} \
CONFIG.PCW_UIPARAM_DDR_ECC {Disabled} \
CONFIG.PCW_UIPARAM_DDR_ENABLE {1} \
CONFIG.PCW_UIPARAM_DDR_FREQ_MHZ {525} \
CONFIG.PCW_UIPARAM_DDR_HIGH_TEMP {Normal (0-85)} \
CONFIG.PCW_UIPARAM_DDR_MEMORY_TYPE {DDR 3} \
CONFIG.PCW_UIPARAM_DDR_PARTNO {MT41K128M16 JT-125} \
CONFIG.PCW_UIPARAM_DDR_ROW_ADDR_COUNT {14} \
CONFIG.PCW_UIPARAM_DDR_SPEED_BIN {DDR3_1066F} \
CONFIG.PCW_UIPARAM_DDR_TRAIN_DATA_EYE {1} \
CONFIG.PCW_UIPARAM_DDR_TRAIN_READ_GATE {1} \
CONFIG.PCW_UIPARAM_DDR_TRAIN_WRITE_LEVEL {1} \
CONFIG.PCW_UIPARAM_DDR_T_FAW {40.0} \
CONFIG.PCW_UIPARAM_DDR_T_RAS_MIN {35.0} \
CONFIG.PCW_UIPARAM_DDR_T_RC {48.75} \
CONFIG.PCW_UIPARAM_DDR_T_RCD {7} \
CONFIG.PCW_UIPARAM_DDR_T_RP {7} \
CONFIG.PCW_UIPARAM_DDR_USE_INTERNAL_VREF {0} \
CONFIG.PCW_USB0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_USB0_PERIPHERAL_FREQMHZ {60} \
CONFIG.PCW_USB0_RESET_ENABLE {0} \
CONFIG.PCW_USB0_RESET_IO {<Select>} \
CONFIG.PCW_USB0_USB0_IO {MIO 28 .. 39} \
CONFIG.PCW_USB1_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_USB1_PERIPHERAL_FREQMHZ {60} \
CONFIG.PCW_USB1_RESET_ENABLE {0} \
CONFIG.PCW_USB1_RESET_IO {<Select>} \
CONFIG.PCW_USB1_USB1_IO {<Select>} \
CONFIG.PCW_USB_RESET_ENABLE {0} \
CONFIG.PCW_USB_RESET_POLARITY {Active Low} \
CONFIG.PCW_USB_RESET_SELECT {<Select>} \
CONFIG.PCW_USE_CROSS_TRIGGER {0} \
CONFIG.PCW_USE_S_AXI_HP1 {1} \
CONFIG.PCW_WDT_PERIPHERAL_CLKSRC {CPU_1X} \
CONFIG.PCW_WDT_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_WDT_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_WDT_PERIPHERAL_FREQMHZ {133.333333} \
CONFIG.PCW_WDT_WDT_IO {<Select>} \
 ] $processing_system7_0

  # Need to retain value_src of defaults
  set_property -dict [ list \
CONFIG.PCW_ACT_APU_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ACT_CAN_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ACT_DCI_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ACT_ENET0_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ACT_ENET1_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ACT_FPGA0_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ACT_FPGA1_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ACT_FPGA2_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ACT_FPGA3_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ACT_PCAP_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ACT_QSPI_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ACT_SDIO_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ACT_SMC_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ACT_SPI_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ACT_TPIU_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ACT_TTC0_CLK0_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ACT_TTC0_CLK1_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ACT_TTC0_CLK2_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ACT_TTC1_CLK0_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ACT_TTC1_CLK1_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ACT_TTC1_CLK2_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ACT_UART_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ACT_WDT_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_APU_CLK_RATIO_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ARMPLL_CTRL_FBDIV.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CAN0_CAN0_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CAN0_GRP_CLK_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CAN0_GRP_CLK_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CAN0_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CAN0_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CAN1_CAN1_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CAN1_GRP_CLK_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CAN1_GRP_CLK_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CAN1_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CAN1_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CAN_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CAN_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CAN_PERIPHERAL_DIVISOR1.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CAN_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CLK0_FREQ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CLK1_FREQ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CLK2_FREQ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CLK3_FREQ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CPU_CPU_6X4X_MAX_RANGE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CPU_CPU_PLL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CPU_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CPU_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DCI_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DCI_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DCI_PERIPHERAL_DIVISOR1.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DCI_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDRPLL_CTRL_FBDIV.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_DDR_PLL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_HPRLPR_QUEUE_PARTITION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_HPR_TO_CRITICAL_PRIORITY_LEVEL.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_LPR_TO_CRITICAL_PRIORITY_LEVEL.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_PORT0_HPR_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_PORT1_HPR_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_PORT2_HPR_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_PORT3_HPR_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_PRIORITY_READPORT_0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_PRIORITY_READPORT_1.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_PRIORITY_READPORT_2.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_PRIORITY_READPORT_3.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_PRIORITY_WRITEPORT_0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_PRIORITY_WRITEPORT_1.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_PRIORITY_WRITEPORT_2.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_PRIORITY_WRITEPORT_3.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_RAM_HIGHADDR.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_WRITE_TO_CRITICAL_PRIORITY_LEVEL.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET0_GRP_MDIO_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET0_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET0_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET0_PERIPHERAL_DIVISOR1.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET0_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET0_RESET_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET1_ENET1_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET1_GRP_MDIO_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET1_GRP_MDIO_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET1_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET1_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET1_PERIPHERAL_DIVISOR1.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET1_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET1_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET1_RESET_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET1_RESET_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET_RESET_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET_RESET_POLARITY.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET_RESET_SELECT.VALUE_SRC {DEFAULT} \
CONFIG.PCW_EN_4K_TIMER.VALUE_SRC {DEFAULT} \
CONFIG.PCW_EN_EMIO_TTC0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_EN_EMIO_WP_SDIO0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_EN_ENET0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_EN_QSPI.VALUE_SRC {DEFAULT} \
CONFIG.PCW_EN_SDIO0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_EN_TTC0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_EN_UART1.VALUE_SRC {DEFAULT} \
CONFIG.PCW_EN_USB0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_FCLK0_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_FCLK0_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_FCLK0_PERIPHERAL_DIVISOR1.VALUE_SRC {DEFAULT} \
CONFIG.PCW_FCLK1_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_FCLK1_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_FCLK1_PERIPHERAL_DIVISOR1.VALUE_SRC {DEFAULT} \
CONFIG.PCW_FCLK2_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_FCLK2_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_FCLK2_PERIPHERAL_DIVISOR1.VALUE_SRC {DEFAULT} \
CONFIG.PCW_FCLK3_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_FCLK3_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_FCLK3_PERIPHERAL_DIVISOR1.VALUE_SRC {DEFAULT} \
CONFIG.PCW_FCLK_CLK0_BUF.VALUE_SRC {DEFAULT} \
CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_FPGA2_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_FPGA3_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_FPGA_FCLK0_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_GPIO_EMIO_GPIO_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_GPIO_EMIO_GPIO_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_GPIO_MIO_GPIO_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_GPIO_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_I2C0_GRP_INT_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_I2C0_GRP_INT_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_I2C0_I2C0_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_I2C0_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_I2C0_RESET_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_I2C0_RESET_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_I2C1_GRP_INT_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_I2C1_GRP_INT_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_I2C1_I2C1_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_I2C1_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_I2C1_RESET_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_I2C1_RESET_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_I2C_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_I2C_RESET_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_I2C_RESET_POLARITY.VALUE_SRC {DEFAULT} \
CONFIG.PCW_I2C_RESET_SELECT.VALUE_SRC {DEFAULT} \
CONFIG.PCW_IOPLL_CTRL_FBDIV.VALUE_SRC {DEFAULT} \
CONFIG.PCW_IO_IO_PLL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_0_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_0_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_0_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_10_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_10_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_10_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_11_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_11_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_11_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_12_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_12_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_12_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_13_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_13_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_13_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_13_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_14_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_14_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_14_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_14_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_15_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_15_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_15_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_15_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_16_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_17_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_18_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_19_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_1_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_1_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_20_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_21_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_22_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_23_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_24_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_25_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_26_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_27_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_28_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_28_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_29_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_29_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_2_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_2_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_2_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_30_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_30_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_31_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_31_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_32_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_32_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_33_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_33_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_34_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_34_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_35_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_35_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_36_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_36_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_37_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_37_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_38_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_38_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_39_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_39_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_3_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_3_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_3_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_40_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_40_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_41_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_41_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_42_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_42_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_43_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_43_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_44_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_44_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_45_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_45_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_46_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_46_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_46_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_46_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_47_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_47_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_47_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_48_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_48_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_48_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_49_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_49_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_49_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_4_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_4_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_4_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_50_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_50_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_51_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_51_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_52_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_52_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_53_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_53_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_5_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_5_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_5_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_6_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_6_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_6_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_7_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_7_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_7_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_7_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_8_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_8_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_8_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_9_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_9_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_9_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_TREE_PERIPHERALS.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_TREE_SIGNALS.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NAND_CYCLES_T_AR.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NAND_CYCLES_T_CLR.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NAND_CYCLES_T_RC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NAND_CYCLES_T_REA.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NAND_CYCLES_T_RR.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NAND_CYCLES_T_WC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NAND_CYCLES_T_WP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NAND_GRP_D8_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NAND_GRP_D8_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NAND_NAND_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NAND_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_CS0_T_CEOE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_CS0_T_PC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_CS0_T_RC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_CS0_T_TR.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_CS0_T_WC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_CS0_T_WP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_CS0_WE_TIME.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_CS1_T_CEOE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_CS1_T_PC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_CS1_T_RC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_CS1_T_TR.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_CS1_T_WC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_CS1_T_WP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_CS1_WE_TIME.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_GRP_A25_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_GRP_A25_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_GRP_CS0_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_GRP_CS0_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_GRP_CS1_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_GRP_CS1_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_GRP_SRAM_CS0_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_GRP_SRAM_CS0_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_GRP_SRAM_CS1_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_GRP_SRAM_CS1_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_GRP_SRAM_INT_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_GRP_SRAM_INT_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_NOR_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_SRAM_CS0_T_CEOE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_SRAM_CS0_T_PC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_SRAM_CS0_T_RC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_SRAM_CS0_T_TR.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_SRAM_CS0_T_WC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_SRAM_CS0_T_WP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_SRAM_CS0_WE_TIME.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_SRAM_CS1_T_CEOE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_SRAM_CS1_T_PC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_SRAM_CS1_T_RC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_SRAM_CS1_T_TR.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_SRAM_CS1_T_WC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_SRAM_CS1_T_WP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_SRAM_CS1_WE_TIME.VALUE_SRC {DEFAULT} \
CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY1.VALUE_SRC {DEFAULT} \
CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY2.VALUE_SRC {DEFAULT} \
CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY3.VALUE_SRC {DEFAULT} \
CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_1.VALUE_SRC {DEFAULT} \
CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_2.VALUE_SRC {DEFAULT} \
CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_3.VALUE_SRC {DEFAULT} \
CONFIG.PCW_PACKAGE_NAME.VALUE_SRC {DEFAULT} \
CONFIG.PCW_PCAP_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_PCAP_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_PCAP_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_PERIPHERAL_BOARD_PRESET.VALUE_SRC {DEFAULT} \
CONFIG.PCW_PJTAG_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_PJTAG_PJTAG_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_PLL_BYPASSMODE_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_PRESET_BANK0_VOLTAGE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_QSPI_GRP_FBCLK_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_QSPI_GRP_IO1_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_QSPI_GRP_IO1_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_QSPI_GRP_SINGLE_SS_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_QSPI_GRP_SS1_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_QSPI_GRP_SS1_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_QSPI_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_QSPI_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_QSPI_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_QSPI_QSPI_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SD0_GRP_POW_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SD0_GRP_POW_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SD0_GRP_WP_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SD0_SD0_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SD1_GRP_CD_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SD1_GRP_CD_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SD1_GRP_POW_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SD1_GRP_POW_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SD1_GRP_WP_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SD1_GRP_WP_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SD1_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SD1_SD1_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SDIO_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SDIO_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SDIO_PERIPHERAL_VALID.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SMC_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SMC_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SMC_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI0_GRP_SS0_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI0_GRP_SS0_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI0_GRP_SS1_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI0_GRP_SS1_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI0_GRP_SS2_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI0_GRP_SS2_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI0_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI0_SPI0_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI1_GRP_SS0_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI1_GRP_SS0_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI1_GRP_SS1_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI1_GRP_SS1_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI1_GRP_SS2_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI1_GRP_SS2_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI1_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI1_SPI1_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_S_AXI_HP0_DATA_WIDTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_S_AXI_HP1_DATA_WIDTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_S_AXI_HP2_DATA_WIDTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_S_AXI_HP3_DATA_WIDTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TPIU_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TPIU_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TPIU_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TRACE_GRP_16BIT_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TRACE_GRP_16BIT_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TRACE_GRP_2BIT_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TRACE_GRP_2BIT_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TRACE_GRP_32BIT_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TRACE_GRP_32BIT_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TRACE_GRP_4BIT_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TRACE_GRP_4BIT_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TRACE_GRP_8BIT_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TRACE_GRP_8BIT_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TRACE_INTERNAL_WIDTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TRACE_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TRACE_TRACE_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC0_CLK0_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC0_CLK0_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC0_CLK0_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC0_CLK1_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC0_CLK1_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC0_CLK1_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC0_CLK2_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC0_CLK2_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC0_CLK2_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC0_TTC0_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC1_CLK0_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC1_CLK0_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC1_CLK0_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC1_CLK1_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC1_CLK1_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC1_CLK1_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC1_CLK2_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC1_CLK2_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC1_CLK2_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC1_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC1_TTC1_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UART0_BAUD_RATE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UART0_GRP_FULL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UART0_GRP_FULL_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UART0_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UART0_UART0_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UART1_BAUD_RATE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UART1_GRP_FULL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UART1_GRP_FULL_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UART1_UART1_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UART_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UART_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UART_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UART_PERIPHERAL_VALID.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_ACT_DDR_FREQ_MHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_ADV_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_AL.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_BANK_ADDR_COUNT.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_BL.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_BUS_WIDTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_CL.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_0_LENGTH_MM.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_0_PACKAGE_LENGTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_0_PROPOGATION_DELAY.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_1_LENGTH_MM.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_1_PACKAGE_LENGTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_1_PROPOGATION_DELAY.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_2_LENGTH_MM.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_2_PACKAGE_LENGTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_2_PROPOGATION_DELAY.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_3_LENGTH_MM.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_3_PACKAGE_LENGTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_3_PROPOGATION_DELAY.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_STOP_EN.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_COL_ADDR_COUNT.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_CWL.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DEVICE_CAPACITY.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQS_0_LENGTH_MM.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQS_0_PACKAGE_LENGTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQS_0_PROPOGATION_DELAY.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQS_1_LENGTH_MM.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQS_1_PACKAGE_LENGTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQS_1_PROPOGATION_DELAY.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQS_2_LENGTH_MM.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQS_2_PACKAGE_LENGTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQS_2_PROPOGATION_DELAY.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQS_3_LENGTH_MM.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQS_3_PACKAGE_LENGTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQS_3_PROPOGATION_DELAY.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQ_0_LENGTH_MM.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQ_0_PACKAGE_LENGTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQ_0_PROPOGATION_DELAY.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQ_1_LENGTH_MM.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQ_1_PACKAGE_LENGTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQ_1_PROPOGATION_DELAY.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQ_2_LENGTH_MM.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQ_2_PACKAGE_LENGTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQ_2_PROPOGATION_DELAY.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQ_3_LENGTH_MM.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQ_3_PACKAGE_LENGTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQ_3_PROPOGATION_DELAY.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DRAM_WIDTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_ECC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_HIGH_TEMP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_MEMORY_TYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_ROW_ADDR_COUNT.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_SPEED_BIN.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_T_FAW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_T_RAS_MIN.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_T_RC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_T_RCD.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_T_RP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_USE_INTERNAL_VREF.VALUE_SRC {DEFAULT} \
CONFIG.PCW_USB0_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_USB0_USB0_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_USB1_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_USB1_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_USB1_RESET_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_USB1_RESET_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_USB1_USB1_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_USB_RESET_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_USB_RESET_POLARITY.VALUE_SRC {DEFAULT} \
CONFIG.PCW_USB_RESET_SELECT.VALUE_SRC {DEFAULT} \
CONFIG.PCW_USE_CROSS_TRIGGER.VALUE_SRC {DEFAULT} \
CONFIG.PCW_WDT_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_WDT_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_WDT_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_WDT_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_WDT_WDT_IO.VALUE_SRC {DEFAULT} \
 ] $processing_system7_0

  # Create instance: processing_system7_0_axi_periph, and set properties
  set processing_system7_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 processing_system7_0_axi_periph ]
  set_property -dict [ list \
CONFIG.NUM_MI {3} \
 ] $processing_system7_0_axi_periph

  # Create instance: rst_processing_system7_0_50M, and set properties
  set rst_processing_system7_0_50M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_processing_system7_0_50M ]

  # Create instance: vga
  create_hier_cell_vga [current_bd_instance .] vga

  # Create interface connections
  connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_ports DDR] [get_bd_intf_pins processing_system7_0/DDR]
  connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins processing_system7_0/FIXED_IO]
  connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP0 [get_bd_intf_pins processing_system7_0/M_AXI_GP0] [get_bd_intf_pins processing_system7_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M00_AXI [get_bd_intf_pins processing_system7_0_axi_periph/M00_AXI] [get_bd_intf_pins vga/s00_axi]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M01_AXI [get_bd_intf_pins processing_system7_0_axi_periph/M01_AXI] [get_bd_intf_pins vga/S_AXI_LITE]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M02_AXI [get_bd_intf_pins processing_system7_0_axi_periph/M02_AXI] [get_bd_intf_pins vga/ctrl]
  connect_bd_intf_net -intf_net vga_M00_AXI [get_bd_intf_pins processing_system7_0/S_AXI_HP1] [get_bd_intf_pins vga/M00_AXI]

  # Create port connections
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins processing_system7_0/S_AXI_HP1_ACLK] [get_bd_pins processing_system7_0_axi_periph/ACLK] [get_bd_pins processing_system7_0_axi_periph/M00_ACLK] [get_bd_pins processing_system7_0_axi_periph/M01_ACLK] [get_bd_pins processing_system7_0_axi_periph/M02_ACLK] [get_bd_pins processing_system7_0_axi_periph/S00_ACLK] [get_bd_pins rst_processing_system7_0_50M/slowest_sync_clk] [get_bd_pins vga/m_axi_mm2s_aclk]
  connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins rst_processing_system7_0_50M/ext_reset_in]
  connect_bd_net -net rst_processing_system7_0_50M_interconnect_aresetn [get_bd_pins processing_system7_0_axi_periph/ARESETN] [get_bd_pins rst_processing_system7_0_50M/interconnect_aresetn] [get_bd_pins vga/ARESETN]
  connect_bd_net -net rst_processing_system7_0_50M_peripheral_aresetn [get_bd_pins processing_system7_0_axi_periph/M00_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M01_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M02_ARESETN] [get_bd_pins processing_system7_0_axi_periph/S00_ARESETN] [get_bd_pins rst_processing_system7_0_50M/peripheral_aresetn] [get_bd_pins vga/S00_ARESETN]
  connect_bd_net -net vga_vga_blue [get_bd_ports vga_blue] [get_bd_pins vga/vga_blue]
  connect_bd_net -net vga_vga_green [get_bd_ports vga_green] [get_bd_pins vga/vga_green]
  connect_bd_net -net vga_vga_hsync [get_bd_ports vga_hsync] [get_bd_pins vga/vga_hsync]
  connect_bd_net -net vga_vga_red [get_bd_ports vga_red] [get_bd_pins vga/vga_red]
  connect_bd_net -net vga_vga_vsync [get_bd_ports vga_vsync] [get_bd_pins vga/vga_vsync]

  # Create address segments
  create_bd_addr_seg -range 0x00010000 -offset 0x43C00000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs vga/axi_dynclk_0/s00_axi/reg0] SEG_axi_dynclk_0_reg0
  create_bd_addr_seg -range 0x00010000 -offset 0x43000000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs vga/axi_vdma_0/S_AXI_LITE/Reg] SEG_axi_vdma_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x43C10000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs vga/v_tc_0/ctrl/Reg] SEG_v_tc_0_Reg
  create_bd_addr_seg -range 0x20000000 -offset 0x00000000 [get_bd_addr_spaces vga/axi_vdma_0/Data_MM2S] [get_bd_addr_segs processing_system7_0/S_AXI_HP1/HP1_DDR_LOWOCM] SEG_processing_system7_0_HP1_DDR_LOWOCM

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.5.12  2016-01-29 bk=1.3547 VDI=39 GEI=35 GUI=JA:1.6
#  -string -flagsOSRD
preplace port vga_hsync -pg 1 -y 350 -defaultsOSRD
preplace port DDR -pg 1 -y 60 -defaultsOSRD
preplace port FIXED_IO -pg 1 -y 80 -defaultsOSRD
preplace port vga_vsync -pg 1 -y 370 -defaultsOSRD
preplace portBus vga_green -pg 1 -y 310 -defaultsOSRD
preplace portBus vga_red -pg 1 -y 290 -defaultsOSRD
preplace portBus vga_blue -pg 1 -y 330 -defaultsOSRD
preplace inst vga -pg 1 -lvl 3 -y 320 -defaultsOSRD
preplace inst rst_processing_system7_0_50M -pg 1 -lvl 1 -y 550 -defaultsOSRD
preplace inst processing_system7_0_axi_periph -pg 1 -lvl 2 -y 290 -defaultsOSRD
preplace inst processing_system7_0 -pg 1 -lvl 4 -y 150 -defaultsOSRD
preplace netloc processing_system7_0_DDR 1 4 1 NJ
preplace netloc vga_M00_AXI 1 3 1 990
preplace netloc vga_vga_green 1 3 2 NJ 320 NJ
preplace netloc processing_system7_0_axi_periph_M00_AXI 1 2 1 N
preplace netloc rst_processing_system7_0_50M_interconnect_aresetn 1 1 2 370 480 NJ
preplace netloc vga_vga_hsync 1 3 2 NJ 350 NJ
preplace netloc processing_system7_0_M_AXI_GP0 1 1 4 370 10 NJ 10 NJ 10 1450
preplace netloc vga_vga_blue 1 3 2 NJ 330 NJ
preplace netloc processing_system7_0_FCLK_RESET0_N 1 0 5 20 450 NJ 450 NJ 210 NJ 300 1450
preplace netloc rst_processing_system7_0_50M_peripheral_aresetn 1 1 2 390 470 NJ
preplace netloc processing_system7_0_axi_periph_M02_AXI 1 2 1 N
preplace netloc vga_vga_red 1 3 2 NJ 310 NJ
preplace netloc vga_vga_vsync 1 3 2 NJ 370 NJ
preplace netloc processing_system7_0_FIXED_IO 1 4 1 NJ
preplace netloc processing_system7_0_FCLK_CLK0 1 0 5 30 460 380 460 670 200 1010 290 1460
preplace netloc processing_system7_0_axi_periph_M01_AXI 1 2 1 N
levelinfo -pg 1 0 200 530 840 1230 1500 -top 0 -bot 640
",
}

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


