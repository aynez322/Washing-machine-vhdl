library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.STD_LOGIC_arith.ALL;

entity counter_spalare is
Port ( data_spalare : in std_logic_vector (7 downto 0);
       enable_spalare: in std_logic;
       load_spalare : in std_logic;
       reset_spalare : in std_logic;
       clk : in std_logic;
       fin_cnt_spalare : out std_logic;
       num_spalare : out std_logic_vector (7 downto 0));
end counter_spalare;

architecture Behavioral of counter_spalare is
signal cnt_spalare : std_logic_vector(7 downto 0);
begin
    process(clk,reset_spalare)
        begin
            if reset_spalare = '1' then
                cnt_spalare <="00000000";
                elsif rising_edge(clk) then
                    if load_spalare = '1' then 
                        cnt_spalare <= data_spalare;
                        elsif enable_spalare = '1'  then
                            cnt_spalare <= cnt_spalare - 1;
                        end if;
                end if;
end process;
process(cnt_spalare)
        begin
            if cnt_spalare = "00000000" then
                fin_cnt_spalare <= '1';
            else
                fin_cnt_spalare <= '0';
            end if;
end process;
num_spalare <= cnt_spalare;
end Behavioral;
