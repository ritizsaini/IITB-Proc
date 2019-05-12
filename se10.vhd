library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;
entity se10 is
port (X: in std_logic_vector(5 downto 0);
Y: out std_logic_vector(15 downto 0));
end entity se10;
architecture Easy of se10 is

begin
      Y(5 downto 0) <= X(5 downto 0); 
		Y(15) <= X(5);
		Y(14) <= X(5); 
		Y(13) <= X(5);
		Y(12) <= X(5); 
		Y(11) <= X(5);
		Y(10) <= X(5);
		Y(9) <= X(5);
		Y(8) <= X(5);
		Y(7) <= X(5);
		Y(6) <= X(5);
end Easy;