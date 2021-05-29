----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.05.2021 22:39:09
-- Design Name: 
-- Module Name: CONT_UNIT_2_TB - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity CONT_UNIT_2_tb is
end;

architecture bench of CONT_UNIT_2_tb is

  component CONT_UNIT_2
      Generic (CW_WIDTH: integer:=21;
              COP_WIDTH: integer:=4);
      Port ( COP_i : in STD_LOGIC_VECTOR (COP_WIDTH-1 downto 0);
             CLK_i : in STD_LOGIC;
             RST_i : in STD_LOGIC;
             FZ_i : in STD_LOGIC;
             CW_o : out STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0));
  end component;
  
  constant CW_WIDTH: integer:= 21;
  constant COP_WIDTH: integer:=4;

  signal COP_i: STD_LOGIC_VECTOR (COP_WIDTH-1 downto 0);
  signal CLK_i: STD_LOGIC;
  signal RST_i: STD_LOGIC;
  signal FZ_i: STD_LOGIC;
  signal CW_o: STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  -- Insert values for generic parameters !!
  uut: CONT_UNIT_2 generic map ( CW_WIDTH  =>  CW_WIDTH  ,
                                 COP_WIDTH =>  COP_WIDTH  )
                      port map ( COP_i     => COP_i,
                                 CLK_i     => CLK_i,
                                 RST_i     => RST_i,
                                 FZ_i      => FZ_i,
                                 CW_o      => CW_o );

  stimulus: process
  begin
  
    -- Put initialisation code here
    RST_i <= '1';
    wait for 10 ns;
    RST_i <= '0'; 
    wait for 10 ns;
  

    -- Put test bench stimulus code here
    COP_i <= "0000";
    FZ_i <= '0';
    wait for 100 ns;
    
    COP_i <= "0001";
    wait for 90 ns;
    
    COP_i <= "0010";
    wait for 90 ns;
    
    COP_i <= "0011";
    wait for 90 ns;
    
    COP_i <= "0100";
    wait for 80 ns;
    
    COP_i <= "0101";
    wait for 80 ns;
    
    COP_i <= "0110";
    wait for 50 ns;
    
    FZ_i <= '1';
    wait for 50 ns;

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      CLK_i <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;
