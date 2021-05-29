----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.05.2021 21:40:05
-- Design Name: 
-- Module Name: DIDACOMP_2_TB - Behavioral
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

entity DIDACOMP_2_tb is
end;

architecture bench of DIDACOMP_2_tb is

  component DIDACOMP_2
      Generic (DATA_WIDTH: integer:=4;
              DATA_RAM_WIDTH: integer:=12;
              ADDR_RAM_WIDTH: integer:=4;
              CW_WIDTH: integer:=21;
              N_ALU: integer:=3;
              NREG_WIDTH: integer:=3;
              COP_WIDTH: integer:=4);
      Port ( CLK_i : in STD_LOGIC;
             RST_i : in STD_LOGIC;
             FZ_o : out STD_LOGIC;
             FC_o : out STD_LOGIC;
             INST_o: out STD_LOGIC_VECTOR (DATA_RAM_WIDTH-1 downto 0);
             CATHODE_o : out STD_LOGIC_VECTOR (6 downto 0);
             ANODE_o : out STD_LOGIC_VECTOR (7 downto 0));
  end component;

  constant DATA_WIDTH: integer:=4;
  constant DATA_RAM_WIDTH: integer:=12;
  constant ADDR_RAM_WIDTH: integer:=4;
  constant CW_WIDTH: integer:=21;
  constant N_ALU: integer:=3;
  constant NREG_WIDTH: integer:=3;
  constant COP_WIDTH: integer:=4;
  signal CLK_i: STD_LOGIC;
  signal RST_i: STD_LOGIC;
  signal FZ_o: STD_LOGIC;
  signal FC_o: STD_LOGIC;
  signal INST_o: STD_LOGIC_VECTOR (DATA_RAM_WIDTH-1 downto 0);
  signal CATHODE_o: STD_LOGIC_VECTOR (6 downto 0);
  signal ANODE_o: STD_LOGIC_VECTOR (7 downto 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;
begin

  -- Insert values for generic parameters !!
  uut: DIDACOMP_2 generic map ( DATA_WIDTH     => DATA_WIDTH     ,
                                DATA_RAM_WIDTH => DATA_RAM_WIDTH ,
                                ADDR_RAM_WIDTH => ADDR_RAM_WIDTH ,
                                CW_WIDTH       => CW_WIDTH       ,
                                N_ALU          => N_ALU          ,
                                NREG_WIDTH     => NREG_WIDTH     ,
                                COP_WIDTH      => COP_WIDTH       )
                     port map ( CLK_i          => CLK_i,
                                RST_i          => RST_i,
                                FZ_o           => FZ_o,
                                FC_o           => FC_o,
                                INST_o         => INST_o,
                                CATHODE_o      => CATHODE_o,
                                ANODE_o        => ANODE_o );

  stimulus: process
  begin
  
    -- Put initialisation code here
    RST_i <= '1';
    wait for 10 ns;
    RST_i <= '0';
    wait for 10 ns;

    -- Put test bench stimulus code here
    wait for 2000 ns;
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
