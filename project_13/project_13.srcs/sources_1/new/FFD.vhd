----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.03.2021 13:33:48
-- Design Name: 
-- Module Name: FFD - Behavioral
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

entity FFD is
    Port ( D_i : in STD_LOGIC;
           RST_I : in STD_LOGIC;
           ENA_I : in STD_LOGIC;
           CLK_i : in STD_LOGIC;
           Q_o : out STD_LOGIC);
end FFD;

architecture Behavioral of FFD is

begin

    process(CLK_i, RST_I, ENA_I)
    Begin
        if RST_I = '1' then 
            Q_o<='0';
        elsif rising_edge(CLK_i) then
            if ENA_i = '1' then
                Q_o <= D_i;
            end if;
        end if;
   end process; 

end Behavioral;
