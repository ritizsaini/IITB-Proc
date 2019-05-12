library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
library ieee;
use ieee.numeric_std.all; 


entity IITB_PROC is
  port (
    clk,rst     : in  std_logic;
	 op : out std_logic_vector(3 downto 0));
end entity;

architecture behave of IITB_PROC is
---------------------------------------------------------------------------------------------------components
component ALU is 
	port( X,Y : in std_logic_vector(15 downto 0);
		s_type : in std_logic ;
		C_out, Z_out: out std_logic;
		Z : out std_logic_vector(15 downto 0));
end component ALU;

component se7 is
port (X: in std_logic_vector(8 downto 0);
s_type: in std_logic;
Y: out std_logic_vector(15 downto 0));
end component se7;

component se10 is
port (X: in std_logic_vector(5 downto 0);
Y: out std_logic_vector(15 downto 0));
end component se10;

component memory is 
	port ( wr,rd,clk : in std_logic; 
			Addr_in, D_in: in std_logic_vector(15 downto 0);
			D_out: out std_logic_vector(15 downto 0)); 
end component memory; 

component rf is 
	port( A1,A2,A3 : in std_logic_vector(2 downto 0);
		  D3, D_PC: in std_logic_vector(15 downto 0);
		  
		clk,wr,pc_wr, reset: in std_logic ; 
		D1, D2: out std_logic_vector(15 downto 0));
end component rf;

----------------------------------------------------------------------------------------------------------------------------------------

type FSMState is (Sres, Sup, S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, S16, S17, S18, S19, S20, S21);
signal state: FSMState;
signal t1, t2, t3, t4, ir, se7_out,se10_out, mem_add, mem_din, mem_dout, alu_x, alu_y, alu_out, rD3, rD_PC, rD1, rD2 :std_logic_vector(15 downto 0):="0000000000000000";
signal mem_rd, se7_type, mem_wr, alu_op ,rpc_wr,zero_out, car_out, z_out, rf_rst, carry, zero, rwr :std_logic:='0';
signal se7_in : std_logic_vector(8 downto 0);
signal se10_in : std_logic_vector(5 downto 0);
signal rA1, rA2, rA3: std_logic_vector(2 downto 0);
signal op_code : std_logic_vector(3 downto 0);
signal mem_addr: std_logic_vector(15 downto 0):="0000000000000000";

begin

se7_reg : se7 port map (se7_in, se7_type, se7_out);
se10_reg : se10 port map (se10_in, se10_out);

rf_main : rf port map (rA1, rA2, rA3, rD3,rD_PC, clk, rwr,rpc_wr, rf_rst, rD1, rD2);
alu_main : alu port map (alu_x, alu_y, alu_op, car_out, z_out, alu_out);
mem_main : memory port map (mem_wr, mem_rd,clk, mem_add, mem_din, mem_dout);


process(clk,state)	
     variable next_state : FSMState;
	  variable t1_v, t2_v, t3_v, t4_v, ir_v, next_ip: std_logic_vector(15 downto 0);
	  variable z, car : std_logic;
	  variable op_v : std_logic_vector(3 downto 0);
	  
begin
	   next_state :=state;
		t1_v :=t1; t2_v :=t2; t3_v :=t3; t4_v :=t4; ir_v :=ir; op_v := op_code;
		z :=zero; car :=carry;
		next_ip :=mem_addr;
  case state is
       when Sres =>
		    mem_wr <= '0';
		    mem_rd <= '0';
			 rwr <= '0';
			 rf_rst <= '1';
          z := '0';
			 car :='0';
          t1_v := "0000000000000000";
          t2_v := "0000000000000000";
          t3_v := "0000000000000000";
		    ir_v := "0000000000000000";
			 next_state := S0;
----------------------------------------------------------
       when S0 =>
		    mem_wr <= '0';
		    mem_rd <= '1';
			 rwr <= '0';
			 rf_rst <='0';
          t1_v := "0000000000000000";
          t2_v := "0000000000000000";
          t3_v := "0000000000000000";
			 mem_add <= mem_addr;
			 ir_v := mem_dout;
			 op_v := ir_v(15 downto 12);
			 
			 case (op_v) is
			   when "0000" =>
				  next_state :=S1;
				when "0001" =>
				  next_state :=S4;
				when "0010" =>
				  next_state :=S1;
				when "0011" =>
				  next_state :=S6;
				when "0100" =>
				  next_state :=S8;
				when "0101" =>
				  next_state :=S8;
				when "0110" =>
				  next_state :=S11;
				when "1001" =>
				  next_state :=S17;
				when "1100" =>
				  next_state :=S1;
				when "1000" =>
				  next_state :=S17;
				when "0111" =>
				  next_state :=S11;
			   when others => null;
          end case; 
--------------------------------------------		
	     when S1 =>
		      mem_wr <= '0';
		      mem_rd <= '0';
			   rwr <= '0';
		      rA1 <=ir_v(11 downto 9);
				rA2 <=ir_v(8 downto 6);
				t1_v := rD1;
				t2_v := rD2;
				next_state :=S2;
----------------------------------------------
		  when S2 =>
		      mem_wr <= '0';
		      mem_rd <= '0';
			   rwr <= '0';
		      alu_x <= t1_v;
				alu_y <= t2_v;
				if(op_v="0010") then
				  alu_op <='1';
				else 
				  alu_op <= '0';
				end if;
				t3_v := alu_out;
				
				case (op_v) is
			    when "0000" =>
				  next_state :=S3;
			    when "0001" =>
				  next_state :=S5;
				 when "0010" =>
				  next_state :=S3;
				 when "0100" =>
				  next_state :=S9;
				 when "0101" =>
				  next_state :=S10;
				 when "1100" =>
				  if(t1_v=t2_v) then
				      next_state :=S20;
					 else
					   next_state :=Sup;
					 end if;
			    when others => null;
            end case; 
-----------------------------------------------
--        when S2_up =>
--				t4_v := std_logic_vector(unsigned(not(t1_v)) + 1);
--				alu_x <= t4_v;
--				alu_y <= t2_v;
--				alu_op <='0';
--				t4_v := alu_out;
--			   case (op_v) is
--			    when "0000" =>
--				  next_state :=S3;
--			    when "0001" =>
--				  next_state :=S5;
--				 when "0010" =>
--				  next_state :=S3;
--				 when "0100" =>
--				  next_state :=S9;
--				 when "0101" =>
--				  next_state :=S10;
--				 when "1100" =>
--				  if(t4_v="0000000000000000") then
--				      next_state :=S20;
--					 else
--					   next_state :=Sup;
--					 end if;
--			    when others => null;
--            end case; 
---------------------------------------------------------------			 
			when S3 =>
			   mem_wr <= '0';
		      mem_rd <= '0';
			   rwr <= '1';
			   if(ir_v(1 downto 0)="00") then
				   rD3<=t3_v;
					rA3<=ir_v(5 downto 3);
					if(op_v="0000" or op_v="0001" or op_v="0010" or op_v="0100") then
				  z :=z_out;
				end if;
				if(op_v="0000" or op_v="0001") then
				  car:=car_out;
				end if;
				elsif(ir_v(1 downto 0)="10" and car='1') then
					rD3<=t3_v;
					rA3<=ir_v(5 downto 3);
					if(op_v="0000" or op_v="0001" or op_v="0010" or op_v="0100") then
				  z :=z_out;
				end if;
				if(op_v="0000" or op_v="0001") then
				  car:=car_out;
				end if;
            elsif(ir_v(1 downto 0)="01" and z='1') then
					rD3<=t3_v;
					rA3<=ir_v(5 downto 3);
					if(op_v="0000" or op_v="0001" or op_v="0010" or op_v="0100") then
				  z :=z_out;
				end if;
				if(op_v="0000" or op_v="0001") then
				  car:=car_out;
				end if;
		      end if;
				
            next_state :=Sup;
-----------------------------------------------------------------
		   when S4 =>
			   mem_wr <= '0';
		      mem_rd <= '0';
			   rwr <= '0';
		      rA1 <=ir_v(11 downto 9);
				t1_v := rD1;
				se10_in <=ir_v(5 downto 0);
				t2_v := se10_out;
				next_state :=S2;
-----------------------------------------------------------------				
			when S5 =>
			   mem_wr <= '0';
		      mem_rd <= '0';
			   rwr <= '1';
				if(op_v="0000" or op_v="0001" or op_v="0010" or op_v="0100") then
				  z :=z_out;
				end if;
				if(op_v="0000" or op_v="0001") then
				  car:=car_out;
				end if;
				rD3<=t3_v;
				rA3<=ir_v(8 downto 6);
            next_state :=Sup;
-----------------------------------------------------------------				
			when S6 =>
			   mem_wr <= '0';
		      mem_rd <= '0';
			   rwr <= '0';
				se7_in <= ir_v(8 downto 0);
				se7_type<='1';
				t1_v := se7_out;
				next_state :=S7;
-----------------------------------------------------------------
		   when S7 =>
			   mem_wr <= '0';
		      mem_rd <= '0';
			   rwr <= '1';
				rD3<=t1_v;
				rA3<=ir_v(11 downto 9);
            next_state :=Sup;
-----------------------------------------------------------------
         when S8 =>
            mem_wr <= '0';
		      mem_rd <= '0';
			   rwr <= '0';
		      rA1 <=ir_v(8 downto 6);
				t1_v := rD1;
				se10_in <=ir_v(5 downto 0);
				t2_v := se10_out;
				next_state :=S2;
-----------------------------------------------------------------
         when S9 =>
			   mem_rd <='1';
				if(op_v="0000" or op_v="0001" or op_v="0010" or op_v="0100") then
				  z :=z_out;
				end if;
				if(op_v="0000" or op_v="0001") then
				  car:=car_out;
				end if;
			   mem_add <= t3_v;
			   t1_v := mem_dout;
			   rwr <= '1';
				rD3<=t1_v;
				rA3<=ir_v(11 downto 9);
            next_state :=Sup;
-----------------------------------------------------------------
         when S10 =>
            mem_wr <= '1';
		      mem_rd <= '0';
			   rwr <= '0';
		      rA1 <=ir_v(11 downto 9);
				t2_v := rD1;
	         mem_add <= t3_v;
	         mem_din <= t2_v;
	         next_state :=Sup;
-----------------------------------------------------------------
	      when S11 =>
			   mem_wr <= '0';
		      mem_rd <= '0';
			   rwr <= '0';
		      rA1 <=ir_v(11 downto 9);
				t1_v := rD1;
				if(op_v="0110") then
				  next_state :=S12;
				else
				  next_state :=S15;
				end if;
-----------------------------------------------------------------
         when S12 =>
			   mem_wr <= '0';
		      mem_rd <= '1';
			   rwr <= '0';
			   mem_add <= t1_v;
			   t3_v := mem_dout;
				next_state :=S13;
-----------------------------------------------------------------
         when S13 =>
			   rwr <= '1';
				rD3<=t3_v;
				rA3<=t2_v(2 downto 0);
				alu_x <= t2_v;
				alu_y <= "0000000000000001";
				alu_op <= '0';
				t2_v := alu_out;
				next_state :=S14;
-----------------------------------------------------------------
         when S14 =>
			   alu_x <= t1_v;
				alu_y <= "0000000000000001";
				alu_op <= '0';
				t1_v := alu_out;
				if(unsigned(t2_v)<8) then
				  if(op_v="0110") then
				    next_state :=S12;
				  else
				    next_state :=S15;
				  end if;
				else
				  next_state :=Sup;
				end if;
-----------------------------------------------------------------				  
         when S15 =>
			   mem_wr <= '1';
		      mem_rd <= '0';
			   rwr <= '0';
		      rA2 <=t2_v(2 downto 0);
				t3_v := rD2;
				mem_add <= t1_v;
	         mem_din <= t3_v;
	         next_state :=S16;
-----------------------------------------------------------------
         when S16 =>
			   alu_x <= t2_v;
				alu_y <= "0000000000000001";
				alu_op <='0';
				t2_v :=alu_out;
				next_state :=S14;
-----------------------------------------------------------------
         when S17 =>
			   mem_wr <= '0';
		      mem_rd <= '0';
			   rwr <= '1';
				rD3<=mem_addr;
				rA3<=ir_v(11 downto 9);
				if(op_v="1001") then
				  next_state :=S18;
				else 
				  next_state :=S19;
				end if;
-----------------------------------------------------------------
         when S18 =>
            mem_wr <= '0';
		      mem_rd <= '0';
			   rwr <= '0';
		      rA1 <=ir_v(8 downto 6);
				next_ip := rD1;
	         next_state :=S0;
-----------------------------------------------------------------
         when S19 =>
			   mem_wr <= '0';
		      mem_rd <= '0';
			   rwr <= '0';
				alu_x <=next_ip;
				se7_in <=ir_v(8 downto 0);
				se7_type <='0';
				alu_y <=se7_out;
				alu_op <= '0';
				next_ip:=alu_out;
				next_state :=S0;
-----------------------------------------------------------------
         when S20 =>
            alu_x <= mem_addr;
	         se10_in <= ir_v(5 downto 0);
	         alu_y <= se10_out;
				alu_op<='0';
				next_ip:=alu_out;
				next_state :=S0;
-----------------------------------------------------------------
         when Sup =>
			   mem_wr <= '0';
		      mem_rd <= '0';
			   rwr <= '0';
			   alu_x <= mem_addr;
			   alu_y <= "0000000000000001";
			   alu_op <= '0';
			   next_ip := alu_out;
				next_state :=S0;
-----------------------------------------------------------------				
		when others => null;
  end case;		
  
 if(clk'event and clk = '0') then
          if(rst = '1') then
             state <= Sres;
          else
             state <= next_state;
				 t1<=t1_v;t2<=t2_v;t3<=t3_v;t4<=t4_v;
				 zero<=z; carry<=car;
				 ir<=ir_v;
				 op_code<=op_v;
				 mem_addr<=next_ip;
          end if;
     end if;
end process;
end behave;