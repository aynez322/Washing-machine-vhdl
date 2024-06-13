library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity main is
    Port (
        CLOCK : in std_logic;
        RESET : in std_logic;
        START : in std_logic;
        CONFIRM : in std_logic;
        OPTIUNE_MOD : in std_logic;
        ADRESA_MOD_AUTO : in std_logic_vector(2 downto 0);
        ADRESA_CLATIRE : in std_logic;
        ADRESA_PRESPALARE : in std_logic;
        ADRESA_TEMPERATURA : in std_logic_vector (1 downto 0);
        ADRESA_VITEZA : in std_logic_vector (1 downto 0);
        LED_ON_OFF : out std_logic;
        LED_DOOR : out std_logic;
        ANOZI : out std_logic_vector (3 downto 0);
        CATOZI : out std_logic_vector (6 downto 0)
    );
end main;
architecture Behavioral of main is
    component mpg is
        Port (
            btn : in std_logic;
            clk : in std_logic;
            debounced : out std_logic
        );
    end component;
    
    signal debounced_reset : std_logic;
    signal debounced_start : std_logic;
    signal debounced_confirm : std_logic;
    
    component UE is
        Port (  
            clk : in std_logic;
            reset : in std_logic;
            optiune_mod : in std_logic;
            optiune_automat: in std_logic_vector(2 downto 0);
            optiune_temperatura : in std_logic_vector (1 downto 0);
            optiune_prespalare : in std_logic;
            optiune_clatire : in std_logic;
            optiune_viteza : in std_logic_vector (1 downto 0);
            enable_counter_1_min : in std_logic;
            selectie_mux_ssd : in std_logic;
            fin_counter_1_min : out std_logic;
            enable_counter_spalare : in std_logic;
            load_counter: in std_logic;
            fin_counter: out std_logic;
            catodes: out std_logic_vector (6 downto 0);
            anodes: out std_logic_vector (3 downto 0)
        );
    end component;

    component UC is
        Port (  
            clk : in std_logic;
            reset : in std_logic;
            start : in std_logic;
            confirm : in std_logic;
            fin_counter : in std_logic;
            fin_counter_1_min : in std_logic;
            enable_counter : out std_logic;
            enable_counter1min : out std_logic;
            led_on_off : out std_logic;
            led_door : out std_logic;
            selectie_mux_ssd : out std_logic;
            load_counter : out std_logic
        );
    end component;

    
    signal FIN_COUNTER : std_logic;
    signal FIN_COUNTER_1_MIN : std_logic;
    signal ENABLE_COUNTER : std_logic;
    signal ENABLE_COUNTER1MIN : std_logic;
    signal LOAD_COUNTER : std_logic; 
    signal SELECTIE_MUX_SSD : std_logic;
begin
    debouncer_reset: mpg port map (btn => RESET, clk => CLOCK, debounced => debounced_reset);
    debouncer_start: mpg port map (btn => START, clk => CLOCK, debounced => debounced_start);
    debouncer_confirm: mpg port map (btn => CONFIRM, clk => CLOCK, debounced => debounced_confirm);
    
    unit_executie : UE port map (
        clk => CLOCK,
        reset => debounced_reset,
        optiune_mod => OPTIUNE_MOD,
        optiune_automat => ADRESA_MOD_AUTO,
        optiune_temperatura => ADRESA_TEMPERATURA,
        optiune_prespalare => ADRESA_PRESPALARE,
        optiune_clatire => ADRESA_CLATIRE,
        optiune_viteza => ADRESA_VITEZA,
        enable_counter_1_min => ENABLE_COUNTER1MIN,
        selectie_mux_ssd => SELECTIE_MUX_SSD,
        fin_counter_1_min => FIN_COUNTER_1_MIN,
        enable_counter_spalare => ENABLE_COUNTER,
        load_counter => LOAD_COUNTER,
        fin_counter => FIN_COUNTER,
        catodes => CATOZI,
        anodes => ANOZI
    );
    unit_control : UC  port map (
        clk => CLOCK,
        reset => debounced_reset,
        start => start,
        confirm => confirm,
        fin_counter => FIN_COUNTER,
        fin_counter_1_min => FIN_COUNTER_1_MIN,
        enable_counter => ENABLE_COUNTER,
        enable_counter1min => ENABLE_COUNTER1MIN,
        led_on_off => LED_ON_OFF,
        led_door => LED_DOOR,
        selectie_mux_ssd => SELECTIE_MUX_SSD,
        load_counter => LOAD_COUNTER
    );
end Behavioral;
