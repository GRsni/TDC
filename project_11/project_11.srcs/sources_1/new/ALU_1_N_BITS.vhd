----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.03.2021 13:01:29
-- Design Name: 
-- Module Name: ALU_1_N_BITS - Behavioral
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

entity ALU_1_N_BITS is
    Generic(WIDTH:integer:=4);
    Port ( A_i : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           B_i : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           OP_i: in STD_LOGIC_VECTOR (2 downto 0);
           RESULT_o : out STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           ZERO_F_o : out STD_LOGIC;
           CARRY_F_o: out STD_LOGIC);
       
end ALU_1_N_BITS;

architecture Behavioral of ALU_1_N_BITS is
     signal A, B: unsigned (WIDTH downto 0);
     signal result: unsigned (WIDTH downto 0);
     constant ZERO: unsigned (WIDTH downto 0):=(others=>'0');
begin

    A <='0' & unsigned(A_i) ;
    B <='0' & unsigned(B_i);
P1: process(A_i, B_i, OP_i)
    Begin
        
        case OP_i is
            when "000" =>
                result <= A+1;
            when "001" =>
                result <= B+1;
            when "010" =>
                result <= shift_right(A, 1);
            when "011" =>
                result <= shift_left(A, 1);    
            when "100" =>
                result <= A+B;
            when "101" =>
                result <= A-B;
            when "110" =>
                result <= A;
            when "111" =>
                result <= B;
            when others =>
                result <=(others => '0');
            end case;   
    end process;

    RESULT_o <=std_logic_vector(result(WIDTH-1 downto 0));
    ZERO_F_o <= '1' when result = ZERO else '0';
    CARRY_F_o <= RESULT(WIDTH);
    

end Behavioral;
