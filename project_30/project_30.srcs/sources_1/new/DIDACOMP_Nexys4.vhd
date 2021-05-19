----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.05.2021 10:27:12
-- Design Name: 
-- Module Name: DIDACOMP_Nexys4 - Behavioral
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

entity DIDACOMP_Nexys4 is
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
           
end DIDACOMP_Nexys4;

architecture Behavioral of DIDACOMP_Nexys4 is

component EdgeDetector_Debounce 
    Generic( TIMER: integer:=30000000);
    Port ( CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           PUSH_i : in STD_LOGIC;
           PULSE_o : out STD_LOGIC);
end component;

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
           PUSH_i : in STD_LOGIC;
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

component DISP8ON 
    Generic(DATA_WIDTH:integer:=4);
    Port ( DATA_0_i : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           DATA_1_i : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           DATA_2_i : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           DATA_3_i : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           DATA_4_i : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           DATA_5_i : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           DATA_6_i : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           DATA_7_i : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           CATHODE_o : out STD_LOGIC_VECTOR (6 downto 0);
           ANODE_o : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal PUSH_CU: STD_LOGIC; --dummy

signal DATA0: STD_LOGIC_VECTOR(DATA_RAM_WIDTH-1 downto 0);--ALU_OUT
signal DATA1: STD_LOGIC_VECTOR(DATA_RAM_WIDTH-1 downto 0);--REG_B
signal DATA2: STD_LOGIC_VECTOR(DATA_RAM_WIDTH-1 downto 0);--REG_A
signal DATA3: STD_LOGIC_VECTOR(ADDR_RAM_WIDTH-1 downto 0);--ADDR2_o
signal DATA4: STD_LOGIC_VECTOR(ADDR_RAM_WIDTH-1 downto 0);--ADDR1_o
signal DATA5: STD_LOGIC_VECTOR(DATA_RAM_WIDTH-1 downto 0);--PC_o
signal DATA6: STD_LOGIC_VECTOR(DATA_RAM_WIDTH-1 downto 0);--DATA_BUS
signal DATA7: STD_LOGIC_VECTOR(ADDR_RAM_WIDTH-1 downto 0);--ADDR_RAM

begin

DEBOUNCE: EdgeDetector_Debounce 
    Generic map( TIMER => DEBOUNCE_TIMER)
    Port map( CLK_i => CLK_i,
           RST_i => RST_i,
           PUSH_i => PUSH_i,
           PULSE_o => PUSH_CU);
           
DIDACOMP_DEBOUNCED: DIDACOMP 
   Generic map(DATA_RAM_WIDTH => DATA_RAM_WIDTH,
           CW_WIDTH => CW_WIDTH,
           N_ALU => N_ALU,
           ADDR_RAM_WIDTH => ADDR_RAM_WIDTH,
           DATA_ROM_WIDTH => DATA_ROM_WIDTH,
           ADDR_ROM_WIDTH => ADDR_ROM_WIDTH,
           COP_WIDTH => COP_WIDTH)
   Port map ( CLK_i => CLK_i,
          RST_i => RST_i,
          PUSH_i => PUSH_CU,
          ALU_RESULT_o => DATA0,
         REG_A_o => DATA2,
         REG_B_o => DATA1,
         FZ_o => FZ_o,
         DATA_BUS_o => DATA6,
         INST_o => INST_o,
         ADDR_RAM_o => DATA7,
         ADDR1_o => DATA4,
         ADDR2_o => DATA3,
         PC_o => DATA5);

 DISP: DISP8ON 
       Generic map(DATA_WIDTH => DATA_RAM_WIDTH)
       Port map( 
              DATA_0_i => DATA0,
              DATA_1_i => DATA1,
              DATA_2_i => DATA2,
              DATA_3_i => DATA3,
              DATA_4_i => DATA4,
              DATA_5_i => DATA5,
              DATA_6_i => DATA6,
              DATA_7_i => DATA7,
              CLK_i => CLK_i,
              RST_i => RST_i,
              CATHODE_o => CATHODE_o,
              ANODE_o => ANODE_o);            


-- Assign dummy signals to outputs

end Behavioral;
