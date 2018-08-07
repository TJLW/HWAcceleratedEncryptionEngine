library ieee;
use ieee.std_logic_1164.all;


entity EncryptionEngine_TB is
    generic (
        AES_KeySize : integer := 128;
        RSA_KeySize : integer := 2048
    );
end entity EncryptionEngine_TB;


architecture mixed of EncryptionEngine_TB is

    constant tick : time := 10 ns; -- 100 MHz
    signal clock : std_logic;
    
        -- Core select signals
    --###############################
     signal AES_CoreSelect           : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');  -- 4 cores currently
     signal RSA_CoreSelect           : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');  -- 3 cores currently
     signal RS232_CoreSelect         : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');  -- 4 cores currently


    -- AES signals
    --###############################
     signal AES_SWLoad               : STD_LOGIC := '0';
     signal AES_HWLoad               : STD_LOGIC := '0';
    
     signal AES_Key                  : STD_LOGIC_VECTOR(AES_KeySize-1 downto 0) := (others => '0');
     signal AES_DataIn               : STD_LOGIC_VECTOR(AES_KeySize-1 downto 0) := (others => '0');
     signal AES_DataOut              : STD_LOGIC_VECTOR(AES_KeySize-1 downto 0) := (others => '0');
     signal AES_Reset                : STD_LOGIC := '0';
     
     
    -- RSA signals
     --###############################
      signal RSA_SWLoad               : STD_LOGIC := '0';
      signal RSA_HWLoad               : STD_LOGIC := '0';
     
      signal RSA_Exp                  : STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0) := (others => '0');
      signal RSA_Mod                  : STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0) := (others => '0');
      signal RSA_DataIn               : STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0) := (others => '0');
      signal RSA_DataOut              : STD_LOGIC_VECTOR(RSA_KeySize-1 downto 0) := (others => '0');
      signal RSA_Ready                : STD_LOGIC := '0';
      signal RSA_Reset                : STD_LOGIC := '0';
      signal RSA_ds                   : STD_LOGIC := '0';
     
     
     -- RS232 signals
     --###############################
      signal RS232_SWLoad             : STD_LOGIC := '0';
      signal RS232_HWLoad             : STD_LOGIC := '0';
 
      signal RS232_DataIn             : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
      signal RS232_DataOut            : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
      signal RS232_UARTRecv           : STD_LOGIC := '0';
      signal RS232_UARTXmit           : STD_LOGIC := '0';
      signal RS232_RecvReady          : STD_LOGIC := '0';
      signal RS232_Reset              : STD_LOGIC := '0';
      signal RS232_Done               : STD_LOGIC := '0';
      signal RS232_xmitH              : STD_LOGIC := '0';
      
      component EncryptionEngine is
          generic (
              AES_KeySize : integer;
              RSA_KeySize : integer
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
      end component EncryptionEngine;
     
begin
    uut : EncryptionEngine
        generic map(AES_KeySize, RSA_KeySize)
        port map(clock, 
                 AES_CoreSelect, RSA_CoreSelect, RS232_CoreSelect,
                 AES_Key, AES_DataIn, AES_DataOut, AES_Reset,
                 RSA_Exp, RSA_Mod, RSA_DataIn, RSA_DataOut, RSA_Ready, RSA_Reset, RSA_ds,
                 RS232_DataIn, RS232_DataOut, RS232_UARTRecv, RS232_UARTXmit, RS232_RecvReady, RS232_Reset, RS232_Done, RS232_xmitH
         );
         
    -- Used for testing RS232 cores
    RS232_UARTRecv <= RS232_UARTXmit;


    AES_Stimulus : process is
    begin

        -- Test AES_TFree, T100, T300, and T500
        AES_CoreSelect <= "00";
        
        AES_DataIn <= x"3243f6a8_885a308d_313198a2_e0370734";
        AES_Key <= x"2b7e1516_28aed2a6_abf71588_09cf4f3c";
        wait for tick*30;
        if AES_DataOut = x"3925841d02dc09fbdc118597196a0b32" then report "AES_TFREE PASS 1"; else report "AES_TFREE FAIL 1"; end if;
        
        AES_DataIn <= x"00112233_44556677_8899aabb_ccddeeff";
        AES_Key <= x"00010203_04050607_08090a0b_0c0d0e0f";
        wait for tick*30;
        if AES_DataOut = x"69c4e0d8_6a7b0430_d8cdb780_70b4c55a" then report "AES_TFREE PASS 2"; else report "AES_TFREE FAIL 2"; end if;
        
        AES_DataIn <= x"00000000_00000000_00000000_00000000";
        AES_Key <= x"00000000_00000000_00000000_00000000";
        wait for tick*30;
        if AES_DataOut = x"66e94bd4_ef8a2c3b_884cfa59_ca342b2e" then report "AES_TFREE PASS 3"; else report "AES_TFREE FAIL 3"; end if;
        
        AES_CoreSelect <= "01";
        
        AES_DataIn <= x"3243f6a8_885a308d_313198a2_e0370734";
        AES_Key <= x"2b7e1516_28aed2a6_abf71588_09cf4f3c";
        wait for tick*30;
        if AES_DataOut = x"3925841d02dc09fbdc118597196a0b32" then report "AES_T100 PASS 1"; else report "AES_T100 FAIL 1"; end if;
        
        AES_DataIn <= x"00112233_44556677_8899aabb_ccddeeff";
        AES_Key <= x"00010203_04050607_08090a0b_0c0d0e0f";
        wait for tick*30;
        if AES_DataOut = x"69c4e0d8_6a7b0430_d8cdb780_70b4c55a" then report "AES_T100 PASS 2"; else report "AES_T100 FAIL 2"; end if;
        
        AES_DataIn <= x"00000000_00000000_00000000_00000000";
        AES_Key <= x"00000000_00000000_00000000_00000000";
        wait for tick*30;
        if AES_DataOut = x"66e94bd4_ef8a2c3b_884cfa59_ca342b2e" then report "AES_T100 PASS 3"; else report "AES_T100 FAIL 3"; end if;
        
        AES_CoreSelect <= "10";
        
        AES_DataIn <= x"3243f6a8_885a308d_313198a2_e0370734";
        AES_Key <= x"2b7e1516_28aed2a6_abf71588_09cf4f3c";
        wait for tick*30;
        if AES_DataOut = x"3925841d02dc09fbdc118597196a0b32" then report "AES_T300 PASS 1"; else report "AES_T300 FAIL 1"; end if;
        
        AES_DataIn <= x"00112233_44556677_8899aabb_ccddeeff";
        AES_Key <= x"00010203_04050607_08090a0b_0c0d0e0f";
        wait for tick*30;
        if AES_DataOut = x"69c4e0d8_6a7b0430_d8cdb780_70b4c55a" then report "AES_T300 PASS 2"; else report "AES_T300 FAIL 2"; end if;
        
        AES_DataIn <= x"00000000_00000000_00000000_00000000";
        AES_Key <= x"00000000_00000000_00000000_00000000";
        wait for tick*30;
        if AES_DataOut = x"66e94bd4_ef8a2c3b_884cfa59_ca342b2e" then report "AES_T300 PASS 3"; else report "AES_T300 FAIL 3"; end if;
        
        AES_CoreSelect <= "11";
        
        AES_DataIn <= x"3243f6a8_885a308d_313198a2_e0370734";
        AES_Key <= x"2b7e1516_28aed2a6_abf71588_09cf4f3c";
        wait for tick*30;
        if AES_DataOut = x"3925841d02dc09fbdc118597196a0b32" then report "AES_T500 PASS 1"; else report "AES_T500 FAIL 1"; end if;
        
        AES_DataIn <= x"00112233_44556677_8899aabb_ccddeeff";
        AES_Key <= x"00010203_04050607_08090a0b_0c0d0e0f";
        wait for tick*30;
        if AES_DataOut = x"69c4e0d8_6a7b0430_d8cdb780_70b4c55a" then report "AES_T500 PASS 2"; else report "AES_T500 FAIL 2"; end if;
        
        AES_DataIn <= x"00000000_00000000_00000000_00000000";
        AES_Key <= x"00000000_00000000_00000000_00000000";
        wait for tick*30;
        if AES_DataOut = x"66e94bd4_ef8a2c3b_884cfa59_ca342b2e" then report "AES_T500 PASS 3"; else report "AES_T500 FAIL 3"; end if;
        
        
--        -- Reset the system
--        AES_Reset <= '1';
--        wait for tick*100;
--        AES_Reset <= '0';
--        wait for tick*100;

        wait;
    end process AES_Stimulus;



    RSA_Stimulus : process is
    begin
    
        -- Test RSA_TFree, T100, and T300
        RSA_CoreSelect <= "00";
        
        wait for 120ns;
        RSA_Reset <= '1';
        RSA_ds <= '0';
  	    wait for 20ns;
        wait until clock = '0';
        RSA_Reset <= '0';
        wait for tick;
        
        -- Encryption exponents (Public key exponent)
--        RSA_Exp <= x"000000a7"; --167
        RSA_Exp <= x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a7"; --167
    
        -- Modulus value (Used for both public and private keys)
--        RSA_Mod <= x"03b2c159"; --62046553
        RSA_Mod <= x"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003b2c159"; --62046553
    
        -- Message   
--        RSA_DataIn <= x"00724183";     
        RSA_DataIn <= x"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000724183";
        
        wait for tick;
        RSA_ds <= '1';
        wait until RSA_Ready = '0';
        RSA_ds <= '0';
        wait until RSA_Ready = '1';
        
        -- Decryption exponent (Private key exponent)
--        RSA_Exp <= x"00440357"; --440357
        RSA_Exp <= x"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000440357"; --440357
    
        -- Message        
        RSA_DataIn <= RSA_DataOut;
        
        RSA_ds <= '1';
        wait until RSA_Ready = '0';
        RSA_ds <= '0';
        wait until RSA_Ready = '1';
   
--        if RSA_DataOut = x"00724183" then report "RSA_TFREE PASS 1"; else report "RSA FAIL 1"; end if;
        if RSA_DataOut = x"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000724183" then report "RSA_TFREE PASS 1"; else report "RSA_TFREE FAIL 1"; end if;

               
        -- Encryption exponents (Public key exponent)
        RSA_Exp <= x"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000903ad9";
   
        -- Message   
        RSA_DataIn <= x"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000724183";     
        
        wait for tick;
        RSA_ds <= '1';
        wait until RSA_Ready = '0';
        RSA_ds <= '0';
        wait until RSA_Ready = '1';
        
        -- Decryption exponent (Private key exponent)
        RSA_Exp <= x"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002d80e39";
    
        -- Message        
        RSA_DataIn <= RSA_DataOut;
        
        RSA_ds <= '1';
        wait until RSA_Ready = '0';
        RSA_ds <= '0';
        wait until RSA_Ready = '1';
   
        if RSA_DataOut = x"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000724183" then report "RSA_TFREE PASS 2"; else report "RSA_TFREE FAIL 2"; end if;
        wait for tick*5;

        -- T100
        RSA_CoreSelect <= "01";
        
        wait for 120ns;
        RSA_Reset <= '1';
        RSA_ds <= '0';
		wait for 20ns;
        wait until clock = '0';
        RSA_Reset <= '0';
        wait for tick;
        
        -- Encryption exponents (Public key exponent)
--        RSA_Exp <= x"000000a7"; --167
        RSA_Exp <= x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a7"; --167
    
        -- Modulus value (Used for both public and private keys)
--        RSA_Mod <= x"03b2c159"; --62046553
        RSA_Mod <= x"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003b2c159"; --62046553
    
        -- Message   
--        RSA_DataIn <= x"44444444";     
        RSA_DataIn <= x"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000044444444";
        
        wait for tick;
        RSA_ds <= '1';
        wait until RSA_Ready = '0';
        RSA_ds <= '0';
        wait until RSA_Ready = '1';
        
        if RSA_DataOut = x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a7" then report "RSA_T100 PASS 1"; else report "RSA_T100 FAIL 1"; end if;
        wait for tick*5;

 
        -- T300 
        RSA_CoreSelect <= "10";
        
        wait for 120ns;
        RSA_Reset <= '1';
        RSA_ds <= '0';
        wait for 20ns;
        wait until clock = '0';
        RSA_Reset <= '0';
        wait for tick;
        
        -- Encryption exponents (Public key exponent)
        RSA_Exp <= x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a7"; --167
    
        -- Modulus value (Used for both public and private keys)
        RSA_Mod <= x"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003b2c159"; --62046553
    
        -- Message   
        RSA_DataIn <= x"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000044444444";
        
        -- Run through twice to trigger T300
        wait for tick;
        RSA_ds <= '1';
        wait until RSA_Ready = '0';
        RSA_ds <= '0';
        wait until RSA_Ready = '1';
        
        RSA_ds <= '1';
        wait until RSA_Ready = '0';
        RSA_ds <= '0';
        wait until RSA_Ready = '1';
        wait for tick;
        
        if RSA_DataOut = x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a7" then report "RSA_T300 PASS 1"; else report "RSA_T300 FAIL 1"; end if;

        wait;
    end process RSA_Stimulus;
    
    
    RS232_Stimulus : process is
    begin
        
        -- Test RS232_TFree, RS232_T100, RS232_T300, and RS232_T500
        RS232_CoreSelect <= "00";

        -- Reset
        RS232_Reset <= '0';
        wait for tick*5;
        RS232_Reset <= '1';
        wait until RS232_RecvReady = '1'; 
        
        
--        -- Test RECV
--        RS232_UARTRecv <= '0'; -- Start data low
--        wait for tick*16;
--        RS232_UARTRecv <= '1';
--        wait for tick*16;
--        RS232_UARTRecv <= '1'; 
--        wait for tick*16;
--        RS232_UARTRecv <= '0'; 
--        wait for tick*16;
--        RS232_UARTRecv <= '1'; 
--        wait for tick*16;
--        RS232_UARTRecv <= '0'; 
--        wait for tick*16;
--        RS232_UARTRecv <= '1';
--        wait for tick*16;
--        RS232_UARTRecv <= '0'; 
--        wait for tick*16;
--        RS232_UARTRecv <= '0';
--        wait for tick*16;
--        RS232_UARTRecv <= '1'; -- End data high
--        wait for tick*16;

--        if RS232_DataOut = x"2b" then report "RS232_TFREE PASS RECV 1"; else report "RS232_TFREE FAIL RECV 1"; end if;

--        -- Wait some time between
--        wait for tick*50;
        
--        RS232_UARTRecv <= '0'; -- Start data low
--        wait for tick*16;
--        RS232_UARTRecv <= '1';
--        wait for tick*16;
--        RS232_UARTRecv <= '0'; 
--        wait for tick*16;
--        RS232_UARTRecv <= '1'; 
--        wait for tick*16;
--        RS232_UARTRecv <= '0'; 
--        wait for tick*16;
--        RS232_UARTRecv <= '1'; 
--        wait for tick*16;
--        RS232_UARTRecv <= '0';
--        wait for tick*16;
--        RS232_UARTRecv <= '1'; 
--        wait for tick*16;
--        RS232_UARTRecv <= '0';
--        wait for tick*16;
--        RS232_UARTRecv <= '1'; -- End data high
--        wait for tick*16; 

--        if RS232_DataOut = x"55" then report "RS232_TFREE PASS RECV 2"; else report "RS232_TFREE FAIL RECV 2"; end if;
        
--        wait for tick*50;
        
        -- Test XMIT/RECV (Requires uart lines to be connected)
        
        RS232_DataIn <= x"37";
        RS232_xmitH <= '1';
        wait for tick*16;
        RS232_xmitH <= '0';
        
        wait for tick*160;
        if RS232_DataOut = x"37" then report "RS232_TFREE PASS XMIT/RECV 1"; else report "RS232_TFREE FAIL XMIT/RECV 1"; end if;
        
        
        RS232_CoreSelect <= "01";

        -- Reset
        RS232_Reset <= '0';
        wait for tick*5;
        RS232_Reset <= '1';
        wait until RS232_RecvReady = '1'; 
        
        RS232_DataIn <= x"37";
        RS232_xmitH <= '1';
        wait for tick*16;
        RS232_xmitH <= '0';
        
        wait for tick*160;
        if RS232_DataOut = x"37" then report "RS232_T100 PASS XMIT/RECV 1"; else report "RS232_T100 FAIL XMIT/RECV 1"; end if;
        
        
        RS232_CoreSelect <= "10";

        -- Reset
        RS232_Reset <= '0';
        wait for tick*5;
        RS232_Reset <= '1';
        wait until RS232_RecvReady = '1'; 
        
        RS232_DataIn <= x"37";
        RS232_xmitH <= '1';
        wait for tick*16;
        RS232_xmitH <= '0';
        
        wait for tick*160;
        if RS232_DataOut = x"37" then report "RS232_T300 PASS XMIT/RECV 1"; else report "RS232_T300 FAIL XMIT/RECV 1"; end if;
        
        
        RS232_CoreSelect <= "11";

        -- Reset
        RS232_Reset <= '0';
        wait for tick*5;
        RS232_Reset <= '1';
        wait until RS232_RecvReady = '1'; 
        
        RS232_DataIn <= x"37";
        RS232_xmitH <= '1';
        wait for tick*16;
        RS232_xmitH <= '0';
        
        wait for tick*160;
        if RS232_DataOut = x"37" then report "RS232_T500 PASS XMIT/RECV 1"; else report "RS232_T500 FAIL XMIT/RECV 1"; end if;

        wait for tick*100;
   
        wait;
    end process RS232_Stimulus;


    clockProcess : process is
    begin
        clock <= '0'; wait for tick/2;
        clock <= '1'; wait for tick/2;
    end process clockProcess;
    
end architecture mixed;
