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
              NREG_WIDTH: integer:=3);
      Port (  RST_i : in STD_LOGIC;
              CLK_i : in STD_LOGIC;
              CW_i : in STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0);
              ADDR_REG_i: in STD_LOGIC_VECTOR(NREG_WIDTH-1 downto 0);
              ALU_RESULT_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
              REG_A_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
              REG_B_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
              ADDR_RA_o : out STD_LOGIC_VECTOR(NREG_WIDTH-1 downto 0);
              ADDR_RB_o : out STD_LOGIC_VECTOR(NREG_WIDTH-1 downto 0);  
              FZ_o : out STD_LOGIC;
              FC_o : out STD_LOGIC; 
              DATA_BUS_o : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0));
  end component;

  constant CW_WIDTH:integer:=12;
  constant DATA_WIDTH: integer:=4;
  constant DATA_RAM_WIDTH: integer:=12;
  constant ADDR_RAM_WIDTH: integer:=4;
  constant N_ALU: integer:=3;
  constant NREG_WIDTH: integer:=3;


  signal RST_i: STD_LOGIC;
  signal CLK_i: STD_LOGIC;
  signal CW_i: STD_LOGIC_VECTOR(CW_WIDTH-1 downto 0);
  signal ADDR_REG_i: STD_LOGIC_VECTOR(NREG_WIDTH-1 downto 0);
  signal ALU_RESULT_o: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
  signal REG_A_o: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
  signal REG_B_o: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
  signal ADDR_RA_o: STD_LOGIC_VECTOR(NREG_WIDTH-1 downto 0);
  signal ADDR_RB_o: STD_LOGIC_VECTOR(NREG_WIDTH-1 downto 0);
  signal FZ_o: STD_LOGIC;
  signal FC_o: STD_LOGIC;
  signal DATA_BUS_o: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  -- Insert values for generic parameters !!
  uut: DATA_PATH_2 generic map ( DATA_WIDTH     => DATA_WIDTH     ,
                                 DATA_RAM_WIDTH => DATA_RAM_WIDTH ,
                                 ADDR_RAM_WIDTH => ADDR_RAM_WIDTH ,
                                 CW_WIDTH       => CW_WIDTH       ,
                                 N_ALU          => N_ALU          ,
                                 NREG_WIDTH     => NREG_WIDTH      )
                      port map ( RST_i          => RST_i,
                                 CLK_i          => CLK_i,
                                 CW_i           => CW_i,
                                 ADDR_REG_i     => ADDR_REG_i,
                                 ALU_RESULT_o   => ALU_RESULT_o,
                                 REG_A_o        => REG_A_o,
                                 REG_B_o        => REG_B_o,
                                 ADDR_RA_o      => ADDR_RA_o,
                                 ADDR_RB_o      => ADDR_RB_o,
                                 FZ_o           => FZ_o,
                                 FC_o           => FC_o,
                                 DATA_BUS_o     => DATA_BUS_o );

  stimulus: process
  begin
  
    -- Put initialisation code here
    RST_i<='1';
    wait for 10 ns;
    RST_i<='0';
    wait for 10 ns;

    -- Put test bench stimulus code here
    ADDR_REG_i <="001";     --Load ADDR RA
    CW_i <= "000100000000";
    wait for 10 ns;
    
    ADDR_REG_i <="000";     --Load ADDR RB
    CW_i <= "000010000000";
    wait for 10 ns;
    
    CW_i <= "000000101000";
    wait for 20 ns;
                  
    CW_i <= "000000010100";
    wait for 10 ns;
    
    CW_i <= "010001000011";
    wait for 10 ns;
                  
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