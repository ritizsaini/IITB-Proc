library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
----------------------------------------------------------------------------------
entity ALU is 
	port( X,Y : in std_logic_vector(15 downto 0);
		s_type : in std_logic ;
		C_out, Z_out: out std_logic;
		Z : out std_logic_vector(15 downto 0));
end entity;
-----------------------------------------------------------------------------------
architecture behave of ALU is
	signal t1,t2: std_logic_vector(15 downto 0);
	signal car1, car2 : std_logic;

	component bit_16_adder is
      port (A,B: in std_logic_vector(15 downto 0);car_in: in std_logic; car_out: out std_logic; sum: out std_logic_vector(15 downto 0));
   end component bit_16_adder;

	component nand_op is
	   port(A,B: in std_logic_vector(15 downto 0);
		op: out std_logic_vector(15 downto 0));
   end component nand_op;

begin
	p_1: bit_16_adder port map (A => X, B => Y, sum => t1, car_in => '0', car_out => car1);
	p_2: nand_op port map (A => X, B => Y, op => t2);

	process (s_type, t1, t2, car1, car2)
	begin
		if (s_type = '0') then
			Z <= t1; -- ADD operation
			C_out <= car1;
			Z_out <= not (t1(0) or t1(1) or t1(2) or t1(3) or t1(4) or t1(5) or t1(6) or t1(7) or t1(8) or t1(9) or t1(10) or t1(11) or t1(12) or t1(13) or t1(14) or t1(15));
		elsif (s_type = '1') then
			Z <= t2; -- NAND operation
			C_out <= car2;
			Z_out <= not (t2(0) or t2(1) or t2(2) or t2(3) or t2(4) or t2(5) or t2(6) or t2(7) or t2(8) or t2(9) or t2(10) or t2(11) or t2(12) or t2(13) or t2(14) or t2(15));
	   end if;
	end process;

end behave;