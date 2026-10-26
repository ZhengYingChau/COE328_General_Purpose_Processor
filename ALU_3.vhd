Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_3 is
	port(Clk : in std_logic; --input clock signal
		  A, B: in unsigned(7 downto 0); --8-bit inputs from latches A and B
		  student_id : in unsigned(3 downto 0); --4 bit student id from FSM
		  OP : in unsigned(15 downto 0); --16-bit selector for Operation from Decoder
		  Parity : out unsigned(6 downto 0)); -- parity output
end ALU_3;

architecture calculation of ALU_3 is --temporary signal declarations
begin
process (Clk,OP)
begin
	--if(rising_edge(Clk)) THEN --Do the calculation @ positive edge of clock cycle.
		case student_id(0) XOR student_id(1) XOR student_id(2) XOR student_id(3) is
			WHEN '1' => Parity <= "1000100";
			WHEN '0' => Parity <= "1101010";
		end case;
	--end if;
end process;
end calculation;
--Since the output seven segments can only 4-bits, split the 8-bit to two 4-bits. 