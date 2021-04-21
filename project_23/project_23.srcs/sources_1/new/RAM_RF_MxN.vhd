----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.04.2021 10:42:34
-- Design Name: 
-- Module Name: RAM_RF_MxN - Behavioral
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

entity RAM_RF_MxN is
    Generic ( DATA_WIDTH:positive:=4;
              ADDR_WIDTH:positive:=10);
    Port ( DATA_RAM_i : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           ADDR_RAM_i : in STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
           WE_i : in STD_LOGIC;
           CLK_i: in STD_LOGIC;
           DATA_RAM_o : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0));
end RAM_RF_MxN;

architecture Behavioral of RAM_RF_MxN is
    type RAM_TYPE is array (2**ADDR_WIDTH-1 downto 0) of
                           STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
   signal RAM: RAM_TYPE;
begin
    process(CLK_i)
        begin
            if rising_edge(CLK_i) then
                if WE_i ='1' then --W/R
                    RAM(to_integer(unsigned(ADDR_RAM_i)))<=DATA_RAM_i;
                end if;
                --SYNC READ
                DATA_RAM_o <=RAM(to_integer(unsigned(ADDR_RAM_i)));
           end if;
       end process;

end Behavioral;
