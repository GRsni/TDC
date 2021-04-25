----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.03.2021 12:40:15
-- Design Name: 
-- Module Name: DATA_PATH_0 - Behavioral
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

entity DATA_PATH_0 is
    Generic (DATA_WIDTH : integer:=4;
            CW_WIDTH : integer:=6;
            N_ALU:integer:=2;
            ADDR_WIDTH: positive:=10);
    Port ( ADDR_RAM_i: in STD_LOGIC_VECTOR( ADDR_WIDTH-1 downto 0);
           RST_i : in STD_LOGIC;
           CLK_i : in STD_LOGIC;
           CW_i : in STD_LOGIC_VECTOR (CW_WIDTH-1 downto 0);
           ALU_RESULT_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           REG_A_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           REG_B_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           FZ_o : out STD_LOGIC;
           DATA_BUS_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0));
end DATA_PATH_0;

architecture Behavioral of DATA_PATH_0 is
    type RAM_TYPE is array (2**ADDR_WIDTH-1 downto 0) of
                            STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
    signal RAM: RAM_TYPE:=
               (0=> "0001", 
                1=> "1111",
                2=> "1110",
                3=> "1110",
                4=> "1110",
                5=> "0000",
                6=> "0001",
                7=> "0010", 
                8=> "0101",
                9=> "1111",
                others=>"0000");
    signal DATA_BUS: std_logic_vector(DATA_WIDTH-1 downto 0);
    signal reg_A: unsigned(DATA_WIDTH-1 downto 0);--dummy
    signal reg_B: unsigned(DATA_WIDTH-1 downto 0);--dummy
    signal FZ: std_logic;
    signal result: unsigned(DATA_WIDTH downto 0);
    constant ZEROu: unsigned(DATA_WIDTH downto 0):=(others=>'0'); 
begin

    ram_wf: process(CLK_i)
    begin
        if rising_edge(CLK_i) then
            if CW_i(3) = '1' then
                RAM(to_integer(unsigned(ADDR_RAM_i)))<=std_logic_vector(result(DATA_WIDTH-1 downto 0));
                DATA_BUS<=std_logic_vector(result(DATA_WIDTH-1 downto 0));
            else --SYNC READ 
              DATA_BUS<=RAM(to_integer(unsigned(ADDR_RAM_i))); 
            end if;
        end if;
    end process;
            

    load_REG_A: process(RST_i, CLK_i)
    begin
        if( RST_i = '1') then
            reg_A<=ZEROu;
        elsif rising_edge(CLK_i) then
            if( CW_i(2)='1') then
                reg_A<= unsigned(DATA_BUS);
            end if;
        end if;
    end process;

    load_reg_B: process(RST_i, CLK_i) 
    begin
        if( RST_i='1') then
            reg_B<=ZEROu;
        elsif rising_edge(CLK_i) then
            if(CW_i(1)='1') then
                reg_B<=unsigned(DATA_BUS);
            end if;
        end if;
    end process;
    
    FZregister: process(RST_i, CLK_i)
    begin
        if(RST_i='1') then
            FZ<='0';
        elsif rising_edge(CLK_i) then
            if(CW_i(0)='1') then
                if(result(DATA_WIDTH-1 downto 0)=ZEROu(DATA_WIDTH-1 downto 0)) then
                    FZ<='1';
                else 
                    FZ<='0';
                end if;
            else
                FZ<='0';
            end if;
       end if;
    end process;
    
    -- Asignamos REG_A_o para depuracion
    REG_A_o<=std_logic_vector(reg_A(DATA_WIDTH-1 downto 0));
    
    -- Asignamos REG_B_o para depuracion
    REG_B_o <=std_logic_vector(reg_B(DATA_WIDTH-1 downto 0));
    
    with CW_i(CW_WIDTH-1 downto CW_WIDTH-N_ALU) select
            result<=   reg_A when "00",
                       reg_A + 1 when "01",
                       reg_A + reg_B when "10",
                       reg_A - reg_B when "11",
                       ZEROu when others;
    
    --Asignamos el resultado de la ALU a la salida
    ALU_RESULT_o <= std_logic_vector(result(DATA_WIDTH-1 downto 0));
    DATA_BUS_o <= DATA_BUS;
    --Actualizamos el registro FZ
    FZ_o<=FZ;
    
end Behavioral;
