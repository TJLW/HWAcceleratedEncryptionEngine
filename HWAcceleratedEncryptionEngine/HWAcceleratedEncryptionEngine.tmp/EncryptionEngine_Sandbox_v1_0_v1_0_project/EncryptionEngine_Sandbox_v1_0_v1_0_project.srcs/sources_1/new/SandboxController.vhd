library IEEE;
use IEEE.std_logic_1164.all;

-- Controller Module

entity SandboxController is
    generic (
      AES_KeySize : integer := 128;
      RSA_KeySize : integer := 32
    );
	port(
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

	   -- Still need to handle ip with internal signals satisfied by other ip. These internal connections need to be made
	);
    attribute keep_hierarchy : string;
    attribute keep_hierarchy of SandboxController : entity is "yes";
end SandboxController;



architecture Behavioral of SandboxController is

    -- Signals
    signal Status : std_logic_vector(8 downto 0);
    signal SandboxInputSignals: std_logic_vector(20 downto 0);
    signal SandboxOutputSignals : std_logic_vector(20 downto 0);
    
    component Checker is
      port(
        ControlClock            : in  std_logic;    -- Control clock assertions will allow transition to occur
        SignalSet               : in  std_logic_vector(20 downto 0);    -- All signals are input here to determine the correct transition

        AES_state                                : in std_logic_vector(AES_KeySize-1 downto 0); -- Saving time by putting these big vectors here (new format)
        AES_Out                                    : in std_logic_vector(AES_KeySize-1 downto 0);

        RSA_ds                                    : in std_logic;
        RSA_ready                                : in std_logic;
        RSA_inExp                                : in std_logic_vector(RSA_KeySize-1 downto 0);
        RSA_inData                          : in std_logic_vector(RSA_KeySize-1 downto 0);
        RSA_cypher                            : in std_logic_vector(RSA_KeySize-1 downto 0);

        IllegalStateDetections  : out std_logic_vector(8 downto 0)    -- Illegal state detections are asserted via this port

        );
    end component Checker;


    -- Borrowed function to do VHDL 2008 and-reduct operation
    function and_reduct(slv : in std_logic_vector) return std_logic is
      variable res_v : std_logic := '1';  -- Null slv vector will also return '1'
    begin
      for i in slv'range loop
        res_v := res_v and slv(i);
      end loop;
      return res_v;
    end function;

begin

    -- Group the shared signals by input
    --  Any signal that is an input to the sandbox controller
    SandboxInputSignals(0)  <= RS232_xmitH_SBI;
    SandboxInputSignals(1)  <= RS232_UARTRecv_SBI;
    SandboxInputSignals(2)  <= RS232_Done_SBI;
    SandboxInputSignals(3)  <= RS232_UARTXmit_SBI;
    SandboxInputSignals(4)  <= RS232_RecvReady_SBI;
    SandboxInputSignals(5)  <= RS232_DataIn_SBI(0);
    SandboxInputSignals(6)  <= RS232_DataIn_SBI(1);
    SandboxInputSignals(7)  <= RS232_DataIn_SBI(2);
    SandboxInputSignals(8)  <= RS232_DataIn_SBI(3);
    SandboxInputSignals(9)  <= RS232_DataIn_SBI(4);
    SandboxInputSignals(10) <= RS232_DataIn_SBI(5);
    SandboxInputSignals(11) <= RS232_DataIn_SBI(6);
    SandboxInputSignals(12) <= RS232_DataIn_SBI(7);
    SandboxInputSignals(13) <= RS232_DataOut_SBI(0);
    SandboxInputSignals(14) <= RS232_DataOut_SBI(1);
    SandboxInputSignals(15) <= RS232_DataOut_SBI(2);
    SandboxInputSignals(16) <= RS232_DataOut_SBI(3);
    SandboxInputSignals(17) <= RS232_DataOut_SBI(4);
    SandboxInputSignals(18) <= RS232_DataOut_SBI(5);
    SandboxInputSignals(19) <= RS232_DataOut_SBI(6);
    SandboxInputSignals(20) <= RS232_DataOut_SBI(7);

    -- Group the shared signals by output
    --  Any signal that is an output from the sandbox controller
    RS232_xmitH_SBO         <= SandboxOutputSignals(0);
    RS232_UARTRecv_SBO      <= SandboxOutputSignals(1);
    RS232_Done_SBO          <= SandboxOutputSignals(2);
    RS232_UARTXmit_SBO      <= SandboxOutputSignals(3);
    RS232_RecvReady_SBO     <= SandboxOutputSignals(4);
    RS232_DataIn_SBO(0)     <= SandboxOutputSignals(5);
    RS232_DataIn_SBO(1)     <= SandboxOutputSignals(6);
    RS232_DataIn_SBO(2)     <= SandboxOutputSignals(7);
    RS232_DataIn_SBO(3)     <= SandboxOutputSignals(8);
    RS232_DataIn_SBO(4)     <= SandboxOutputSignals(9);
    RS232_DataIn_SBO(5)     <= SandboxOutputSignals(10);
    RS232_DataIn_SBO(6)     <= SandboxOutputSignals(11);
    RS232_DataIn_SBO(7)     <= SandboxOutputSignals(12);
    RS232_DataOut_SBO(0)    <= SandboxOutputSignals(13);
    RS232_DataOut_SBO(1)    <= SandboxOutputSignals(14);
    RS232_DataOut_SBO(2)    <= SandboxOutputSignals(15);
    RS232_DataOut_SBO(3)    <= SandboxOutputSignals(16);
    RS232_DataOut_SBO(4)    <= SandboxOutputSignals(17);
    RS232_DataOut_SBO(5)    <= SandboxOutputSignals(18);
    RS232_DataOut_SBO(6)    <= SandboxOutputSignals(19);
    RS232_DataOut_SBO(7)    <= SandboxOutputSignals(20);

	  -- Route input signals to their output equivalent if status permits
    SandboxOutputSignals <= SandboxInputSignals when(and_reduct(Status) = '0') else (others => '0');

    -- I tried a variation of how I was formatting before (like the above statement)
    --  This way is much better and will allow me to knock out only the signals I want to
    --    To do that, I'll simply need to know which bits of status (illegal states) affect each signal
    AES_DataIn_SBO  <= AES_DataIn_SBI   when(and_reduct(Status) = '0') else (others => '0');
    AES_DataOut_SBO <= AES_DataOut_SBI  when(and_reduct(Status) = '0') else (others => '0');
    RSA_ds_SBO      <= RSA_ds_SBI       when(and_reduct(Status) = '0') else '0';
    RSA_Ready_SBO   <= RSA_Ready_SBI    when(and_reduct(Status) = '0') else '0';
    RSA_Exp_SBO     <= RSA_Exp_SBI      when(and_reduct(Status) = '0') else (others => '0');
    RSA_DataIn_SBO  <= RSA_DataIn_SBI   when(and_reduct(Status) = '0') else (others => '0');
    RSA_DataOut_SBO <= RSA_DataOut_SBI  when(and_reduct(Status) = '0') else (others => '0');

    -- Use the behavior checker
    CheckerModule : Checker port map(ControlClock, SandboxInputSignals, AES_DataIn_SBI, AES_DataOut_SBI, RSA_ds_SBI, RSA_Ready_SBI, RSA_Exp_SBI, RSA_DataIn_SBI, RSA_DataOut_SBI, Status);

    -- Expose status
    Deactivated <= '0' when(and_reduct(Status) = '0') else '1';

end Behavioral;
