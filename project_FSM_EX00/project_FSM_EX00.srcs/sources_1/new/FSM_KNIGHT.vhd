----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.05.2021 13:11:06
-- Design Name: 
-- Module Name: FSM_KNIGHT - Behavioral
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

entity FSM_KNIGHT is
    Generic ( LED_COUNT: integer:=16);
    Port ( RST_i : in STD_LOGIC;
           CLK_i : in STD_LOGIC;
           LED_pos_i : in STD_LOGIC_VECTOR(LED_COUNT-1 downto 0);
           L_R_o : out STD_LOGIC);  --0 means MOVE_LEFT, 1 means MOVE_RIGHT
end FSM_KNIGHT;

architecture Behavioral of FSM_KNIGHT is
Type FSM_States is (inic, move_left, move_right);
signal State: FSM_States;

begin

    Process(RST_i, CLK_i)
    Begin
        if RST_i = '1' then
            State <= inic;
        elsif rising_edge(CLK_i) then
            case State is
                when inic => State<= move_left;
                when move_left =>  if (LED_pos_i="1000000000000000") then
                                        State<=move_right;
                                    end if;
                when move_right => if (LED_pos_i="0000000000000001") then
                                        State<=move_left;
                                  end if;
                when others => State <=inic;
            end case;
        end if;
    end process;
        
    with State select
        L_R_o <= '0' when inic,
                 '0' when move_left,
                 '1' when move_right,
                 '0' when others;                   

end Behavioral;
