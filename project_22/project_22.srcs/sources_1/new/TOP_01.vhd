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
    Generic (DATA_WIDTH : integer:=4;
            CW_WIDTH : integer:=5;
            N_ALU: integer:=2);
    Port (  DATA_BUS_i : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
            RST_i : in STD_LOGIC;
            CLK_i : in STD_LOGIC;
            CW_i : in STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0);
            FZ_o: out STD_LOGIC;
            CATHODE_o : out STD_LOGIC_VECTOR (6 downto 0);
            ANODE_o : out STD_LOGIC_VECTOR (7 downto 0));
end TOP_01; 

architecture Behavioral of TOP_01 is

component DATA_PATH_0 
    Generic (DATA_WIDTH : integer:=4;
            CW_WIDTH : integer:=5;
            N_ALU: integer:=2);
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
    
    signal DATA0:STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);--DATA_BUS
    signal DATA1:STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);--REG_A
    signal DATA2:STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);--REG_B
    signal DATA3:STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);--ALU_RES
begin

DATA_PATH: DATA_PATH_0
    Generic map(DATA_WIDTH=>DATA_WIDTH,
                CW_WIDTH=>CW_WIDTH, 
                N_ALU=>N_ALU)
   Port map(
            DATA_BUS_i=>DATA_BUS_i,
            RST_i=>RST_i,
            CLK_i=>CLK_i,
            CW_i=>CW_i,
            ALU_RESULT_o=>DATA3,
            REG_A_o=>DATA1,
            REG_B_o=>DATA2,
            FZ_o=>FZ_o,
            DATA_BUS_o=>DATA0);

DISP7SEG8ON: DISP8ON
    Generic map(DATA_WIDTH=>DATA_WIDTH)
    Port map(
             DATA_0_i=>DATA0,
             DATA_1_i=>DATA1,
             DATA_2_i=>DATA2,
             DATA_3_i=>DATA3,
             DATA_4_i=>(others=>'0'),
             DATA_5_i=>(others=>'0'),
             DATA_6_i=>(others=>'0'),
             DATA_7_i=>(others=>'0'),
             CLK_i=>CLK_i,
             RST_i=>RST_i,
             CATHODE_o=>CATHODE_o,
             ANODE_o=>ANODE_o);
end Behavioral;
