----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.03.2021 10:25:59
-- Design Name: 
-- Module Name: CE_1KHz - Behavioral
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

entity CE_1KHz is
    Port ( CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           CLK_1KHz_o : out STD_LOGIC);
end CE_1KHz;

architecture Behavioral of CE_1KHz is
    constant END_COUNT: integer:=10000;
    signal COUNTER: integer range 0 to END_COUNT;
begin
    
    process(CLK_i, RST_i)
    begin
        if RST_i ='1' then
            CLK_1KHz_o<='0';
            COUNTER<=0;
        elsif rising_edge(CLK_i) then
            if (COUNTER=END_COUNT) then
                CLK_1KHz_o <='1';
                COUNTER <=0;
            else
                CLK_1KHz_o<='0';
                COUNTER<=COUNTER+1;
            end if;
        end if;

    end process;
end Behavioral;
