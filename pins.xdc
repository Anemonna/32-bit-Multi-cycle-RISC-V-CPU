set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports reset]
set_property PACKAGE_PIN M19 [get_ports clk]
set_property PACKAGE_PIN AB6 [get_ports reset]










set_property IOSTANDARD LVCMOS33 [get_ports {segment_select[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segment_select[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segment_select[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segment_select[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segment_select[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segment_select[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segment_select[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segment_select[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports digit_select_tenth]
set_property IOSTANDARD LVCMOS33 [get_ports digit_select_unit]
set_property PACKAGE_PIN N19 [get_ports digit_select_tenth]
set_property PACKAGE_PIN M20 [get_ports digit_select_unit]
set_property PACKAGE_PIN T16 [get_ports {segment_select[0]}]
set_property PACKAGE_PIN P18 [get_ports {segment_select[1]}]
set_property PACKAGE_PIN P17 [get_ports {segment_select[2]}]
set_property PACKAGE_PIN P15 [get_ports {segment_select[3]}]
set_property PACKAGE_PIN N15 [get_ports {segment_select[4]}]
set_property PACKAGE_PIN P21 [get_ports {segment_select[5]}]
set_property PACKAGE_PIN P20 [get_ports {segment_select[6]}]
set_property PACKAGE_PIN R21 [get_ports {segment_select[7]}]


set_property IOSTANDARD LVCMOS33 [get_ports digit_select_hunth]
set_property IOSTANDARD LVCMOS33 [get_ports digit_select_sign]
set_property PACKAGE_PIN N20 [get_ports digit_select_hunth]
set_property PACKAGE_PIN M21 [get_ports digit_select_sign]

set_property DRIVE 12 [get_ports digit_select_hunth]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk_div_reg_n_11]
