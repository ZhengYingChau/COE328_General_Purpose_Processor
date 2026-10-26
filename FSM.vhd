LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY FSM IS
	PORT ( clk, data_in, reset : IN STD_LOGIC ;
			 student_id, current_state : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) ) ;
END FSM ;

ARCHITECTURE Behavior OF FSM IS
	type state_type is (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9);
	SIGNAL ytsm : state_type ;
BEGIN
	process (clk, reset)
	BEGIN
		if reset = '0' then
			ytsm <= s0;
		elsif Rising_edge(clk) then
			case ytsm is
				when s0 => ytsm <= s1;
				when s1 => ytsm <= s2;
				when s2 => ytsm <= s3;
				when s3 => ytsm <= s4;
				when s4 => ytsm <= s5;
				when s5 => ytsm <= s6;
				when s6 => ytsm <= s7;
				when s7 => ytsm <= s8;
				when s8 => ytsm <= s0;
				when others => ytsm <= s9;
			end case;
		end if;
	end process;
	process (ytsm)
	begin
		case ytsm is
			when s0 => student_id <= "0101";
			when s1 => student_id <= "0000";
			when s2 => student_id <= "0001";
			when s3 => student_id <= "0011";
			when s4 => student_id <= "0001";
			when s5 => student_id <= "0000";
			when s6 => student_id <= "0111";
			when s7 => student_id <= "1000";
			when s8 => student_id <= "0101";
			when s9 => student_id <= "----";
		end case;
		case ytsm is
			when s0 => current_state <= "0000";
			when s1 => current_state <= "0001";
			when s2 => current_state <= "0010";
			when s3 => current_state <= "0011";
			when s4 => current_state <= "0100";
			when s5 => current_state <= "0101";
			when s6 => current_state <= "0110";
			when s7 => current_state <= "0111";
			when s8 => current_state <= "1000";
			when s9 => current_state <= "----";
		end case;
	end process;
END Behavior ;