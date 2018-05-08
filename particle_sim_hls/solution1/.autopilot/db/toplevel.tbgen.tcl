set C_TypeInfoList {{ 
"toplevel" : [[], { "return": [[], "void"]} , [{"ExternC" : 0}], [ {"ram": [[],{ "pointer":  {"scalar": "float"}}] }, {"numP": [[],{ "pointer": "0"}] }, {"numA": [[],{ "pointer": "0"}] }],["1","2"],""],
 "1": [ "numberParticles", [[],"0"],""],
 "2": [ "numberAttractors", [[],"0"],""], 
"0": [ "uint32", {"typedef": [[[], {"scalar": "unsigned int"}],""]}]
}}
set moduleName toplevel
set isCombinational 0
set isDatapathOnly 0
set isPipelined 0
set pipeline_type none
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set C_modelName {toplevel}
set C_modelType { void 0 }
set C_modelArgList {
	{ MAXI float 32 regular {axi_master 2}  }
	{ ram int 32 regular {axi_slave 0}  }
	{ numP int 32 regular {axi_slave 0}  }
	{ numA int 32 regular {axi_slave 0}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "MAXI", "interface" : "axi_master", "bitwidth" : 32, "direction" : "READWRITE", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "ram","cData": "float","bit_use": { "low": 0,"up": 31},"offset": { "type": "dynamic","port_name": "ram","bundle": "AXILiteS"},"direction": "READWRITE","cArray": [{"low" : 0,"up" : 0,"step" : 1}]}]}]} , 
 	{ "Name" : "ram", "interface" : "axi_slave", "bundle":"AXILiteS","type":"ap_none","bitwidth" : 32, "direction" : "READONLY", "offset" : {"in":16}, "offset_end" : {"in":23}} , 
 	{ "Name" : "numP", "interface" : "axi_slave", "bundle":"AXILiteS","type":"ap_none","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "numP","cData": "unsigned int","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 0,"step" : 1}]}]}], "offset" : {"in":24}, "offset_end" : {"in":31}} , 
 	{ "Name" : "numA", "interface" : "axi_slave", "bundle":"AXILiteS","type":"ap_none","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "numA","cData": "unsigned int","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 0,"step" : 1}]}]}], "offset" : {"in":32}, "offset_end" : {"in":39}} ]}
# RTL Port declarations: 
set portNum 65
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst_n sc_in sc_logic 1 reset -1 active_low_sync } 
	{ m_axi_MAXI_AWVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_MAXI_AWREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_MAXI_AWADDR sc_out sc_lv 32 signal 0 } 
	{ m_axi_MAXI_AWID sc_out sc_lv 1 signal 0 } 
	{ m_axi_MAXI_AWLEN sc_out sc_lv 8 signal 0 } 
	{ m_axi_MAXI_AWSIZE sc_out sc_lv 3 signal 0 } 
	{ m_axi_MAXI_AWBURST sc_out sc_lv 2 signal 0 } 
	{ m_axi_MAXI_AWLOCK sc_out sc_lv 2 signal 0 } 
	{ m_axi_MAXI_AWCACHE sc_out sc_lv 4 signal 0 } 
	{ m_axi_MAXI_AWPROT sc_out sc_lv 3 signal 0 } 
	{ m_axi_MAXI_AWQOS sc_out sc_lv 4 signal 0 } 
	{ m_axi_MAXI_AWREGION sc_out sc_lv 4 signal 0 } 
	{ m_axi_MAXI_AWUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_MAXI_WVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_MAXI_WREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_MAXI_WDATA sc_out sc_lv 32 signal 0 } 
	{ m_axi_MAXI_WSTRB sc_out sc_lv 4 signal 0 } 
	{ m_axi_MAXI_WLAST sc_out sc_logic 1 signal 0 } 
	{ m_axi_MAXI_WID sc_out sc_lv 1 signal 0 } 
	{ m_axi_MAXI_WUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_MAXI_ARVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_MAXI_ARREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_MAXI_ARADDR sc_out sc_lv 32 signal 0 } 
	{ m_axi_MAXI_ARID sc_out sc_lv 1 signal 0 } 
	{ m_axi_MAXI_ARLEN sc_out sc_lv 8 signal 0 } 
	{ m_axi_MAXI_ARSIZE sc_out sc_lv 3 signal 0 } 
	{ m_axi_MAXI_ARBURST sc_out sc_lv 2 signal 0 } 
	{ m_axi_MAXI_ARLOCK sc_out sc_lv 2 signal 0 } 
	{ m_axi_MAXI_ARCACHE sc_out sc_lv 4 signal 0 } 
	{ m_axi_MAXI_ARPROT sc_out sc_lv 3 signal 0 } 
	{ m_axi_MAXI_ARQOS sc_out sc_lv 4 signal 0 } 
	{ m_axi_MAXI_ARREGION sc_out sc_lv 4 signal 0 } 
	{ m_axi_MAXI_ARUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_MAXI_RVALID sc_in sc_logic 1 signal 0 } 
	{ m_axi_MAXI_RREADY sc_out sc_logic 1 signal 0 } 
	{ m_axi_MAXI_RDATA sc_in sc_lv 32 signal 0 } 
	{ m_axi_MAXI_RLAST sc_in sc_logic 1 signal 0 } 
	{ m_axi_MAXI_RID sc_in sc_lv 1 signal 0 } 
	{ m_axi_MAXI_RUSER sc_in sc_lv 1 signal 0 } 
	{ m_axi_MAXI_RRESP sc_in sc_lv 2 signal 0 } 
	{ m_axi_MAXI_BVALID sc_in sc_logic 1 signal 0 } 
	{ m_axi_MAXI_BREADY sc_out sc_logic 1 signal 0 } 
	{ m_axi_MAXI_BRESP sc_in sc_lv 2 signal 0 } 
	{ m_axi_MAXI_BID sc_in sc_lv 1 signal 0 } 
	{ m_axi_MAXI_BUSER sc_in sc_lv 1 signal 0 } 
	{ s_axi_AXILiteS_AWVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_AXILiteS_AWREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_AXILiteS_AWADDR sc_in sc_lv 6 signal -1 } 
	{ s_axi_AXILiteS_WVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_AXILiteS_WREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_AXILiteS_WDATA sc_in sc_lv 32 signal -1 } 
	{ s_axi_AXILiteS_WSTRB sc_in sc_lv 4 signal -1 } 
	{ s_axi_AXILiteS_ARVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_AXILiteS_ARREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_AXILiteS_ARADDR sc_in sc_lv 6 signal -1 } 
	{ s_axi_AXILiteS_RVALID sc_out sc_logic 1 signal -1 } 
	{ s_axi_AXILiteS_RREADY sc_in sc_logic 1 signal -1 } 
	{ s_axi_AXILiteS_RDATA sc_out sc_lv 32 signal -1 } 
	{ s_axi_AXILiteS_RRESP sc_out sc_lv 2 signal -1 } 
	{ s_axi_AXILiteS_BVALID sc_out sc_logic 1 signal -1 } 
	{ s_axi_AXILiteS_BREADY sc_in sc_logic 1 signal -1 } 
	{ s_axi_AXILiteS_BRESP sc_out sc_lv 2 signal -1 } 
	{ interrupt sc_out sc_logic 1 signal -1 } 
}
set NewPortList {[ 
	{ "name": "s_axi_AXILiteS_AWADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "AXILiteS", "role": "AWADDR" },"address":[{"name":"toplevel","role":"start","value":"0","valid_bit":"0"},{"name":"toplevel","role":"continue","value":"0","valid_bit":"4"},{"name":"toplevel","role":"auto_start","value":"0","valid_bit":"7"},{"name":"ram","role":"data","value":"16"},{"name":"numP","role":"data","value":"24"},{"name":"numA","role":"data","value":"32"}] },
	{ "name": "s_axi_AXILiteS_AWVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "AXILiteS", "role": "AWVALID" } },
	{ "name": "s_axi_AXILiteS_AWREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "AXILiteS", "role": "AWREADY" } },
	{ "name": "s_axi_AXILiteS_WVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "AXILiteS", "role": "WVALID" } },
	{ "name": "s_axi_AXILiteS_WREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "AXILiteS", "role": "WREADY" } },
	{ "name": "s_axi_AXILiteS_WDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "AXILiteS", "role": "WDATA" } },
	{ "name": "s_axi_AXILiteS_WSTRB", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "AXILiteS", "role": "WSTRB" } },
	{ "name": "s_axi_AXILiteS_ARADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "AXILiteS", "role": "ARADDR" },"address":[{"name":"toplevel","role":"start","value":"0","valid_bit":"0"},{"name":"toplevel","role":"done","value":"0","valid_bit":"1"},{"name":"toplevel","role":"idle","value":"0","valid_bit":"2"},{"name":"toplevel","role":"ready","value":"0","valid_bit":"3"},{"name":"toplevel","role":"auto_start","value":"0","valid_bit":"7"}] },
	{ "name": "s_axi_AXILiteS_ARVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "AXILiteS", "role": "ARVALID" } },
	{ "name": "s_axi_AXILiteS_ARREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "AXILiteS", "role": "ARREADY" } },
	{ "name": "s_axi_AXILiteS_RVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "AXILiteS", "role": "RVALID" } },
	{ "name": "s_axi_AXILiteS_RREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "AXILiteS", "role": "RREADY" } },
	{ "name": "s_axi_AXILiteS_RDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "AXILiteS", "role": "RDATA" } },
	{ "name": "s_axi_AXILiteS_RRESP", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "AXILiteS", "role": "RRESP" } },
	{ "name": "s_axi_AXILiteS_BVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "AXILiteS", "role": "BVALID" } },
	{ "name": "s_axi_AXILiteS_BREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "AXILiteS", "role": "BREADY" } },
	{ "name": "s_axi_AXILiteS_BRESP", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "AXILiteS", "role": "BRESP" } },
	{ "name": "interrupt", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "AXILiteS", "role": "interrupt" } }, 
 	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst_n", "role": "default" }} , 
 	{ "name": "m_axi_MAXI_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "AWVALID" }} , 
 	{ "name": "m_axi_MAXI_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "AWREADY" }} , 
 	{ "name": "m_axi_MAXI_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "MAXI", "role": "AWADDR" }} , 
 	{ "name": "m_axi_MAXI_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "AWID" }} , 
 	{ "name": "m_axi_MAXI_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "MAXI", "role": "AWLEN" }} , 
 	{ "name": "m_axi_MAXI_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "MAXI", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_MAXI_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "MAXI", "role": "AWBURST" }} , 
 	{ "name": "m_axi_MAXI_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "MAXI", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_MAXI_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "MAXI", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_MAXI_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "MAXI", "role": "AWPROT" }} , 
 	{ "name": "m_axi_MAXI_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "MAXI", "role": "AWQOS" }} , 
 	{ "name": "m_axi_MAXI_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "MAXI", "role": "AWREGION" }} , 
 	{ "name": "m_axi_MAXI_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "AWUSER" }} , 
 	{ "name": "m_axi_MAXI_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "WVALID" }} , 
 	{ "name": "m_axi_MAXI_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "WREADY" }} , 
 	{ "name": "m_axi_MAXI_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "MAXI", "role": "WDATA" }} , 
 	{ "name": "m_axi_MAXI_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "MAXI", "role": "WSTRB" }} , 
 	{ "name": "m_axi_MAXI_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "WLAST" }} , 
 	{ "name": "m_axi_MAXI_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "WID" }} , 
 	{ "name": "m_axi_MAXI_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "WUSER" }} , 
 	{ "name": "m_axi_MAXI_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "ARVALID" }} , 
 	{ "name": "m_axi_MAXI_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "ARREADY" }} , 
 	{ "name": "m_axi_MAXI_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "MAXI", "role": "ARADDR" }} , 
 	{ "name": "m_axi_MAXI_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "ARID" }} , 
 	{ "name": "m_axi_MAXI_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "MAXI", "role": "ARLEN" }} , 
 	{ "name": "m_axi_MAXI_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "MAXI", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_MAXI_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "MAXI", "role": "ARBURST" }} , 
 	{ "name": "m_axi_MAXI_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "MAXI", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_MAXI_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "MAXI", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_MAXI_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "MAXI", "role": "ARPROT" }} , 
 	{ "name": "m_axi_MAXI_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "MAXI", "role": "ARQOS" }} , 
 	{ "name": "m_axi_MAXI_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "MAXI", "role": "ARREGION" }} , 
 	{ "name": "m_axi_MAXI_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "ARUSER" }} , 
 	{ "name": "m_axi_MAXI_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "RVALID" }} , 
 	{ "name": "m_axi_MAXI_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "RREADY" }} , 
 	{ "name": "m_axi_MAXI_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "MAXI", "role": "RDATA" }} , 
 	{ "name": "m_axi_MAXI_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "RLAST" }} , 
 	{ "name": "m_axi_MAXI_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "RID" }} , 
 	{ "name": "m_axi_MAXI_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "RUSER" }} , 
 	{ "name": "m_axi_MAXI_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "MAXI", "role": "RRESP" }} , 
 	{ "name": "m_axi_MAXI_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "BVALID" }} , 
 	{ "name": "m_axi_MAXI_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "BREADY" }} , 
 	{ "name": "m_axi_MAXI_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "MAXI", "role": "BRESP" }} , 
 	{ "name": "m_axi_MAXI_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "BID" }} , 
 	{ "name": "m_axi_MAXI_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "MAXI", "role": "BUSER" }}  ]}

set RtlHierarchyInfo {[
	{"Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2", "3", "4", "5", "6", "7", "8", "9"], "CDFG" : "toplevel", "VariableLatency" : "1", "AlignedPipeline" : "0", "UnalignedPipeline" : "0", "ProcessNetwork" : "0", "Combinational" : "0", "ControlExist" : "1",
		"Port" : [
		{"Name" : "MAXI", "Type" : "MAXI", "Direction" : "IO", "BlockSignal" : [
			{"Name" : "MAXI_blk_n_AR", "Type" : "RtlSignal"}, 
			{"Name" : "MAXI_blk_n_R", "Type" : "RtlSignal"}, 
			{"Name" : "MAXI_blk_n_AW", "Type" : "RtlSignal"}, 
			{"Name" : "MAXI_blk_n_W", "Type" : "RtlSignal"}, 
			{"Name" : "MAXI_blk_n_B", "Type" : "RtlSignal"}], "SubConnect" : []}, 
		{"Name" : "ram", "Type" : "None", "Direction" : "I", "BlockSignal" : [], "SubConnect" : []}, 
		{"Name" : "numP", "Type" : "None", "Direction" : "I", "BlockSignal" : [], "SubConnect" : []}, 
		{"Name" : "numA", "Type" : "None", "Direction" : "I", "BlockSignal" : [], "SubConnect" : []}, 
		{"Name" : "numberParticles", "Type" : "Vld", "Direction" : "O", "BlockSignal" : [], "SubConnect" : []}, 
		{"Name" : "numberAttractors", "Type" : "OVld", "Direction" : "IO", "BlockSignal" : [], "SubConnect" : []}],
		"WaitState" : [],
		"SubBlockPort" : []},
	{"Level" : "1", "Path" : "`AUTOTB_DUT_INST.toplevel_AXILiteS_s_axi_U", "Parent" : "0", "Child" : []},
	{"Level" : "1", "Path" : "`AUTOTB_DUT_INST.toplevel_MAXI_m_axi_U", "Parent" : "0", "Child" : []},
	{"Level" : "1", "Path" : "`AUTOTB_DUT_INST.toplevel_faddfsub_32ns_32ns_32_5_full_dsp_U1", "Parent" : "0", "Child" : []},
	{"Level" : "1", "Path" : "`AUTOTB_DUT_INST.toplevel_fadd_32ns_32ns_32_5_full_dsp_U2", "Parent" : "0", "Child" : []},
	{"Level" : "1", "Path" : "`AUTOTB_DUT_INST.toplevel_fmul_32ns_32ns_32_4_max_dsp_U3", "Parent" : "0", "Child" : []},
	{"Level" : "1", "Path" : "`AUTOTB_DUT_INST.toplevel_fmul_32ns_32ns_32_4_max_dsp_U4", "Parent" : "0", "Child" : []},
	{"Level" : "1", "Path" : "`AUTOTB_DUT_INST.toplevel_fdiv_32ns_32ns_32_16_U5", "Parent" : "0", "Child" : []},
	{"Level" : "1", "Path" : "`AUTOTB_DUT_INST.toplevel_fcmp_32ns_32ns_1_1_U6", "Parent" : "0", "Child" : []},
	{"Level" : "1", "Path" : "`AUTOTB_DUT_INST.toplevel_fsqrt_32ns_32ns_32_12_U7", "Parent" : "0", "Child" : []}]}

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "3", "Max" : "6576003"}
	, {"Name" : "Interval", "Min" : "4", "Max" : "6576004"}
]}

set Spec2ImplPortList { 
	MAXI { m_axi {  { m_axi_MAXI_AWVALID VALID 1 1 }  { m_axi_MAXI_AWREADY READY 0 1 }  { m_axi_MAXI_AWADDR ADDR 1 32 }  { m_axi_MAXI_AWID ID 1 1 }  { m_axi_MAXI_AWLEN LEN 1 8 }  { m_axi_MAXI_AWSIZE SIZE 1 3 }  { m_axi_MAXI_AWBURST BURST 1 2 }  { m_axi_MAXI_AWLOCK LOCK 1 2 }  { m_axi_MAXI_AWCACHE CACHE 1 4 }  { m_axi_MAXI_AWPROT PROT 1 3 }  { m_axi_MAXI_AWQOS QOS 1 4 }  { m_axi_MAXI_AWREGION REGION 1 4 }  { m_axi_MAXI_AWUSER USER 1 1 }  { m_axi_MAXI_WVALID VALID 1 1 }  { m_axi_MAXI_WREADY READY 0 1 }  { m_axi_MAXI_WDATA DATA 1 32 }  { m_axi_MAXI_WSTRB STRB 1 4 }  { m_axi_MAXI_WLAST LAST 1 1 }  { m_axi_MAXI_WID ID 1 1 }  { m_axi_MAXI_WUSER USER 1 1 }  { m_axi_MAXI_ARVALID VALID 1 1 }  { m_axi_MAXI_ARREADY READY 0 1 }  { m_axi_MAXI_ARADDR ADDR 1 32 }  { m_axi_MAXI_ARID ID 1 1 }  { m_axi_MAXI_ARLEN LEN 1 8 }  { m_axi_MAXI_ARSIZE SIZE 1 3 }  { m_axi_MAXI_ARBURST BURST 1 2 }  { m_axi_MAXI_ARLOCK LOCK 1 2 }  { m_axi_MAXI_ARCACHE CACHE 1 4 }  { m_axi_MAXI_ARPROT PROT 1 3 }  { m_axi_MAXI_ARQOS QOS 1 4 }  { m_axi_MAXI_ARREGION REGION 1 4 }  { m_axi_MAXI_ARUSER USER 1 1 }  { m_axi_MAXI_RVALID VALID 0 1 }  { m_axi_MAXI_RREADY READY 1 1 }  { m_axi_MAXI_RDATA DATA 0 32 }  { m_axi_MAXI_RLAST LAST 0 1 }  { m_axi_MAXI_RID ID 0 1 }  { m_axi_MAXI_RUSER USER 0 1 }  { m_axi_MAXI_RRESP RESP 0 2 }  { m_axi_MAXI_BVALID VALID 0 1 }  { m_axi_MAXI_BREADY READY 1 1 }  { m_axi_MAXI_BRESP RESP 0 2 }  { m_axi_MAXI_BID ID 0 1 }  { m_axi_MAXI_BUSER USER 0 1 } } }
}

set busDeadlockParameterList { 
	{ MAXI { NUM_READ_OUTSTANDING 16 NUM_WRITE_OUTSTANDING 16 MAX_READ_BURST_LENGTH 16 MAX_WRITE_BURST_LENGTH 16 } } \
}

# RTL port scheduling information:
set fifoSchedulingInfoList { 
}

# RTL bus port read request latency information:
set busReadReqLatencyList { 
	{ MAXI 1 }
}

# RTL bus port write response latency information:
set busWriteResLatencyList { 
	{ MAXI 1 }
}

# RTL array port load latency information:
set memoryLoadLatencyList { 
}