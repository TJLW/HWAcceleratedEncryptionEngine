--Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2015.4 (lin64) Build 1412921 Wed Nov 18 09:44:32 MST 2015
--Date        : Wed Apr  5 02:48:47 2017
--Host        : MinuxBox running 64-bit Ubuntu 14.04.5 LTS
--Command     : generate_target EncryptionSubsystem_wrapper.bd
--Design      : EncryptionSubsystem_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity EncryptionSubsystem_wrapper is
  port (
    UARTRecv : in STD_LOGIC;
    UART_XMIT : out STD_LOGIC;
    reset : in STD_LOGIC;
    sys_diff_clock_clk_n : in STD_LOGIC;
    sys_diff_clock_clk_p : in STD_LOGIC
  );
end EncryptionSubsystem_wrapper;

architecture STRUCTURE of EncryptionSubsystem_wrapper is
  component EncryptionSubsystem is
  port (
    sys_diff_clock_clk_n : in STD_LOGIC;
    sys_diff_clock_clk_p : in STD_LOGIC;
    UART_XMIT : out STD_LOGIC;
    UARTRecv : in STD_LOGIC;
    reset : in STD_LOGIC
  );
  end component EncryptionSubsystem;
begin
EncryptionSubsystem_i: component EncryptionSubsystem
     port map (
      UARTRecv => UARTRecv,
      UART_XMIT => UART_XMIT,
      reset => reset,
      sys_diff_clock_clk_n => sys_diff_clock_clk_n,
      sys_diff_clock_clk_p => sys_diff_clock_clk_p
    );
end STRUCTURE;
