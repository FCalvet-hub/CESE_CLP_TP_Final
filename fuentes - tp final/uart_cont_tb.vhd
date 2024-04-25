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
            rxd_pin : IN STD_LOGIC; -- Uart input
            cont_pins : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- 4 LED outputs
            clk_i : IN STD_LOGIC --in de clock del contador
        );
    END COMPONENT;

    -- Constants for clock period and simulation duration
    CONSTANT clk_period : TIME := 8 ns;
    CONSTANT clk_cont_period : TIME := 20 us;
    CONSTANT bit_period : TIME := 8681 ns;

    -- Signals for UART top entity ports
    SIGNAL clk_pin_tb : STD_LOGIC := '0';
    SIGNAL rst_pin_tb : STD_LOGIC := '1';
    SIGNAL rxd_pin_tb : STD_LOGIC := '1';
    SIGNAL cont_pins_tb : STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal clk_i_tb : STD_LOGIC := '0';

    SIGNAL ascii_char : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN

    -- Instantiate the UART top entity
    DUT : uart_top
    PORT MAP(
        clk_pin => clk_pin_tb,
        rst_pin => rst_pin_tb,
        rxd_pin => rxd_pin_tb,
        cont_pins => cont_pins_tb,
        clk_i => clk_i_tb
    );

    -- Clock process
    clk_process : PROCESS
    BEGIN
        clk_pin_tb <= NOT clk_pin_tb;
        WAIT FOR clk_period / 2;
    END PROCESS clk_process;

    clk_cont : PROCESS
    BEGIN
    clk_i_tb <= NOT clk_i_tb;
        WAIT FOR clk_cont_period / 2;
    END PROCESS clk_cont;    

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
        WAIT FOR bit_period * 20;


        ascii_char <= X"55"; --U
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
        WAIT FOR bit_period * 20;
        
        
        ascii_char <= X"49"; --I
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
        WAIT FOR bit_period * 20;     
        
        ascii_char <= X"44"; --D
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
        WAIT FOR bit_period * 20;
        
        
        ascii_char <= X"53"; --S
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
        WAIT FOR bit_period * 20;  
        
        ascii_char <= X"43"; --C
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
        WAIT FOR bit_period * 20;
        
        
        ascii_char <= X"C2"; -- A
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
        WAIT FOR bit_period * 20;          

    END PROCESS stimulus;

END ARCHITECTURE testbench;

