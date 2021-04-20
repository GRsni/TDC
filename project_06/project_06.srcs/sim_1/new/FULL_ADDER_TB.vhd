----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.02.2021 11:10:47
-- Design Name: 
-- Module Name: FULL_ADDER_TB - Behavioral
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

entity FULL_ADDER_tb is
end;

architecture bench of FULL_ADDER_tb is

  component FULL_ADDER
      Port ( A_i : in STD_LOGIC;
             B_i : in STD_LOGIC;
             CARRY_i : in STD_LOGIC;
             CARRY_o : out STD_LOGIC;
             SUM_o : out STD_LOGIC);
  end component;

  signal A_i: STD_LOGIC;
  signal B_i: STD_LOGIC;
  signal CARRY_i: STD_LOGIC;
  signal CARRY_o: STD_LOGIC;
  signal SUM_o: STD_LOGIC;

begin

  uut: FULL_ADDER port map ( A_i     => A_i,
                             B_i     => B_i,
                             CARRY_i => CARRY_i,
                             CARRY_o => CARRY_o,
                             SUM_o   => SUM_o );

  stimulus: process
  begin
  
    -- Put initialisation code here


    -- Put test bench stimulus code here
    
    A_i <= '0';
    B_i <= '0';
    CARRY_i <= '0';
    wait for 20 ns;
    
    A_i <= '1';
    wait for 20 ns;
    
    B_i <= '1';
    wait for 20 ns;
    
    A_i <= '0';
    wait for 20 ns;
    
    B_i <= '0';
    CARRY_i <= '1';
    wait for 40 ns;
    
    A_i <= '1';
    wait for 20 ns;
    
    B_i <= '1';
    wait for 20 ns;
    
    A_i <= '0';
    wait;
  end process;


end;