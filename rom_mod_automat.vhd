library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.STD_LOGIC_arith.ALL;

entity rom_mod_automat is
Port (addr_automat: in std_logic_vector(2 downto 0);
      data_automat: out std_logic_vector (7 downto 0));
end rom_mod_automat;

architecture Behavioral of rom_mod_automat is
type rom_vector_a is array(0 to 7) of std_logic_vector(7 downto 0);
signal rom_mem_automat :  rom_vector_a := ("00101000", "00101101", "00110010", "00110010","00110100","00000000","00000000","00000000");
begin
data_automat <= rom_mem_automat(conv_integer(addr_automat));
end Behavioral;
