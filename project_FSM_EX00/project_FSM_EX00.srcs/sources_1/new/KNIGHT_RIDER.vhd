----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.05.2021 14:02:59
-- Design Name: 
-- Module Name: KNIGHT_RIDER - Behavioral
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

entity KNIGHT_RIDER is
    Generic(LED_COUNT: integer:=16);
    Port ( CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           LED_o : out STD_LOGIC_VECTOR (LED_COUNT-1 downto 0));
end KNIGHT_RIDER;

architecture Behavioral of KNIGHT_RIDER is

component FSM_KNIGHT
    Generic ( LED_COUNT: integer:=16);
    Port ( RST_i : in STD_LOGIC;
           CLK_i : in STD_LOGIC;
           LED_pos_i : in STD_LOGIC_VECTOR(LED_COUNT-1 downto 0);
           L_R_o : out STD_LOGIC);  --0 means MOVE_LEFT, 1 means MOVE_RIGHT
end component;

component ROT_REG 
    Generic(LED_COUNT: integer:=16);
    Port ( RST_i : in STD_LOGIC;
           CLK_i : in STD_LOGIC;
           ENA_i : in STD_LOGIC;
           L_R_i : in STD_LOGIC;
           LED_o : out STD_LOGIC_VECTOR (LED_COUNT-1 downto 0));
end component;

component CE_N_Hz 
    Generic ( END_COUNT: integer:= 100);
    Port ( CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           CLK_N_Hz_o : out STD_LOGIC);
end component;

    signal LED_pos: std_logic_vector(LED_COUNT-1 downto 0); --dummy
    signal L_R: std_logic;
    signal ENA: std_logic;

begin

FSM:FSM_KNIGHT
    Generic map(LED_COUNT=>LED_COUNT)
    Port map(RST_i=>RST_i,
            CLK_i=>CLK_i, 
            LED_pos_i=>LED_pos,
            L_R_o=> L_R);

CE_10_HZ:CE_N_Hz
    Generic map(END_COUNT=>10000000)
    Port map(RST_i=>RST_i,
            CLK_i=>CLK_i,
            CLK_N_Hz_o=>ENA);

ROT:ROT_REG
    Generic map(LED_COUNT=>LED_COUNT)
    Port map(RST_i=>RST_i,
            CLK_i=>CLK_i,
            ENA_i=>ENA,
            L_R_i=>L_R,
            LED_o=>LED_pos);
            
    LED_o<=LED_pos;

end Behavioral;
