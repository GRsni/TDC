----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.04.2021 20:50:39
-- Design Name: 
-- Module Name: TOP_01_TB - Behavioral
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

entity TOP_01_tb is
end;

architecture bench of TOP_01_tb is

  component TOP_01
      Generic (DATA_WIDTH : integer:=4;
              ADDR_WIDTH: positive:=4;
              CW_WIDTH : integer:=6;
              N_ALU: integer:=2);
      Port (  ADDR_BUS_i: in STD_LOGIC_VECTOR(ADDR_WIDTH-1 downto 0);
              RST_i : in STD_LOGIC;
              CLK_i : in STD_LOGIC;
              CW_i : in STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0);
              FZ_o: out STD_LOGIC;
              CATHODE_o : out STD_LOGIC_VECTOR (6 downto 0);
              ANODE_o : out STD_LOGIC_VECTOR (7 downto 0));
  end component;

  constant DATA_WIDTH:positive:=4;
  constant ADDR_WIDTH:integer:=4;
  constant CW_WIDTH: integer:=5;
  constant N_ALU:integer:=2;
  signal ADDR_BUS_i: STD_LOGIC_VECTOR(ADDR_WIDTH-1 downto 0);
  signal RST_i: STD_LOGIC;
  signal CLK_i: STD_LOGIC;
  signal CW_i: STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0);
  signal FZ_o: STD_LOGIC;
  signal CATHODE_o: STD_LOGIC_VECTOR (6 downto 0);
  signal ANODE_o: STD_LOGIC_VECTOR (7 downto 0);

begin

  -- Insert values for generic parameters !!
  uut: TOP_01 generic map ( DATA_WIDTH => DATA_WIDTH,
                            ADDR_WIDTH => ADDR_WIDTH,
                            CW_WIDTH   => CW_WIDTH,
                            N_ALU      =>  N_ALU)
                 port map ( ADDR_BUS_i => ADDR_BUS_i,
                            RST_i      => RST_i,
                            CLK_i      => CLK_i,
                            CW_i       => CW_i,
                            FZ_o       => FZ_o,
                            CATHODE_o  => CATHODE_o,
                            ANODE_o    => ANODE_o );

  stimulus: process
  begin
  
   RST_i<='1';
   wait for 10 ns;
   RST_i<='0';
   wait for 10 ns;
   
   ADDR_BUS_i<="0000";
   wait for 10 ns;
   CW_i<="00100";
   wait for 10 ns;

    wait;
  end process;


end;