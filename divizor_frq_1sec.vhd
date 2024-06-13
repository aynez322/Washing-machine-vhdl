library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.STD_LOGIC_arith.ALL;
entity divizor_frq_1sec is
Port (clk : in std_logic;
      reset : in std_logic;
      clk_1_sec : out std_logic);
end divizor_frq_1sec;

architecture Behavioral of divizor_frq_1sec is
constant frq : integer := 500000000;-- frecventa normala 50MHZ
constant val_max : integer := frq-1;
signal counter : integer range 0 to val_max := 0;
signal tact : std_logic := '0'; 
begin
    process(clk,reset)
        begin
            if reset = '1' then 
                counter <= 0;
                tact <= '0';
            elsif rising_edge(clk) then
                if counter = val_max then -- cand a ajuns la val max tact se face 1 astfel se obtine frecventa de 1s
                    counter <= 0;
                    tact <= not tact;
                else
                    counter <= counter + 1;
                end if;
            end if;        
    end process;
clk_1_sec <= tact;
end Behavioral;
