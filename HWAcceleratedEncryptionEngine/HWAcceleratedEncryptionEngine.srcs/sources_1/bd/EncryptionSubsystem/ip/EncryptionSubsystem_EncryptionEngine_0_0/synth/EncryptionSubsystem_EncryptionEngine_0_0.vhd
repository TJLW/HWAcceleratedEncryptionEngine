-- (c) Copyright 1995-2017 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: SmartES:Evaluation:EncryptionEngine:1.0
-- IP Revision: 12

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY EncryptionSubsystem_EncryptionEngine_0_0 IS
  PORT (
    clock : IN STD_LOGIC;
    RS232_UARTRecv : IN STD_LOGIC;
    RS232_UARTXmit : OUT STD_LOGIC;
    rsa_axi_awaddr : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
    rsa_axi_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    rsa_axi_awvalid : IN STD_LOGIC;
    rsa_axi_awready : OUT STD_LOGIC;
    rsa_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    rsa_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    rsa_axi_wvalid : IN STD_LOGIC;
    rsa_axi_wready : OUT STD_LOGIC;
    rsa_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    rsa_axi_bvalid : OUT STD_LOGIC;
    rsa_axi_bready : IN STD_LOGIC;
    rsa_axi_araddr : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
    rsa_axi_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    rsa_axi_arvalid : IN STD_LOGIC;
    rsa_axi_arready : OUT STD_LOGIC;
    rsa_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    rsa_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    rsa_axi_rvalid : OUT STD_LOGIC;
    rsa_axi_rready : IN STD_LOGIC;
    rsa_axi_aclk : IN STD_LOGIC;
    rsa_axi_aresetn : IN STD_LOGIC;
    control_axi_awaddr : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
    control_axi_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    control_axi_awvalid : IN STD_LOGIC;
    control_axi_awready : OUT STD_LOGIC;
    control_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    control_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    control_axi_wvalid : IN STD_LOGIC;
    control_axi_wready : OUT STD_LOGIC;
    control_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    control_axi_bvalid : OUT STD_LOGIC;
    control_axi_bready : IN STD_LOGIC;
    control_axi_araddr : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
    control_axi_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    control_axi_arvalid : IN STD_LOGIC;
    control_axi_arready : OUT STD_LOGIC;
    control_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    control_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    control_axi_rvalid : OUT STD_LOGIC;
    control_axi_rready : IN STD_LOGIC;
    control_axi_aclk : IN STD_LOGIC;
    control_axi_aresetn : IN STD_LOGIC;
    rs232_axi_awaddr : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    rs232_axi_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    rs232_axi_awvalid : IN STD_LOGIC;
    rs232_axi_awready : OUT STD_LOGIC;
    rs232_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    rs232_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    rs232_axi_wvalid : IN STD_LOGIC;
    rs232_axi_wready : OUT STD_LOGIC;
    rs232_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    rs232_axi_bvalid : OUT STD_LOGIC;
    rs232_axi_bready : IN STD_LOGIC;
    rs232_axi_araddr : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    rs232_axi_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    rs232_axi_arvalid : IN STD_LOGIC;
    rs232_axi_arready : OUT STD_LOGIC;
    rs232_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    rs232_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    rs232_axi_rvalid : OUT STD_LOGIC;
    rs232_axi_rready : IN STD_LOGIC;
    rs232_axi_aclk : IN STD_LOGIC;
    rs232_axi_aresetn : IN STD_LOGIC;
    aes_axi_awaddr : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    aes_axi_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    aes_axi_awvalid : IN STD_LOGIC;
    aes_axi_awready : OUT STD_LOGIC;
    aes_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    aes_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    aes_axi_wvalid : IN STD_LOGIC;
    aes_axi_wready : OUT STD_LOGIC;
    aes_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    aes_axi_bvalid : OUT STD_LOGIC;
    aes_axi_bready : IN STD_LOGIC;
    aes_axi_araddr : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    aes_axi_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    aes_axi_arvalid : IN STD_LOGIC;
    aes_axi_arready : OUT STD_LOGIC;
    aes_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    aes_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    aes_axi_rvalid : OUT STD_LOGIC;
    aes_axi_rready : IN STD_LOGIC;
    aes_axi_aclk : IN STD_LOGIC;
    aes_axi_aresetn : IN STD_LOGIC
  );
END EncryptionSubsystem_EncryptionEngine_0_0;

ARCHITECTURE EncryptionSubsystem_EncryptionEngine_0_0_arch OF EncryptionSubsystem_EncryptionEngine_0_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : string;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF EncryptionSubsystem_EncryptionEngine_0_0_arch: ARCHITECTURE IS "yes";

  COMPONENT EncryptionEngine_v1_0 IS
    GENERIC (
      C_RSA_AXI_DATA_WIDTH : INTEGER; -- Width of S_AXI data bus
      C_RSA_AXI_ADDR_WIDTH : INTEGER; -- Width of S_AXI address bus
      C_Control_AXI_DATA_WIDTH : INTEGER; -- Width of S_AXI data bus
      C_Control_AXI_ADDR_WIDTH : INTEGER; -- Width of S_AXI address bus
      C_RS232_AXI_DATA_WIDTH : INTEGER; -- Width of S_AXI data bus
      C_RS232_AXI_ADDR_WIDTH : INTEGER; -- Width of S_AXI address bus
      C_AES_AXI_DATA_WIDTH : INTEGER; -- Width of S_AXI data bus
      C_AES_AXI_ADDR_WIDTH : INTEGER; -- Width of S_AXI address bus
      AES_KeySize : INTEGER;
      RSA_KeySize : INTEGER
    );
    PORT (
      clock : IN STD_LOGIC;
      RS232_UARTRecv : IN STD_LOGIC;
      RS232_UARTXmit : OUT STD_LOGIC;
      rsa_axi_awaddr : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
      rsa_axi_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      rsa_axi_awvalid : IN STD_LOGIC;
      rsa_axi_awready : OUT STD_LOGIC;
      rsa_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      rsa_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      rsa_axi_wvalid : IN STD_LOGIC;
      rsa_axi_wready : OUT STD_LOGIC;
      rsa_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      rsa_axi_bvalid : OUT STD_LOGIC;
      rsa_axi_bready : IN STD_LOGIC;
      rsa_axi_araddr : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
      rsa_axi_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      rsa_axi_arvalid : IN STD_LOGIC;
      rsa_axi_arready : OUT STD_LOGIC;
      rsa_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      rsa_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      rsa_axi_rvalid : OUT STD_LOGIC;
      rsa_axi_rready : IN STD_LOGIC;
      rsa_axi_aclk : IN STD_LOGIC;
      rsa_axi_aresetn : IN STD_LOGIC;
      control_axi_awaddr : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      control_axi_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      control_axi_awvalid : IN STD_LOGIC;
      control_axi_awready : OUT STD_LOGIC;
      control_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      control_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      control_axi_wvalid : IN STD_LOGIC;
      control_axi_wready : OUT STD_LOGIC;
      control_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      control_axi_bvalid : OUT STD_LOGIC;
      control_axi_bready : IN STD_LOGIC;
      control_axi_araddr : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      control_axi_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      control_axi_arvalid : IN STD_LOGIC;
      control_axi_arready : OUT STD_LOGIC;
      control_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      control_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      control_axi_rvalid : OUT STD_LOGIC;
      control_axi_rready : IN STD_LOGIC;
      control_axi_aclk : IN STD_LOGIC;
      control_axi_aresetn : IN STD_LOGIC;
      rs232_axi_awaddr : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      rs232_axi_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      rs232_axi_awvalid : IN STD_LOGIC;
      rs232_axi_awready : OUT STD_LOGIC;
      rs232_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      rs232_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      rs232_axi_wvalid : IN STD_LOGIC;
      rs232_axi_wready : OUT STD_LOGIC;
      rs232_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      rs232_axi_bvalid : OUT STD_LOGIC;
      rs232_axi_bready : IN STD_LOGIC;
      rs232_axi_araddr : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      rs232_axi_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      rs232_axi_arvalid : IN STD_LOGIC;
      rs232_axi_arready : OUT STD_LOGIC;
      rs232_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      rs232_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      rs232_axi_rvalid : OUT STD_LOGIC;
      rs232_axi_rready : IN STD_LOGIC;
      rs232_axi_aclk : IN STD_LOGIC;
      rs232_axi_aresetn : IN STD_LOGIC;
      aes_axi_awaddr : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
      aes_axi_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      aes_axi_awvalid : IN STD_LOGIC;
      aes_axi_awready : OUT STD_LOGIC;
      aes_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      aes_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      aes_axi_wvalid : IN STD_LOGIC;
      aes_axi_wready : OUT STD_LOGIC;
      aes_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      aes_axi_bvalid : OUT STD_LOGIC;
      aes_axi_bready : IN STD_LOGIC;
      aes_axi_araddr : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
      aes_axi_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      aes_axi_arvalid : IN STD_LOGIC;
      aes_axi_arready : OUT STD_LOGIC;
      aes_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      aes_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      aes_axi_rvalid : OUT STD_LOGIC;
      aes_axi_rready : IN STD_LOGIC;
      aes_axi_aclk : IN STD_LOGIC;
      aes_axi_aresetn : IN STD_LOGIC
    );
  END COMPONENT EncryptionEngine_v1_0;
  ATTRIBUTE X_CORE_INFO : STRING;
  ATTRIBUTE X_CORE_INFO OF EncryptionSubsystem_EncryptionEngine_0_0_arch: ARCHITECTURE IS "EncryptionEngine_v1_0,Vivado 2015.4";
  ATTRIBUTE CHECK_LICENSE_TYPE : STRING;
  ATTRIBUTE CHECK_LICENSE_TYPE OF EncryptionSubsystem_EncryptionEngine_0_0_arch : ARCHITECTURE IS "EncryptionSubsystem_EncryptionEngine_0_0,EncryptionEngine_v1_0,{}";
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_INFO OF rsa_axi_awaddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 RSA_AXI AWADDR";
  ATTRIBUTE X_INTERFACE_INFO OF rsa_axi_awprot: SIGNAL IS "xilinx.com:interface:aximm:1.0 RSA_AXI AWPROT";
  ATTRIBUTE X_INTERFACE_INFO OF rsa_axi_awvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 RSA_AXI AWVALID";
  ATTRIBUTE X_INTERFACE_INFO OF rsa_axi_awready: SIGNAL IS "xilinx.com:interface:aximm:1.0 RSA_AXI AWREADY";
  ATTRIBUTE X_INTERFACE_INFO OF rsa_axi_wdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 RSA_AXI WDATA";
  ATTRIBUTE X_INTERFACE_INFO OF rsa_axi_wstrb: SIGNAL IS "xilinx.com:interface:aximm:1.0 RSA_AXI WSTRB";
  ATTRIBUTE X_INTERFACE_INFO OF rsa_axi_wvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 RSA_AXI WVALID";
  ATTRIBUTE X_INTERFACE_INFO OF rsa_axi_wready: SIGNAL IS "xilinx.com:interface:aximm:1.0 RSA_AXI WREADY";
  ATTRIBUTE X_INTERFACE_INFO OF rsa_axi_bresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 RSA_AXI BRESP";
  ATTRIBUTE X_INTERFACE_INFO OF rsa_axi_bvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 RSA_AXI BVALID";
  ATTRIBUTE X_INTERFACE_INFO OF rsa_axi_bready: SIGNAL IS "xilinx.com:interface:aximm:1.0 RSA_AXI BREADY";
  ATTRIBUTE X_INTERFACE_INFO OF rsa_axi_araddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 RSA_AXI ARADDR";
  ATTRIBUTE X_INTERFACE_INFO OF rsa_axi_arprot: SIGNAL IS "xilinx.com:interface:aximm:1.0 RSA_AXI ARPROT";
  ATTRIBUTE X_INTERFACE_INFO OF rsa_axi_arvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 RSA_AXI ARVALID";
  ATTRIBUTE X_INTERFACE_INFO OF rsa_axi_arready: SIGNAL IS "xilinx.com:interface:aximm:1.0 RSA_AXI ARREADY";
  ATTRIBUTE X_INTERFACE_INFO OF rsa_axi_rdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 RSA_AXI RDATA";
  ATTRIBUTE X_INTERFACE_INFO OF rsa_axi_rresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 RSA_AXI RRESP";
  ATTRIBUTE X_INTERFACE_INFO OF rsa_axi_rvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 RSA_AXI RVALID";
  ATTRIBUTE X_INTERFACE_INFO OF rsa_axi_rready: SIGNAL IS "xilinx.com:interface:aximm:1.0 RSA_AXI RREADY";
  ATTRIBUTE X_INTERFACE_INFO OF rsa_axi_aclk: SIGNAL IS "xilinx.com:signal:clock:1.0 RSA_AXI_CLK CLK";
  ATTRIBUTE X_INTERFACE_INFO OF rsa_axi_aresetn: SIGNAL IS "xilinx.com:signal:reset:1.0 RSA_AXI_RST RST";
  ATTRIBUTE X_INTERFACE_INFO OF control_axi_awaddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 Control_AXI AWADDR";
  ATTRIBUTE X_INTERFACE_INFO OF control_axi_awprot: SIGNAL IS "xilinx.com:interface:aximm:1.0 Control_AXI AWPROT";
  ATTRIBUTE X_INTERFACE_INFO OF control_axi_awvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 Control_AXI AWVALID";
  ATTRIBUTE X_INTERFACE_INFO OF control_axi_awready: SIGNAL IS "xilinx.com:interface:aximm:1.0 Control_AXI AWREADY";
  ATTRIBUTE X_INTERFACE_INFO OF control_axi_wdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 Control_AXI WDATA";
  ATTRIBUTE X_INTERFACE_INFO OF control_axi_wstrb: SIGNAL IS "xilinx.com:interface:aximm:1.0 Control_AXI WSTRB";
  ATTRIBUTE X_INTERFACE_INFO OF control_axi_wvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 Control_AXI WVALID";
  ATTRIBUTE X_INTERFACE_INFO OF control_axi_wready: SIGNAL IS "xilinx.com:interface:aximm:1.0 Control_AXI WREADY";
  ATTRIBUTE X_INTERFACE_INFO OF control_axi_bresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 Control_AXI BRESP";
  ATTRIBUTE X_INTERFACE_INFO OF control_axi_bvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 Control_AXI BVALID";
  ATTRIBUTE X_INTERFACE_INFO OF control_axi_bready: SIGNAL IS "xilinx.com:interface:aximm:1.0 Control_AXI BREADY";
  ATTRIBUTE X_INTERFACE_INFO OF control_axi_araddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 Control_AXI ARADDR";
  ATTRIBUTE X_INTERFACE_INFO OF control_axi_arprot: SIGNAL IS "xilinx.com:interface:aximm:1.0 Control_AXI ARPROT";
  ATTRIBUTE X_INTERFACE_INFO OF control_axi_arvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 Control_AXI ARVALID";
  ATTRIBUTE X_INTERFACE_INFO OF control_axi_arready: SIGNAL IS "xilinx.com:interface:aximm:1.0 Control_AXI ARREADY";
  ATTRIBUTE X_INTERFACE_INFO OF control_axi_rdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 Control_AXI RDATA";
  ATTRIBUTE X_INTERFACE_INFO OF control_axi_rresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 Control_AXI RRESP";
  ATTRIBUTE X_INTERFACE_INFO OF control_axi_rvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 Control_AXI RVALID";
  ATTRIBUTE X_INTERFACE_INFO OF control_axi_rready: SIGNAL IS "xilinx.com:interface:aximm:1.0 Control_AXI RREADY";
  ATTRIBUTE X_INTERFACE_INFO OF control_axi_aclk: SIGNAL IS "xilinx.com:signal:clock:1.0 Control_AXI_CLK CLK";
  ATTRIBUTE X_INTERFACE_INFO OF control_axi_aresetn: SIGNAL IS "xilinx.com:signal:reset:1.0 Control_AXI_RST RST";
  ATTRIBUTE X_INTERFACE_INFO OF rs232_axi_awaddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 RS232_AXI AWADDR";
  ATTRIBUTE X_INTERFACE_INFO OF rs232_axi_awprot: SIGNAL IS "xilinx.com:interface:aximm:1.0 RS232_AXI AWPROT";
  ATTRIBUTE X_INTERFACE_INFO OF rs232_axi_awvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 RS232_AXI AWVALID";
  ATTRIBUTE X_INTERFACE_INFO OF rs232_axi_awready: SIGNAL IS "xilinx.com:interface:aximm:1.0 RS232_AXI AWREADY";
  ATTRIBUTE X_INTERFACE_INFO OF rs232_axi_wdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 RS232_AXI WDATA";
  ATTRIBUTE X_INTERFACE_INFO OF rs232_axi_wstrb: SIGNAL IS "xilinx.com:interface:aximm:1.0 RS232_AXI WSTRB";
  ATTRIBUTE X_INTERFACE_INFO OF rs232_axi_wvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 RS232_AXI WVALID";
  ATTRIBUTE X_INTERFACE_INFO OF rs232_axi_wready: SIGNAL IS "xilinx.com:interface:aximm:1.0 RS232_AXI WREADY";
  ATTRIBUTE X_INTERFACE_INFO OF rs232_axi_bresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 RS232_AXI BRESP";
  ATTRIBUTE X_INTERFACE_INFO OF rs232_axi_bvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 RS232_AXI BVALID";
  ATTRIBUTE X_INTERFACE_INFO OF rs232_axi_bready: SIGNAL IS "xilinx.com:interface:aximm:1.0 RS232_AXI BREADY";
  ATTRIBUTE X_INTERFACE_INFO OF rs232_axi_araddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 RS232_AXI ARADDR";
  ATTRIBUTE X_INTERFACE_INFO OF rs232_axi_arprot: SIGNAL IS "xilinx.com:interface:aximm:1.0 RS232_AXI ARPROT";
  ATTRIBUTE X_INTERFACE_INFO OF rs232_axi_arvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 RS232_AXI ARVALID";
  ATTRIBUTE X_INTERFACE_INFO OF rs232_axi_arready: SIGNAL IS "xilinx.com:interface:aximm:1.0 RS232_AXI ARREADY";
  ATTRIBUTE X_INTERFACE_INFO OF rs232_axi_rdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 RS232_AXI RDATA";
  ATTRIBUTE X_INTERFACE_INFO OF rs232_axi_rresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 RS232_AXI RRESP";
  ATTRIBUTE X_INTERFACE_INFO OF rs232_axi_rvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 RS232_AXI RVALID";
  ATTRIBUTE X_INTERFACE_INFO OF rs232_axi_rready: SIGNAL IS "xilinx.com:interface:aximm:1.0 RS232_AXI RREADY";
  ATTRIBUTE X_INTERFACE_INFO OF rs232_axi_aclk: SIGNAL IS "xilinx.com:signal:clock:1.0 RS232_AXI_CLK CLK";
  ATTRIBUTE X_INTERFACE_INFO OF rs232_axi_aresetn: SIGNAL IS "xilinx.com:signal:reset:1.0 RS232_AXI_RST RST";
  ATTRIBUTE X_INTERFACE_INFO OF aes_axi_awaddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 AES_AXI AWADDR";
  ATTRIBUTE X_INTERFACE_INFO OF aes_axi_awprot: SIGNAL IS "xilinx.com:interface:aximm:1.0 AES_AXI AWPROT";
  ATTRIBUTE X_INTERFACE_INFO OF aes_axi_awvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 AES_AXI AWVALID";
  ATTRIBUTE X_INTERFACE_INFO OF aes_axi_awready: SIGNAL IS "xilinx.com:interface:aximm:1.0 AES_AXI AWREADY";
  ATTRIBUTE X_INTERFACE_INFO OF aes_axi_wdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 AES_AXI WDATA";
  ATTRIBUTE X_INTERFACE_INFO OF aes_axi_wstrb: SIGNAL IS "xilinx.com:interface:aximm:1.0 AES_AXI WSTRB";
  ATTRIBUTE X_INTERFACE_INFO OF aes_axi_wvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 AES_AXI WVALID";
  ATTRIBUTE X_INTERFACE_INFO OF aes_axi_wready: SIGNAL IS "xilinx.com:interface:aximm:1.0 AES_AXI WREADY";
  ATTRIBUTE X_INTERFACE_INFO OF aes_axi_bresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 AES_AXI BRESP";
  ATTRIBUTE X_INTERFACE_INFO OF aes_axi_bvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 AES_AXI BVALID";
  ATTRIBUTE X_INTERFACE_INFO OF aes_axi_bready: SIGNAL IS "xilinx.com:interface:aximm:1.0 AES_AXI BREADY";
  ATTRIBUTE X_INTERFACE_INFO OF aes_axi_araddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 AES_AXI ARADDR";
  ATTRIBUTE X_INTERFACE_INFO OF aes_axi_arprot: SIGNAL IS "xilinx.com:interface:aximm:1.0 AES_AXI ARPROT";
  ATTRIBUTE X_INTERFACE_INFO OF aes_axi_arvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 AES_AXI ARVALID";
  ATTRIBUTE X_INTERFACE_INFO OF aes_axi_arready: SIGNAL IS "xilinx.com:interface:aximm:1.0 AES_AXI ARREADY";
  ATTRIBUTE X_INTERFACE_INFO OF aes_axi_rdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 AES_AXI RDATA";
  ATTRIBUTE X_INTERFACE_INFO OF aes_axi_rresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 AES_AXI RRESP";
  ATTRIBUTE X_INTERFACE_INFO OF aes_axi_rvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 AES_AXI RVALID";
  ATTRIBUTE X_INTERFACE_INFO OF aes_axi_rready: SIGNAL IS "xilinx.com:interface:aximm:1.0 AES_AXI RREADY";
  ATTRIBUTE X_INTERFACE_INFO OF aes_axi_aclk: SIGNAL IS "xilinx.com:signal:clock:1.0 AES_AXI_CLK CLK";
  ATTRIBUTE X_INTERFACE_INFO OF aes_axi_aresetn: SIGNAL IS "xilinx.com:signal:reset:1.0 AES_AXI_RST RST";
BEGIN
  U0 : EncryptionEngine_v1_0
    GENERIC MAP (
      C_RSA_AXI_DATA_WIDTH => 32,
      C_RSA_AXI_ADDR_WIDTH => 11,
      C_Control_AXI_DATA_WIDTH => 32,
      C_Control_AXI_ADDR_WIDTH => 5,
      C_RS232_AXI_DATA_WIDTH => 32,
      C_RS232_AXI_ADDR_WIDTH => 4,
      C_AES_AXI_DATA_WIDTH => 32,
      C_AES_AXI_ADDR_WIDTH => 7,
      AES_KeySize => 128,
      RSA_KeySize => 32
    )
    PORT MAP (
      clock => clock,
      RS232_UARTRecv => RS232_UARTRecv,
      RS232_UARTXmit => RS232_UARTXmit,
      rsa_axi_awaddr => rsa_axi_awaddr,
      rsa_axi_awprot => rsa_axi_awprot,
      rsa_axi_awvalid => rsa_axi_awvalid,
      rsa_axi_awready => rsa_axi_awready,
      rsa_axi_wdata => rsa_axi_wdata,
      rsa_axi_wstrb => rsa_axi_wstrb,
      rsa_axi_wvalid => rsa_axi_wvalid,
      rsa_axi_wready => rsa_axi_wready,
      rsa_axi_bresp => rsa_axi_bresp,
      rsa_axi_bvalid => rsa_axi_bvalid,
      rsa_axi_bready => rsa_axi_bready,
      rsa_axi_araddr => rsa_axi_araddr,
      rsa_axi_arprot => rsa_axi_arprot,
      rsa_axi_arvalid => rsa_axi_arvalid,
      rsa_axi_arready => rsa_axi_arready,
      rsa_axi_rdata => rsa_axi_rdata,
      rsa_axi_rresp => rsa_axi_rresp,
      rsa_axi_rvalid => rsa_axi_rvalid,
      rsa_axi_rready => rsa_axi_rready,
      rsa_axi_aclk => rsa_axi_aclk,
      rsa_axi_aresetn => rsa_axi_aresetn,
      control_axi_awaddr => control_axi_awaddr,
      control_axi_awprot => control_axi_awprot,
      control_axi_awvalid => control_axi_awvalid,
      control_axi_awready => control_axi_awready,
      control_axi_wdata => control_axi_wdata,
      control_axi_wstrb => control_axi_wstrb,
      control_axi_wvalid => control_axi_wvalid,
      control_axi_wready => control_axi_wready,
      control_axi_bresp => control_axi_bresp,
      control_axi_bvalid => control_axi_bvalid,
      control_axi_bready => control_axi_bready,
      control_axi_araddr => control_axi_araddr,
      control_axi_arprot => control_axi_arprot,
      control_axi_arvalid => control_axi_arvalid,
      control_axi_arready => control_axi_arready,
      control_axi_rdata => control_axi_rdata,
      control_axi_rresp => control_axi_rresp,
      control_axi_rvalid => control_axi_rvalid,
      control_axi_rready => control_axi_rready,
      control_axi_aclk => control_axi_aclk,
      control_axi_aresetn => control_axi_aresetn,
      rs232_axi_awaddr => rs232_axi_awaddr,
      rs232_axi_awprot => rs232_axi_awprot,
      rs232_axi_awvalid => rs232_axi_awvalid,
      rs232_axi_awready => rs232_axi_awready,
      rs232_axi_wdata => rs232_axi_wdata,
      rs232_axi_wstrb => rs232_axi_wstrb,
      rs232_axi_wvalid => rs232_axi_wvalid,
      rs232_axi_wready => rs232_axi_wready,
      rs232_axi_bresp => rs232_axi_bresp,
      rs232_axi_bvalid => rs232_axi_bvalid,
      rs232_axi_bready => rs232_axi_bready,
      rs232_axi_araddr => rs232_axi_araddr,
      rs232_axi_arprot => rs232_axi_arprot,
      rs232_axi_arvalid => rs232_axi_arvalid,
      rs232_axi_arready => rs232_axi_arready,
      rs232_axi_rdata => rs232_axi_rdata,
      rs232_axi_rresp => rs232_axi_rresp,
      rs232_axi_rvalid => rs232_axi_rvalid,
      rs232_axi_rready => rs232_axi_rready,
      rs232_axi_aclk => rs232_axi_aclk,
      rs232_axi_aresetn => rs232_axi_aresetn,
      aes_axi_awaddr => aes_axi_awaddr,
      aes_axi_awprot => aes_axi_awprot,
      aes_axi_awvalid => aes_axi_awvalid,
      aes_axi_awready => aes_axi_awready,
      aes_axi_wdata => aes_axi_wdata,
      aes_axi_wstrb => aes_axi_wstrb,
      aes_axi_wvalid => aes_axi_wvalid,
      aes_axi_wready => aes_axi_wready,
      aes_axi_bresp => aes_axi_bresp,
      aes_axi_bvalid => aes_axi_bvalid,
      aes_axi_bready => aes_axi_bready,
      aes_axi_araddr => aes_axi_araddr,
      aes_axi_arprot => aes_axi_arprot,
      aes_axi_arvalid => aes_axi_arvalid,
      aes_axi_arready => aes_axi_arready,
      aes_axi_rdata => aes_axi_rdata,
      aes_axi_rresp => aes_axi_rresp,
      aes_axi_rvalid => aes_axi_rvalid,
      aes_axi_rready => aes_axi_rready,
      aes_axi_aclk => aes_axi_aclk,
      aes_axi_aresetn => aes_axi_aresetn
    );
END EncryptionSubsystem_EncryptionEngine_0_0_arch;