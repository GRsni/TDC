----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.05.2021 22:30:47
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

entity DIDACOMP_tb is
end;

architecture bench of DIDACOMP_tb is

  component DIDACOMP
      Generic (DATA_RAM_WIDTH : integer:=4;
              CW_WIDTH : integer:=10;
              N_ALU:integer:=2;
              ADDR_RAM_WIDTH: positive:=4;
              DATA_ROM_WIDTH:positive:=11;
              ADDR_ROM_WIDTH:positive:=4;
              COP_WIDTH:integer:=3);
      Port ( CLK_i : in STD_LOGIC;
             RST_i : in STD_LOGIC;
             ALU_RESULT_o : out STD_LOGIC_VECTOR (DATA_RAM_WIDTH-1 downto 0);
            REG_A_o : out STD_LOGIC_VECTOR (DATA_RAM_WIDTH-1 downto 0);
            REG_B_o : out STD_LOGIC_VECTOR (DATA_RAM_WIDTH-1 downto 0);
            FZ_o : out STD_LOGIC;
            DATA_BUS_o : out STD_LOGIC_VECTOR (DATA_RAM_WIDTH-1 downto 0);
            INST_o: out STD_LOGIC_VECTOR (DATA_ROM_WIDTH-1 downto 0);
            ADDR_RAM_o: out STD_LOGIC_VECTOR(ADDR_RAM_WIDTH-1 downto 0);
            ADDR1_o: out STD_LOGIC_VECTOR(ADDR_RAM_WIDTH-1 downto 0);
            ADDR2_o: out STD_LOGIC_VECTOR(ADDR_RAM_WIDTH-1 downto 0);
            PC_o: out STD_LOGIC_VECTOR(ADDR_ROM_WIDTH-1 downto 0));
  end component;

  constant DATA_RAM_WIDTH: integer:=4;
  constant CW_WIDTH: integer:=10;
  constant N_ALU: integer:=2;
  constant ADDR_RAM_WIDTH: integer:=4;
  constant DATA_ROM_WIDTH: integer:=11;
  constant ADDR_ROM_WIDTH: integer:=4;
  constant COP_WIDTH: integer:=3;

  signal CLK_i: STD_LOGIC;
  signal RST_i: STD_LOGIC;
  signal ALU_RESULT_o: STD_LOGIC_VECTOR (DATA_RAM_WIDTH-1 downto 0);
  signal REG_A_o: STD_LOGIC_VECTOR (DATA_RAM_WIDTH-1 downto 0);
  signal REG_B_o: STD_LOGIC_VECTOR (DATA_RAM_WIDTH-1 downto 0);
  signal FZ_o: STD_LOGIC;
  signal DATA_BUS_o: STD_LOGIC_VECTOR (DATA_RAM_WIDTH-1 downto 0);
  signal INST_o: STD_LOGIC_VECTOR (DATA_ROM_WIDTH-1 downto 0);
  signal ADDR_RAM_o: STD_LOGIC_VECTOR(ADDR_RAM_WIDTH-1 downto 0);
  signal ADDR1_o: STD_LOGIC_VECTOR(ADDR_RAM_WIDTH-1 downto 0);
  signal ADDR2_o: STD_LOGIC_VECTOR(ADDR_RAM_WIDTH-1 downto 0);
  signal PC_o: STD_LOGIC_VECTOR(ADDR_ROM_WIDTH-1 downto 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;
begin

  -- Insert values for generic parameters !!
  uut: DIDACOMP generic map ( DATA_RAM_WIDTH => DATA_RAM_WIDTH,
                              CW_WIDTH       =>CW_WIDTH ,
                              N_ALU          => N_ALU,
                              ADDR_RAM_WIDTH => ADDR_RAM_WIDTH,
                              DATA_ROM_WIDTH => DATA_ROM_WIDTH,
                              ADDR_ROM_WIDTH => ADDR_ROM_WIDTH,
                              COP_WIDTH      => COP_WIDTH )
                   port map ( CLK_i          => CLK_i,
                              RST_i          => RST_i,
                              ALU_RESULT_o   => ALU_RESULT_o,
                              REG_A_o        => REG_A_o,
                              REG_B_o        => REG_B_o,
                              FZ_o           => FZ_o,
                              DATA_BUS_o     => DATA_BUS_o,
                              INST_o         => INST_o,
                              ADDR_RAM_o     => ADDR_RAM_o,
                              ADDR1_o        => ADDR1_o,
                              ADDR2_o        => ADDR2_o,
                              PC_o           => PC_o );

  stimulus: process
  begin
  
    -- Put initialisation code here
    RST_i <= '1';
    wait for 5 ns;
    RST_i <= '0';
    wait for 5 ns;

    -- Put test bench stimulus code here

    wait for 300 ns;

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
