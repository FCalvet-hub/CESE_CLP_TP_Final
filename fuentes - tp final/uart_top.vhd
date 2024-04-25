-------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/19/2015 10:24:29 AM
-- Design Name: 
-- Module Name: uart_top
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
--////////////////////////////////////////////////////////////////////////////////

library IEEE;
use IEEE.std_logic_1164.all;

entity uart_top is
	port(
		--Write side inputs
		clk_pin: in std_logic;		-- Clock input (from pin)
		rst_pin: in std_logic;		-- Active HIGH reset (from pin)

		rxd_pin: in std_logic; 		-- Uart input
		cont_pins: out std_logic_vector(3 downto 0); -- 4 LED outputs
		clk_i : IN STD_LOGIC --in de clock del contador
	);
end;
	

architecture uart_top_arq of uart_top is

	component uart_cont is
		generic(
			BAUD_RATE: integer := 115200;   
			CLOCK_RATE: integer := 50E6
		);
		port(
			-- Write side inputs
			clk_pin:	in std_logic;      					-- Clock input (from pin)
			rst_pin: 	in std_logic;      					-- Active HIGH reset (from pin)			
			rxd_pin: 	in std_logic;      					-- RS232 RXD pin - directly from pin
			cont_pins: 	out std_logic_vector(3 downto 0);   -- 8 LED outputs
			clk_i : IN STD_LOGIC; --in de clock del contador
			rx_data_rdy_out: out std_logic
		);
	end component;
	    
    signal rx_data_rdy_out: std_logic_vector(0 downto 0);
begin

	U0: uart_cont
		generic map(
			BAUD_RATE => 115200,
			CLOCK_RATE => 125E6
		)
		port map(
			clk_pin => clk_pin,  	-- Clock input (from pin)
			rst_pin => rst_pin,  	-- Active HIGH reset (from pin)			
			rxd_pin => rxd_pin,  	-- RS232 RXD pin - directly from pin
			cont_pins => cont_pins, 	-- 8 LED outputs
			clk_i => clk_i,
			rx_data_rdy_out => rx_data_rdy_out(0)
		);
        
end;