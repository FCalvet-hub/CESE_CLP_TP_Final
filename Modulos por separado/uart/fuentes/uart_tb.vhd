LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY uart_top_tb IS
END ENTITY uart_top_tb;

ARCHITECTURE testbench OF uart_top_tb IS

    COMPONENT uart_top IS
        PORT (
            --Write side inputs
            clk_pin : IN STD_LOGIC; -- Clock input (from pin)
            rst_pin : IN STD_LOGIC; -- Active HIGH reset (from pin)
            btn_pin : IN STD_LOGIC; -- Button to swap high and low bits
            rxd_pin : IN STD_LOGIC; -- Uart input
            txd_pin : OUT STD_LOGIC;
            led_pins : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) -- 4 LED outputs
        );
    END COMPONENT;

    -- Constants for clock period and simulation duration
    CONSTANT clk_period : TIME := 8 ns;
    CONSTANT bit_period : TIME := 8681 ns;

    -- Signals for UART top entity ports
    SIGNAL clk_pin_tb : STD_LOGIC := '0';
    SIGNAL rst_pin_tb : STD_LOGIC := '1';
    SIGNAL btn_pin_tb : STD_LOGIC := '0';
    SIGNAL rxd_pin_tb : STD_LOGIC := '1';
    SIGNAL txd_pin_tb : STD_LOGIC;
    SIGNAL led_pins_tb : STD_LOGIC_VECTOR(3 DOWNTO 0);

    SIGNAL ascii_char : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN

    -- Instantiate the UART top entity
    DUT : uart_top
    PORT MAP(
        clk_pin => clk_pin_tb,
        rst_pin => rst_pin_tb,
        btn_pin => btn_pin_tb,
        rxd_pin => rxd_pin_tb,
        txd_pin => txd_pin_tb,
        led_pins => led_pins_tb
    );

    -- Clock process
    clk_process : PROCESS
    BEGIN
        clk_pin_tb <= NOT clk_pin_tb;
        WAIT FOR clk_period / 2;
    END PROCESS clk_process;

    -- Stimulus process
    stimulus : PROCESS
    BEGIN
        -- Apply reset
        rxd_pin_tb <= '1'; -- Example data, you can change it accordingly
        rst_pin_tb <= '1';
        WAIT FOR bit_period * 10;
        rst_pin_tb <= '0';

        ascii_char <= X"3F";
        -- Send Start Bit
        rxd_pin_tb <= '0';
        WAIT FOR bit_period;
        -- Send Data Byte
        FOR ii IN 0 TO 7 LOOP
            rxd_pin_tb <= ascii_char(ii);
            WAIT FOR bit_period;
        END LOOP; -- ii
        -- Send Stop Bit
        rxd_pin_tb <= '1';
        WAIT FOR bit_period;
        WAIT FOR bit_period * 100;


        ascii_char <= X"53";
        -- Send Start Bit
        rxd_pin_tb <= '0';
        WAIT FOR bit_period;
        -- Send Data Byte
        FOR ii IN 0 TO 7 LOOP
            rxd_pin_tb <= ascii_char(ii);
            WAIT FOR bit_period;
        END LOOP; -- ii
        -- Send Stop Bit
        rxd_pin_tb <= '1';
        WAIT FOR bit_period;
        WAIT FOR bit_period * 100;
        
        
        ascii_char <= X"53";
        -- Send Start Bit
        rxd_pin_tb <= '0';
        WAIT FOR bit_period;
        -- Send Data Byte
        FOR ii IN 0 TO 7 LOOP
            rxd_pin_tb <= ascii_char(ii);
            WAIT FOR bit_period;
        END LOOP; -- ii
        -- Send Stop Bit
        rxd_pin_tb <= '1';
        WAIT FOR bit_period;
        WAIT FOR bit_period * 100;     
        
        ascii_char <= X"53";
        -- Send Start Bit
        rxd_pin_tb <= '0';
        WAIT FOR bit_period;
        -- Send Data Byte
        FOR ii IN 0 TO 7 LOOP
            rxd_pin_tb <= ascii_char(ii);
            WAIT FOR bit_period;
        END LOOP; -- ii
        -- Send Stop Bit
        rxd_pin_tb <= '1';
        WAIT FOR bit_period;
        WAIT FOR bit_period * 100;
        
        
        ascii_char <= X"53";
        -- Send Start Bit
        rxd_pin_tb <= '0';
        WAIT FOR bit_period;
        -- Send Data Byte
        FOR ii IN 0 TO 7 LOOP
            rxd_pin_tb <= ascii_char(ii);
            WAIT FOR bit_period;
        END LOOP; -- ii
        -- Send Stop Bit
        rxd_pin_tb <= '1';
        WAIT FOR bit_period;
        WAIT FOR bit_period * 100;  
        
        ascii_char <= X"52";
        -- Send Start Bit
        rxd_pin_tb <= '0';
        WAIT FOR bit_period;
        -- Send Data Byte
        FOR ii IN 0 TO 7 LOOP
            rxd_pin_tb <= ascii_char(ii);
            WAIT FOR bit_period;
        END LOOP; -- ii
        -- Send Stop Bit
        rxd_pin_tb <= '1';
        WAIT FOR bit_period;
        WAIT FOR bit_period * 100;
        
        
        ascii_char <= X"C2";
        -- Send Start Bit
        rxd_pin_tb <= '0';
        WAIT FOR bit_period;
        -- Send Data Byte
        FOR ii IN 0 TO 7 LOOP
            rxd_pin_tb <= ascii_char(ii);
            WAIT FOR bit_period;
        END LOOP; -- ii
        -- Send Stop Bit
        rxd_pin_tb <= '1';
        WAIT FOR bit_period;
        WAIT FOR bit_period * 100;          

    END PROCESS stimulus;

END ARCHITECTURE testbench;