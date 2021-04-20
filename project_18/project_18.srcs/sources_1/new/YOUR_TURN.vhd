----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.03.2021 13:51:34
-- Design Name: 
-- Module Name: YOUR_TURN - Behavioral
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

entity YOUR_TURN is 
    Port ( CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           INC_i : in STD_LOGIC;
           NUMBER_o : out STD_LOGIC_VECTOR (3 downto 0));
end YOUR_TURN;

architecture Behavioral of YOUR_TURN is
    signal counter:unsigned(3 downto 0);
    signal REG_PUSH, PREV_PUSH:std_logic;
begin
    process(CLK_i, RST_i)
    Begin
        if RST_i ='1' then
            counter<=(others=>'0');
        elsif rising_edge(CLK_i) then
            REG_PUSH<=INC_i;
            PREV_PUSH<=REG_PUSH;
            if PREV_PUSH ='0' and REG_PUSH='1' then
                counter<=counter+1;
                if counter>=9 then
                    counter<=(others=>'0');
                end if;
            end if;
        end if;
    end process;
    
    NUMBER_o<=std_logic_vector(counter);
            
end Behavioral;
