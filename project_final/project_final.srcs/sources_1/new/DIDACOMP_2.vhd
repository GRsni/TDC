----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.05.2021 19:50:43
-- Design Name: 
-- Module Name: DIDACOMP_2 - Behavioral
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

entity DIDACOMP_2 is
    Generic (DATA_WIDTH: integer:=4;
            DATA_RAM_WIDTH: integer:=12;
            ADDR_RAM_WIDTH: integer:=4;
            CW_WIDTH: integer:=21;
            N_ALU: integer:=3;
            NREG_WIDTH: integer:=3;
            COP_WIDTH: integer:=4;
            TIMER: integer:=30000000);
    Port ( CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           PUSH_i : in STD_LOGIC;
           FZ_o : out STD_LOGIC;
           FC_o : out STD_LOGIC;
           INST_o: out STD_LOGIC_VECTOR (DATA_RAM_WIDTH-1 downto 0);
           CATHODE_o : out STD_LOGIC_VECTOR (6 downto 0);
           ANODE_o : out STD_LOGIC_VECTOR (7 downto 0));
end DIDACOMP_2;

architecture Behavioral of DIDACOMP_2 is
-----------------------------------------------------------------------
--                       COMPONENT DECLARATION                       --
-----------------------------------------------------------------------
component DATA_PATH_2 
    Generic (DATA_WIDTH: integer:=4;
            DATA_RAM_WIDTH: integer:=12;
            ADDR_RAM_WIDTH: integer:=4;
            CW_WIDTH: integer:=21;
            N_ALU: integer:=3;
            NREG_WIDTH: integer:=3;
            COP_WIDTH: integer:=4);
    Port (  RST_i : in STD_LOGIC;
            CLK_i : in STD_LOGIC;
            CW_i : in STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0);
            ALU_RESULT_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
            REG_A_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
            REG_B_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
            ADDR_RA_o : out STD_LOGIC_VECTOR(NREG_WIDTH-1 downto 0);
            ADDR_RB_o : out STD_LOGIC_VECTOR(NREG_WIDTH-1 downto 0);  
            FZ_o : out STD_LOGIC;
            FC_o : out STD_LOGIC; 
            DATA_BUS_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
            REG_INST_o : out STD_LOGIC_VECTOR(DATA_RAM_WIDTH-1 downto 0);
            ADDR_RAM_o : out STD_LOGIC_VECTOR(ADDR_RAM_WIDTH-1 downto 0);
            REG_PC_o : out unsigned(ADDR_RAM_WIDTH-1 downto 0));
end component;


component CONT_UNIT_2 
    Generic (CW_WIDTH: integer:=21;
            COP_WIDTH: integer:=4);
    Port ( COP_i : in STD_LOGIC_VECTOR (COP_WIDTH-1 downto 0);
           CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           FZ_i : in STD_LOGIC;
           PUSH_i : in STD_LOGIC;
           CW_o : out STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0));
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

component EdgeDetector_Debounce
    Generic( TIMER: integer:=30000000);
    Port ( CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           PUSH_i : in STD_LOGIC;
           PULSE_o : out STD_LOGIC);
end component;

component EDGE_DETECTOR_00 
    Port ( RST_i : in STD_LOGIC;
           PUSH_i : in STD_LOGIC;
           CLK_i : in STD_LOGIC;
           PULSE_o : out STD_LOGIC);
end component;
--------------------------------------------------------------
--                     SIGNAL DECLARATION                   --
--------------------------------------------------------------
signal DATA0: STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);      -- ALU_OUT
signal DATA1: STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);      -- REG_B
signal DATA2: STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);      -- REG_A
signal DATA3: STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);      -- ADDR_RB
signal DATA4: STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);      -- ADDR_RA
signal DATA5: STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);      -- DATA_BUS
signal DATA6: STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);      -- RAM_ADDR
signal DATA7: STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);      -- REG_PC


signal ADDR_RA: STD_LOGIC_VECTOR(NREG_WIDTH-1 downto 0);    --dummy
signal ADDR_RB: STD_LOGIC_VECTOR(NREG_WIDTH-1 downto 0);    --dummy
signal CW_CU: STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0);        --dummy
signal CW_DEBOUNCED: STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0);
signal CW_11: STD_LOGIC;                                    --dummy
signal CW_14: STD_LOGIC;                                    --dummy
signal CW_17: STD_LOGIC;                                    --dummy
signal INST: STD_LOGIC_VECTOR(DATA_RAM_WIDTH-1 downto 0);   --dummy
signal PC: unsigned(ADDR_RAM_WIDTH-1 downto 0);             --dummy
signal FZ: STD_LOGIC;                                       --dummy
signal PUSH_CU: STD_LOGIC;                                  --dummy

begin
----------------------------------------------------------------
--                  COMPONENT LINKING                         --
----------------------------------------------------------------            
DEBOUNCE: EdgeDetector_Debounce
    Generic map(TIMER => TIMER)
    Port map(
           CLK_i => CLK_i,
           RST_i => RST_i,
           PUSH_i => PUSH_i,
           PULSE_o => PUSH_CU);
            
CONTROL_UNIT: CONT_UNIT_2
    Generic map(
                CW_WIDTH => CW_WIDTH,
                COP_WIDTH => COP_WIDTH)
    Port map(  
              COP_i => INST(DATA_RAM_WIDTH-1 downto DATA_RAM_WIDTH-COP_WIDTH),
              CLK_i => CLK_i,
              RST_i => RST_i,
              FZ_i => FZ,
              PUSH_i => PUSH_CU,
              CW_o => CW_CU); 

                
DATA_PATH: DATA_PATH_2
    Generic map( 
              DATA_WIDTH => DATA_WIDTH,
              DATA_RAM_WIDTH => DATA_RAM_WIDTH,
              ADDR_RAM_WIDTH => ADDR_RAM_WIDTH, 
              CW_WIDTH => CW_WIDTH, 
              N_ALU => N_ALU,
              NREG_WIDTH => NREG_WIDTH,
              COP_WIDTH => COP_WIDTH)
    Port map (
              RST_i => RST_i,
              CLK_i => CLK_i,
              CW_i => CW_DEBOUNCED,
              ALU_RESULT_o => DATA0(DATA_WIDTH-1 downto 0),
              REG_A_o => DATA2,
              REG_B_o => DATA1,
              ADDR_RA_o => ADDR_RA(NREG_WIDTH-1 downto 0),
              ADDR_RB_o => ADDR_RB(NREG_WIDTH-1 downto 0),
              FZ_o => FZ,
              FC_o => FC_o, 
              DATA_BUS_o => DATA5,
              REG_INST_o => INST,
              ADDR_RAM_o => DATA6,
              REG_PC_o => PC);
       
CW11: EDGE_DETECTOR_00      -- LOAD REG_RAM_ADDR
    Port map( 
          RST_i => RST_i,
          PUSH_i => CW_CU(11),
          CLK_i => CLK_i, 
          PULSE_o => CW_11);
            
CW14: EDGE_DETECTOR_00      -- LOAD REG INSTR
   Port map( 
          RST_i => RST_i,
          PUSH_i => CW_CU(14),
          CLK_i => CLK_i,
          PULSE_o => CW_14);
             
CW17: EDGE_DETECTOR_00      -- UPDATE REG PC
    Port map( 
            RST_i => RST_i,
            PUSH_i => CW_CU(17),
            CLK_i => CLK_i, 
            PULSE_o => CW_17);
       

                
               
DISP: DISP8ON
    Generic map(
            DATA_WIDTH => DATA_WIDTH)
    Port map ( 
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
          
-------------------------------------------------------------
--                  DUMMY SIGNALS                          --
-------------------------------------------------------------
FZ_o <= FZ;

INST_o <= INST;

CW_DEBOUNCED <= CW_CU(CW_WIDTH-1 downto 18) & CW_17 & CW_CU(16 downto 15) &
                CW_14 & CW_CU(13 downto 12) & CW_11 & CW_CU(10 downto 0);

DATA4 <= '0' & ADDR_RA;

DATA3 <= '0' & ADDR_RB;

DATA7 <= std_logic_vector(PC);
end Behavioral;
