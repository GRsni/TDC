----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.02.2021 11:32:26
-- Design Name: 
-- Module Name: MUX4 - Behavioral
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

entity MUX4 is
    generic (WIDTH: integer:=8);
    Port ( A_i : in STD_LOGIC_VECTOR (WIDTH - 1 downto 0);
           B_i : in STD_LOGIC_VECTOR (WIDTH - 1 downto 0);
           C_i : in STD_LOGIC_VECTOR (WIDTH - 1 downto 0);
           D_i : in STD_LOGIC_VECTOR (WIDTH - 1 downto 0);
           E_i : in STD_LOGIC_VECTOR (WIDTH - 1 downto 0);
           F_i : in STD_LOGIC_VECTOR (WIDTH - 1 downto 0);
           G_i : in STD_LOGIC_VECTOR (WIDTH - 1 downto 0);
           H_i : in STD_LOGIC_VECTOR (WIDTH - 1 downto 0);
           SEL_i : in STD_LOGIC_VECTOR (2 downto 0);
           Z_o : out STD_LOGIC_VECTOR (WIDTH - 1 downto 0));
end MUX4;

architecture Behavioral of MUX4 is

begin

    with SEL_i select
        Z_o <= A_i when "000",
               B_i when "001",
               C_i when "010", 
               D_i when "011", 
               E_i when "100", 
               F_i when "101", 
               G_i when "110", 
               H_i when others; 

end Behavioral;
