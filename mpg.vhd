library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mpg is
Port (BTN    : in STD_LOGIC;
      CLK    : in STD_LOGIC;
      DEBOUNCED : out STD_LOGIC);
end mpg;

architecture Behavioral of mpg is
    signal COUNT: STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal Q1, Q2, Q3: STD_LOGIC := '0';
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            COUNT <= COUNT + 1;
        end if;
    end process;
    process(CLK)
    begin
        if rising_edge(CLK) then
            if COUNT = x"FFFF" then
                Q1 <= BTN;
            end if;
        end if;
    end process;
    process(CLK)
    begin
        if rising_edge(CLK) then
            Q2 <= Q1;
            Q3 <= Q2;
        end if;
    end process;
    DEBOUNCED <= Q2 and not Q3;
end Behavioral;
