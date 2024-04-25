LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY contControl_tb IS
END contControl_tb;

ARCHITECTURE contControl_tb_arq OF contControl_tb IS

  -- Component declaration
  COMPONENT contControl IS
    PORT (
      clk_rx : IN STD_LOGIC; -- Clock input
      rst_clk_rx : IN STD_LOGIC; -- Active HIGH reset - synchronous to clk_rx
      rx_data : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 bit data output
      rx_data_rdy : IN STD_LOGIC; -- valid when rx_data_rdy is asserted
      co_up_o : OUT STD_LOGIC;
      co_down_o : OUT STD_LOGIC;
      co_clr_o : OUT STD_LOGIC
    );
  END COMPONENT;

  -- Signals for testbench
  SIGNAL clk_rx_tb : STD_LOGIC := '0'; -- Clock input
  SIGNAL rst_clk_rx_tb : STD_LOGIC := '0'; -- Active HIGH reset - synchronous to clk_rx
  SIGNAL rx_data_tb : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0'); -- Initialize all bits to '0'
  SIGNAL rx_data_rdy_tb : STD_LOGIC := '0'; -- valid when rx_data_rdy is asserted
  SIGNAL co_up_o_tb : STD_LOGIC;
  SIGNAL co_down_o_tb : STD_LOGIC;
  SIGNAL co_clr_o_tb : STD_LOGIC;

BEGIN

  -- Process for driving the clock
  clk_rx_tb <= NOT clk_rx_tb AFTER 10ns;

  -- Drive other signals with delayed assignments after initial delay
  rx_data_tb <= "01000011" after 200ns;
  rx_data_rdy_tb <= NOT rx_data_rdy_tb after 210ns;

  -- DUT instantiation
  DUT : contControl
  PORT MAP (
    clk_rx => clk_rx_tb,
    rst_clk_rx => rst_clk_rx_tb,
    rx_data => rx_data_tb,
    rx_data_rdy => rx_data_rdy_tb,
    co_up_o => co_up_o_tb,
    co_down_o => co_down_o_tb,
    co_clr_o => co_clr_o_tb
  );

END contControl_tb_arq;
