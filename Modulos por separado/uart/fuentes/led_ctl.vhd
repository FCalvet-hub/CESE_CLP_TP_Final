-----------------------------------------------------------------------------
--  
--  Copyright (c) 2009 Xilinx Inc.
--
--  Project  : Programmable Wave Generator
--  Module   : led_ctl.v
--  Parent   : uart_led.v
--  Children : None
--
--  Description: 
--     LED output generator
--
--  Parameters:
--     None
--
--  Local Parameters:
--
--  Notes       : 
--
--  Multicycle and False Paths
--    None
--

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY led_ctl IS
	PORT (
		clk_rx : IN STD_LOGIC; -- Clock input
		rst_clk_rx : IN STD_LOGIC; -- Active HIGH reset - synchronous to clk_rx
		btn_clk_rx : IN STD_LOGIC; -- Button to swap low and high pins
		rx_data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);-- 8 bit data output
		rx_data_rdy : IN STD_LOGIC; -- valid when rx_data_rdy is asserted
		led_o : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)-- The LED outputs
	);
END;

ARCHITECTURE led_ctl_arq OF led_ctl IS
	SIGNAL old_rx_data_rdy : STD_LOGIC;
	SIGNAL char_data : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL led_pipeline_reg : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL integer_value : INTEGER RANGE 0 TO 127; -- Adjust range as needed
BEGIN

	PROCESS (clk_rx)
	BEGIN
		IF rising_edge(clk_rx) THEN
			IF rst_clk_rx = '1' THEN
				old_rx_data_rdy <= '0';
				char_data <= "00000000";
				led_o <= "0000";
			ELSE
				-- Capture the value of rx_data_rdy for edge detection
				old_rx_data_rdy <= rx_data_rdy;
				-- If rising edge of rx_data_rdy, capture rx_data
				IF (rx_data_rdy = '1' AND old_rx_data_rdy = '0') THEN
					char_data <= rx_data;
					-- Check if all bits are equal
					IF (rx_data = "01010011") THEN
						integer_value <= integer_value + 1;
						led_pipeline_reg <= STD_LOGIC_VECTOR(to_unsigned(integer_value, led_pipeline_reg'length));
					END IF;
					IF (rx_data = "01010010") THEN
						integer_value <= integer_value - 1;
						led_pipeline_reg <= STD_LOGIC_VECTOR(to_unsigned(integer_value, led_pipeline_reg'length));
					END IF;					
				END IF;

				--Output the normal data or the data with high and low swapped
				IF btn_clk_rx = '1' THEN
					led_pipeline_reg <= char_data(7 DOWNTO 4);
				ELSE
					led_pipeline_reg <= char_data(3 DOWNTO 0);
				END IF;
			END IF; -- if !rst
		END IF;
		led_o <= led_pipeline_reg;
	END PROCESS;
END;