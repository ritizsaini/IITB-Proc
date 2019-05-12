library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;
entity bit_16_adder is
  port (A,B: in std_logic_vector(15 downto 0);car_in: in std_logic; car_out: out std_logic; sum: out std_logic_vector(15 downto 0));
end entity bit_16_adder;
architecture Struct of bit_16_adder is
  signal ti1, ti2,ti3,ti4,ti5,ti6,ti7,ti8,ti9,ti10,ti11,ti12,ti13,ti14,ti15: std_logic;
component Full_Adder  is
  port (A, B, Cin: in std_logic; S, Cout: out std_logic);
end component Full_Adder;
begin
       
  -- component instances
       fa0: Full_Adder
       port map (A => A(0), B => B(0) , Cin=>car_in, S => sum(0), Cout => ti1 );
       fa1: Full_Adder
       port map (A => A(1), B => B(1) , Cin=> ti1, S => sum(1), Cout => ti2 );
       fa2: Full_Adder
       port map (A => A(2), B => B(2) , Cin=> ti2, S => sum(2), Cout => ti3 );
		 fa3: Full_Adder
       port map (A => A(3), B => B(3) , Cin=> ti3, S => sum(3), Cout => ti4 );
		 fa4: Full_Adder
       port map (A => A(4), B => B(4) , Cin=> ti4, S => sum(4), Cout => ti5 );
		 fa5: Full_Adder
       port map (A => A(5), B => B(5) , Cin=> ti5, S => sum(5), Cout => ti6 );
		 fa6: Full_Adder
       port map (A => A(6), B => B(6) , Cin=> ti6, S => sum(6), Cout => ti7 );
		 fa7: Full_Adder
       port map (A => A(7), B => B(7) , Cin=> ti7, S => sum(7), Cout => ti8 );
		 fa8: Full_Adder
       port map (A => A(8), B => B(8) , Cin=> ti8, S => sum(8), Cout => ti9 );
		 fa9: Full_Adder
       port map (A => A(9), B => B(9) , Cin=> ti9, S => sum(9), Cout => ti10 );
		 fa10: Full_Adder
       port map (A => A(10), B => B(10) , Cin=> ti10, S => sum(10), Cout => ti11 );
		 fa11: Full_Adder
       port map (A => A(11), B => B(11) , Cin=> ti11, S => sum(11), Cout => ti12 );
		 fa12: Full_Adder
       port map (A => A(12), B => B(12) , Cin=> ti12, S => sum(12), Cout => ti13 );
		 fa13: Full_Adder
       port map (A => A(13), B => B(13) , Cin=> ti13, S => sum(13), Cout => ti14 );
		 fa14: Full_Adder
       port map (A => A(14), B => B(14) , Cin=> ti14, S => sum(14), Cout => ti15 );
		 fa15: Full_Adder
       port map (A => A(15), B => B(15) , Cin=> ti15, S => sum(15), Cout => car_out );
  -- propagate carry.
end Struct;