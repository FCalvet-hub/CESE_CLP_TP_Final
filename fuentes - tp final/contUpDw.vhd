LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY contUpDw IS
    PORT (
        clk_i : IN STD_LOGIC;
        clr_i : IN STD_LOGIC;
        up_i :  IN STD_LOGIC;
        down_i :IN STD_LOGIC;
        count : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
        );
END contUpDw;

ARCHITECTURE contUpDw_arq OF contUpDw IS

    SIGNAL aux:STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";

BEGIN
    PROCESS (clk_i, clr_i)
    BEGIN

        IF (clr_i = '1') THEN
            aux <= "0000";
        ELSIF (rising_edge(clk_i)) THEN
            IF (up_i = '1') THEN
                aux <= aux + 1;
            ELSif(down_i = '1') THEN
                aux <= aux - 1;
            END IF;
        END IF;
    END PROCESS;

    count <= aux;
END contUpDw_arq;