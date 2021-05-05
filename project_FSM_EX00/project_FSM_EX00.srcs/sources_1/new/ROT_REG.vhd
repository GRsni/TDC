----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.05.2021 13:32:11
-- Design Name: 
-- Module Name: ROT_REG - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ROT_REG is
    Generic(LED_COUNT: integer:=16);
    Port ( RST_i : in STD_LOGIC;
           CLK_i : in STD_LOGIC;
           ENA_i : in STD_LOGIC;
           L_R_i : in STD_LOGIC;
           LED_o : out STD_LOGIC_VECTOR (LED_COUNT-1 downto 0));
end ROT_REG;

architecture Behavioral of ROT_REG is
signal counter :unsigned(LED_COUNT-1 downto 0);
begin

    Process(RST_i, CLK_i)
    Begin 
        if RST_i = '1' then
           counter<="0000000000000001";
        elsif rising_edge(CLK_i) then
            if ENA_i = '1' then
                if L_R_i = '0' then
                    counter <= shift_left(counter, 1);
                else 
                    counter <=shift_right(counter, 1);
                end if;
           end if;
       end if;
    end process;
    
    LED_o<=std_logic_vector(counter);

end Behavioral;
