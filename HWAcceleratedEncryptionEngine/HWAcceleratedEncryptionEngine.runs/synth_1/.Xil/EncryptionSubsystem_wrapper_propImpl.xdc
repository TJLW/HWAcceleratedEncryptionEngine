set_property SRC_FILE_INFO {cfile:/home/tjlw/HWAcceleratedEncryptionEngine/HWAcceleratedEncryptionEngine.srcs/sources_1/bd/EncryptionSubsystem/ip/EncryptionSubsystem_clk_wiz_1_0/EncryptionSubsystem_clk_wiz_1_0.xdc rfile:../../../HWAcceleratedEncryptionEngine.srcs/sources_1/bd/EncryptionSubsystem/ip/EncryptionSubsystem_clk_wiz_1_0/EncryptionSubsystem_clk_wiz_1_0.xdc id:1 order:EARLY scoped_inst:EncryptionSubsystem_i/clk_wiz_1/inst} [current_design]
set_property SRC_FILE_INFO {cfile:/home/tjlw/HWAcceleratedEncryptionEngine/HWAcceleratedEncryptionEngine.srcs/constrs_1/new/EncryptionSubsystemPinConstraints_KC705.xdc rfile:../../../HWAcceleratedEncryptionEngine.srcs/constrs_1/new/EncryptionSubsystemPinConstraints_KC705.xdc id:2} [current_design]
set_property src_info {type:SCOPED_XDC file:1 line:56 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1_p]] 0.05
set_property src_info {type:XDC file:2 line:1 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN M19 [get_ports UART_XMIT]
set_property src_info {type:XDC file:2 line:2 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN K24 [get_ports UARTRecv]
