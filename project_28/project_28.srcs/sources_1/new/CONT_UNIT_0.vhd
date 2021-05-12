----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.05.2021 12:35:08
-- Design Name: 
-- Module Name: CONT_UNIT_0 - Behavioral
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

entity CONT_UNIT_0 is
    Generic(CW_WIDTH:integer:=10;
            COP_WIDTH:integer:=3);
    Port ( COP_i : in STD_LOGIC_VECTOR (COP_WIDTH-1 downto 0);
           CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           FZ_i : in STD_LOGIC;
           CW_o : out STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0));
end CONT_UNIT_0;

architecture Behavioral of CONT_UNIT_0 is
-----------------------------------------------------------------
--                    STATES DEFINITION                        --
-----------------------------------------------------------------
type STATES_FSM is (IDLE, FETCH, DECODE, BRANCH, OPE_A, ADDR_B, OPE_B, MOV_A, INC_A, A_SUB_B, A_ADD_B);
signal CURRENT_STATE: STATES_FSM; 
--                                                                    AAA W     
-----------------------------------------------------------------   AARCRLRLLL
--                      OUTPUT MATRIX                          --   LLOPARARRF 
-----------------------------------------------------------------   UUMCMIMABZ
constant OUTPUT_IDLE:       STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="0000000000";
constant OUTPUT_FETCH:      STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="0001010000";
constant OUTPUT_DECODE:     STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="0000000000";
constant OUTPUT_BRANCH:     STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="0010100000"; 
constant OUTPUT_OPE_A:      STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="0000000100";
constant OUTPUT_ADDR_B:     STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="0000010000";
constant OUTPUT_OPE_B:      STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="0000010010";
constant OUTPUT_MOV_A:      STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="0000011001";
constant OUTPUT_INC_A:      STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="0100011001";
constant OUTPUT_A_SUB_B:    STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="1100011001";
constant OUTPUT_A_ADD_B:    STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="1000011001";


begin

    FSM:Process(RST_i, CLK_i)
    Begin
        if(RST_i = '1') then 
            CW_o <= (others=>'0');
        elsif rising_edge(CLK_i) then
            
        end if;
    end process;

end Behavioral;
