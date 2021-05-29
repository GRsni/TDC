----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.05.2021 11:00:36
-- Design Name: 
-- Module Name: EdgeDetector_FSM - Behavioral
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

entity EdgeDetector_Debounce is
    Generic( TIMER: integer:=30000000);
    Port ( CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           PUSH_i : in STD_LOGIC;
           PULSE_o : out STD_LOGIC);
end EdgeDetector_Debounce;

architecture Behavioral of EdgeDetector_Debounce is

Type EdgeDetector_States is (inic, s0, s01, s_wait);
signal State:EdgeDetector_States;
signal Push: std_logic; --dummy
signal Timer_count: integer range 0 to TIMER;

begin

    Register_push: Process(CLK_i, RST_i)
    Begin
        if(RST_i = '1') then
            Push <= '0';
        elsif rising_edge(CLK_i) then
            Push <= PUSH_i;
        end if;
    end process;

    ChangeState: Process(CLK_i, RST_i)
    Begin
        if(RST_i = '1') then
            State <= inic;
        elsif rising_edge(CLK_i) then
                case State is
                    when inic => if Push = '0' then
                                    State <= s0;
                                end if;
                    when s0 => if Push = '1' then
                                    State <= s01;
                                end if;
                    when s01 => State <= s_wait;
                    when s_wait => if Timer_count<TIMER then
                                        Timer_count<=Timer_count+1;
                                   else 
                                       Timer_count<=0;
                                       State<=inic;
                                   end if;
                   when others => State <=inic;
                end case;
           end if;
    end process;

    with State select
        PULSE_o <= '0' when inic,
                   '0' when s0,
                   '1' when s01,
                   '0' when s_wait,
                   '0' when others;

end Behavioral;
