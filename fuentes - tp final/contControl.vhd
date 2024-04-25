LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY contControl IS
    PORT (
        clk_rx : IN STD_LOGIC; -- Clock input
        rst_clk_rx : IN STD_LOGIC; -- Active HIGH reset - synchronous to clk_rx
        rx_data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);-- 8 bit data output
        rx_data_rdy : IN STD_LOGIC; -- valid when rx_data_rdy is asserted
        co_up_o : OUT STD_LOGIC;
        co_down_o : OUT STD_LOGIC;
        co_clr_o : OUT STD_LOGIC
    );
END;

ARCHITECTURE contControl_arq OF contControl IS
    SIGNAL old_rx_data_rdy : STD_LOGIC;
    SIGNAL char_data : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN

    PROCESS (clk_rx)
    BEGIN
        IF rising_edge(clk_rx) THEN
            IF rst_clk_rx = '1' THEN
                old_rx_data_rdy <= '0';
                char_data <= "00000000";
            ELSE

                old_rx_data_rdy <= rx_data_rdy;

                IF (rx_data_rdy = '1' AND old_rx_data_rdy = '0') THEN
                    char_data <= rx_data;

                    IF (rx_data = "01010101") THEN --U
                        co_up_o <= '1';
                        co_down_o <= '0';
                    END IF;
                    IF (rx_data = "01000100") THEN --D
                        co_up_o <= '0';
                        co_down_o <= '1';
                    END IF;
                    IF (rx_data = "01000011") THEN --C
                        co_clr_o <= '1';
                        co_up_o <= '0';
                        co_down_o <= '0';
                    END IF;        
                else
                    co_clr_o <= '0';
                END IF;
            END IF; -- if !rst
        END IF;
    END PROCESS;
END;