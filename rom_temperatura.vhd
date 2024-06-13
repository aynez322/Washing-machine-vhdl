library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.STD_LOGIC_arith.ALL;

entity rom_temperatura is
Port ( addr_temperatura: in std_logic_vector (1 downto 0);
       data_temperatura: out std_logic_vector (7 downto 0));
end rom_temperatura;

architecture Behavioral of rom_temperatura is
type rom_vector_t is array (0 to 3) of std_logic_vector (7 downto 0);
signal rom_mem_temperatura : rom_vector_t := ("00001111","00010100","00010110","00011001");
begin
data_temperatura <= rom_mem_temperatura(conv_integer (addr_temperatura));
end Behavioral;
