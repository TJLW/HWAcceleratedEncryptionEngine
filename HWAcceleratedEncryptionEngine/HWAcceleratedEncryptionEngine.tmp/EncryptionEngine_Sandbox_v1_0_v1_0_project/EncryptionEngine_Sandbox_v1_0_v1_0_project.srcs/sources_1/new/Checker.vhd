library IEEE;
use IEEE.std_logic_1164.all;

-- Component Checker Module
--	This file has been generated from the component configurations provided. The
--    checker module simply determines component behavior to be in line with the
--    expected behavior or not.
--  If illegal behavior is detected, the appropriate illegal state will be asserted and
--    no further transitions will be allowed. Current state will be locked.
--	Accepting state detections are asserted upon transitions to end states. Transitions
--    can continue according to configured behavior. Current state will not be locked
--    so long as transitions exist to progress the automata

-- The signal set is indexed as listed below:
   -- 0 - xmitH
   -- 1 - uart_REC_dataH
   -- 2 - xmit_doneH
   -- 3 - uart_XMIT_dataH
   -- 4 - rec_readyH
   -- 5 - xmit_dataH(0)
   -- 6 - xmit_dataH(1)
   -- 7 - xmit_dataH(2)
   -- 8 - xmit_dataH(3)
   -- 9 - xmit_dataH(4)
   -- 10 - xmit_dataH(5)
   -- 11 - xmit_dataH(6)
   -- 12 - xmit_dataH(7)
   -- 13 - rec_dataH(0)
   -- 14 - rec_dataH(1)
   -- 15 - rec_dataH(2)
   -- 16 - rec_dataH(3)
   -- 17 - rec_dataH(4)
   -- 18 - rec_dataH(5)
   -- 19 - rec_dataH(6)
   -- 20 - rec_dataH(7)


-- Define the automaton checking entity
entity Checker is
	port(
		ControlClock            : in  std_logic;	-- Control clock assertions will allow transition to occur
		SignalSet               : in  std_logic_vector(20 downto 0);	-- All signals are input here to determine the correct transition
		AES_state								: in std_logic_vector(127 downto 0); -- Saving time by putting these big vectors here
		AES_Out									: in std_logic_vector(127 downto 0);

		RSA_ds									: in std_logic;
		RSA_ready								: in std_logic;
		RSA_inExp								: in std_logic_vector(31 downto 0);
	  RSA_inData						  : in std_logic_vector(31 downto 0);
	  RSA_cypher							: in std_logic_vector(31 downto 0);

    IllegalStateDetections  : out std_logic_vector(8 downto 0)	-- Illegal state detections are asserted via this port

	);
end Checker;

architecture STRUCTURAL of Checker is

  -- UART transmission should be identical to current bit
  --  Assert on condition (VHDL should be 'downto' vector option)
  signal logic0   : std_logic;
  signal logic1   : std_logic;
  signal logic2   : std_logic;
  signal logic3   : std_logic;
  signal logic4   : std_logic;
  signal logic5   : std_logic;
  signal logic6   : std_logic;
  signal logic7   : std_logic;
  signal trans0   : std_logic;
  signal trans1   : std_logic;
  signal trans2   : std_logic;
  signal trans3   : std_logic;
  signal trans4   : std_logic;
  signal trans5   : std_logic;
  signal trans6   : std_logic;
  signal trans7   : std_logic;
  signal trans8   : std_logic;
  signal trans9   : std_logic;
  signal trans10  : std_logic;
  signal trans11  : std_logic;
  signal trans12  : std_logic;
  signal trans13  : std_logic;
  signal trans14  : std_logic;
  signal trans15  : std_logic;
  signal trans16  : std_logic;
  signal trans17  : std_logic;
  signal trans18  : std_logic;

  -- Omitting counter triggers for now
  signal logic8    : std_logic;
  signal logic9    : std_logic;
  signal logic10   : std_logic;
  signal logic11   : std_logic;
  signal logic12   : std_logic;
  signal logic13   : std_logic;
  signal logic14   : std_logic;
  signal logic15   : std_logic;
  signal logic16   : std_logic;
  signal logic17   : std_logic;
  signal logic18   : std_logic;
  signal logic19   : std_logic;
  signal logic20   : std_logic;
  signal logic21   : std_logic;
  signal logic22   : std_logic;

	--------------------------
	-- States - Automata 0 -- RS232
	--------------------------
	signal S0_0, S0_1, S0_2, S0_3, S0_4, S0_5, S0_6, S0_7, S0_8, S0_9, S0_10, S0_11, S0_12, S0_13, S0_14, S0_15, S0_16, S0_17, S0_18, S0_19, S0_20 : std_logic;
	signal S0_21 : std_logic;

  --------------------------
  -- States - Automata 1
  --------------------------
  signal S1_0 : std_logic;
  signal S1_1 : std_logic := '1';

  --------------------------
  -- States - Automata 2
  --------------------------
  signal S2_0, S2_1, S2_2, S2_3 : std_logic;
  signal S2_4 : std_logic := '1';

  --------------------------
  -- States - Automata 3
  --------------------------
  signal S3_0, S3_1, S3_2, S3_3 : std_logic;
  signal S3_4 : std_logic := '1';

  --------------------------
  -- States - Automata 4
  --------------------------
  signal S4_0, S4_1, S4_2, S4_3 : std_logic;
  signal S4_4 : std_logic := '1';

	--------------------------
	-- States - Automata 5
	--------------------------
	signal S5_0 : std_logic;
	signal S5_1 : std_logic := '1';


	signal logic23 : std_logic;
	signal logic24 : std_logic;
	signal logic25 : std_logic;
	signal logic26 : std_logic;
	signal logic27 : std_logic;
	signal logic28 : std_logic;
	signal logic29 : std_logic;

	--------------------------
	-- States - Automata 6
	--------------------------
	signal S6_0 : std_logic;
	signal S6_1 : std_logic := '1';

	--------------------------
	-- States - Automata 7
	--------------------------
	signal S7_0, S7_1, S7_2, S7_3 : std_logic;
	signal S7_4 : std_logic := '1';


	signal logic30 : std_logic;
	signal logic31 : std_logic;
	signal logic32 : std_logic;
	signal logic33 : std_logic;

	--------------------------
	-- States - Automata 8
	--------------------------
	signal S8_0, S8_1, S8_2 : std_logic;
	signal S8_3 : std_logic := '1';

	--------------------------
	-- States - Automata 9
	--------------------------
	signal S9_0 : std_logic;
	signal S9_1 : std_logic := '1';

	--------------------------
	-- States - Automata 10
	--------------------------
	signal S10_0 : std_logic;
	signal S10_1 : std_logic := '1';

  -- Counter
  component Counter is
  generic(n: natural :=2);
  port(	clock:	in std_logic;
  	clear:	in std_logic;
  	count:	in std_logic;
		value: 	in std_logic_vector(n-1 downto 0);
  	done:	out std_logic
  );
  end component;

	signal counter1_done : std_logic;
	signal counter2_done : std_logic;
	signal counter3_done : std_logic;



begin

  logic0 <= '1' when SignalSet(3) = SignalSet(5)	else '0';
  logic1 <= '1' when SignalSet(3) = SignalSet(6)	else '0';
  logic2 <= '1' when SignalSet(3) = SignalSet(7)	else '0';
  logic3 <= '1' when SignalSet(3) = SignalSet(8)	else '0';
  logic4 <= '1' when SignalSet(3) = SignalSet(9)	else '0';
  logic5 <= '1' when SignalSet(3) = SignalSet(10)	else '0';
  logic6 <= '1' when SignalSet(3) = SignalSet(11)	else '0';
  logic7 <= '1' when SignalSet(3) = SignalSet(12)	else '0';

  trans0 	<= '1' when 	(SignalSet(2) = '0' and SignalSet(3) = '0')			else '0';
  trans1 	<= '1' when 	(SignalSet(2) = '0' and logic0 = '1')						else '0';
  trans2 	<= '1' when 	(SignalSet(2) = '0' and logic1 = '1')						else '0';
  trans3 	<= '1' when 	(SignalSet(2) = '0' and logic2 = '1')						else '0';
  trans4 	<= '1' when 	(SignalSet(2) = '0' and logic3 = '1')						else '0';
  trans5 	<= '1' when 	(SignalSet(2) = '0' and logic4 = '1')						else '0';
  trans6 	<= '1' when 	(SignalSet(2) = '0' and logic5 = '1')						else '0';
  trans7 	<= '1' when 	(SignalSet(2) = '0' and logic6 = '1')						else '0';
  trans8 	<= '1' when 	(SignalSet(2) = '0' and logic7 = '1')						else '0';
  trans9 	<= '1' when 	(SignalSet(2) = '0' and SignalSet(0) = '1')			else '0';
  trans10 <= '1' when 	(SignalSet(1) = '0' and SignalSet(4) = '0')			else '0';
  trans11 <= '1' when 	SignalSet(1) = SignalSet(13)										else '0';
  trans12 <= '1' when 	SignalSet(1) = SignalSet(14)										else '0';
  trans13 <= '1' when 	SignalSet(1) = SignalSet(15)										else '0';
  trans14 <= '1' when 	SignalSet(1) = SignalSet(16)										else '0';
  trans15 <= '1' when 	SignalSet(1) = SignalSet(17)										else '0';
  trans16 <= '1' when 	SignalSet(1) = SignalSet(18)										else '0';
  trans17 <= '1' when 	SignalSet(1) = SignalSet(19)										else '0';
  trans18 <= '1' when 	SignalSet(1) = SignalSet(20)										else '0';

  logic8 <= '1' when SignalSet(0) = '1' else '0';

  counter1 : Counter
  generic map(32)
  port map(ControlClock, '0', logic8, x"FFFFFFFF", counter1_done);

  logic9 	<= '1' when SignalSet(20 downto 13) = x"4C"	 else '0';
  logic10 <= '1' when SignalSet(12 downto 5) = x"4C" else '0';

  logic11 <= '1' when SignalSet(12 downto 5) = x"AA" else '0';
  logic12 <= '1' when SignalSet(12 downto 5) = x"55" else '0';
  logic13 <= '1' when SignalSet(12 downto 5) = x"22" else '0';
  logic14 <= '1' when SignalSet(12 downto 5) = x"FF" else '0';

  logic15 <= '1' when SignalSet(12 downto 5) = x"AA" else '0';
  logic16 <= '1' when SignalSet(12 downto 5) = x"55" else '0';
  logic17 <= '1' when SignalSet(12 downto 5) = x"00" else '0';
  logic18 <= '1' when SignalSet(12 downto 5) = x"FF" else '0';

  logic19 <= '1' when SignalSet(12 downto 5) = x"AA" else '0';
  logic20 <= '1' when SignalSet(12 downto 5) = x"00" else '0';
  logic21 <= '1' when SignalSet(12 downto 5) = x"55" else '0';
  logic22 <= '1' when SignalSet(12 downto 5) = x"FF" else '0';


	--------------------------
	-- Logic - Automata 0
	--------------------------
	-- Transition process
	process(ControlClock)
	begin
		if ControlClock'event and ControlClock = '1' then
			S0_1 <= (SignalSet(0) and S0_0);
			S0_1 <= (SignalSet(0) and S0_1);
			S0_2 <= (trans0 and S0_1);
			S0_2 <= (trans0 and S0_2);
			S0_3 <= (trans1 and S0_2);
			S0_3 <= (trans1 and S0_3);
			S0_4 <= (trans2 and S0_3);
			S0_4 <= (trans2 and S0_4);
			S0_5 <= (trans3 and S0_4);
			S0_5 <= (trans3 and S0_5);
			S0_6 <= (trans4 and S0_5);
			S0_6 <= (trans4 and S0_6);
			S0_7 <= (trans5 and S0_6);
			S0_7 <= (trans5 and S0_7);
			S0_8 <= (trans6 and S0_7);
			S0_8 <= (trans6 and S0_8);
			S0_9 <= (trans7 and S0_8);
			S0_9 <= (trans7 and S0_9);
			S0_10 <= (trans8 and S0_9);
			S0_10 <= (trans8 and S0_10);
			S0_11 <= (trans9 and S0_10);
			S0_11 <= (trans9 and S0_11);
			S0_0 <= (SignalSet(2) and S0_11);
			S0_0 <= (SignalSet(2) and S0_0);
			S0_12 <= (trans10 and S0_0);
			S0_12 <= (trans10 and S0_12);
			S0_13 <= (trans11 and S0_12);
			S0_13 <= (trans11 and S0_13);
			S0_14 <= (trans12 and S0_13);
			S0_14 <= (trans12 and S0_14);
			S0_15 <= (trans13 and S0_14);
			S0_15 <= (trans13 and S0_15);
			S0_16 <= (trans14 and S0_15);
			S0_16 <= (trans14 and S0_16);
			S0_17 <= (trans15 and S0_16);
			S0_17 <= (trans15 and S0_17);
			S0_18 <= (trans16 and S0_17);
			S0_18 <= (trans16 and S0_18);
			S0_19 <= (trans17 and S0_18);
			S0_19 <= (trans17 and S0_19);
			S0_20 <= (trans18 and S0_19);
			S0_20 <= (trans18 and S0_20);
			S0_21 <= (not SignalSet(1) and S0_20);
			S0_21 <= (not SignalSet(1) and S0_21);
			S0_0 <= (not SignalSet(4) and S0_21);

		end if;
	end process;

  --------------------------
  -- Logic - Automata 1
  --------------------------
  -- Transition process
  process(ControlClock)
  begin
    if ControlClock'event and ControlClock = '1' then
      S1_0 <= (logic9 and logic10 and S1_1);

      IllegalStateDetections(0) <= S1_0;
    end if;
  end process;

  --------------------------
  -- Logic - Automata 2
  --------------------------
  -- Transition process
  process(ControlClock)
  begin
    if ControlClock'event and ControlClock = '1' then
      S2_0 <= (logic14 and S2_1);
      S2_1 <= (logic13 and S2_2);
      S2_2 <= (logic12 and S2_3);
      S2_3 <= (logic11 and S2_4);
      S2_4 <= (not logic14 and S2_1);
      S2_4 <= (not logic13 and S2_2);
      S2_4 <= (not logic12 and S2_3);

      IllegalStateDetections(1) <= S2_0;
    end if;
  end process;

  --------------------------
  -- Logic - Automata 3
  --------------------------
  -- Transition process
  process(ControlClock)
  begin
    if ControlClock'event and ControlClock = '1' then
      S3_0 <= (logic18 and S3_1);
      S3_1 <= (logic17 and S3_2);
      S3_2 <= (logic16 and S3_3);
      S3_3 <= (logic15 and S3_4);
      S3_4 <= (not logic18 and S3_1);
      S3_4 <= (not logic17 and S3_2);
      S3_4 <= (not logic16 and S3_3);

      IllegalStateDetections(2) <= S3_0;
    end if;
  end process;

  --------------------------
  -- Logic - Automata 4
  --------------------------
  -- Transition process
  process(ControlClock)
  begin
    if ControlClock'event and ControlClock = '1' then
      S4_0 <= (logic22 and S4_1);
      S4_1 <= (logic21 and S4_2);
      S4_2 <= (logic20 and S4_3);
      S4_3 <= (logic19 and S4_4);
      S4_4 <= (not logic22 and S4_1);
      S4_4 <= (not logic21 and S4_2);
      S4_4 <= (not logic20 and S4_3);

      IllegalStateDetections(3) <= S4_0;
    end if;
  end process;

	--------------------------
	-- Logic - Automata 5
	--------------------------
	-- Transition process
	process(ControlClock)
	begin
		if ControlClock'event and ControlClock = '1' then
			S5_0 <= (counter1_done and S5_1);

			IllegalStateDetections(4) <= S5_0;
		end if;
	end process;




	logic23 <= '1' when AES_state = x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF" else '0';

	logic24 <= '1' when AES_state = x"3243F6A8885A308D313198A2E0370734" else '0';
	logic25 <= '1' when AES_state = x"00112233445566778899AABBCCDDEEFF" else '0';
	logic26 <= '1' when AES_state = x"00000000000000000000000000000000" else '0';
	logic27 <= '1' when AES_state = x"00000000000000000000000000000001" else '0';

	logic28 <= '1' when AES_state = x"00112233445566778899AABBCCDDEEFF" else '0';

--	logic29 <= '1' when AES_Out'event else '0';
	logic29 <= '0';


	counter2 : Counter
	generic map(128)
	port map(ControlClock, '0', logic29, x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF", counter2_done);

	--------------------------
	-- Logic - Automata 6
	--------------------------
	-- Transition process
	process(ControlClock)
	begin
		if ControlClock'event and ControlClock = '1' then
			S6_0 <= ((logic23 or logic28 or counter2_done) and S6_1);

			IllegalStateDetections(5) <= S6_0;
		end if;
	end process;

	--------------------------
	-- Logic - Automata 7
	--------------------------
	-- Transition process
	process(ControlClock)
	begin
		if ControlClock'event and ControlClock = '1' then
			S7_0 <= (logic27 and S7_1);
			S7_1 <= (logic26 and S7_2);
			S7_2 <= (logic25 and S7_3);
			S7_3 <= (logic24 and S7_4);
			S7_4 <= (not logic27 and S7_1);
			S7_4 <= (not logic26 and S7_2);
			S7_4 <= (not logic25 and S7_3);

			IllegalStateDetections(6) <= S7_0;
		end if;
	end process;




	logic30 <= '1' when RSA_cypher = RSA_inExp		else '0';

	logic31 <= '1' when RSA_inData = x"44444444"	else '0';

	logic32 <= '1' when RSA_inData = x"01FA0301"	else '0';

	logic33 <= '1' when RSA_ds = '1'							else '0';

	counter3 : Counter
	generic map(32)
	port map(ControlClock, '0', logic33, x"FFFFFFFF", counter3_done);

	--------------------------
	-- Logic - Automata 8
	--------------------------
	-- Transition process
	process(ControlClock)
	begin
		if ControlClock'event and ControlClock = '1' then
			S8_1 <= (RSA_ds and S8_0);
			S8_2 <= (not RSA_Ready and S8_1);
			S8_3 <= (not RSA_ds and S8_2);
			S8_0 <= (RSA_Ready and S8_3);

		end if;
	end process;

	--------------------------
	-- Logic - Automata 9
	--------------------------
	-- Transition process
	process(ControlClock)
	begin
		if ControlClock'event and ControlClock = '1' then
			S9_0 <= (logic30 and S9_1);

			IllegalStateDetections(7) <= S9_0;
		end if;
	end process;

	--------------------------
	-- Logic - Automata 10
	--------------------------
	-- Transition process
	process(ControlClock)
	begin
		if ControlClock'event and ControlClock = '1' then
			S10_0 <= ((logic31 or logic32 or counter3_done) and S10_1);

			IllegalStateDetections(8) <= S10_0;
		end if;
	end process;




end STRUCTURAL;