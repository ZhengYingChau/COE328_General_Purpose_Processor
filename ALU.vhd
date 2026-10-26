Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
	port(Clk : in std_logic; --input clock signal
		  A, B: in unsigned(7 downto 0); --8-bit inputs from latches A and B
		  student_id : in unsigned(3 downto 0); --4 bit student id from FSM
		  OP : in unsigned(15 downto 0); --16-bit selector for Operation from Decoder
		  Neg: out std_logic; --is the result negative ? Set-ve bit output
		  R1 : out unsigned(3 downto 0); --lower 4-bits of 8-bit Result Output
		  R2 : out unsigned(3 downto 0)); --higher 4-bits of 8-bit Result Output
end ALU;

architecture calculation of ALU is --temporary signal declarations
	signal Reg1, Reg2, Result : unsigned(7 downto 0):= (others => '0');
	signal Reg4 : unsigned (0 to 7);
begin
	Reg1 <= A; --temporarily store A in Regl local variable
	Reg2 <= B; --tcmporarily store B in Reg2 local variable
process (Clk,OP)
begin
	--if(rising_edge(Clk)) THEN --Do the calculation @ positive edge of clock cycle.
		case OP is
			WHEN "0000000000000001" => --Addition
				Result <= Reg1 + Reg2;
				Neg <= '0';
			WHEN "0000000000000010" => --Subtraction
				if (Reg1 < Reg2) then
					Result <= Reg2 - Reg1;
					Neg <= '1';
				else
					Result <= Reg2 - Reg1;
					Neg <= '0';
				end if;
			WHEN "0000000000000100" => --Inverse
				Result <= NOT Reg1;
				Neg <= '0';
			WHEN "0000000000001000" => --NAND
				Result <= Reg1 NAND Reg2;
				Neg <= '0';
			WHEN "0000000000010000" => --NOR
				Result <= Reg1 NOR Reg2;
				Neg <= '0';
			WHEN "0000000000100000" => --AND
				Result <= Reg1 AND Reg2;
				Neg <= '0';
			WHEN "0000000001000000" => --OR
				Result <= Reg1 OR Reg2;
				Neg <= '0';
			WHEN "0000000010000000" => --XOR
				Result <= Reg1 XOR Reg2;
				Neg <= '0';
			WHEN "0000000100000000" => --XNOR
				Result <= Reg1 XNOR Reg2;
				Neg <= '0';
			WHEN OTHERS => --Nothing
		end case;
	--end if;
end process;
	R1 <= Result(3 downto 0);  -- lower 4-bits of 8-bit Result Output
	R2 <= Result(7 downto 4);  -- higher 4-bits of 8-bit Result Output
end calculation;
--Since the output seven segments can only 4-bits, split the 8-bit to two 4-bits. 