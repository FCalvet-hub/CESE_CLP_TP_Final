LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY contUpDw_tb IS
END contUpDw_tb;

ARCHITECTURE contUpDw_tb_arq OF contUpDw_tb IS

    COMPONENT contUpDw IS
        PORT (
            clk_i : IN STD_LOGIC;
            clr_i : IN STD_LOGIC;
            up_i : IN STD_LOGIC;
            down_i : IN STD_LOGIC;
            count : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL clk_tb : STD_LOGIC := '1';
    SIGNAL clr_tb : STD_LOGIC := '0';
    SIGNAL up_tb : STD_LOGIC := '1';
    SIGNAL down_tb : STD_LOGIC := '0';
    SIGNAL count_tb : STD_LOGIC_VECTOR (3 DOWNTO 0);

BEGIN

    clk_tb <= NOT clk_tb AFTER 10ns;
    up_tb <= NOT up_tb AFTER 200ns;
    down_tb <= NOT down_tb AFTER 200ns;

    DUT : contUpDw
    PORT MAP(
        clk_i => clk_tb,
        clr_i => clr_tb,
        up_i => up_tb,
        down_i => down_tb,
        count => count_tb
    );
END contUpDw_tb_arq;