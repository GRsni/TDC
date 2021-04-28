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
    Generic (DATA_RAM_WIDTH : integer:=4;
            CW_WIDTH : integer:=10;
            N_ALU:integer:=2;
            ADDR_RAM_WIDTH: positive:=4;
            DATA_ROM_WIDTH:positive:=11;
            ADDR_ROM_WIDTH:positive:=4;
            OP_CODE_WIDTH:integer:=3);
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
           PC_o: out STD_LOGIC_VECTOR(ADDR_ROM_WIDTH-1 downto 0));
           
end DATA_PATH_0;

architecture Behavioral of DATA_PATH_0 is
    type RAM_TYPE is array (2**ADDR_RAM_WIDTH-1 downto 0) of
                            STD_LOGIC_VECTOR(DATA_RAM_WIDTH-1 downto 0);
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
                
    type ROM_TYPE is array(2**ADDR_ROM_WIDTH-1 downto 0) of 
                        std_logic_vector(DATA_ROM_WIDTH-1 downto 0);
    signal ROM: ROM_TYPE:=
                (0=>"01010000011",
                 1=>"00000010100",
                 2=>"00100001001",
                 3=>"01100010001",
                 4=>"10000110111",
                 5=>"00001000000",
                 6=>"00000000000",
                 7=>"00000000000",
                 others=>"00000000000");
    
    signal DATA_ROM: std_logic_vector(DATA_ROM_WIDTH-1 downto 0);
    signal ADDR_ROM: std_logic_vector(ADDR_ROM_WIDTH-1 downto 0);
    signal DATA_BUS: std_logic_vector(DATA_RAM_WIDTH-1 downto 0);
    signal ADDR_RAM: std_logic_vector(ADDR_RAM_WIDTH-1 downto 0);
    signal reg_PC: unsigned(ADDR_ROM_WIDTH-1 downto 0); --dummy
    signal reg_INST: std_logic_vector(DATA_ROM_WIDTH-1 downto 0);--dummy
    signal reg_A: unsigned(DATA_RAM_WIDTH-1 downto 0);--dummy
    signal reg_B: unsigned(DATA_RAM_WIDTH-1 downto 0);--dummy
    signal FZ: std_logic;
    signal result: unsigned(DATA_RAM_WIDTH-1 downto 0);
    constant ZEROu: unsigned(DATA_RAM_WIDTH-1 downto 0) :=(others=>'0'); 
begin
    
    load_REG: process(RST_i, CLK_i)
    begin
       if(RST_i = '1') then
           reg_PC <= (others=>'0');
           reg_inst <= (others=>'0');
           reg_A <= (others=>'0');
           reg_b <= (others=>'0');
           FZ<='0';
       elsif rising_edge(CLK_i) then
           if(CW_i(6) = '1') then --Increment reg_PC
              reg_PC <= 1 + unsigned(ADDR_ROM);
           end if;
       
           if(CW_i(4) = '1') then --Load reg_INST
               reg_INST <= DATA_ROM;
           end if;
           
           if( CW_i(2)='1') then --Load reg_A
               reg_A <= unsigned(DATA_BUS);
           end if;
           
           if(CW_i(1)='1') then --Load reg_B
               reg_B <= unsigned(DATA_BUS);
           end if;
           
           if(CW_i(0)='1') then --Load reg_FZ
               if(result=ZEROu) then
                   FZ<='1';
               else 
                   FZ<='0';
               end if;
           end if;
      end if;
    end process;
    
    --Copy reg_PC into PC_o for debug purposes
    PC_o<=std_logic_vector(reg_PC);
    
   ADDR_ROM <= std_logic_vector(reg_PC) when CW_i(7) = '0' else
               reg_INST(ADDR_RAM_WIDTH-1 downto 0);
    
    
    rom_read:  process(CLK_i) -- Read instruction from ROM in ADDR_ROM_i position
    Begin
       if rising_edge(CLK_i) then
           DATA_ROM<=ROM(to_integer(unsigned(ADDR_ROM)));
       end if;
    end process;
    
    --Copy DATA_ROM into INST_o for debug purposes
    INST_o<=DATA_ROM;

    --Select the ram address from the instruction register
    with CW_i(5) select
        ADDR_RAM <= reg_INST(2*ADDR_RAM_WIDTH-1 downto ADDR_RAM_WIDTH)  when '0',  -- load ADDR1 from reg_INST
                    reg_INST(ADDR_RAM_WIDTH-1 downto 0) when others;               -- Load ADDR2 from reg_INST




    ram_wf: process(CLK_i)  -- Read data from RAM in ADDR_RAM memory position
    begin
        if rising_edge(CLK_i) then
            if CW_i(3) = '1' then
                RAM(to_integer(unsigned(ADDR_RAM)))<=std_logic_vector(result(DATA_RAM_WIDTH-1 downto 0));
                DATA_BUS<=std_logic_vector(result(DATA_RAM_WIDTH-1 downto 0));
            else --SYNC READ 
              DATA_BUS<=RAM(to_integer(unsigned(ADDR_RAM))); 
            end if;
        end if;
    end process;
    
    
    -- Asignamos REG_A_o para depuracion
    REG_A_o<=std_logic_vector(reg_A);
    
    -- Asignamos REG_B_o para depuracion
    REG_B_o <=std_logic_vector(reg_B);
    
    -- Perform ALU operation
    with CW_i(CW_WIDTH-1 downto CW_WIDTH-N_ALU) select
            result<=   reg_A when "00",
                       (reg_A + 1)when "01",
                       (reg_A + reg_B) when "10",
                       (reg_A - reg_B) when "11",
                       ZEROu when others;
    
    --Copy selected ADDR_RAM to ADDR_RAM_o for debug purposes
    ADDR_RAM_o<=ADDR_RAM;
    
    --Copy alu operation result into ALU_RESULT_o
    ALU_RESULT_o <= std_logic_vector(result);
    DATA_BUS_o <= DATA_BUS;
    
    --Update FZ_o register with FZ value
    FZ_o<=FZ;
    
end Behavioral;
