----------------------------------------------------------------------------------
-- Engineer: Santiago Jesús Mas Peña
-- 
-- Create Date: 22.05.2021 18:18:11
-- Design Name: Data path opcion 2 proyecto final 
-- Module Name: DATA_PATH_2 - Behavioral
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

entity DATA_PATH_2 is
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
end DATA_PATH_2;

architecture Behavioral of DATA_PATH_2 is

   type RAM_TYPE is array (2**ADDR_RAM_WIDTH-1 downto 0) of
                            STD_LOGIC_VECTOR(DATA_RAM_WIDTH-1 downto 0);
    signal RAM: RAM_TYPE:=
                       (0=>  "000010110111", 
                        1=>  "000011010001",
                        2=>  "001101110001",
                        3=>  "010000100001",
                        4=>  "010110000001",
                        5=>  "000011100011",
                        6=>  "001000110111",
                        7=>  "011000001001", 
                        8=>  "000111000001",
                        9=>  "000111110111",
                        10=> "011000000000",
                        11=> "000000001111",
                        12=> "000000001111", 
                        13=> "000000001001", 
                        14=> "000000000001", 
                        15=> "000000001111");

    type REG_BANK_TYPE is array(2 ** NREG_WIDTH-1 downto 0) of
                                STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
                              
    signal REG_BANK: REG_BANK_TYPE:=(others => "0000");

    signal ALU_DATA_BUS: STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);       --dummy
    signal ALU_RES_BUS: STD_LOGIC_VECTOR(DATA_WIDTH downto 0);          --dummy
    signal RAM_DATA_BUS: STD_LOGIC_VECTOR(DATA_RAM_WIDTH-1 downto 0);   --dummy
    signal RAM_ADDR_BUS: STD_LOGIC_VECTOR(ADDR_RAM_WIDTH-1 downto 0);       --dummy
    signal PC_OUT_BUS: STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);     --dummy
    
    signal reg_A: unsigned(DATA_WIDTH downto 0);
    signal reg_B: unsigned(DATA_WIDTH downto 0);
    signal reg_FZ: STD_LOGIC;
    signal reg_FC: STD_LOGIC;
    signal reg_ADDR_RA: STD_LOGIC_VECTOR(NREG_WIDTH-1 downto 0);
    signal reg_ADDR_RB: STD_LOGIC_VECTOR(NREG_WIDTH-1 downto 0);
    signal reg_DATA_RAM: STD_LOGIC_VECTOR(DATA_RAM_WIDTH-1 downto 0);
    signal reg_ADDR_RAM: STD_LOGIC_VECTOR(ADDR_RAM_WIDTH-1 downto 0);
    signal reg_INST: STD_LOGIC_VECTOR(DATA_RAM_WIDTH-1 downto 0);
    signal reg_PC: unsigned(ADDR_RAM_WIDTH-1 downto 0);
    
    constant ZEROu: STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0) :=(others=>'0');
    constant ZEROram: STD_LOGIC_VECTOR(DATA_RAM_WIDTH-1 downto 0):= (others=>'0'); 
begin

    RAM_WF: process(CLK_i)
    begin
        if rising_edge(CLK_i) then
            if(CW_i(9)= '1') then --RAM WRITE
                RAM(to_integer(unsigned(reg_ADDR_RAM))) <= std_logic_vector(reg_DATA_RAM);
                RAM_DATA_BUS <= reg_DATA_RAM;
            else    --SYNC RAM READ
                RAM_DATA_BUS <= RAM(to_integer(unsigned(reg_ADDR_RAM)));
            end if;
        end if;
    end process;
    
    WRITE_REG_BANK: process(CLK_i)
    begin
        if(rising_edge(CLK_i))then
          if(CW_i(6) = '1') then    --  Load value from ALU into register bank
                REG_BANK(to_integer(unsigned(reg_ADDR_RB))) <= std_logic_vector(ALU_RES_BUS(DATA_WIDTH-1 downto 0));                
            end if;
        end if;
    end process;
    
    
    -- Load RAM ADDR BUS with first or second reg INST field
    with CW_i(15) select
        RAM_ADDR_BUS <= reg_INST(2*ADDR_RAM_WIDTH-1 downto ADDR_RAM_WIDTH)  when '0',  -- load ADDR1 from reg_INST
                         reg_INST(ADDR_RAM_WIDTH-1 downto 0) when others;               -- Load ADDR2 from reg_INST
    
    -- Load PC bus with either reg_PC or jump address if BEZ and FZ = 1
    PC_OUT_BUS <= reg_INST(ADDR_RAM_WIDTH-1 downto 0) when CW_i(16) = '1' and
                                                        reg_FZ = '1' else
                  std_logic_vector(reg_PC);
    
    LOAD_REGS: process(RST_i, CLK_i)
    begin
        if(RST_i = '1') then
            reg_A <= (others=>'0');
            reg_B <= (others=>'0');
            reg_ADDR_RA <= (others=>'0');
            reg_ADDR_RB <= (others=>'0');
            reg_FZ <= '0';
            reg_FC <= '0';
            reg_ADDR_RAM <= (others => '0');
            reg_DATA_RAM <= (others => '0');
            reg_INST <= (others => '0');
            reg_PC <= (others => '0');
        elsif rising_edge(CLK_i) then
            -- load register depending on CW_i
            if(CW_i(17) = '1') then -- Update reg PC
                reg_PC <= 1 + unsigned(PC_OUT_BUS);
            end if;
            
            if(CW_i(14) = '1') then --Load reg INST with data from RAM
                reg_INST <= RAM_DATA_BUS;
            end if;
            
            if(CW_i(13) = '1') then --Load reg DATA RAM with either data from RAM or from ALU RESULT
                if(CW_i(12) = '1') then
                    reg_DATA_RAM <= RAM_DATA_BUS;
                else
                    reg_DATA_RAM <= ZEROram(DATA_RAM_WIDTH-1 downto DATA_WIDTH) & ALU_RES_BUS(DATA_WIDTH-1 downto 0);
                end if;
            end if;
            
            if(CW_i(11) = '1') then -- Load reg ADDR RAM
                if(CW_i(10) = '0') then     
                    reg_ADDR_RAM <= RAM_ADDR_BUS;   -- Load RAM address register from address bus
                else
                    reg_ADDR_RAM <= PC_OUT_BUS;     -- Load RAM address register with PC pointer
                end if;
            end if;
            
            if(CW_i(8) = '1') then  -- Load reg ADDR RA for register bank register pointer
                reg_ADDR_RA <= RAM_ADDR_BUS(NREG_WIDTH-1 downto 0);
            end if;
            
            if(CW_i(7) = '1') then  -- Loas reg ADDR RB for register bank register pointer
                reg_ADDR_RB <= RAM_ADDR_BUS(NREG_WIDTH-1 downto 0);
            end if;
           
            if(CW_i(3) = '1') then  -- Load ALU aux reg_A
                reg_A <= '0' & unsigned(ALU_DATA_BUS);
            end if;
            
            if(CW_i(2) = '1') then  -- Load ALU aux reg_B
                reg_B <= '0' & unsigned(ALU_DATA_BUS);
            end if;
           
            if(CW_i(1) = '1') then  -- Load value into Zero flag register
                if(ALU_RES_BUS(DATA_WIDTH-1 downto 0) = ZEROu) then
                    reg_FZ <= '1';
                else
                    reg_FZ <= '0';
                end if;
            end if;
           
            if(CW_i(0) = '1') then  -- Load value into Carry flag register
                if(ALU_RES_BUS(DATA_WIDTH) = '1') then
                    reg_FC <= '1';
                else
                    reg_FC <= '0';
                end if;
            end if;
        end if;
   end process;
   
   --Select DATA source into ALU_DATA_BUS
   with CW_i(5 downto 4) select
        ALU_DATA_BUS <= REG_BANK(to_integer(unsigned(reg_ADDR_RA))) when "00",
                        REG_BANK(to_integer(unsigned(reg_ADDR_RB))) when "01",
                        reg_DATA_RAM(DATA_WIDTH-1 downto 0)         when "10",
                        RAM_ADDR_BUS                                when "11",
                        REG_BANK(to_integer(unsigned(reg_ADDR_RB))) when others;

    
    -- Perform ALU operations
    with CW_i(CW_WIDTH-1 downto CW_WIDTH-N_ALU) select
        ALU_RES_BUS  <=     std_logic_vector(reg_B) when "000",             -- LD   addr, RB
                            std_logic_vector(reg_B) when "001",             --ST    addr, RB
                            std_logic_vector((reg_A + reg_B)) when "010",   --ADD   RA, RB
                            std_logic_vector((reg_A - reg_B)) when "011",   --SUB   RA, RB
                            std_logic_vector((reg_A + reg_B)) when "100",   --INC  inm, RB   
                            std_logic_vector((reg_A - reg_B)) when "101",   --DEC  inm, RB
                            (others => '0') when others;

    
    -- Assign signals to output lines
    REG_A_o <= std_logic_vector(reg_A(DATA_WIDTH-1 downto 0));     
    
    REG_B_o <= std_logic_vector(reg_B(DATA_WIDTH-1 downto 0));
    
    FZ_o <= reg_FZ;
    
    FC_o <= reg_FC;
    
    ALU_RESULT_o <= std_logic_vector(ALU_RES_BUS(DATA_WIDTH-1 downto 0));
    
    DATA_BUS_o <= reg_DATA_RAM(DATA_WIDTH-1 downto 0);
    
    ADDR_RA_o <= reg_ADDR_RA;
    
    ADDR_RB_o <= reg_ADDR_RB;
    
    REG_INST_o <= reg_INST;
    
    REG_PC_o <= reg_PC;
    
    ADDR_RAM_o <= reg_ADDR_RAM;

end Behavioral;