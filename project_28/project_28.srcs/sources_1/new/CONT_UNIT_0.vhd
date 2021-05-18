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
type STATES_FSM is (IDLE, FETCH, DECODE, BRANCH, BR_INST, OPE_A, ADDR_B, OPE_B, MOV_A, INC_A, A_ADD_B, A_SUB_B);
signal CURRENT_STATE: STATES_FSM; 
--                                                                    AAA W     
-----------------------------------------------------------------   AARCRLRLLL
--                      OUTPUT MATRIX                          --   LLOPARARRF 
-----------------------------------------------------------------   UUMCMIMABZ
constant OUTPUT_IDLE:       STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="0000000000";
constant OUTPUT_FETCH:      STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="0001010000";
constant OUTPUT_DECODE:     STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="0000000000";
constant OUTPUT_BRANCH:     STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="0010000000";
constant OUTPUT_BR_INST:    STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="0011010000";
constant OUTPUT_OPE_A:      STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="0000000100";
constant OUTPUT_ADDR_B:     STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="0000100000";
constant OUTPUT_OPE_B:      STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="0000100010";
constant OUTPUT_MOV_A:      STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="0000101001";
constant OUTPUT_INC_A:      STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="0100101001";
constant OUTPUT_A_ADD_B:    STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="1000101001";
constant OUTPUT_A_SUB_B:    STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="1100101001";


begin

    FSM:Process(RST_i, CLK_i)
    Begin
        if(RST_i = '1') then 
            CURRENT_STATE <= IDLE;
        elsif rising_edge(CLK_i) then
            case CURRENT_STATE is
                when IDLE =>
                    CURRENT_STATE <=FETCH;
                when FETCH =>
                    CURRENT_STATE <=DECODE;
                when DECODE =>
                    case COP_i is
                       when "000" | "001" | "010" | "011" =>  --MOV/INC/ADD/SUB
                            CURRENT_STATE <= OPE_A; 
                       when "100" =>
                            case FZ_i is
                                when '0' =>
                                    CURRENT_STATE <= FETCH;
                                when others =>
                                    CURRENT_STATE <=BRANCH;
                            end case;
                       when others =>
                            CURRENT_STATE <= IDLE;
                   end case;
                when BRANCH =>
                    CURRENT_STATE <= BR_INST;
                when BR_INST =>
                    CURRENT_STATE <= FETCH;
                when OPE_A =>
                    case COP_i is
                        when "000" =>
                            CURRENT_STATE <= MOV_A;
                        when "001" =>
                            CURRENT_STATE <= INC_A;
                        when "010" | "011" =>
                            CURRENT_STATE <= ADDR_B;
                        when others =>
                            CURRENT_STATE <= IDLE;
                    end case;
                when ADDR_B => 
                    CURRENT_STATE <= OPE_B;
                when OPE_B =>
                    case COP_i is
                        when "010" =>
                            CURRENT_STATE <= A_ADD_B;
                        when "011" =>
                            CURRENT_STATE <= A_SUB_B;
                        when others =>
                            CURRENT_STATE <= IDLE;
                    end case;
                when MOV_A | INC_A | A_ADD_B | A_SUB_B =>
                    CURRENT_STATE <= FETCH;
                when others =>
                    CURRENT_STATE <= IDLE;
            end case;
        end if;
    end process;
    
    with CURRENT_STATE select
        CW_o <= OUTPUT_IDLE     when IDLE,
                OUTPUT_FETCH    when FETCH,
                OUTPUT_DECODE   when DECODE,
                OUTPUT_BRANCH   when BRANCH,
                OUTPUT_BR_INST  when BR_INST,
                OUTPUT_OPE_A    when OPE_A,
                OUTPUT_ADDR_B   when ADDR_B,
                OUTPUT_OPE_B    when OPE_B,
                OUTPUT_MOV_A    when MOV_A,
                OUTPUT_INC_A    when INC_A,
                OUTPUT_A_ADD_B  when A_ADD_B,
                OUTPUT_A_SUB_B  when A_SUB_B,
                OUTPUT_IDLE     when others;
end Behavioral;
