library ieee;
use ieee.std_logic_1164.all;
package Gates is
  component INVERTER is
   port (A: in std_logic; Y: out std_logic);
  end component INVERTER;
  
 component AND_8 is
   port (X0,X1, X2,X3,X4,X5,X6,X7,B: in std_logic; Y0,Y1, Y2,Y3,Y4,Y5,Y6,Y7: out std_logic);
  end component AND_8; 
  component AND_v is
   port (p:in std_logic_vector(15 downto 0);q: in std_logic;o: out std_logic_vector(15 downto 0));
  end component AND_v;
  component AND_2 is
   port (A, B: in std_logic; Y: out std_logic);
  end component AND_2;

  component NAND_2 is
   port (A, B: in std_logic; Y: out std_logic);
  end component NAND_2;

  component OR_2 is
   port (A, B: in std_logic; Y: out std_logic);
  end component OR_2;

  component NOR_2 is
   port (A, B: in std_logic; Y: out std_logic);
  end component NOR_2;

  component XOR_2 is
   port (A, B: in std_logic; Y: out std_logic);
  end component XOR_2;

  component XNOR_2 is
   port (A, B: in std_logic; Y: out std_logic);
  end component XNOR_2;

  component HALF_ADDER is
   port (A, B: in std_logic; S, C: out std_logic);
  end component HALF_ADDER;

end package Gates;


library ieee;
use ieee.std_logic_1164.all;
entity INVERTER is
   port (A: in std_logic; Y: out std_logic);
end entity INVERTER;

architecture Equations of INVERTER is
begin
   Y <= not A;
end Equations;
  
library ieee;
use ieee.std_logic_1164.all;
entity AND_8 is
   port (X0,X1, X2,X3,X4,X5,X6,X7,B: in std_logic;Y0,Y1, Y2,Y3,Y4,Y5,Y6,Y7: out std_logic);
end entity AND_8;

architecture Equations of AND_8 is
begin
   Y0 <= (X0 and B);
	Y1 <= (X1 and B);
	Y2 <= (X2 and B);
	Y3 <= (X3 and B);
	Y4 <= (X4 and B);
	Y5 <= (X5 and B);
	Y6 <= (X6 and B);
	Y7 <= (X7 and B);
end Equations;
  
library ieee;
use ieee.std_logic_1164.all;  
entity AND_v is
   port (p:in std_logic_vector(15 downto 0);q: in std_logic;o: out std_logic_vector(15 downto 0));
  end entity AND_v;  
architecture Equations of AND_v is
begin
   o(15)<=(p(15) and q);
	o(14)<=(p(14) and q);
	o(13)<=(p(13) and q);
	o(12)<=(p(12) and q);
	o(11)<=(p(11) and q);
	o(10)<=(p(10) and q);
	o(9)<=(p(9) and q);
	o(8)<=(p(8) and q);
	o(7)<=(p(7) and q);
	o(6)<=(p(6) and q);
	o(5)<=(p(5) and q);
	o(4)<=(p(4) and q);
	o(3)<=(p(3) and q);
	o(2)<=(p(2) and q);
	o(1)<=(p(1) and q);
	o(0)<=(p(0) and q);
end Equations;


library ieee;
use ieee.std_logic_1164.all;
entity AND_2 is
   port (A, B: in std_logic; Y: out std_logic);
end entity AND_2;

architecture Equations of AND_2 is
begin
   Y <= A and B;
end Equations;
  
library ieee;
use ieee.std_logic_1164.all;
entity NAND_2 is
   port (A, B: in std_logic; Y: out std_logic);
end entity NAND_2;

architecture Equations of NAND_2 is
begin
   Y <= not (A and B);
end Equations;
  
library ieee;
use ieee.std_logic_1164.all;
entity OR_2 is
   port (A, B: in std_logic; Y: out std_logic);
end entity OR_2;

architecture Equations of OR_2 is
begin
   Y <= A or B;
end Equations;
  
library ieee;
use ieee.std_logic_1164.all;
entity NOR_2 is
   port (A, B: in std_logic; Y: out std_logic);
end entity NOR_2;

architecture Equations of NOR_2 is
begin
   Y <= not (A or B);
end Equations;
  

library ieee;
use ieee.std_logic_1164.all;
entity XOR_2 is
   port (A, B: in std_logic; Y: out std_logic);
end entity XOR_2;

architecture Equations of XOR_2 is
begin
   Y <= A xor B;
end Equations;
  
library ieee;
use ieee.std_logic_1164.all;
entity XNOR_2 is
   port (A, B: in std_logic; Y: out std_logic);
end entity XNOR_2;

architecture Equations of XNOR_2 is
begin
   Y <= not (A xor B);
end Equations;
  
library ieee;
use ieee.std_logic_1164.all;
entity HALF_ADDER is
   port (A, B: in std_logic; S, C: out std_logic);
end entity HALF_ADDER;

architecture Equations of HALF_ADDER is
begin
   S <= (A xor B);
   C <= (A and B);
end Equations;
  