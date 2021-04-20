----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.03.2021 11:41:06
-- Design Name: 
-- Module Name: DECO_N_BITS_TB - Behavioral
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

entity DECO_N_BITS_tb is
end;

architecture bench of DECO_N_BITS_tb is

  component DECO_N_BITS
      Generic(N: integer:=4);
      Port ( A_i : in STD_LOGIC_VECTOR(N-1 downto 0);
             Z_o : out STD_LOGIC_VECTOR(2**N-1 downto 0));
  end component;
  constant N: integer:=4;
  signal A_i: STD_LOGIC_VECTOR(N-1 downto 0);
  signal Z_o: STD_LOGIC_VECTOR(2**N-1 downto 0);

begin

  -- Insert values for generic parameters !!
  uut: DECO_N_BITS generic map ( N   =>  N)
                      port map ( A_i => A_i,
                                 Z_o => Z_o );

  stimulus: process
  begin
  
    -- Put initialisation code here
    -- Put test bench stimulus code here
    A_i<="0000";
    wait for 20 ns;

    A_i<="0001";
    wait for 20 ns;
    
    A_i<="0010";
    wait for 20 ns;
    
    A_i<="0011";
    wait for 20 ns;
    
    A_i<="0100";
    wait for 20 ns;
    
    wait;
  end process;


end;