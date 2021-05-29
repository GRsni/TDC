library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity DATA_PATH_2_tb is
end;

architecture bench of DATA_PATH_2_tb is

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
              ADDR_RAM_o : out STD_LOGIC_VECTOR(ADDR_RAM_WIDTH-1 downto 0));
  end component;

   constant CW_WIDTH: integer:=21;
   constant DATA_WIDTH: integer:=4;
   constant DATA_RAM_WIDTH: integer:=12;
   constant ADDR_RAM_WIDTH: integer:=4;
   constant NREG_WIDTH: integer:=3;
   constant N_ALU:integer:=3;
   constant COP_WIDTH:integer:=4;

  signal RST_i: STD_LOGIC;
  signal CLK_i: STD_LOGIC;
  signal CW_i: STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0);
  signal ALU_RESULT_o: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
  signal REG_A_o: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
  signal REG_B_o: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
  signal ADDR_RA_o: STD_LOGIC_VECTOR(NREG_WIDTH-1 downto 0);
  signal ADDR_RB_o: STD_LOGIC_VECTOR(NREG_WIDTH-1 downto 0);
  signal FZ_o: STD_LOGIC;
  signal FC_o: STD_LOGIC;
  signal DATA_BUS_o: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
  signal REG_INST_o: STD_LOGIC_VECTOR(DATA_RAM_WIDTH-1 downto 0);
  signal ADDR_RAM_o: STD_LOGIC_VECTOR(ADDR_RAM_WIDTH-1 downto 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  -- Insert values for generic parameters !!
  uut: DATA_PATH_2 generic map ( DATA_WIDTH     =>DATA_WIDTH    ,
                                 DATA_RAM_WIDTH =>DATA_RAM_WIDTH,
                                 ADDR_RAM_WIDTH =>ADDR_RAM_WIDTH,
                                 CW_WIDTH       =>CW_WIDTH      ,
                                 N_ALU          =>N_ALU         ,
                                 NREG_WIDTH     =>NREG_WIDTH     ,
                                 COP_WIDTH      =>COP_WIDTH     )
                      port map ( RST_i          => RST_i,
                                 CLK_i          => CLK_i,
                                 CW_i           => CW_i,
                                 ALU_RESULT_o   => ALU_RESULT_o,
                                 REG_A_o        => REG_A_o,
                                 REG_B_o        => REG_B_o,
                                 ADDR_RA_o      => ADDR_RA_o,
                                 ADDR_RB_o      => ADDR_RB_o,
                                 FZ_o           => FZ_o,
                                 FC_o           => FC_o,
                                 DATA_BUS_o     => DATA_BUS_o,
                                 REG_INST_o     => REG_INST_o,
                                 ADDR_RAM_o     => ADDR_RAM_o );

  stimulus: process
  begin
  
    -- Put initialisation code here
    RST_i <= '1';
    wait for 10 ns;
    RST_i <= '0'; 
    wait for 10 ns;

    -- Put test bench stimulus code here
    
    ---------- INSTRUCTION LD [11], [7] ------------------
    ---------- 0000           1011 0111 ------------------
    CW_i <= "000100000110000000000";    -- LOAD_INSTR_ADDR
    wait for 10 ns;
    
    CW_i <= "000000000000000000000";    -- RAM_INSTR_ADDR_UPDATE
    wait for 10 ns;
    
    CW_i <= "000000100000000000000";    -- FETCH
    wait for 10 ns;
    
    CW_i <= "000000000000000000000";    -- DECODE
    wait for 10 ns;
    
    CW_i <= "000000000100000000000";    -- LOAD_RAM_ADDR
    wait for 10 ns;
        
    CW_i <= "000001000000010000000";    -- LOAD_RB_ADDR
    wait for 10 ns;
    
    CW_i <= "000000011000000000000";    -- LOAD_RAM_DATA
    wait for 10 ns;
    
    CW_i <= "000000000000000100100";    -- LOAD_ALU_REG_B
    wait for 10 ns;
    
    CW_i <= "000000000000001000011";    -- LD_OP
    wait for 10 ns;   
    ------------------------------------------------------
    
    
    ---------- INSTRUCTION LD [13], R7 ------------------
    ---------- 0000           1101 0001 ------------------
    CW_i <= "000100000110000000000";    -- LOAD_INSTR_ADDR      
    wait for 10 ns;
    
    CW_i <= "000000000000000000000";    -- RAM_INSTR_ADDR_UPDATE
    wait for 10 ns;
    
    CW_i <= "000000100000000000000";    -- FETCH                
    wait for 10 ns;
    
    CW_i <= "000000000000000000000";    -- DECODE               
    wait for 10 ns;
    
    CW_i <= "000000000100000000000";    -- LOAD_RAM_ADDR        
    wait for 10 ns;
        
    CW_i <= "000001000000010000000";    -- LOAD_RB_ADDR         
    wait for 10 ns;
    
    CW_i <= "000000011000000000000";    -- LOAD_RAM_DATA        
    wait for 10 ns;
    
    CW_i <= "000000000000000100100";    -- LOAD_ALU_REG_B       
    wait for 10 ns;
    
    CW_i <= "000000000000001000011";    -- LD_OP                
    wait for 10 ns;  
    ------------------------------------------------------
        
        
    ---------- INSTRUCTION SUB R7, R1 ------------------
    ---------- 0011         0111 0001 ------------------
    CW_i <= "000100000110000000000";    -- LOAD_INSTR_ADDR
    wait for 10 ns;
    
    CW_i <= "000000000000000000000";    -- RAM_INSTR_ADDR_UPDATE
    wait for 10 ns;
    
    CW_i <= "000000100000000000000";    -- FETCH
    wait for 10 ns;
    
    CW_i <= "000000000000000000000";    -- DECODE
    wait for 10 ns;
    
    CW_i <= "000000000000100000000";    -- LOAD_RA_ADDR
    wait for 10 ns;
    
    CW_i <= "000000000000000001000";    -- LOAD_ALU_REG_A
    wait for 10 ns;
    
    CW_i <= "000001000000010000000";    -- LOAD_RB_ADDR
    wait for 10 ns;
    
    CW_i <= "000000000000000010100";    -- LOAD_ALU_REG_B
    wait for 10 ns;
    
    CW_i <= "011000000000001000011";    -- SUB_OP
    wait for 10 ns;
    -------------------------------------------------------
    
    
    ---------- INSTRUCTION INC 2, R1 ------------------
    ---------- 0011         0010 0001 ------------------
    CW_i <= "000100000110000000000";    -- LOAD_INSTR_ADDR      
    wait for 10 ns;
    
    CW_i <= "000000000000000000000";    -- RAM_INSTR_ADDR_UPDATE
    wait for 10 ns;
    
    CW_i <= "000000100000000000000";    -- FETCH                
    wait for 10 ns;
    
    CW_i <= "000000000000000000000";    -- DECODE               
    wait for 10 ns;
    
    CW_i <= "000000000000000111000";    -- LOAD_INM_REG_A        
    wait for 10 ns;
    
    CW_i <= "000001000000010000000";    -- LOAD_RB_ADDR
    wait for 10 ns;
    
    CW_i <= "000000000000000010100";    -- LOAD_ALU_REG_B
    wait for 10 ns;
    
    CW_i <= "100000000000001000011";    -- INC_OP
    wait for 10 ns;
    
    -------------------------------------------------------
        
        
    ---------- INSTRUCTION DEC 8, R1 ------------------
    ---------- 0011          1000 0001 ------------------
    CW_i <= "000100000110000000000";    -- LOAD_INSTR_ADDR      
    wait for 10 ns;
    
    CW_i <= "000000000000000000000";    -- RAM_INSTR_ADDR_UPDATE
    wait for 10 ns;
    
    CW_i <= "000000100000000000000";    -- FETCH                
    wait for 10 ns;
    
    CW_i <= "000000000000000000000";    -- DECODE               
    wait for 10 ns;
    
    CW_i <= "000000000000000111000";    -- LOAD_INM_REG_A
    wait for 10 ns;
    
    CW_i <= "000001000000010000000";    -- LOAD_RB_ADDR
    wait for 10 ns;
    
    CW_i <= "000000000000000010100";    -- LOAD_ALU_REG_B
    wait for 10 ns;
    
    CW_i <= "101000000000001000011";    -- DEC_OP
    wait for 10 ns;
    ------------------------------------------------------
       
       
    ---------- INSTRUCTION LD [14], R3 ------------------
    ---------- 0000           1110 0011 ------------------
    CW_i <= "000100000110000000000";    -- LOAD_INSTR_ADDR      
    wait for 10 ns;
    
    CW_i <= "000000000000000000000";    -- RAM_INSTR_ADDR_UPDATE
    wait for 10 ns;
    
    CW_i <= "000000100000000000000";    -- FETCH                
    wait for 10 ns;
    
    CW_i <= "000000000000000000000";    -- DECODE               
    wait for 10 ns;
    
    CW_i <= "000000000100000000000";    -- LOAD_RAM_ADDR        
    wait for 10 ns;
        
    CW_i <= "000001000000010000000";    -- LOAD_RB_ADDR         
    wait for 10 ns;
    
    CW_i <= "000000011000000000000";    -- LOAD_RAM_DATA        
    wait for 10 ns;
    
    CW_i <= "000000000000000100100";    -- LOAD_ALU_REG_B       
    wait for 10 ns;
    
    CW_i <= "000000000000001000011";    -- LD_OP                
    wait for 10 ns;   
    ------------------------------------------------------
            
            
    ---------- INSTRUCTION ADD R7, R3 ------------------
    ---------- 0010         0111 0011 ------------------
    CW_i <= "000100000110000000000";    -- LOAD_INSTR_ADDR      
    wait for 10 ns;
    
    CW_i <= "000000000000000000000";    -- RAM_INSTR_ADDR_UPDATE
    wait for 10 ns;
    
    CW_i <= "000000100000000000000";    -- FETCH                
    wait for 10 ns;
    
    CW_i <= "000000000000000000000";    -- DECODE               
    wait for 10 ns;
    
    CW_i <= "000000000000100000000";    -- LOAD_RA_ADDR
    wait for 10 ns;
    
    CW_i <= "000000000000000001000";    -- LOAD_ALU_REG_A
    wait for 10 ns;
    
    CW_i <= "000001000000010000000";    -- LOAD_RB_ADDR
    wait for 10 ns;
    
    CW_i <= "000000000000000010100";    -- LOAD_ALU_REG_B
    wait for 10 ns;
    
    CW_i <= "010000000000001000011";    -- ADD_OP
    wait for 10 ns;
    ------------------------------------------------------
                
                
    ---------- INSTRUCTION BEZ     [9]  ------------------
    ---------- 0110          0000 1001  ------------------
    CW_i <= "000100000110000000000";   -- LOAD_INSTR_ADDR      
    wait for 10 ns;
    
    CW_i <= "000000000000000000000";   -- RAM_INSTR_ADDR_UPDATE
    wait for 10 ns;
    
    CW_i <= "000000100000000000000";   -- FETCH                
    wait for 10 ns;
    
    CW_i <= "000000000000000000000";   -- DECODE               
    wait for 10 ns;
    
    CW_i <= "000111000110000000011";    -- BEZ_OP
    wait for 10 ns;
    ----------------------------------------------------
    
    
    ---------- INSTRUCTION ST [15], R3 ------------------
    ---------- 0010          1111 0011 ------------------
    CW_i <= "000100000110000000000";   -- LOAD_INSTR_ADDR      
    wait for 10 ns;
    
    CW_i <= "000000000000000000000";    -- RAM_INSTR_ADDR_UPDATE
    wait for 10 ns;
    
    CW_i <= "000000100000000000000";    -- FETCH
    wait for 10 ns;
    
    CW_i <= "000000000000000000000";    -- DECODE
    wait for 10 ns;
    
    CW_i <= "000000000100000000000";    -- LOAD_RAM_ADDR
    wait for 10 ns;
    
    CW_i <= "000001000000010000000";    -- LOAD_RB_ADDR
    wait for 10 ns;
    
    CW_i <= "000000000000000010100";    -- LOAD_ALU_REG_B
    wait for 10 ns;
    
    CW_i <= "001000010000000000000";    -- LOAD_RB_INTO_RAM_DATA
    wait for 10 ns;
    
    CW_i <= "001000000001000000011";    -- ST_OP
    wait for 10 ns;
    -------------------------------------------------------
    
    
    ---------- INSTRUCTION BEZ     [0]  ------------------
    ---------- 0110          0000 0000  ------------------
    CW_i <= "000100000110000000000";    -- LOAD_INSTR_ADDR      
    wait for 10 ns;
    
    CW_i <= "000000000000000000000";    -- RAM_INSTR_ADDR_UPDATE
    wait for 10 ns;
    
    CW_i <= "000000100000000000000";    -- FETCH                
    wait for 10 ns;
    
    CW_i <= "000000000000000000000";    -- DECODE               
    wait for 10 ns;
    
    CW_i <= "000111000110000000011";    -- BEZ_OP
    wait for 10 ns;
    ----------------------------------------------------
    
    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      CLK_i <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;