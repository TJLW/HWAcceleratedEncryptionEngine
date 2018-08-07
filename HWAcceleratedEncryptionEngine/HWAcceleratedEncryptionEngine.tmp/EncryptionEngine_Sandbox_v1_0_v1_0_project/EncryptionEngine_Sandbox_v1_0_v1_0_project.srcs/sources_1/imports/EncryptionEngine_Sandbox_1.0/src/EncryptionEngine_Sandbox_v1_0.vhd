library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity EncryptionEngine_Sandbox_v1_0 is
	generic (
		-- Users to add parameters here

        AES_KeySize : integer := 128;
        RSA_KeySize : integer := 32;

		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Slave Bus Interface AES_AXI
		C_AES_AXI_DATA_WIDTH	: integer	:= 32;
		C_AES_AXI_ADDR_WIDTH	: integer	:= 7;

		-- Parameters of Axi Slave Bus Interface RSA_AXI
		C_RSA_AXI_DATA_WIDTH	: integer	:= 32;
		C_RSA_AXI_ADDR_WIDTH	: integer	:= 11;

		-- Parameters of Axi Slave Bus Interface RS232_AXI
		C_RS232_AXI_DATA_WIDTH	: integer	:= 32;
		C_RS232_AXI_ADDR_WIDTH	: integer	:= 4;

		-- Parameters of Axi Slave Bus Interface Control_AXI
		C_Control_AXI_DATA_WIDTH	: integer	:= 32;
		C_Control_AXI_ADDR_WIDTH	: integer	:= 5
	);
	port (
		-- Users to add ports here

        clock : in STD_LOGIC;
        RS232_UARTRecv           : in STD_LOGIC;
        RS232_UARTXmit           : out STD_LOGIC;

		-- User ports ends
		-- Do not modify the ports beyond this line


		-- Ports of Axi Slave Bus Interface AES_AXI
		aes_axi_aclk	: in std_logic;
		aes_axi_aresetn	: in std_logic;
		aes_axi_awaddr	: in std_logic_vector(C_AES_AXI_ADDR_WIDTH-1 downto 0);
		aes_axi_awprot	: in std_logic_vector(2 downto 0);
		aes_axi_awvalid	: in std_logic;
		aes_axi_awready	: out std_logic;
		aes_axi_wdata	: in std_logic_vector(C_AES_AXI_DATA_WIDTH-1 downto 0);
		aes_axi_wstrb	: in std_logic_vector((C_AES_AXI_DATA_WIDTH/8)-1 downto 0);
		aes_axi_wvalid	: in std_logic;
		aes_axi_wready	: out std_logic;
		aes_axi_bresp	: out std_logic_vector(1 downto 0);
		aes_axi_bvalid	: out std_logic;
		aes_axi_bready	: in std_logic;
		aes_axi_araddr	: in std_logic_vector(C_AES_AXI_ADDR_WIDTH-1 downto 0);
		aes_axi_arprot	: in std_logic_vector(2 downto 0);
		aes_axi_arvalid	: in std_logic;
		aes_axi_arready	: out std_logic;
		aes_axi_rdata	: out std_logic_vector(C_AES_AXI_DATA_WIDTH-1 downto 0);
		aes_axi_rresp	: out std_logic_vector(1 downto 0);
		aes_axi_rvalid	: out std_logic;
		aes_axi_rready	: in std_logic;

		-- Ports of Axi Slave Bus Interface RSA_AXI
		rsa_axi_aclk	: in std_logic;
		rsa_axi_aresetn	: in std_logic;
		rsa_axi_awaddr	: in std_logic_vector(C_RSA_AXI_ADDR_WIDTH-1 downto 0);
		rsa_axi_awprot	: in std_logic_vector(2 downto 0);
		rsa_axi_awvalid	: in std_logic;
		rsa_axi_awready	: out std_logic;
		rsa_axi_wdata	: in std_logic_vector(C_RSA_AXI_DATA_WIDTH-1 downto 0);
		rsa_axi_wstrb	: in std_logic_vector((C_RSA_AXI_DATA_WIDTH/8)-1 downto 0);
		rsa_axi_wvalid	: in std_logic;
		rsa_axi_wready	: out std_logic;
		rsa_axi_bresp	: out std_logic_vector(1 downto 0);
		rsa_axi_bvalid	: out std_logic;
		rsa_axi_bready	: in std_logic;
		rsa_axi_araddr	: in std_logic_vector(C_RSA_AXI_ADDR_WIDTH-1 downto 0);
		rsa_axi_arprot	: in std_logic_vector(2 downto 0);
		rsa_axi_arvalid	: in std_logic;
		rsa_axi_arready	: out std_logic;
		rsa_axi_rdata	: out std_logic_vector(C_RSA_AXI_DATA_WIDTH-1 downto 0);
		rsa_axi_rresp	: out std_logic_vector(1 downto 0);
		rsa_axi_rvalid	: out std_logic;
		rsa_axi_rready	: in std_logic;

		-- Ports of Axi Slave Bus Interface RS232_AXI
		rs232_axi_aclk	: in std_logic;
		rs232_axi_aresetn	: in std_logic;
		rs232_axi_awaddr	: in std_logic_vector(C_RS232_AXI_ADDR_WIDTH-1 downto 0);
		rs232_axi_awprot	: in std_logic_vector(2 downto 0);
		rs232_axi_awvalid	: in std_logic;
		rs232_axi_awready	: out std_logic;
		rs232_axi_wdata	: in std_logic_vector(C_RS232_AXI_DATA_WIDTH-1 downto 0);
		rs232_axi_wstrb	: in std_logic_vector((C_RS232_AXI_DATA_WIDTH/8)-1 downto 0);
		rs232_axi_wvalid	: in std_logic;
		rs232_axi_wready	: out std_logic;
		rs232_axi_bresp	: out std_logic_vector(1 downto 0);
		rs232_axi_bvalid	: out std_logic;
		rs232_axi_bready	: in std_logic;
		rs232_axi_araddr	: in std_logic_vector(C_RS232_AXI_ADDR_WIDTH-1 downto 0);
		rs232_axi_arprot	: in std_logic_vector(2 downto 0);
		rs232_axi_arvalid	: in std_logic;
		rs232_axi_arready	: out std_logic;
		rs232_axi_rdata	: out std_logic_vector(C_RS232_AXI_DATA_WIDTH-1 downto 0);
		rs232_axi_rresp	: out std_logic_vector(1 downto 0);
		rs232_axi_rvalid	: out std_logic;
		rs232_axi_rready	: in std_logic;

		-- Ports of Axi Slave Bus Interface Control_AXI
		control_axi_aclk	: in std_logic;
		control_axi_aresetn	: in std_logic;
		control_axi_awaddr	: in std_logic_vector(C_Control_AXI_ADDR_WIDTH-1 downto 0);
		control_axi_awprot	: in std_logic_vector(2 downto 0);
		control_axi_awvalid	: in std_logic;
		control_axi_awready	: out std_logic;
		control_axi_wdata	: in std_logic_vector(C_Control_AXI_DATA_WIDTH-1 downto 0);
		control_axi_wstrb	: in std_logic_vector((C_Control_AXI_DATA_WIDTH/8)-1 downto 0);
		control_axi_wvalid	: in std_logic;
		control_axi_wready	: out std_logic;
		control_axi_bresp	: out std_logic_vector(1 downto 0);
		control_axi_bvalid	: out std_logic;
		control_axi_bready	: in std_logic;
		control_axi_araddr	: in std_logic_vector(C_Control_AXI_ADDR_WIDTH-1 downto 0);
		control_axi_arprot	: in std_logic_vector(2 downto 0);
		control_axi_arvalid	: in std_logic;
		control_axi_arready	: out std_logic;
		control_axi_rdata	: out std_logic_vector(C_Control_AXI_DATA_WIDTH-1 downto 0);
		control_axi_rresp	: out std_logic_vector(1 downto 0);
		control_axi_rvalid	: out std_logic;
		control_axi_rready	: in std_logic
	);
end EncryptionEngine_Sandbox_v1_0;

architecture arch_imp of EncryptionEngine_Sandbox_v1_0 is

	-- Core select signals
	--###############################
	signal AES_CoreSelect           		: STD_LOGIC_VECTOR(1 downto 0) := (others => '0');  -- 4 cores currently
	signal RSA_CoreSelect           		: STD_LOGIC_VECTOR(1 downto 0) := (others => '0');  -- 3 cores currently
	signal RS232_CoreSelect         		: STD_LOGIC_VECTOR(1 downto 0) := (others => '0');  -- 4 cores currently


	-- AES signals
	--###############################
	signal AES_SWLoad               		: STD_LOGIC := '0';
	signal AES_HWLoad               		: STD_LOGIC := '0';

	signal AES_Key                  		: STD_LOGIC_VECTOR(AES_KeySize-1 downto 0) := (others => '0');
	signal AES_Reset                		: STD_LOGIC := '0';

	signal AES_DataIn_SBI               : STD_LOGIC_VECTOR(AES_KeySize-1 downto 0) := (others => '0');
	signal AES_DataOut_SBI              : STD_LOGIC_VECTOR(AES_KeySize-1 downto 0) := (others => '0');

	signal AES_DataIn_SBO               : STD_LOGIC_VECTOR(AES_KeySize-1 downto 0) := (others => '0');
	signal AES_DataOut_SBO              : STD_LOGIC_VECTOR(AES_KeySize-1 downto 0) := (others => '0');


	-- RSA signals
	--###############################
	signal RSA_SWLoad               		: STD_LOGIC := '0';
	signal RSA_HWLoad               		: STD_LOGIC := '0';

	signal RSA_Mod                  		: STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0) := (others => '0');
	signal RSA_Reset                		: STD_LOGIC := '0';

	signal RSA_Exp_SBI                  : STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0) := (others => '0');
	signal RSA_DataIn_SBI               : STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0) := (others => '0');
	signal RSA_DataOut_SBI              : STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0) := (others => '0');
	signal RSA_Ready_SBI                : STD_LOGIC := '0';
	signal RSA_ds_SBI                   : STD_LOGIC := '0';

	signal RSA_Exp_SBO                  : STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0) := (others => '0');
	signal RSA_DataIn_SBO               : STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0) := (others => '0');
	signal RSA_DataOut_SBO              : STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0) := (others => '0');
	signal RSA_Ready_SBO                : STD_LOGIC := '0';
	signal RSA_ds_SBO                   : STD_LOGIC := '0';


	-- RS232 signals
	--###############################
	signal RS232_SWLoad             		: STD_LOGIC := '0';
	signal RS232_HWLoad            		  : STD_LOGIC := '0';

	signal RS232_Reset              		: STD_LOGIC := '0';

	signal RS232_DataIn_SBI             : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal RS232_DataOut_SBI            : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal RS232_RecvReady_SBI          : STD_LOGIC := '0';
	signal RS232_Done_SBI               : STD_LOGIC := '0';
	signal RS232_xmitH_SBI              : STD_LOGIC := '0';
	signal RS232_UARTRecv_SBI           : STD_LOGIC;
	signal RS232_UARTXmit_SBI           : STD_LOGIC;

	signal RS232_DataIn_SBO             : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal RS232_DataOut_SBO            : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal RS232_RecvReady_SBO          : STD_LOGIC := '0';
	signal RS232_Done_SBO               : STD_LOGIC := '0';
	signal RS232_xmitH_SBO              : STD_LOGIC := '0';
	signal RS232_UARTRecv_SBO           : STD_LOGIC;
	signal RS232_UARTXmit_SBO           : STD_LOGIC;


	-- Status signal
	signal Deactivated : STD_LOGIC := '0';


	-- component declaration

    component SandboxController is
        generic (
      AES_KeySize : integer := 128;
      RSA_KeySize : integer := 2048
    );
        port (
        ControlClock       : in STD_LOGIC;

	      -- Status signal
	      Deactivated 			 : out STD_LOGIC;

        -- AES signals
        --###############################
        AES_DataIn_SBI               : in STD_LOGIC_VECTOR(AES_KeySize-1 downto 0);
        AES_DataOut_SBI              : in STD_LOGIC_VECTOR(AES_KeySize-1 downto 0);

        AES_DataIn_SBO               : out STD_LOGIC_VECTOR(AES_KeySize-1 downto 0);
        AES_DataOut_SBO              : out STD_LOGIC_VECTOR(AES_KeySize-1 downto 0);


        -- RSA signals
        --###############################
        RSA_Exp_SBI                  : in STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0);
        RSA_DataIn_SBI               : in STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0);
        RSA_DataOut_SBI              : in STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0);
        RSA_Ready_SBI                : in STD_LOGIC;
        RSA_ds_SBI                   : in STD_LOGIC;

        RSA_Exp_SBO                  : out STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0);
        RSA_DataIn_SBO               : out STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0);
        RSA_DataOut_SBO              : out STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0);
        RSA_Ready_SBO                : out STD_LOGIC;
        RSA_ds_SBO                   : out STD_LOGIC;


        -- RS232 signals
        --###############################
        RS232_DataIn_SBI             : in STD_LOGIC_VECTOR(7 downto 0);
        RS232_DataOut_SBI            : in STD_LOGIC_VECTOR(7 downto 0);
        RS232_RecvReady_SBI          : in STD_LOGIC;
        RS232_Done_SBI               : in STD_LOGIC;
        RS232_xmitH_SBI              : in STD_LOGIC;
        RS232_UARTRecv_SBI           : in STD_LOGIC;
        RS232_UARTXmit_SBI           : in STD_LOGIC;

        RS232_DataIn_SBO             : out STD_LOGIC_VECTOR(7 downto 0);
        RS232_DataOut_SBO            : out STD_LOGIC_VECTOR(7 downto 0);
        RS232_RecvReady_SBO          : out STD_LOGIC;
        RS232_Done_SBO               : out STD_LOGIC;
        RS232_xmitH_SBO              : out STD_LOGIC;
        RS232_UARTRecv_SBO           : out STD_LOGIC;
        RS232_UARTXmit_SBO           : out STD_LOGIC
        );
    end component;

	component EncryptionEngine is
    generic (
        AES_KeySize : integer := AES_KeySize;
        RSA_KeySize : integer := RSA_KeySize
    );
    port (
    clock                    : in STD_LOGIC;
    AES_CoreSelect           : in STD_LOGIC_VECTOR(1 downto 0);  -- 4 cores currently
    RSA_CoreSelect           : in STD_LOGIC_VECTOR(1 downto 0);  -- 3 cores currently
    RS232_CoreSelect         : in STD_LOGIC_VECTOR(1 downto 0);  -- 4 cores currently
    AES_Key                  : in STD_LOGIC_VECTOR(AES_KeySize-1 downto 0);
    AES_DataIn               : in STD_LOGIC_VECTOR(AES_KeySize-1 downto 0);
    AES_DataOut              : out STD_LOGIC_VECTOR(AES_KeySize-1 downto 0);
    AES_Reset                : in STD_LOGIC;
    RSA_Exp                  : in STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0);
    RSA_Mod                  : in STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0);
    RSA_DataIn               : in STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0);
    RSA_DataOut              : out STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0);
    RSA_Ready                : out STD_LOGIC;
    RSA_Reset                : in STD_LOGIC;
    RSA_ds                   : in STD_LOGIC;
    RS232_DataIn             : in STD_LOGIC_VECTOR(7 downto 0);
    RS232_DataOut            : out STD_LOGIC_VECTOR(7 downto 0);
    RS232_UARTRecv           : in STD_LOGIC;
    RS232_UARTXmit           : out STD_LOGIC;
    RS232_RecvReady          : out STD_LOGIC;
    RS232_Reset              : in STD_LOGIC;
    RS232_Done               : out STD_LOGIC;
    RS232_xmitH              : in STD_LOGIC
    );
  end component EncryptionEngine;

	component EncryptionEngine_v1_0_AES_AXI is
		generic (
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 7;

        AES_KeySize : integer := AES_KeySize
		);
		port (
		S_AXI_ACLK	: in std_logic;
		S_AXI_ARESETN	: in std_logic;
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		S_AXI_AWVALID	: in std_logic;
		S_AXI_AWREADY	: out std_logic;
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WVALID	: in std_logic;
		S_AXI_WREADY	: out std_logic;
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		S_AXI_BVALID	: out std_logic;
		S_AXI_BREADY	: in std_logic;
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		S_AXI_ARVALID	: in std_logic;
		S_AXI_ARREADY	: out std_logic;
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		S_AXI_RVALID	: out std_logic;
		S_AXI_RREADY	: in std_logic;

        AES_Key                  : out STD_LOGIC_VECTOR(AES_KeySize-1 downto 0);
        AES_DataIn               : out STD_LOGIC_VECTOR(AES_KeySize-1 downto 0);
        AES_DataOut              : in STD_LOGIC_VECTOR(AES_KeySize-1 downto 0)
		);
	end component EncryptionEngine_v1_0_AES_AXI;

	component EncryptionEngine_v1_0_RSA_AXI is
		generic (
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 11;

        RSA_KeySize : integer := RSA_KeySize
		);
		port (
		S_AXI_ACLK	: in std_logic;
		S_AXI_ARESETN	: in std_logic;
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		S_AXI_AWVALID	: in std_logic;
		S_AXI_AWREADY	: out std_logic;
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WVALID	: in std_logic;
		S_AXI_WREADY	: out std_logic;
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		S_AXI_BVALID	: out std_logic;
		S_AXI_BREADY	: in std_logic;
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		S_AXI_ARVALID	: in std_logic;
		S_AXI_ARREADY	: out std_logic;
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		S_AXI_RVALID	: out std_logic;
		S_AXI_RREADY	: in std_logic;

        RSA_Exp                  : out STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0);
        RSA_Mod                  : out STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0);
        RSA_DataIn               : out STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0);
        RSA_DataOut              : in STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0)
		);
	end component EncryptionEngine_v1_0_RSA_AXI;

	component EncryptionEngine_v1_0_RS232_AXI is
		generic (
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 4
		);
		port (
		S_AXI_ACLK	: in std_logic;
		S_AXI_ARESETN	: in std_logic;
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		S_AXI_AWVALID	: in std_logic;
		S_AXI_AWREADY	: out std_logic;
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WVALID	: in std_logic;
		S_AXI_WREADY	: out std_logic;
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		S_AXI_BVALID	: out std_logic;
		S_AXI_BREADY	: in std_logic;
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		S_AXI_ARVALID	: in std_logic;
		S_AXI_ARREADY	: out std_logic;
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		S_AXI_RVALID	: out std_logic;
		S_AXI_RREADY	: in std_logic;

        RS232_DataIn             : out STD_LOGIC_VECTOR(7 downto 0);
        RS232_DataOut            : in STD_LOGIC_VECTOR(7 downto 0)
		);
	end component EncryptionEngine_v1_0_RS232_AXI;

	component EncryptionEngine_v1_0_Control_AXI is
		generic (
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 5
		);
		port (
		S_AXI_ACLK	: in std_logic;
		S_AXI_ARESETN	: in std_logic;
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		S_AXI_AWVALID	: in std_logic;
		S_AXI_AWREADY	: out std_logic;
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WVALID	: in std_logic;
		S_AXI_WREADY	: out std_logic;
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		S_AXI_BVALID	: out std_logic;
		S_AXI_BREADY	: in std_logic;
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		S_AXI_ARVALID	: in std_logic;
		S_AXI_ARREADY	: out std_logic;
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		S_AXI_RVALID	: out std_logic;
		S_AXI_RREADY	: in std_logic;

        AES_SWLoad               : out STD_LOGIC;
        AES_HWLoad               : in STD_LOGIC;
        AES_CoreSelect           : out STD_LOGIC_VECTOR(1 downto 0);

        RSA_SWLoad               : out STD_LOGIC;
        RSA_HWLoad               : in STD_LOGIC;
        RSA_CoreSelect           : out STD_LOGIC_VECTOR(1 downto 0);

        RS232_SWLoad             : out STD_LOGIC;
        RS232_HWLoad             : in STD_LOGIC;
        RS232_CoreSelect         : out STD_LOGIC_VECTOR(1 downto 0)
		);
	end component EncryptionEngine_v1_0_Control_AXI;

begin

	-- Instantiation of Sandbox Controller
	Controller : SandboxController
	generic map(AES_KeySize, RSA_KeySize)
	port map(
		clock, Deactivated,
		AES_DataIn_SBI, AES_DataOut_SBI,
		AES_DataIn_SBO, AES_DataOut_SBO,
		RSA_Exp_SBI, RSA_DataIn_SBI, RSA_DataOut_SBI, RSA_Ready_SBI, RSA_ds_SBI,
		RSA_Exp_SBO, RSA_DataIn_SBO, RSA_DataOut_SBO, RSA_Ready_SBO, RSA_ds_SBO,
		RS232_DataIn_SBI, RS232_DataOut_SBI, RS232_RecvReady_SBI, RS232_Done_SBI, RS232_xmitH_SBI, RS232_UARTRecv_SBI, RS232_UARTXmit_SBI,
		RS232_DataIn_SBO, RS232_DataOut_SBO, RS232_RecvReady_SBO, RS232_Done_SBO, RS232_xmitH_SBO, RS232_UARTRecv_SBO, RS232_UARTXmit_SBO
	);

	-- Instantiation of Axi Bus Interface AES_AXI
	EncryptionEngine_v1_0_AES_AXI_inst : EncryptionEngine_v1_0_AES_AXI
		generic map (
			C_S_AXI_DATA_WIDTH	=> C_AES_AXI_DATA_WIDTH,
			C_S_AXI_ADDR_WIDTH	=> C_AES_AXI_ADDR_WIDTH,

			AES_KeySize => AES_KeySize
		)
		port map (
			S_AXI_ACLK	=> aes_axi_aclk,
			S_AXI_ARESETN	=> aes_axi_aresetn,
			S_AXI_AWADDR	=> aes_axi_awaddr,
			S_AXI_AWPROT	=> aes_axi_awprot,
			S_AXI_AWVALID	=> aes_axi_awvalid,
			S_AXI_AWREADY	=> aes_axi_awready,
			S_AXI_WDATA	=> aes_axi_wdata,
			S_AXI_WSTRB	=> aes_axi_wstrb,
			S_AXI_WVALID	=> aes_axi_wvalid,
			S_AXI_WREADY	=> aes_axi_wready,
			S_AXI_BRESP	=> aes_axi_bresp,
			S_AXI_BVALID	=> aes_axi_bvalid,
			S_AXI_BREADY	=> aes_axi_bready,
			S_AXI_ARADDR	=> aes_axi_araddr,
			S_AXI_ARPROT	=> aes_axi_arprot,
			S_AXI_ARVALID	=> aes_axi_arvalid,
			S_AXI_ARREADY	=> aes_axi_arready,
			S_AXI_RDATA	=> aes_axi_rdata,
			S_AXI_RRESP	=> aes_axi_rresp,
			S_AXI_RVALID	=> aes_axi_rvalid,
			S_AXI_RREADY	=> aes_axi_rready,

	    AES_Key => AES_Key,
	    AES_DataIn => AES_DataIn_SBI,
	    AES_DataOut => AES_DataOut_SBO
		);

	-- Instantiation of Axi Bus Interface RSA_AXI
	EncryptionEngine_v1_0_RSA_AXI_inst : EncryptionEngine_v1_0_RSA_AXI
		generic map (
			C_S_AXI_DATA_WIDTH	=> C_RSA_AXI_DATA_WIDTH,
			C_S_AXI_ADDR_WIDTH	=> C_RSA_AXI_ADDR_WIDTH,

			RSA_KeySize => RSA_KeySize
		)
		port map (
			S_AXI_ACLK	=> rsa_axi_aclk,
			S_AXI_ARESETN	=> rsa_axi_aresetn,
			S_AXI_AWADDR	=> rsa_axi_awaddr,
			S_AXI_AWPROT	=> rsa_axi_awprot,
			S_AXI_AWVALID	=> rsa_axi_awvalid,
			S_AXI_AWREADY	=> rsa_axi_awready,
			S_AXI_WDATA	=> rsa_axi_wdata,
			S_AXI_WSTRB	=> rsa_axi_wstrb,
			S_AXI_WVALID	=> rsa_axi_wvalid,
			S_AXI_WREADY	=> rsa_axi_wready,
			S_AXI_BRESP	=> rsa_axi_bresp,
			S_AXI_BVALID	=> rsa_axi_bvalid,
			S_AXI_BREADY	=> rsa_axi_bready,
			S_AXI_ARADDR	=> rsa_axi_araddr,
			S_AXI_ARPROT	=> rsa_axi_arprot,
			S_AXI_ARVALID	=> rsa_axi_arvalid,
			S_AXI_ARREADY	=> rsa_axi_arready,
			S_AXI_RDATA	=> rsa_axi_rdata,
			S_AXI_RRESP	=> rsa_axi_rresp,
			S_AXI_RVALID	=> rsa_axi_rvalid,
			S_AXI_RREADY	=> rsa_axi_rready,

      RSA_Exp => RSA_Exp_SBI,
      RSA_Mod => RSA_Mod,
      RSA_DataIn => RSA_DataIn_SBI,
      RSA_DataOut=> RSA_DataOut_SBO
		);

	-- Instantiation of Axi Bus Interface RS232_AXI
	EncryptionEngine_v1_0_RS232_AXI_inst : EncryptionEngine_v1_0_RS232_AXI
		generic map (
			C_S_AXI_DATA_WIDTH	=> C_RS232_AXI_DATA_WIDTH,
			C_S_AXI_ADDR_WIDTH	=> C_RS232_AXI_ADDR_WIDTH
		)
		port map (
			S_AXI_ACLK	=> rs232_axi_aclk,
			S_AXI_ARESETN	=> rs232_axi_aresetn,
			S_AXI_AWADDR	=> rs232_axi_awaddr,
			S_AXI_AWPROT	=> rs232_axi_awprot,
			S_AXI_AWVALID	=> rs232_axi_awvalid,
			S_AXI_AWREADY	=> rs232_axi_awready,
			S_AXI_WDATA	=> rs232_axi_wdata,
			S_AXI_WSTRB	=> rs232_axi_wstrb,
			S_AXI_WVALID	=> rs232_axi_wvalid,
			S_AXI_WREADY	=> rs232_axi_wready,
			S_AXI_BRESP	=> rs232_axi_bresp,
			S_AXI_BVALID	=> rs232_axi_bvalid,
			S_AXI_BREADY	=> rs232_axi_bready,
			S_AXI_ARADDR	=> rs232_axi_araddr,
			S_AXI_ARPROT	=> rs232_axi_arprot,
			S_AXI_ARVALID	=> rs232_axi_arvalid,
			S_AXI_ARREADY	=> rs232_axi_arready,
			S_AXI_RDATA	=> rs232_axi_rdata,
			S_AXI_RRESP	=> rs232_axi_rresp,
			S_AXI_RVALID	=> rs232_axi_rvalid,
			S_AXI_RREADY	=> rs232_axi_rready,

      RS232_DataIn => RS232_DataIn_SBI,
      RS232_DataOut => RS232_DataOut_SBO
		);

	-- Instantiation of Axi Bus Interface Control_AXI
	EncryptionEngine_v1_0_Control_AXI_inst : EncryptionEngine_v1_0_Control_AXI
		generic map (
			C_S_AXI_DATA_WIDTH	=> C_Control_AXI_DATA_WIDTH,
			C_S_AXI_ADDR_WIDTH	=> C_Control_AXI_ADDR_WIDTH
		)
		port map (
			S_AXI_ACLK	=> control_axi_aclk,
			S_AXI_ARESETN	=> control_axi_aresetn,
			S_AXI_AWADDR	=> control_axi_awaddr,
			S_AXI_AWPROT	=> control_axi_awprot,
			S_AXI_AWVALID	=> control_axi_awvalid,
			S_AXI_AWREADY	=> control_axi_awready,
			S_AXI_WDATA	=> control_axi_wdata,
			S_AXI_WSTRB	=> control_axi_wstrb,
			S_AXI_WVALID	=> control_axi_wvalid,
			S_AXI_WREADY	=> control_axi_wready,
			S_AXI_BRESP	=> control_axi_bresp,
			S_AXI_BVALID	=> control_axi_bvalid,
			S_AXI_BREADY	=> control_axi_bready,
			S_AXI_ARADDR	=> control_axi_araddr,
			S_AXI_ARPROT	=> control_axi_arprot,
			S_AXI_ARVALID	=> control_axi_arvalid,
			S_AXI_ARREADY	=> control_axi_arready,
			S_AXI_RDATA	=> control_axi_rdata,
			S_AXI_RRESP	=> control_axi_rresp,
			S_AXI_RVALID	=> control_axi_rvalid,
			S_AXI_RREADY	=> control_axi_rready,

      AES_SWLoad => AES_SWLoad,
      AES_HWLoad => AES_HWLoad,
      AES_CoreSelect => AES_CoreSelect,
      RSA_SWLoad => RSA_SWLoad,
      RSA_HWLoad => RSA_HWLoad,
      RSA_CoreSelect => RSA_CoreSelect,
      RS232_SWLoad => RS232_SWLoad,
      RS232_HWLoad => RS232_HWLoad,
      RS232_CoreSelect => RS232_CoreSelect
		);

		-- Add user logic here

	-- Instantiation of encryption engine
	EE : EncryptionEngine
		port map(clock,
		         AES_CoreSelect, RSA_CoreSelect, RS232_CoreSelect,
		         AES_Key, AES_DataIn_SBO, AES_DataOut_SBI, AES_Reset,
		         RSA_Exp_SBO, RSA_Mod, RSA_DataIn_SBO, RSA_DataOut_SBI, RSA_Ready_SBI, RSA_Reset, RSA_ds_SBO,
		         RS232_DataIn_SBO, RS232_DataOut_SBI, RS232_UARTRecv_SBO, RS232_UARTXmit_SBI, RS232_RecvReady_SBI, RS232_Reset, RS232_Done_SBI, RS232_xmitH_SBO
		);


	-- Deactivation example
	RS232_UARTRecv_SBI <= RS232_UARTRecv when Deactivated = '0' else '0';
	RS232_UARTXmit <= RS232_UARTXmit_SBO when Deactivated = '0' else '0';




	-- AES Processes
	process(AES_SWLoad, AES_DataOut_SBO)
    begin
    if(AES_SWLoad = '1') then
        AES_HWLoad <= '0';
    
        -- AES Cores takes ~225ns (22.5 clock cycles) on 100 MHz clock to produce output
    end if;
    
    if(AES_HWLoad = '0') then
        AES_HWLoad <= '1';
    end if;
    end process;
    
    
    -- RSA Processes
    process(RSA_SWLoad, RSA_Ready_SBO)
    begin
    if(RSA_SWLoad = '1') then
        RSA_ds_SBI <= '1';
        RSA_HWLoad <= '0';
    end if;
    
    if(RSA_Ready_SBO = '1') then
        RSA_ds_SBI <= '1';
        RSA_HWLoad <= '1';
    else
        RSA_ds_SBI <= '0';
    end if;
    end process;


	-- RS232 Process
	process(RS232_SWLoad, RS232_RecvReady_SBO)
	begin
    if(RS232_SWLoad = '1') then
        RS232_HWLoad <= '0';
    end if;

    if(RS232_RecvReady_SBO = '1') then
        RS232_HWLoad <= '1';
    else
        RS232_HWLoad <= '0';
    end if;
	end process;


	-- User logic ends

end arch_imp;