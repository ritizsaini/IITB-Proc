library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;
entity se7 is
port (X: in std_logic_vector(8 downto 0);
s_type: in std_logic;
Y: out std_logic_vector(15 downto 0));
end entity se7;
architecture Easy of se7 is

begin
process(X,s_type)
begin
if(s_type='1') then
      Y<=X(8)&X(7)&X(6)&X(5)&X(4)&X(3)&X(2)&X(1)&X(0)&'0'&'0'&'0'&'0'&'0'&'0'&'0';
elsif(s_type='0') then
      Y(8 downto 0) <= X(8 downto 0); 
		Y(15) <= X(8);
		Y(14) <= X(8); 
		Y(13) <= X(8);
		Y(12) <= X(8); 
		Y(11) <= X(8);
		Y(10) <= X(8);
		Y(9) <= X(8);
end if;
end process;
end Easy;