----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.04.2021 14:03:23
-- Design Name: 
-- Module Name: DATA_PATH_0_TB - Behavioral
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
      Generic(DATA_RAM_WIDTH : integer:=4;
              CW_WIDTH : integer:=10;
              N_ALU:integer:=2;
              ADDR_RAM_WIDTH: positive:=4;
              DATA_ROM_WIDTH:positive:=11;
              ADDR_ROM_WIDTH:positive:=4;
              OP_CODE_WIDTH:integer:=3);
      Port ( RST_i: in STD_LOGIC;
             CLK_i : in STD_LOGIC;
             CW_i : in STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0);
             ALU_RESULT_o : out STD_LOGIC_VECTOR (DATA_RAM_WIDTH-1 downto 0);
             REG_A_o : out STD_LOGIC_VECTOR (DATA_RAM_WIDTH-1 downto 0);
             REG_B_o : out STD_LOGIC_VECTOR (DATA_RAM_WIDTH-1 downto 0);
             FZ_o : out STD_LOGIC;
             DATA_BUS_o : out STD_LOGIC_VECTOR (DATA_RAM_WIDTH-1 downto 0);
             INST_o: out STD_LOGIC_VECTOR (DATA_ROM_WIDTH-1 downto 0);
             ADDR_RAM_o: out STD_LOGIC_VECTOR(ADDR_RAM_WIDTH-1 downto 0);
             PC_o: out STD_LOGIC_VECTOR(ADDR_ROM_WIDTH-1 downto 0));
  end component;
  constant CW_WIDTH:integer:=10;
  constant DATA_RAM_WIDTH : integer:=4;
  constant N_ALU:integer:=2;           
  constant ADDR_RAM_WIDTH: positive:=4;
  constant DATA_ROM_WIDTH:positive:=11;
  constant ADDR_ROM_WIDTH:positive:=4; 
  constant OP_CODE_WIDTH:integer:=3;  
  
  signal RST_i: STD_LOGIC;
  signal CLK_i: STD_LOGIC;
  signal CW_i: STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0);
  signal ALU_RESULT_o: STD_LOGIC_VECTOR (DATA_RAM_WIDTH-1 downto 0);
  signal REG_A_o: STD_LOGIC_VECTOR (DATA_RAM_WIDTH-1 downto 0);
  signal REG_B_o: STD_LOGIC_VECTOR (DATA_RAM_WIDTH-1 downto 0);
  signal FZ_o: STD_LOGIC;
  signal DATA_BUS_o: STD_LOGIC_VECTOR (DATA_RAM_WIDTH-1 downto 0);
  signal INST_o: STD_LOGIC_VECTOR (DATA_ROM_WIDTH-1 downto 0);
  signal ADDR_RAM_o: STD_LOGIC_VECTOR(ADDR_RAM_WIDTH-1 downto 0);
  signal PC_o: STD_LOGIC_VECTOR(ADDR_ROM_WIDTH-1 downto 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  -- Insert values for generic parameters !!
  uut: DATA_PATH_0 generic map ( DATA_RAM_WIDTH => DATA_RAM_WIDTH,
                                 CW_WIDTH       => CW_WIDTH,
                                 N_ALU          => N_ALU,
                                 ADDR_RAM_WIDTH => ADDR_RAM_WIDTH,
                                 DATA_ROM_WIDTH => DATA_ROM_WIDTH,
                                 ADDR_ROM_WIDTH => ADDR_ROM_WIDTH,
                                 OP_CODE_WIDTH  =>  OP_CODE_WIDTH)
                      port map ( RST_i          => RST_i,
                                 CLK_i          => CLK_i,
                                 CW_i           => CW_i,
                                 ALU_RESULT_o   => ALU_RESULT_o,
                                 REG_A_o        => REG_A_o,
                                 REG_B_o        => REG_B_o,
                                 FZ_o           => FZ_o,
                                 DATA_BUS_o     => DATA_BUS_o,
                                 INST_o         => INST_o,
                                 ADDR_RAM_o     => ADDR_RAM_o,
                                 PC_o           => PC_o );

  stimulus: process
  begin
  
    -- Put initialisation code here
    RST_i<='1';
    wait for 10 ns;
    RST_i<='0';
    wait for 10 ns;

    -- Put test bench stimulus code here

    CW_i<="0011010000";
    wait for 10 ns;
    
    CW_i<="0000000100";
    wait for 10 ns;
    
    CW_i<="0000100010";
    wait for 10 ns;
    
    CW_i<="1000101001";
    wait for 10 ns;

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
