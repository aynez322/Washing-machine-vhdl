library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Hex_to_7seg is
    Port (
        clock_100Mhz : in STD_LOGIC;
        reset : in STD_LOGIC;
        hex : in STD_LOGIC_VECTOR(7 downto 0);
        cat : out STD_LOGIC_VECTOR(6 downto 0);
        an : out STD_LOGIC_VECTOR(3 downto 0)
    );
end Hex_to_7seg;

architecture Behavioral of Hex_to_7seg is
    signal LED_BCD : unsigned(3 downto 0) := (others => '0');
    signal refresh_counter : unsigned(19 downto 0) := (others => '0');
    signal LED_activating_counter : unsigned(1 downto 0);
    signal decimal_digits : unsigned(11 downto 0) := (others => '0');
    procedure binary_to_bcd(
        bin : in STD_LOGIC_VECTOR(7 downto 0);
        variable bcd : out unsigned(11 downto 0)
    ) is
        variable bcd_temp : unsigned(11 downto 0) := (others => '0');
        variable bin_temp : unsigned(7 downto 0) := unsigned(bin);
    begin
        for i in 0 to 7 loop
            if bcd_temp(3 downto 0) > "0100" then
                bcd_temp(3 downto 0) := bcd_temp(3 downto 0) + "0011";
            end if;
            if bcd_temp(7 downto 4) > "0100" then
                bcd_temp(7 downto 4) := bcd_temp(7 downto 4) + "0011";
            end if;
            if bcd_temp(11 downto 8) > "0100" then
                bcd_temp(11 downto 8) := bcd_temp(11 downto 8) + "0011";
            end if;
            bcd_temp := bcd_temp(10 downto 0) & bin_temp(7);
            bin_temp := bin_temp(6 downto 0) & '0';
        end loop;
        bcd := bcd_temp;
    end procedure;

begin
    process(clock_100Mhz, reset)
    begin
        if reset = '1' then
            refresh_counter <= (others => '0');
        elsif rising_edge(clock_100Mhz) then
            refresh_counter <= refresh_counter + 1;
        end if;
    end process;
    process(hex)
        variable bcd_var : unsigned(11 downto 0);
    begin
        binary_to_bcd(hex, bcd_var);
        decimal_digits <= bcd_var;
    end process;
    LED_activating_counter <= refresh_counter(19 downto 18);
    
    process(LED_activating_counter, decimal_digits)
    begin
        case LED_activating_counter is
            when "00" =>
                an <= "1110"; 
                LED_BCD <= decimal_digits(3 downto 0);
            when "01" =>
                an <= "1101"; 
                LED_BCD <= decimal_digits(7 downto 4); 
            when "10" =>
                an <= "1011"; 
                LED_BCD <= decimal_digits(11 downto 8);
            when others =>
                an <= "1111";
                LED_BCD <= "0000"; 
        end case;
    end process;
    process(LED_BCD)
    begin
        case LED_BCD is
            when "0000" => cat <= "1000000"; -- '0'
            when "0001" => cat <= "1111001"; -- '1'
            when "0010" => cat <= "0100100"; -- '2'
            when "0011" => cat <= "0110000"; -- '3'
            when "0100" => cat <= "0011001"; -- '4'
            when "0101" => cat <= "0010010"; -- '5'
            when "0110" => cat <= "0000010"; -- '6'
            when "0111" => cat <= "1111000"; -- '7'
            when "1000" => cat <= "0000000"; -- '8'
            when "1001" => cat <= "0010000"; -- '9'
            when others => cat <= "1111111"; -- Off
        end case;
    end process;

end Behavioral;
