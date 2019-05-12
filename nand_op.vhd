library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;
entity nand_op is
	port(A,B: in std_logic_vector(15 downto 0);
		op: out std_logic_vector(15 downto 0));
end entity;

architecture comp_nand of nand_op is

begin
	op <= A nand B;
end comp_nand;