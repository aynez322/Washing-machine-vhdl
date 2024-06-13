library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity UE is
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
end UE;

architecture Behavioral of UE is

component counter_spalare is
    Port (
        data_spalare : in std_logic_vector (7 downto 0);
        enable_spalare: in std_logic;
        load_spalare : in std_logic;
        reset_spalare : in std_logic;
        clk : in std_logic;
        fin_cnt_spalare : out std_logic;
        num_spalare : out std_logic_vector (7 downto 0)
    );
end component;

component counter_1_min is
    Port (
        enable_1: in std_logic;
        reset_1 : in std_logic;
        clk : in std_logic;
        fin_cnt_1 : out std_logic;
        num_1_min : out std_logic_vector (7 downto 0)
    );
end component;

component mux_2_to_1 is
    Port (
        I0: in std_logic_vector (7 downto 0);
        I1: in std_logic_vector (7 downto 0);
        selectie: in std_logic;
        output: out std_logic_vector(7 downto 0)
    );
end component;

component rom_clatire is
    Port (
        addr_clatire: in std_logic; 
        data_clatire: out std_logic_vector (7 downto 0)
    );
end component;

component rom_mod_automat is
    Port (
        addr_automat: in std_logic_vector(2 downto 0);
        data_automat: out std_logic_vector (7 downto 0)
    );
end component;

component rom_prespalare is
    Port (
        addr_prespalare : in std_logic; 
        data_prespalare : out std_logic_vector (7 downto 0)
    );
end component;

component rom_temperatura is
    Port (
        addr_temperatura: in std_logic_vector (1 downto 0);
        data_temperatura: out std_logic_vector (7 downto 0)
    );
end component;

component rom_viteza is
    Port (
        addr_viteza: in std_logic_vector (1 downto 0); 
        data_viteza: out std_logic_vector (7 downto 0)
    );
end component;

component sumator_4_op is
    Port (
        clk : in std_logic;
        op1 : in std_logic_vector (7 downto 0);
        op2 : in std_logic_vector (7 downto 0);
        op3 : in std_logic_vector (7 downto 0);
        op4 : in std_logic_vector (7 downto 0);
        rezultat: out std_logic_vector (7 downto 0)
    );
end component;

component divizor_frq_1sec is
    Port (
        clk : in std_logic;
        reset : in std_logic;
        clk_1_sec : out std_logic
    );
end component;

component Hex_to_7seg is
    Port (
        clock_100Mhz : in STD_LOGIC;
        reset : in STD_LOGIC;
        hex : in STD_LOGIC_VECTOR(7 downto 0);
        cat : out STD_LOGIC_VECTOR(6 downto 0); 
        an : out STD_LOGIC_VECTOR(3 downto 0)
    );
end component;

signal d_automat : std_logic_vector (7 downto 0);
signal d_clatire : std_logic_vector (7 downto 0);
signal d_prespalare : std_logic_vector(7 downto 0);
signal d_temperatura : std_logic_vector (7 downto 0);
signal d_viteza : std_logic_vector (7 downto 0);
signal n_spalare : std_logic_vector (7 downto 0);
signal n_1_min : std_logic_vector (7 downto 0);
signal timp_spalare : std_logic_vector (7 downto 0);
signal clk1 : std_logic;
signal out_mux : std_logic_vector (7 downto 0);
signal out_mux_afisare : std_logic_vector (7 downto 0);
begin
div_frq: divizor_frq_1sec port map (clk, reset, clk1);

rom_automat: rom_mod_automat port map (optiune_automat, d_automat);
rom_temp: rom_temperatura port map (optiune_temperatura, d_temperatura);
rom_clt: rom_clatire port map (optiune_clatire, d_clatire);
rom_presp: rom_prespalare port map (optiune_prespalare, d_prespalare);
rom_vtz: rom_viteza port map (optiune_viteza, d_viteza);

sum: sumator_4_op port map (clk, d_temperatura, d_clatire, d_prespalare, d_viteza, timp_spalare);

mux2_1: mux_2_to_1 port map (d_automat, timp_spalare, optiune_mod, out_mux);

cnt_spalare: counter_spalare port map (out_mux, enable_counter_spalare, load_counter, reset, clk, fin_counter, n_spalare);
cnt_1_min: counter_1_min port map (enable_counter_1_min, reset, clk1, fin_counter_1_min, n_1_min);

selectie_afisare : mux_2_to_1 port map (n_spalare,n_1_min,selectie_mux_ssd,out_mux_afisare);
seven_segment: Hex_to_7seg port map (clk, reset, out_mux_afisare, catodes, anodes);

end Behavioral;
