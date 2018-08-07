

proc generate {drv_handle} {
	xdefine_include_file $drv_handle "xparameters.h" "EncryptionEngine" "NUM_INSTANCES" "DEVICE_ID"  "C_AES_AXI_BASEADDR" "C_AES_AXI_HIGHADDR" "C_RSA_AXI_BASEADDR" "C_RSA_AXI_HIGHADDR" "C_RS232_AXI_BASEADDR" "C_RS232_AXI_HIGHADDR" "C_Control_AXI_BASEADDR" "C_Control_AXI_HIGHADDR"
}
