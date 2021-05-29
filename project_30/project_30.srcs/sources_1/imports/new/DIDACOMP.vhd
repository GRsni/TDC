----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.05.2021 22:04:50
-- Design Name: 
-- Module Name: DIDACOMP - Behavioral
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

entity DIDACOMP is
    Generic (DATA_RAM_WIDTH : integer:=4;
            CW_WIDTH : integer:=10;
            N_ALU:integer:=2;
            ADDR_RAM_WIDTH: positive:=4;
            DATA_ROM_WIDTH:positive:=11;
            ADDR_ROM_WIDTH:positive:=4;
            COP_WIDTH:integer:=3);
    Port ( CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           PUSH_i: in STD_LOGIC;
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
end DIDACOMP;

architecture Behavioral of DIDACOMP is

component DATA_PATH_0 
    Generic (DATA_RAM_WIDTH : integer:=4;
            CW_WIDTH : integer:=10;
            N_ALU:integer:=2;
            ADDR_RAM_WIDTH: positive:=4;
            DATA_ROM_WIDTH:positive:=11;
            ADDR_ROM_WIDTH:positive:=4);
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
           ADDR1_o: out STD_LOGIC_VECTOR(ADDR_RAM_WIDTH-1 downto 0);
           ADDR2_o: out STD_LOGIC_VECTOR(ADDR_RAM_WIDTH-1 downto 0);
           PC_o: out STD_LOGIC_VECTOR(ADDR_ROM_WIDTH-1 downto 0));
           
end component;

component CONT_UNIT_0 
    Generic(CW_WIDTH:integer:=10;
            COP_WIDTH:integer:=3);
    Port ( COP_i : in STD_LOGIC_VECTOR (COP_WIDTH-1 downto 0);
           CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           FZ_i : in STD_LOGIC;
           PUSH_i: in STD_LOGIC;
           CW_o : out STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0));
end component;

component EDGE_DETECTOR_00 
    Port ( RST_i : in STD_LOGIC;
           PUSH_i : in STD_LOGIC;
           CLK_i : in STD_LOGIC;
           PULSE_o : out STD_LOGIC);
end component;

signal INST: STD_LOGIC_VECTOR(DATA_ROM_WIDTH-1 downto 0); --dummy
signal FZ: STD_LOGIC; --dummy
signal CW_CU: STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0); --dummy
signal CW_debounced: STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0);
signal CW_6: STD_LOGIC;
signal CW_4: STD_LOGIC;

begin

CONTROL_UNIT:CONT_UNIT_0
    Generic map(CW_WIDTH => CW_WIDTH,
                COP_WIDTH => COP_WIDTH)
    Port map(
            COP_i =>INST(DATA_ROM_WIDTH-1 downto DATA_ROM_WIDTH-COP_WIDTH),
            CLK_i =>CLK_i,
            RST_i =>RST_i,
            FZ_i => FZ,
            PUSH_i => PUSH_i,
            CW_o => CW_CU);
            
CW4: EDGE_DETECTOR_00 
    Port map( RST_i => RST_i,
           PUSH_i => CW_CU(4),
           CLK_i => CLK_i,
           PULSE_o => CW_4);
           
CW6: EDGE_DETECTOR_00 
    Port map( RST_i => RST_i,
          PUSH_i => CW_CU(6),
          CLK_i => CLK_i,
          PULSE_o => CW_6);
            
DATA_PATH: DATA_PATH_0
    Generic map(DATA_RAM_WIDTH =>DATA_RAM_WIDTH,
            CW_WIDTH => CW_WIDTH,
            N_ALU=>N_ALU,
            ADDR_RAM_WIDTH=>ADDR_RAM_WIDTH,
            DATA_ROM_WIDTH=>DATA_ROM_WIDTH,
            ADDR_ROM_WIDTH=>ADDR_ROM_WIDTH)
    Port map( RST_i=>RST_i,
           CLK_i =>CLK_i,
           CW_i =>CW_debounced,
           ALU_RESULT_o =>ALU_RESULT_o,
           REG_A_o =>REG_A_o,
           REG_B_o => REG_B_o,
           FZ_o => FZ,
           DATA_BUS_o => DATA_BUS_o,
           INST_o => INST,
           ADDR_RAM_o => ADDR_RAM_o,
           ADDR1_o => ADDR1_o,
           ADDR2_o => ADDR2_o,
           PC_o => PC_o);
           

-- Concat CW_CU into CW_debounced
CW_debounced <= CW_CU(CW_WIDTH-1 downto 7) & CW_6 & CW_CU(5) & CW_4 & CW_CU(3 downto 0);

-- Assign dummy signals to outputs
FZ_o <=FZ;
INST_o<=INST;
           
end Behavioral;
