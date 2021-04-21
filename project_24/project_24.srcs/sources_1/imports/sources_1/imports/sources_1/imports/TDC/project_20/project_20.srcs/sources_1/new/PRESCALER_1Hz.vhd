----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.03.2021 11:21:08
-- Design Name: 
-- Module Name: PRESCALER_1Hz - Behavioral
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

entity PRESCALER_1Hz is
    Generic(FREQ: integer:=100000);
    Port ( CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           CLK_1kHz_o : out STD_LOGIC);
end PRESCALER_1Hz;

architecture Behavioral of PRESCALER_1Hz is
    constant END_COUNT:integer:=FREQ;
    signal COUNTER:integer range 0 to END_COUNT-1;
    signal clk_o: std_logic; --dummy;
begin
    process(CLK_i, RST_i)
    begin
    if RST_i ='1' then
        clk_o<='0';
        COUNTER<=0;
    elsif rising_edge(CLK_i) then
        if(COUNTER = END_COUNT / 2) then
            clk_o<=not clk_o;
            COUNTER<=0;
        else
            COUNTER<=COUNTER+1;
        end if;
    end if;
    end process;
    
    CLK_1kHz_o<=clk_o;

end Behavioral;
