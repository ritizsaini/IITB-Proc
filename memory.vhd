library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all; 
library ieee;
use ieee.numeric_std.all;

entity memory is 
	port (wr,rd,clk: in std_logic; 
			Addr_in, D_in: in std_logic_vector(15 downto 0);
			D_out: out std_logic_vector(15 downto 0)); 
end entity; 

architecture behave of memory is 
	type registerFile is array(65535 downto 0) of std_logic_vector(15 downto 0);
	signal mem_reg: registerFile:=(0 => x"3001", 1 => x"60aa", 2 => x"0038", 3 => x"03fa", 4 => x"0079", 5 => x"5f9f", 6 => x"13fb", 7 => x"2038",
	8 => x"233a", 9 => x"2079", 10 => x"4f86",11 => x"4f9f", 12 => x"c9c2", 13 => x"abcd", 14 => x"8e02", 15 => x"1234", 16 => x"7caa", 17 => x"91c0",
	128 => x"ffff", 129 => x"0002", 130 => x"0000", 131 => x"0000", 132 => x"0001", 133 => x"0000",
	others => x"0000");
	begin 
	  process(wr,rd,Addr_in,D_in,mem_reg,clk)
	   begin
		if (rd = '1') then
			 D_out <= mem_reg(to_integer(unsigned(Addr_in)));
		elsif (rd = '0') then
		  	 D_out <= "1111111111111111";
		end if;

		if (wr = '1') then
		  if(falling_edge(clk)) then
			mem_reg(to_integer(unsigned(Addr_in))) <= D_in;
		  end if;
		end if;
	end process;	
	end behave;