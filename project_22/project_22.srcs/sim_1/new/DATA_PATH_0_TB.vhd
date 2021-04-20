----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.03.2021 13:27:14
-- Design Name: 
-- Module Name: DATA_PATH_0 - Behavioral
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

entity DATA_PATH_0_tb is
end;

architecture bench of DATA_PATH_0_tb is

  component DATA_PATH_0
      Generic (DATA_WIDTH : integer:=4;
              CW_WIDTH : integer:=5);
      Port ( DATA_BUS_i : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
             RST_i : in STD_LOGIC;
             CLK_i : in STD_LOGIC;
             CW_i : in STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0);
             ALU_RESULT_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
             REG_A_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
             REG_B_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
             FZ_o : out STD_LOGIC;
             DATA_BUS_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0));
  end component;
  constant DATA_WIDTH:integer:=4;
  constant CW_WIDTH: integer:=5;
  signal DATA_BUS_i: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
  signal RST_i: STD_LOGIC;
  signal CLK_i: STD_LOGIC;
  signal CW_i: STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0);
  signal ALU_RESULT_o: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
  signal REG_A_o: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
  signal REG_B_o: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
  signal FZ_o: STD_LOGIC;
  signal DATA_BUS_o: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  -- Insert values for generic parameters !!
  uut: DATA_PATH_0 generic map ( DATA_WIDTH   => DATA_WIDTH,
                                 CW_WIDTH     => CW_WIDTH )
                      port map ( DATA_BUS_i   => DATA_BUS_i,
                                 RST_i        => RST_i,
                                 CLK_i        => CLK_i,
                                 CW_i         => CW_i,
                                 ALU_RESULT_o => ALU_RESULT_o,
                                 REG_A_o      => REG_A_o,
                                 REG_B_o      => REG_B_o,
                                 FZ_o         => FZ_o,
                                 DATA_BUS_o   => DATA_BUS_o );

  stimulus: process
  begin
  
    -- Put initialisation code here

    RST_i <= '1';
    wait for 10 ns;
    RST_i <= '0';
    wait for 10 ns;

    -- Put test bench stimulus code here

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
