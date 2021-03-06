----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.03.2021 13:52:43
-- Design Name: 
-- Module Name: TOGGLE_00 - Behavioral
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

entity TOGGLE_00 is
    Port ( CLK_i : in STD_LOGIC;
           ENA_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           Q_o : out STD_LOGIC);
end TOGGLE_00;

architecture Behavioral of TOGGLE_00 is
    signal Q: STD_LOGIC; --dummy
    signal ENA: STD_LOGIC; --dummy
    
begin
    process(CLK_i, RST_i)
    Begin
        if RST_i = '1' then
            Q<='0';
        elsif rising_edge(CLK_i) then
            if ENA_i = '1' then
                Q<=not Q;
            end if;
       end if;
   end process;
   
   Q_o<=Q; 
   
end Behavioral;
