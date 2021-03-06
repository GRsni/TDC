----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.03.2021 13:24:36
-- Design Name: 
-- Module Name: COUNTER_N_bits - Behavioral
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

entity COUNTER_N_bits is
    Generic( N: integer:=4);
    Port ( CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           ENA_i : in STD_LOGIC;
           Q_o : out STD_LOGIC_VECTOR (N-1 downto 0));
end COUNTER_N_bits;

architecture Behavioral of COUNTER_N_bits is
    signal counter:unsigned(N-1 downto 0):=(others=>'0');
    constant ZERO:STD_LOGIC_VECTOR(N-1 downto 0):=(others=>'0');
begin

    process(RST_i, CLK_i)
    Begin
        if RST_i='1' then
            counter<=(others=>'0');
        elsif rising_edge(CLK_i) then
            if ENA_i ='1' then
                counter<=counter+1;
            end if;
        end if;
    end process;
    
    Q_o<=std_logic_vector(counter);

end Behavioral;
