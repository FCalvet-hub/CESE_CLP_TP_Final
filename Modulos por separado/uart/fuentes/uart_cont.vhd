library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity uart_cont is
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
end;

architecture uart_cont_arq of uart_cont is

	component meta_harden is
		port(
			clk_dst: 	in std_logic;	-- Destination clock
			rst_dst: 	in std_logic;	-- Reset - synchronous to destination clock
			signal_src: in std_logic;	-- Asynchronous signal to be synchronized
			signal_dst: out std_logic	-- Synchronized signal
		);
	end component;
	
	component uart_rx is
		generic(
			BAUD_RATE: integer := 115200; 	-- Baud rate
			CLOCK_RATE: integer := 50E6
		);

		port(
			-- Write side inputs
			clk_rx: in std_logic;       				-- Clock input
			rst_clk_rx: in std_logic;   				-- Active HIGH reset - synchronous to clk_rx
							
			rxd_i: in std_logic;        				-- RS232 RXD pin - Directly from pad
			rxd_clk_rx: out std_logic;					-- RXD pin after synchronization to clk_rx
		
			rx_data: out std_logic_vector(7 downto 0);	-- 8 bit data output
														--  - valid when rx_data_rdy is asserted
			rx_data_rdy: out std_logic;  				-- Ready signal for rx_data
			frm_err: out std_logic       				-- The STOP bit was not detected	
		);
	end component;
	
	component upDwTop is
		port(
			clk_rx:			in std_logic;					-- Clock input
			rst_clk_rx:		in std_logic;					-- Active HIGH reset - synchronous to clk_rx
			rx_data:		in std_logic_vector(7 downto 0);-- 8 bit data output
			rx_data_rdy:	in std_logic;					-- valid when rx_data_rdy is asserted
			clk_i : 		IN STD_LOGIC; --in de clock del contador
			count : 		OUT STD_LOGIC_VECTOR (3 DOWNTO 0) -- out del contador
		);
	end component;

	signal rst_clk_rx: std_logic;

	-- Between uart_rx and led_ctl
	signal rx_data: std_logic_vector(7 downto 0); 	-- Data output of uart_rx
	signal rx_data_rdy: std_logic;  				-- Data ready output of uart_rx
  
begin

    rx_data_rdy_out <= rx_data_rdy;
    
	meta_harden_rst_i0: meta_harden
		port map(
			clk_dst 	=> clk_pin,
			rst_dst 	=> '0',    		-- No reset on the hardener for reset!
			signal_src 	=> rst_pin,
			signal_dst 	=> rst_clk_rx
		);


	uart_rx_i0: uart_rx 
		generic map(
			CLOCK_RATE 	=> CLOCK_RATE,
			BAUD_RATE  	=> BAUD_RATE
		)
		port map(
			clk_rx     	=> clk_pin,
			rst_clk_rx 	=> rst_clk_rx,
	
			rxd_i      	=> rxd_pin,
			rxd_clk_rx 	=> open,
	
			rx_data_rdy	=> rx_data_rdy,
			rx_data    	=> rx_data,
			frm_err    	=> open
		);

	led_ctl_i0: upDwTop
		port map(
			clk_rx     	=> clk_pin,
			rst_clk_rx  => rst_clk_rx,			
			rx_data		=> rx_data,
			rx_data_rdy => rx_data_rdy,
			clk_i		=> clk_i,
			count       => cont_pins
		);

end;
