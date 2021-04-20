----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.04.2021 12:38:21
-- Design Name: 
-- Module Name: DISP8ON - Behavioral
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

entity DISP8ON is
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
end DISP8ON;


architecture Behavioral of DISP8ON is

component COUNTER_N_bits 
    Generic( N: integer:=3);
    Port ( CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           ENA_i : in STD_LOGIC;
           Q_o : out STD_LOGIC_VECTOR (N-1 downto 0));
end component;

component DISP7SEG
    Port ( BINARY_i : in STD_LOGIC_VECTOR (3 downto 0);
           DISPLAY_i : in STD_LOGIC_VECTOR (2 downto 0);
           CATHODE_o : out STD_LOGIC_VECTOR (6 downto 0);
           ANODE_o : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component MUX4 
    generic (WIDTH: integer:=8);
    Port ( A_i : in STD_LOGIC_VECTOR (WIDTH - 1 downto 0);
           B_i : in STD_LOGIC_VECTOR (WIDTH - 1 downto 0);
           C_i : in STD_LOGIC_VECTOR (WIDTH - 1 downto 0);
           D_i : in STD_LOGIC_VECTOR (WIDTH - 1 downto 0);
           E_i : in STD_LOGIC_VECTOR (WIDTH - 1 downto 0);
           F_i : in STD_LOGIC_VECTOR (WIDTH - 1 downto 0);
           G_i : in STD_LOGIC_VECTOR (WIDTH - 1 downto 0);
           H_i : in STD_LOGIC_VECTOR (WIDTH - 1 downto 0);
           SEL_i : in STD_LOGIC_VECTOR (2 downto 0);
           Z_o : out STD_LOGIC_VECTOR (WIDTH - 1 downto 0));
end component;

component PRESCALER_1Hz 
    Generic(FREQ: integer:=100000);
    Port ( CLK_i : in STD_LOGIC;
           RST_i : in STD_LOGIC;
           CLK_1kHz_o : out STD_LOGIC);
end component;

    signal CLK_1kHz: STD_LOGIC; --dummy
    signal ENABLE: STD_LOGIC; --dummy
    signal SELECTOR: STD_LOGIC_VECTOR(2 downto 0); --dummy
    signal DATA: STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0); --dummy 

begin
PRESCALER_1kHz :PRESCALER_1Hz
    generic map(FREQ => 100000)
    port map(
        CLK_i=>CLK_i,
        RST_i=>RST_i,
        CLK_1kHz_o=>CLK_1kHz);
    

COUNTER: COUNTER_N_bits
    generic map(N=>3)
    port map(  
        CLK_i=>CLK_i,
        RST_i=>RST_i, 
        ENA_i=>CLK_1kHz,
        Q_o=>SELECTOR);


MUX8: MUX4
    generic map(WIDTH=>DATA_WIDTH)
    port map(
        A_i=>DATA_0_i, 
        B_i=>DATA_1_i, 
        C_i=>DATA_2_i, 
        D_i=>DATA_3_i, 
        E_i=>DATA_4_i, 
        F_i=>DATA_5_i, 
        G_i=>DATA_6_i, 
        H_i=>DATA_7_i,
        SEL_i=>SELECTOR, 
        Z_o=>DATA);
        
DISP7: DISP7SEG
    port map(
        BINARY_i=>DATA, 
        DISPLAY_i=>SELECTOR, 
        CATHODE_o=>CATHODE_o, 
        ANODE_o=>ANODE_o);


end Behavioral;
