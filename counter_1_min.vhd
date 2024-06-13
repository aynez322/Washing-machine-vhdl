library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.STD_LOGIC_arith.ALL;

entity counter_1_min is
Port ( enable_1: in std_logic;
       reset_1 : in std_logic;
       clk : in std_logic;
       fin_cnt_1 : out std_logic;
       num_1_min : out std_logic_vector (7 downto 0));
end counter_1_min;

architecture Behavioral of counter_1_min is
signal counter : std_logic_vector (7 downto 0):= "00111100";
begin
    process(reset_1,clk)
        begin
        if reset_1 = '1' then
            counter <= "00111100";
        elsif rising_edge(clk) then
                if enable_1 = '1' then 
                    counter <= counter-1; 
                end if;
            end if; 
end process;
process(counter)
        begin
        if counter = "00000000" then
            fin_cnt_1 <= '1';
        else
            fin_cnt_1 <= '0';
        end if;
    end process;
num_1_min <= counter;
end Behavioral;
