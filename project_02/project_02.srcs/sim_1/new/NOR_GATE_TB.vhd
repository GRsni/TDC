----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.02.2021 12:19:07
-- Design Name: 
-- Module Name: NOR_GATE_TB - Behavioral
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

entity NOR_GATE_tb is
end;

architecture bench of NOR_GATE_tb is

  component NOR_GATE
      Port ( A_i : in STD_LOGIC_VECTOR (1 downto 0);
             B_i : in STD_LOGIC_VECTOR (1 downto 0);
             Z_o : out STD_LOGIC_VECTOR (1 downto 0));
  end component;

  signal A_i: STD_LOGIC_VECTOR (1 downto 0);
  signal B_i: STD_LOGIC_VECTOR (1 downto 0);
  signal Z_o: STD_LOGIC_VECTOR (1 downto 0);

begin

  uut: NOR_GATE port map ( A_i => A_i,
                           B_i => B_i,
                           Z_o => Z_o );

  stimulus: process
  begin
  
    -- Put initialisation code here


    -- Put test bench stimulus code here
        -- 00 for B
        A_i <= "00";
        B_i <= "00";
        wait for 40 ns;

        A_i <= "01";
        B_i <= "00";
        wait for 40 ns;
        
        A_i <= "10";
        B_i <= "00";
        wait for 40 ns;
        
        A_i <= "11";
        B_i <= "00";
        wait for 40 ns;
        
        -- 01 for B
        
        A_i <= "00";
        B_i <= "01";
        wait for 40 ns;
        
        A_i <= "01";
        B_i <= "01";
        wait for 40 ns;
        
        A_i <= "10";
        B_i <= "01";
        wait for 40 ns;
        
        A_i <= "11";
        B_i <= "01";
        wait for 40 ns;
        
        -- 10 for B
        
        A_i <= "00";
        B_i <= "10";
        wait for 40 ns;
        
        A_i <= "01";
        B_i <= "10";
        wait for 40 ns;
        
        A_i <= "01";
        B_i <= "10";
        wait for 40 ns;
        
        A_i <= "11";
        B_i <= "10";
        wait for 40 ns;
        
        -- 11 for B
        
        A_i <= "00";
        B_i <= "11";
        wait for 40 ns;
        
        A_i <= "01";
        B_i <= "11";
        wait for 40 ns;
        
        A_i <= "01";
        B_i <= "11";
        wait for 40 ns;
        
        A_i <= "11";
        B_i <= "11";
        wait for 40 ns;
                                
    wait;
  end process;


end;
