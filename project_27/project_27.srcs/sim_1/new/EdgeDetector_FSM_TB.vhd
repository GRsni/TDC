----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.05.2021 11:23:09
-- Design Name: 
-- Module Name: EdgeDetector_FSM_TB - Behavioral
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
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity EdgeDetector_FSM_tb is
end;

architecture bench of EdgeDetector_FSM_tb is

  component EdgeDetector_FSM
      Port ( CLK_i : in STD_LOGIC;
             RST_i : in STD_LOGIC;
             PUSH_i : in STD_LOGIC;
             PULSE_o : out STD_LOGIC);
  end component;

  signal CLK_i: STD_LOGIC;
  signal RST_i: STD_LOGIC;
  signal PUSH_i: STD_LOGIC;
  signal PULSE_o: STD_LOGIC;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: EdgeDetector_FSM port map ( CLK_i   => CLK_i,
                                   RST_i   => RST_i,
                                   PUSH_i  => PUSH_i,
                                   PULSE_o => PULSE_o );

  stimulus: process
  begin
  
    -- Put initialisation code here
    RST_i<='1';
    wait for 5 ns;
    RST_i <='0';
    wait for 5 ns;

    -- Put test bench stimulus code here

 
    PUSH_i <= '1';
    wait for 10 ns;
    
    PUSH_i <= '0';
    wait for 20 ns;
    
    PUSH_i <='1';
    wait for 20 ns;
    
    PUSH_i <= '0';
    wait for 20 ns;
    
    PUSH_i<= '1';
    wait for 40 ns;
    
    PUSH_i<='0';
    wait for 5 ns;
    
    PUSH_i<='1';
    wait for 15 ns;
    
    PUSH_i<='0';

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      CLK_i <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;
