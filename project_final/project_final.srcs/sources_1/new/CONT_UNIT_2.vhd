----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.05.2021 21:15:08
-- Design Name: 
-- Module Name: CONT_UNIT_2 - Behavioral
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

entity CONT_UNIT_2 is
    Generic (CW_WIDTH: integer:=21;
            COP_WIDTH: integer:=4);
    Port ( COP_i : in STD_LOGIC_VECTOR (COP_WIDTH-1 downto 0);
           CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           FZ_i : in STD_LOGIC;
           PUSH_i : in STD_LOGIC;
           CW_o : out STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0));
end CONT_UNIT_2;

architecture Behavioral of CONT_UNIT_2 is
---------------------------------------------------------------------
--                       CONTROL UNIT STATES                       --
---------------------------------------------------------------------
type FSM_STATES is (IDLE, LOAD_INST_ADDR, RAM_INST_ADDR_UPDATE, FETCH, DECODE, 
                    LOAD_RAM_ADDR, LOAD_RAM_DATA, LOAD_RA_ADDR, LOAD_RB_ADDR, 
                    LOAD_ALU_REG_A, LOAD_ALU_REG_B, LOAD_INM_REG_A,
                    LOAD_RB_INTO_RAM_DATA, LOAD_RAM_DATA_INTO_ALU_REG_B,
                    LD_OP, ST_OP, ADD_OP, SUB_OP, INC_OP, DEC_OP, BEZ_OP);
signal CURRENT_STATE: FSM_STATES;

----------------------------------------------------------------------
--                   CONTROL WORD OUTPUT MATRIX                     --
----------------------------------------------------------------------
constant OUTPUT_IDLE                            :STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="000000000000000000000";
constant OUTPUT_LOAD_INST_ADDR                  :STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="000100000110000000000"; 
constant OUTPUT_RAM_INST_ADDR_UPDATE            :STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="000000000000000000000";
constant OUTPUT_FETCH                           :STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="000000100000000000000";
constant OUTPUT_DECODE                          :STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="000000000000000000000";
constant OUTPUT_LOAD_RAM_ADDR                   :STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="000000000100000000000";
constant OUTPUT_LOAD_RAM_DATA                   :STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="000000011000000000000";
constant OUTPUT_LOAD_RA_ADDR                    :STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="000000000000100000000";
constant OUTPUT_LOAD_RB_ADDR                    :STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="000001000000010000000";
constant OUTPUT_LOAD_ALU_REG_A                  :STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="000000000000000001000";
constant OUTPUT_LOAD_ALU_REG_B                  :STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="000000000000000010100";
constant OUTPUT_LOAD_INM_REG_A                  :STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="000000000000000111000";
constant OUTPUT_LOAD_RB_INTO_RAM_DATA           :STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="001000010000000000000";
constant OUTPUT_LOAD_RAM_DATA_INTO_ALU_REG_B    :STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="000000000000000100100";
constant OUTPUT_LD_OP                           :STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="000000000000001000011";
constant OUTPUT_ST_OP                           :STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="001000000001000000011";
constant OUTPUT_ADD_OP                          :STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="010000000000001000011";
constant OUTPUT_SUB_OP                          :STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="011000000000001000011";
constant OUTPUT_INC_OP                          :STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="100000000000001000011";
constant OUTPUT_DEC_OP                          :STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="101000000000001000011";
constant OUTPUT_BEZ_OP                          :STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="000111000000000000000";
constant OUTPUT_BEZ_INST                        :STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0):="000111000110000000000";


begin

    FSM: process(CLK_i, RST_i)
    begin
        if(RST_i = '1') then
            CURRENT_STATE <= IDLE;
        elsif(rising_edge(CLK_i)) then    
            if(PUSH_i = '1') then
                case CURRENT_STATE is
                    when IDLE =>
                        CURRENT_STATE <= LOAD_INST_ADDR;
                    when LOAD_INST_ADDR =>
                        CURRENT_STATE <= RAM_INST_ADDR_UPDATE;
                    when RAM_INST_ADDR_UPDATE =>
                        CURRENT_STATE <= FETCH;
                    when FETCH =>
                        CURRENT_STATE <= DECODE;
                    when DECODE =>
                        case COP_i is
                            when "0000" | "0001" =>                     -- LD_OP or ST_OP
                                CURRENT_STATE <= LOAD_RAM_ADDR;
                            when "0010" | "0011" =>                     -- ADD_OP or SUB_OP
                                CURRENT_STATE <= LOAD_RA_ADDR;
                            when "0100" | "0101" =>                     -- INC_OP or DEC_OP
                                CURRENT_STATE <= LOAD_INM_REG_A;
                            when "0110" =>                              -- BEZ_OP
                                case FZ_i is
                                    when '1' =>
                                        CURRENT_STATE <= BEZ_OP;
                                    when others =>
                                        CURRENT_STATE <= LOAD_INST_ADDR;
                                    end case;
                            when others =>
                                CURRENT_STATE <= IDLE;
                        end case;
                    when BEZ_OP =>
                        CURRENT_STATE <= BEZ_INST;
                    when BEZ_INST =>
                        CURRENT_STATE <= RAM_INST_ADDR_UPDATE;
                    when LOAD_RA_ADDR =>
                        CURRENT_STATE <= LOAD_ALU_REG_A;
                    when LOAD_ALU_REG_A | LOAD_RAM_ADDR | LOAD_INM_REG_A =>
                        CURRENT_STATE <= LOAD_RB_ADDR;
                    when LOAD_RB_ADDR =>
                        case COP_i is
                            when "0000" =>                                          -- LD_OP
                                CURRENT_STATE <= LOAD_RAM_DATA;
                            when "0001" | "0010" | "0011" | "0100" | "0101" =>      -- ST_OP, ADD_OP, SUB_OP, INC_OP, DEC_OP 
                                CURRENT_STATE <= LOAD_ALU_REG_B;
                            when others => 
                                CURRENT_STATE <= IDLE;
                        end case;
                    when LOAD_RAM_DATA =>
                        CURRENT_STATE <= LOAD_RAM_DATA_INTO_ALU_REG_B;
                    when LOAD_RAM_DATA_INTO_ALU_REG_B =>
                        CURRENT_STATE <= LD_OP;
                    when LOAD_ALU_REG_B =>
                        case COP_i is
                            when "0001" =>                                  -- ST_OP
                                CURRENT_STATE <= LOAD_RB_INTO_RAM_DATA;
                            when "0010" =>                                  -- ADD_OP    
                                CURRENT_STATE <= ADD_OP;
                            when "0011" => 
                                CURRENT_STATE <= SUB_OP;                    -- SUB_OP
                            when "0100" => 
                                CURRENT_STATE <= INC_OP;                    -- INC_OP
                            when "0101" =>
                                CURRENT_STATE <= DEC_OP;                    -- DEC_OP
                            when others =>  
                                CURRENT_STATE <= IDLE;                      -- OTHERS
                        end case;
                    when LOAD_RB_INTO_RAM_DATA => 
                        CURRENT_STATE <= ST_OP;
                    when LD_OP | ST_OP | ADD_OP | SUB_OP | INC_OP | DEC_OP =>
                        CURRENT_STATE <= LOAD_INST_ADDR;
                    when others =>
                        CURRENT_STATE <= IDLE;
                end case;
            end if;
        end if;
    end process;    


    with CURRENT_STATE select
        CW_o <=  OUTPUT_IDLE                            when IDLE,
                 OUTPUT_LOAD_INST_ADDR                  when LOAD_INST_ADDR,
                 OUTPUT_RAM_INST_ADDR_UPDATE            when RAM_INST_ADDR_UPDATE,
                 OUTPUT_FETCH                           when FETCH,
                 OUTPUT_DECODE                          when DECODE,
                 OUTPUT_LOAD_RAM_ADDR                   when LOAD_RAM_ADDR,
                 OUTPUT_LOAD_RAM_DATA                   when LOAD_RAM_DATA,
                 OUTPUT_LOAD_RA_ADDR                    when LOAD_RA_ADDR,
                 OUTPUT_LOAD_RB_ADDR                    when LOAD_RB_ADDR,
                 OUTPUT_LOAD_ALU_REG_A                  when LOAD_ALU_REG_A,
                 OUTPUT_LOAD_ALU_REG_B                  when LOAD_ALU_REG_B,
                 OUTPUT_LOAD_INM_REG_A                  when LOAD_INM_REG_A,
                 OUTPUT_LOAD_RB_INTO_RAM_DATA           when LOAD_RB_INTO_RAM_DATA,
                 OUTPUT_LOAD_RAM_DATA_INTO_ALU_REG_B    when LOAD_RAM_DATA_INTO_ALU_REG_B,
                 OUTPUT_LD_OP                           when LD_OP,
                 OUTPUT_ST_OP                           when ST_OP,
                 OUTPUT_ADD_OP                          when ADD_OP,
                 OUTPUT_SUB_OP                          when SUB_OP,
                 OUTPUT_INC_OP                          when INC_OP,
                 OUTPUT_DEC_OP                          when DEC_OP,
                 OUTPUT_BEZ_OP                          when BEZ_OP,
                 OUTPUT_BEZ_INST                          when BEZ_INST,
                 OUTPUT_IDLE                            when others;

end Behavioral;
