----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.03.2021 14:16:50
-- Design Name: 
-- Module Name: DECO_N_BITS - Behavioral
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

entity DECO_N_BITS is
    Generic(N: integer:=4);
    Port ( A_i : in STD_LOGIC_VECTOR(N-1 downto 0);
           Z_o : out STD_LOGIC_VECTOR(2**N-1 downto 0));
end DECO_N_BITS;

architecture Behavioral of DECO_N_BITS is

    signal A: unsigned(N-1 downto 0);
    signal Z:unsigned(2**N-1 downto 0):=(0=>'1', others=>'0');

begin

    P1: process(A_i)
    Begin
        A<=(unsigned(A_i));
        Z<=shift_left(Z, to_integer(A));
        Z_o<=std_logic_vector(Z);
    End process;
   

end Behavioral;
