----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.04.2021 12:26:34
-- Design Name: 
-- Module Name: TOP_01 - Behavioral
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

entity TOP_01 is
    Generic (DATA_RAM_WIDTH : integer:=4;
            ADDR_RAM_WIDTH: positive:=4;
            CW_WIDTH : integer:=10;
            N_ALU: integer:=2;
           DATA_ROM_WIDTH:positive:=11;
           ADDR_ROM_WIDTH:positive:=4;
           OP_CODE_WIDTH:integer:=3);
    Port (  RST_i : in STD_LOGIC;
            CLK_i : in STD_LOGIC;
            CW_i : in STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0);
            FZ_o: out STD_LOGIC;
            INST_o: out STD_LOGIC_VECTOR(DATA_ROM_WIDTH-1 downto 0);
            CATHODE_o : out STD_LOGIC_VECTOR (6 downto 0);
            ANODE_o : out STD_LOGIC_VECTOR (7 downto 0));
end TOP_01; 

architecture Behavioral of TOP_01 is

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
    
    signal DATA0: STD_LOGIC_VECTOR(DATA_RAM_WIDTH-1 downto 0);--ALU_OUT
    signal DATA1: STD_LOGIC_VECTOR(DATA_RAM_WIDTH-1 downto 0);--REG_B
    signal DATA2: STD_LOGIC_VECTOR(DATA_RAM_WIDTH-1 downto 0);--REG_A
    signal DATA3: STD_LOGIC_VECTOR(ADDR_RAM_WIDTH-1 downto 0);--ADDR2_o
    signal DATA4: STD_LOGIC_VECTOR(ADDR_RAM_WIDTH-1 downto 0);--ADDR1_o
    signal DATA5: STD_LOGIC_VECTOR(DATA_RAM_WIDTH-1 downto 0);--PC_o
    signal DATA6: STD_LOGIC_VECTOR(DATA_RAM_WIDTH-1 downto 0);--DATA_BUS
    signal DATA7: STD_LOGIC_VECTOR(ADDR_RAM_WIDTH-1 downto 0);--ADDR_RAM
begin

DATA_PATH: DATA_PATH_0
    Generic map(DATA_RAM_WIDTH=>DATA_RAM_WIDTH,
                ADDR_RAM_WIDTH=>ADDR_RAM_WIDTH,
                CW_WIDTH=>CW_WIDTH, 
                N_ALU=>N_ALU, 
                DATA_ROM_WIDTH=>DATA_ROM_WIDTH, 
                ADDR_ROM_WIDTH=>ADDR_ROM_WIDTH)
   Port map(
             RST_i=>RST_i, 
             CLK_i=>CLK_i,
             CW_i=>CW_i,
             ALU_RESULT_o=>DATA0, 
             REG_A_o =>DATA2,
             REG_B_o=>DATA1,
             FZ_o =>FZ_o,
             DATA_BUS_o =>DATA6,
             INST_o=>INST_o,
             ADDR_RAM_o=>DATA7,
             ADDR1_o=>DATA4,
             ADDR2_o=>DATA3,
             PC_o=>DATA5);

DISP7SEG8ON: DISP8ON
    Generic map(DATA_WIDTH=>DATA_RAM_WIDTH)
    Port map(
             DATA_0_i=>DATA0,
             DATA_1_i=>DATA1,
             DATA_2_i=>DATA2,
             DATA_3_i=>DATA3,
             DATA_4_i=>DATA4,
             DATA_5_i=>DATA5,
             DATA_6_i=>DATA6,
             DATA_7_i=>DATA7,
             CLK_i=>CLK_i,
             RST_i=>RST_i,
             CATHODE_o=>CATHODE_o,
             ANODE_o=>ANODE_o); 
end Behavioral;
