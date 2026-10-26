Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALUModified is
	port(Clk : in std_logic; --input clock signal
		  A, B: in unsigned(7 downto 0); --8-bit inputs from latches A and B
		  student_id : in unsigned(3 downto 0); --4 bit student id from FSM
		  OP : in unsigned(15 downto 0); --16-bit selector for Operation from Decoder
		  Neg: out std_logic; --is the result negative ? Set-ve bit output
		  R1 : out unsigned(3 downto 0); --lower 4-bits of 8-bit Result Output
		  R2 : out unsigned(3 downto 0)); --higher 4-bits of 8-bit Result Output
end ALUModified;

architecture calculation of ALUModified is --temporary signal declarations
	signal Reg1, Reg2, Result : unsigned(7 downto 0):= (others => '0');
	signal Reg4 : unsigned (0 to 7);
begin
	Reg1 <= A; --temporarily store A in Regl local variable
	Reg2 <= B; --tcmporarily store B in Reg2 local variable
process (Clk,OP)
begin
	if(rising_edge(Clk)) THEN --Do the calculation @ positive edge of clock cycle.
		case OP is
			WHEN "0000000000000001" => --Difference
				if Reg1 < Reg2 then
					Result <= Reg2 - Reg1;
					Neg <= '0';
				else
					Result <= Reg1 - Reg2;
					Neg <= '0';
				end if;
			WHEN "0000000000000010" => --Two's Complement of B
				Result <= NOT Reg2 + "00000001";
			WHEN "0000000000000100" => --4 LSB Swap
				Reg1(3 downto 0) <= B(3 downto 0);
				Reg2(3 downto 0) <= A(3 downto 0);
			WHEN "0000000000001000" => --Null
				Result <= null;
			WHEN "0000000000010000" => --Decrement B by 5
				Reg2 <= B - "00000101";
			WHEN "0000000000100000" => --Invert order of A
				Reg1(0) <= A(7);
				Reg1(1) <= A(6);
				Reg1(2) <= A(5);
				Reg1(3) <= A(4);
				Reg1(4) <= A(3);
				Reg1(5) <= A(2);
				Reg1(6) <= A(1);
				Reg1(7) <= A(0);
			WHEN "0000000001000000" => --Shift B left 3 bits (In = 1)
				Reg2(0) <= B(3);
				Reg2(1) <= B(4);
				Reg2(2) <= B(5);
				Reg2(3) <= B(6);
				Reg2(4) <= B(7);
				Reg2(5 to 7) <= "111";
			WHEN "0000000010000000" => --Increment A by 3
				Reg1 <= A + "00000011";
			WHEN "0000000100000000" => --Invert B
				Reg2 <= NOT B;
			WHEN OTHERS => --Nothing
		end case;
	end if;
end process;
	R1 <= Result(3 downto 0);  -- lower 4-bits of 8-bit Result Output
	R2 <= Result(7 downto 4);  -- higher 4-bits of 8-bit Result Output
end calculation;
--Since the output seven segments can only 4-bits, split the 8-bit to two 4-bits. 