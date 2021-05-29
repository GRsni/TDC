----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.05.2021 14:40:41
-- Design Name: 
-- Module Name: DIDACOMP_TB - Behavioral
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

entity DIDACOMP_Nexys4_tb is
end;

architecture bench of DIDACOMP_Nexys4_tb is

  component DIDACOMP_Nexys4
      Generic (DATA_RAM_WIDTH : integer:=4;
              CW_WIDTH : integer:=10;
              N_ALU:integer:=2;
              ADDR_RAM_WIDTH: positive:=4;
              DATA_ROM_WIDTH:positive:=11;
              ADDR_ROM_WIDTH:positive:=4;
              COP_WIDTH:integer:=3;
              DEBOUNCE_TIMER:integer:=30000000);
      Port ( CLK_i : in STD_LOGIC;
              RST_i : in STD_LOGIC;
              PUSH_i : in STD_LOGIC;
              FZ_o : out STD_LOGIC;
              INST_o: out STD_LOGIC_VECTOR (DATA_ROM_WIDTH-1 downto 0);
              CATHODE_o : out STD_LOGIC_VECTOR (6 downto 0);
              ANODE_o : out STD_LOGIC_VECTOR (7 downto 0));
  end component;
  
constant DATA_RAM_WIDTH : integer:=4;
constant CW_WIDTH : integer:=10;
constant N_ALU:integer:=2;
constant ADDR_RAM_WIDTH: positive:=4;
constant DATA_ROM_WIDTH:positive:=11;
constant ADDR_ROM_WIDTH:positive:=4;
constant COP_WIDTH:integer:=3;
constant DEBOUNCE_TIMER:integer:=30000000;

  signal CLK_i: STD_LOGIC;
  signal RST_i: STD_LOGIC;
  signal PUSH_i: STD_LOGIC;
  signal FZ_o: STD_LOGIC;
  signal INST_o: STD_LOGIC_VECTOR (DATA_ROM_WIDTH-1 downto 0);
  signal CATHODE_o: STD_LOGIC_VECTOR (6 downto 0);
  signal ANODE_o: STD_LOGIC_VECTOR (7 downto 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;
begin

  -- Insert values for generic parameters !!
  uut: DIDACOMP_Nexys4 generic map ( DATA_RAM_WIDTH => DATA_RAM_WIDTH,
                                     CW_WIDTH       => CW_WIDTH      ,
                                     N_ALU          => N_ALU         ,
                                     ADDR_RAM_WIDTH => ADDR_RAM_WIDTH,
                                     DATA_ROM_WIDTH => DATA_ROM_WIDTH,
                                     ADDR_ROM_WIDTH => ADDR_ROM_WIDTH,
                                     COP_WIDTH      => COP_WIDTH     ,
                                     DEBOUNCE_TIMER => DEBOUNCE_TIMER )
                          port map ( CLK_i          => CLK_i,
                                     RST_i          => RST_i,
                                     PUSH_i         => PUSH_i,
                                     FZ_o           => FZ_o,
                                     INST_o         => INST_o,
                                     CATHODE_o      => CATHODE_o,
                                     ANODE_o        => ANODE_o );

  stimulus: process
  begin
  
   -- Put initialisation code here
    RST_i <= '1';
    wait for 10 ns;
    RST_i <= '0';
    PUSH_i <= '0';
    wait for 10 ns;
    -- Put test bench stimulus code here
    
    PUSH_i <= '1';
    wait for 100 ms;
    PUSH_i <= '0';
    wait for 250 ms;
    PUSH_i <= '1';
    wait for 100 ms;
    PUSH_i <= '0';
    wait for 250 ms;
    PUSH_i <= '1';
    wait for 100 ms;
    PUSH_i <= '0';
    wait for 250 ms;
    PUSH_i <= '1';
    wait for 100 ms;
    PUSH_i <= '0';
    wait for 250 ms;
    PUSH_i <= '1';
    wait for 100 ms;
    PUSH_i <= '0';
    wait for 250 ms;
    PUSH_i <= '1';
    wait for 100 ms;
    PUSH_i <= '0';
    wait for 250 ms;

    PUSH_i <= '1';
    wait for 100 ms;
    PUSH_i <= '0';
    wait for 250 ms;
    PUSH_i <= '1';
    wait for 100 ms;
    PUSH_i <= '0';
    wait for 250 ms;
    PUSH_i <= '1';
    wait for 100 ms;
    PUSH_i <= '0';
    wait for 250 ms;
    PUSH_i <= '1';
    wait for 100 ms;
    PUSH_i <= '0';
    wait for 250 ms;

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