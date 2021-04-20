----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.02.2021 14:17:05
-- Design Name: 
-- Module Name: DEC_2to4_TB - Behavioral
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

entity DEC_2to4_tb is
end;

architecture bench of DEC_2to4_tb is

  component DEC_2to4
      Port ( A_i : in STD_LOGIC_VECTOR (1 downto 0);
             ENA_i : in STD_LOGIC;
             Z_o : out STD_LOGIC_VECTOR (3 downto 0));
  end component;

  signal A_i: STD_LOGIC_VECTOR (1 downto 0):="00";
  signal ENA_i: STD_LOGIC;
  signal Z_o: STD_LOGIC_VECTOR (3 downto 0);

begin

  uut: DEC_2to4 port map ( A_i   => A_i,
                           ENA_i => ENA_i,
                           Z_o   => Z_o );

  stimulus: process
  begin
  
    -- Put initialisation code here
    ENA_i <= '0';
    wait for 10 ns;
    
    -- Put test bench stimulus code here
    A_i <="00";
    wait for 10 ns;
    
    A_i <="01";
    wait for 10 ns;
    
    A_i <="10";
    wait for 10 ns;
            
    A_i <="11";
    wait for 10 ns;
    
    ENA_i <= '1';
    A_i <="00";
    wait for 10 ns;
    
    A_i <="01";
    wait for 10 ns;
    
    A_i <="10";
    wait for 10 ns;
       
    A_i <="11";

    wait;
  end process;


end;