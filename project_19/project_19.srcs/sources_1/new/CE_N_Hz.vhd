----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.03.2021 10:53:51
-- Design Name: 
-- Module Name: CE_N_Hz - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CE_N_Hz is
    Generic ( END_COUNT: integer:= 100);
    Port ( CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           CLK_N_Hz_o : out STD_LOGIC);
end CE_N_Hz;

architecture Behavioral of CE_N_Hz is
    signal COUNTER: integer range 0 to END_COUNT;
begin
    
    process(CLK_i, RST_i)
    begin
        if RST_i ='1' then
            CLK_N_Hz_o<='0';
            COUNTER<=0;
        elsif rising_edge(CLK_i) then
            if (COUNTER=END_COUNT-1) then
                CLK_N_Hz_o <='1';
                COUNTER <=0;
            else
                CLK_N_Hz_o<='0';
                COUNTER<=COUNTER+1;
            end if;
        end if;

    end process;
end Behavioral;
