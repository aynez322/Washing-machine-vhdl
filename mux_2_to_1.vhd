library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_2_to_1 is
Port (I0: in std_logic_vector (7 downto 0);
      I1: in std_logic_vector (7 downto 0);
      selectie: in std_logic;
      output: out std_logic_vector(7 downto 0));
end mux_2_to_1;

architecture Behavioral of mux_2_to_1 is

begin
    process(I0,I1,selectie)
        begin
            case selectie is
                when '0' =>
                    output<=I0;
                when '1' =>
                    output<=I1;
                when others =>
                    output<="00000000";
                end case;
    end process;
end Behavioral;
