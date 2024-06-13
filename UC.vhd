library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UC is
    Port (
        clk : in std_logic;
        reset : in std_logic;
        start : in std_logic;
        confirm : in std_logic;
        fin_counter: in std_logic;
        fin_counter_1_min : in std_logic;
        enable_counter : out std_logic;
        enable_counter1min : out std_logic;
        led_on_off : out std_logic;
        led_door : out std_logic;
        selectie_mux_ssd : out std_logic;
        load_counter : out std_logic
    );
end UC;

architecture Behavioral of UC is
    type stare_t is (astept, astept_confirm, astept_counter, astept_counter1min, final);
    signal stare, nx_stare : stare_t;
    signal en_cnt : std_logic;
    signal en_cnt1min: std_logic;
    signal on_off : std_logic;
    signal door : std_logic;
    signal selectie : std_logic;
    signal load : std_logic;
begin

    act_stare : process(clk, reset)
    begin
        if reset = '1' then
            stare <= astept;
        elsif rising_edge(clk) then
            stare <= nx_stare;
        end if;
    end process;

    tranzitii : process(stare, start, confirm, fin_counter, fin_counter_1_min)
    begin
        en_cnt <= '0';
        en_cnt1min <= '0';
        door <= '0';
        load <= '0';
        on_off <= '0';
        selectie <= '0';
        case stare is 
            when astept =>
                if start = '1' then
                    on_off <= '1';
                    nx_stare <= astept_confirm;
                    load <= '1';
                    door <= '0';
                else
                    nx_stare <= astept;
                end if;
            when astept_confirm =>
                on_off <= '1';
                if confirm = '1' then 
                    nx_stare <= astept_counter;
                    door <= '1';
                    en_cnt <= '1';  
                else
                    nx_stare <= astept_confirm;
                end if;
            when astept_counter =>
                en_cnt <= '1';
                on_off <= '1';
                load <= '0';
                door <= '1';
                if fin_counter = '1' then 
                    nx_stare <= astept_counter1min;
                    selectie <= '1';
                    en_cnt1min <= '1';
                else
                    nx_stare <= astept_counter;
                end if;
            when astept_counter1min =>
                en_cnt1min <= '1';
                on_off <= '1';
                en_cnt <= '0';
                door <= '1';
                selectie <= '1';
                if fin_counter_1_min = '1' then
                    nx_stare <= final;
                    door <= '0';
                    en_cnt1min <= '0';
                    selectie <= '0'; 
                else
                    nx_stare <= astept_counter1min;
                end if;
            when final =>
                on_off <= '1';
                door <= '0';
                selectie <= '0';    
                load <= '0';
                en_cnt <= '0';
                en_cnt1min <= '0';
                nx_stare <= astept;
            when others =>
                nx_stare <= astept;
        end case;
    end process;
    enable_counter <= en_cnt;
    enable_counter1min <= en_cnt1min;
    led_on_off <= on_off;
    led_door <= door;
    selectie_mux_ssd <= selectie;
    load_counter <= load;
end Behavioral;
