library IEEE;

use IEEE.STD_LOGIC_1164.ALL;


entity EncryptionEngine is
    generic (
        AES_KeySize : integer := 128;
        RSA_KeySize : integer := 32
    );
    port (clock : in STD_LOGIC;

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
    attribute keep_hierarchy : string;
    attribute keep_hierarchy of EncryptionEngine : entity is "yes";
end entity EncryptionEngine;

architecture behavioral of EncryptionEngine is


    -- AES signals
    --###############################
    signal AES_Key_TFree            : STD_LOGIC_VECTOR(AES_KeySize-1 downto 0) := (others => '0');
    signal AES_DataIn_TFree         : STD_LOGIC_VECTOR(AES_KeySize-1 downto 0) := (others => '0');
    signal AES_DataOut_TFree        : STD_LOGIC_VECTOR(AES_KeySize-1 downto 0) := (others => '0');

    signal AES_Key_T100             : STD_LOGIC_VECTOR(AES_KeySize-1 downto 0) := (others => '0');
    signal AES_DataIn_T100          : STD_LOGIC_VECTOR(AES_KeySize-1 downto 0) := (others => '0');
    signal AES_DataOut_T100         : STD_LOGIC_VECTOR(AES_KeySize-1 downto 0) := (others => '0');
    signal AES_Reset_T100           : STD_LOGIC := '0';

    signal AES_Key_T300             : STD_LOGIC_VECTOR(AES_KeySize-1 downto 0) := (others => '0');
    signal AES_DataIn_T300          : STD_LOGIC_VECTOR(AES_KeySize-1 downto 0) := (others => '0');
    signal AES_DataOut_T300         : STD_LOGIC_VECTOR(AES_KeySize-1 downto 0) := (others => '0');
    signal AES_Reset_T300           : STD_LOGIC := '0';

    signal AES_Key_T500             : STD_LOGIC_VECTOR(AES_KeySize-1 downto 0) := (others => '0');
    signal AES_DataIn_T500          : STD_LOGIC_VECTOR(AES_KeySize-1 downto 0) := (others => '0');
    signal AES_DataOut_T500         : STD_LOGIC_VECTOR(AES_KeySize-1 downto 0) := (others => '0');
    signal AES_Reset_T500           : STD_LOGIC := '0';


    -- RSA signals
    --###############################
    signal RSA_Exp_TFree            : STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0) := (others => '0');
    signal RSA_Mod_TFree            : STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0) := (others => '0');
    signal RSA_DataIn_TFree         : STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0) := (others => '0');
    signal RSA_DataOut_TFree        : STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0) := (others => '0');
    signal RSA_Ready_TFree          : STD_LOGIC := '0';
    signal RSA_Reset_TFree          : STD_LOGIC := '0';
    signal RSA_ds_TFree             : STD_LOGIC := '0';

    signal RSA_Exp_T100             : STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0) := (others => '0');
    signal RSA_Mod_T100             : STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0) := (others => '0');
    signal RSA_DataIn_T100          : STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0) := (others => '0');
    signal RSA_DataOut_T100         : STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0) := (others => '0');
    signal RSA_Ready_T100           : STD_LOGIC := '0';
    signal RSA_Reset_T100           : STD_LOGIC := '0';
    signal RSA_ds_T100              : STD_LOGIC := '0';

    signal RSA_Exp_T300             : STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0) := (others => '0');
    signal RSA_Mod_T300             : STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0) := (others => '0');
    signal RSA_DataIn_T300          : STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0) := (others => '0');
    signal RSA_DataOut_T300         : STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0) := (others => '0');
    signal RSA_Ready_T300           : STD_LOGIC := '0';
    signal RSA_Reset_T300           : STD_LOGIC := '0';
    signal RSA_ds_T300              : STD_LOGIC := '0';


    -- RS232 signals
    --###############################
    signal RS232_DataIn_TFree       : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal RS232_DataOut_TFree      : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal RS232_UARTRecv_TFree     : STD_LOGIC := '0';
    signal RS232_UARTXmit_TFree     : STD_LOGIC := '0';
    signal RS232_RecvReady_TFree    : STD_LOGIC := '0';
    signal RS232_Reset_TFree        : STD_LOGIC := '0';
    signal RS232_Done_TFree         : STD_LOGIC := '0';
    signal RS232_xmitH_TFree        : STD_LOGIC := '0';

    signal RS232_DataIn_T100        : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal RS232_DataOut_T100       : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal RS232_UARTRecv_T100      : STD_LOGIC := '0';
    signal RS232_UARTXmit_T100      : STD_LOGIC := '0';
    signal RS232_RecvReady_T100     : STD_LOGIC := '0';
    signal RS232_Reset_T100         : STD_LOGIC := '0';
    signal RS232_Done_T100          : STD_LOGIC := '0';
    signal RS232_xmitH_T100         : STD_LOGIC := '0';

    signal RS232_DataIn_T300        : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal RS232_DataOut_T300       : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal RS232_UARTRecv_T300      : STD_LOGIC := '0';
    signal RS232_UARTXmit_T300      : STD_LOGIC := '0';
    signal RS232_RecvReady_T300     : STD_LOGIC := '0';
    signal RS232_Reset_T300         : STD_LOGIC := '0';
    signal RS232_Done_T300          : STD_LOGIC := '0';
    signal RS232_xmitH_T300         : STD_LOGIC := '0';

    signal RS232_DataIn_T500        : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal RS232_DataOut_T500       : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal RS232_UARTRecv_T500      : STD_LOGIC := '0';
    signal RS232_UARTXmit_T500      : STD_LOGIC := '0';
    signal RS232_RecvReady_T500     : STD_LOGIC := '0';
    signal RS232_Reset_T500         : STD_LOGIC := '0';
    signal RS232_Done_T500          : STD_LOGIC := '0';
    signal RS232_xmitH_T500         : STD_LOGIC := '0';


    component aes_128_TFree
        port(clk : IN STD_LOGIC;
             state : IN STD_LOGIC_VECTOR(AES_KeySize-1 downto 0);
             key : IN STD_LOGIC_VECTOR(AES_KeySize-1 downto 0);
             cipher : OUT STD_LOGIC_VECTOR(AES_KeySize-1 downto 0) );
    end component;

    component top_aes_128_T100
        port(clk : IN STD_LOGIC;
             rst : IN STD_LOGIC;
             state : IN STD_LOGIC_VECTOR(AES_KeySize-1 downto 0);
             key : IN STD_LOGIC_VECTOR(AES_KeySize-1 downto 0);
             cipher : OUT STD_LOGIC_VECTOR(AES_KeySize-1 downto 0);
             Capacitance : OUT STD_LOGIC_VECTOR(63 downto 0) );
    end component;

    component top_aes_128_T300
        port(clk : IN STD_LOGIC;
             rst : IN STD_LOGIC;
             state : IN STD_LOGIC_VECTOR(AES_KeySize-1 downto 0);
             key : IN STD_LOGIC_VECTOR(AES_KeySize-1 downto 0);
             cipher : OUT STD_LOGIC_VECTOR(AES_KeySize-1 downto 0) );
    end component;
    
    component top_aes_128_T500
        port(clk : IN STD_LOGIC;
             rst : IN STD_LOGIC;
             state : IN STD_LOGIC_VECTOR(AES_KeySize-1 downto 0);
             key : IN STD_LOGIC_VECTOR(AES_KeySize-1 downto 0);
             cipher : OUT STD_LOGIC_VECTOR(AES_KeySize-1 downto 0) );
    end component;


    component RSACypher_TFree
        generic(KEYSIZE : integer := RSA_KeySize);
        port(indata: IN STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0);
             inExp: IN STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0);
             inMod: IN STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0);
             cypher: OUT STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0);
             clk: IN STD_LOGIC;
             ds: IN STD_LOGIC;
             reset: IN STD_LOGIC;
             ready: OUT STD_LOGIC );
    end component;

    component RSACypher_T100
        generic(KEYSIZE : integer := RSA_KeySize);
        port(indata: IN STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0);
             inExp: IN STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0);
             inMod: IN STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0);
             cypher: OUT STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0);
             clk: IN STD_LOGIC;
             ds: IN STD_LOGIC;
             reset: IN STD_LOGIC;
             ready: OUT STD_LOGIC );
    end component;

    component RSACypher_T300
        generic(KEYSIZE : integer := RSA_KeySize);
        port(indata: IN STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0);
             inExp: IN STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0);
             inMod: IN STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0);
             cypher: OUT STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0);
             clk: IN STD_LOGIC;
             ds: IN STD_LOGIC;
             reset: IN STD_LOGIC;
             ready: OUT STD_LOGIC );
    end component;


    component uart_TFree
        port(sys_clk : IN STD_LOGIC;
             sys_rst_l : IN STD_LOGIC;
             uart_XMIT_dataH : OUT STD_LOGIC;
             xmitH : IN STD_LOGIC;
             xmit_dataH : IN STD_LOGIC_VECTOR(7 downto 0);
             xmit_doneH : OUT STD_LOGIC;
             uart_REC_dataH : IN STD_LOGIC;
             rec_dataH : OUT STD_LOGIC_VECTOR(7 downto 0);
             rec_readyH : OUT STD_LOGIC );
    end component;


    component uart_T100
        port(sys_clk : IN STD_LOGIC;
             sys_rst_l : IN STD_LOGIC;
             uart_XMIT_dataH : OUT STD_LOGIC;
             xmitH : IN STD_LOGIC;
             xmit_dataH : IN STD_LOGIC_VECTOR(7 downto 0);
             xmit_doneH : OUT STD_LOGIC;
             uart_REC_dataH : IN STD_LOGIC;
             rec_dataH : OUT STD_LOGIC_VECTOR(7 downto 0);
             rec_readyH : OUT STD_LOGIC );
    end component;

    component uart_T300
        port(sys_clk : IN STD_LOGIC;
             sys_rst_l : IN STD_LOGIC;
             uart_XMIT_dataH : OUT STD_LOGIC;
             xmitH : IN STD_LOGIC;
             xmit_dataH : IN STD_LOGIC_VECTOR(7 downto 0);
             xmit_doneH : OUT STD_LOGIC;
             uart_REC_dataH : IN STD_LOGIC;
             rec_dataH : OUT STD_LOGIC_VECTOR(7 downto 0);
             rec_readyH : OUT STD_LOGIC );
    end component;

    component uart_T500
        port(sys_clk : IN STD_LOGIC;
             sys_rst_l : IN STD_LOGIC;
             uart_XMIT_dataH : OUT STD_LOGIC;
             xmitH : IN STD_LOGIC;
             xmit_dataH : IN STD_LOGIC_VECTOR(7 downto 0);
             xmit_doneH : OUT STD_LOGIC;
             uart_REC_dataH : IN STD_LOGIC;
             rec_dataH : OUT STD_LOGIC_VECTOR(7 downto 0);
             rec_readyH : OUT STD_LOGIC );
    end component;


begin

    -- AES Cores
    --###############################
    AES_TFree : aes_128_TFree
    port map (clock, AES_DataIn_TFree, AES_Key_TFree, AES_DataOut_TFree);

    AES_T100 : top_aes_128_T100
    port map (clock, AES_Reset_T100, AES_DataIn_T100, AES_Key_T100, AES_DataOut_T100);
    --port map (clock, AES_Reset, AES_DataIn, AES_Key, AES_DataOut, AES_Capacitance);

    AES_T300 : top_aes_128_T300
    port map (clock, AES_Reset_T300, AES_DataIn_T300, AES_Key_T300, AES_DataOut_T300);

    AES_T500 : top_aes_128_T500
    port map (clock, AES_Reset_T500, AES_DataIn_T500, AES_Key_T500, AES_DataOut_T500);



    -- RSA Cores
    --###############################
    RSA_TFree : RSACypher_TFree
    generic map(RSA_KeySize)
    port map (RSA_DataIn_TFree, RSA_Exp_TFree, RSA_Mod_TFree, RSA_DataOut_TFree, clock, RSA_ds_TFree, RSA_Reset_TFree, RSA_Ready_TFree);

    RSA_T100 : RSACypher_T100
    generic map(RSA_KeySize)
    port map (RSA_DataIn_T100, RSA_Exp_T100, RSA_Mod_T100, RSA_DataOut_T100, clock, RSA_ds_T100, RSA_Reset_T100, RSA_Ready_T100);

    RSA_T300 : RSACypher_T300
    generic map(RSA_KeySize)
    port map (RSA_DataIn_T300, RSA_Exp_T300, RSA_Mod_T300, RSA_DataOut_T300, clock, RSA_ds_T300, RSA_Reset_T300, RSA_Ready_T300);



    -- RS232 Cores
    --###############################
    RS232_TFree : uart_TFree
    port map (clock, RS232_Reset_TFree, RS232_UARTXmit_TFree, RS232_xmitH_TFree, RS232_DataIn_TFree, RS232_Done_TFree, RS232_UARTRecv_TFree, RS232_DataOut_TFree, RS232_RecvReady_TFree);

    RS232_T100 : uart_T100
    port map (clock, RS232_Reset_T100, RS232_UARTXmit_T100, RS232_xmitH_T100, RS232_DataIn_T100, RS232_Done_T100, RS232_UARTRecv_T100, RS232_DataOut_T100, RS232_RecvReady_T100);

    RS232_T300 : uart_T300
    port map (clock, RS232_Reset_T300, RS232_UARTXmit_T300, RS232_xmitH_T300, RS232_DataIn_T300, RS232_Done_T300, RS232_UARTRecv_T300, RS232_DataOut_T300, RS232_RecvReady_T300);

    RS232_T500 : uart_T500
    port map (clock, RS232_Reset_T500, RS232_UARTXmit_T500, RS232_xmitH_T500, RS232_DataIn_T500, RS232_Done_T500, RS232_UARTRecv_T500, RS232_DataOut_T500, RS232_RecvReady_T500);



    -- Utilize only the selected cores
    -- AES
    process(clock)
    begin
        if(rising_edge(clock)) then

            case AES_CoreSelect is
                when "00" =>
                  AES_Key_TFree <= AES_Key;
                  AES_DataIn_TFree <= AES_DataIn;
                  AES_DataOut <= AES_DataOut_TFree;

                when "01" =>
                  AES_Key_T100 <= AES_Key;
                  AES_DataIn_T100 <= AES_DataIn;
                  AES_Reset_T100 <= AES_Reset;
                  
                  AES_DataOut <= AES_DataOut_T100;

                when "10" =>
                  AES_Key_T300 <= AES_Key;
                  AES_DataIn_T300 <= AES_DataIn;
                  AES_Reset_T300 <= AES_Reset;
                  
                  AES_DataOut <= AES_DataOut_T300;

                when others =>
                  AES_Key_T500 <= AES_Key;
                  AES_DataIn_T500 <= AES_DataIn;
                  AES_Reset_T500 <= AES_Reset;

                  AES_DataOut <= AES_DataOut_T500;

            end case;
        end if;
    end process;

    -- RSA
    process(clock)
    begin
        if(rising_edge(clock)) then

            case RSA_CoreSelect is
                when "00" =>
                  RSA_Exp_TFree <= RSA_Exp;
                  RSA_Mod_TFree <= RSA_Mod;
                  RSA_DataIn_TFree <= RSA_DataIn;
                  RSA_Reset_TFree <= RSA_Reset;
                  RSA_ds_TFree <= RSA_ds;
                  
                  RSA_Ready <= RSA_Ready_TFree;
                  RSA_DataOut <= RSA_DataOut_TFree;

                when "01" =>
                  RSA_Exp_T100 <= RSA_Exp;
                  RSA_Mod_T100 <= RSA_Mod;
                  RSA_DataIn_T100 <= RSA_DataIn;
                  RSA_Reset_T100 <= RSA_Reset;
                  RSA_ds_T100 <= RSA_ds;
                  
                  RSA_Ready <= RSA_Ready_T100;
                  RSA_DataOut <= RSA_DataOut_T100;

                when others =>
                  RSA_Exp_T300 <= RSA_Exp;
                  RSA_Mod_T300 <= RSA_Mod;
                  RSA_DataIn_T300 <= RSA_DataIn;
                  RSA_Reset_T300 <= RSA_Reset;
                  RSA_ds_T300 <= RSA_ds;
                  
                  RSA_Ready <= RSA_Ready_T300;
                  RSA_DataOut <= RSA_DataOut_T300;

            end case;
        end if;
    end process;

    -- RS232
    process(clock)
    begin
        if(rising_edge(clock)) then

            case RS232_CoreSelect is
                when "00" =>
                  RS232_DataIn_TFree <= RS232_DataIn;
                  RS232_UARTRecv_TFree <= RS232_UARTRecv;
                  RS232_Reset_TFree <= RS232_Reset;
                  RS232_xmitH_TFree <= RS232_xmitH;
                  
                  RS232_DataOut <= RS232_DataOut_TFree;
                  RS232_UARTXmit <= RS232_UARTXmit_TFree;
                  RS232_RecvReady <= RS232_RecvReady_TFree;
                  RS232_Done <= RS232_Done_TFree;

                when "01" =>
                  RS232_DataIn_T100 <= RS232_DataIn;
                  RS232_UARTRecv_T100 <= RS232_UARTRecv;
                  RS232_Reset_T100 <= RS232_Reset;
                  RS232_xmitH_T100 <= RS232_xmitH;
                  
                  RS232_DataOut <= RS232_DataOut_T100;
                  RS232_UARTXmit <= RS232_UARTXmit_T100;
                  RS232_RecvReady <= RS232_RecvReady_T100;
                  RS232_Done <= RS232_Done_T100;

                when "10" =>
                  RS232_DataIn_T300 <= RS232_DataIn;
                  RS232_UARTRecv_T300 <= RS232_UARTRecv;
                  RS232_Reset_T300 <= RS232_Reset;
                  RS232_xmitH_T300 <= RS232_xmitH;
                                    
                  RS232_DataOut <= RS232_DataOut_T300;
                  RS232_UARTXmit <= RS232_UARTXmit_T300;
                  RS232_RecvReady <= RS232_RecvReady_T300;
                  RS232_Done <= RS232_Done_T300;

                when others =>
                  RS232_DataIn_T500 <= RS232_DataIn;
                  RS232_UARTRecv_T500 <= RS232_UARTRecv;
                  RS232_Reset_T500 <= RS232_Reset;
                  RS232_xmitH_T500 <= RS232_xmitH;
                  
                  RS232_DataOut <= RS232_DataOut_T500;
                  RS232_UARTXmit <= RS232_UARTXmit_T500;
                  RS232_RecvReady <= RS232_RecvReady_T500;
                  RS232_Done <= RS232_Done_T500;

            end case;
        end if;
    end process;

end architecture behavioral;