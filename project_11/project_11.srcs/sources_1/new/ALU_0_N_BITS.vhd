----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.03.2021 11:30:24
-- Design Name: 
-- Module Name: ALU_0_N_BITS - Behavioral
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

entity ALU_0_N_BITS is
    Generic(WIDTH: integer:=4);
    Port ( A_i : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           B_i : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           OP_i : in STD_LOGIC_VECTOR (1 downto 0);
           RESULT_o : out STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           ZERO_F_o : out STD_LOGIC);
end ALU_0_N_BITS;

architecture Behavioral of ALU_0_N_BITS is
    signal A, B: unsigned (WIDTH-1 downto 0);
    signal result: unsigned (WIDTH-1 downto 0);
    constant ZERO: unsigned (WIDTH-1 downto 0):=(others=>'0');
begin
    
    A<=unsigned(A_i);
    B<=unsigned(B_i);
    
    with OP_i select
        result <=   A when "00",
                    A + 1 when "01",
                    A + B when "10", 
                    A - B when "11", 
                    ZERO when others;
                    
 ZERO_F_o <= '1' when result=ZERO else '0';
    RESULT_o <= std_logic_vector(result);
        
    
             
end Behavioral;
