LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY upDwTop IS
    PORT (
        clk_rx : IN STD_LOGIC; -- Clock input
        rst_clk_rx : IN STD_LOGIC; -- Active HIGH reset - synchronous to clk_rx
        rx_data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);-- 8 bit data output
        rx_data_rdy : IN STD_LOGIC; -- valid when rx_data_rdy is asserted
        clk_i : IN STD_LOGIC; --in de clock del contador
        count : OUT STD_LOGIC_VECTOR (3 DOWNTO 0) -- out del contador
    );
END;

ARCHITECTURE upDwTop_arq OF upDwTop IS

    COMPONENT contUpDw IS
        PORT (
            clk_i : IN STD_LOGIC;
            clr_i : IN STD_LOGIC;
            up_i : IN STD_LOGIC;
            down_i : IN STD_LOGIC;
            count : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT contControl IS
        PORT (
            clk_rx : IN STD_LOGIC; -- Clock input
            rst_clk_rx : IN STD_LOGIC; -- Active HIGH reset - synchronous to clk_rx
            rx_data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);-- 8 bit data output
            rx_data_rdy : IN STD_LOGIC; -- valid when rx_data_rdy is asserted
            co_up_o : OUT STD_LOGIC;
            co_down_o : OUT STD_LOGIC;
            co_clr_o : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL co_up_o_aux : STD_LOGIC;
    SIGNAL co_down_o_aux : STD_LOGIC;
    SIGNAL co_clr_o_aux : STD_LOGIC;

BEGIN

    control : contControl
    PORT MAP(
        clk_rx => clk_rx,
        rst_clk_rx => rst_clk_rx,
        rx_data => rx_data,
        rx_data_rdy => rx_data_rdy,
        co_up_o => co_up_o_aux,
        co_down_o => co_down_o_aux,
        co_clr_o => co_clr_o_aux
    );

    contador : contUpDw
    PORT MAP(
        clk_i => clk_i,
        clr_i => co_clr_o_aux,
        up_i => co_up_o_aux,
        down_i => co_down_o_aux,
        count => count
    );

END;