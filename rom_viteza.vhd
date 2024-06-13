library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_1164.ALL;

entity rom_viteza is
Port (addr_viteza: in std_logic_vector (1 downto 0); 
      data_viteza: out std_logic_vector (7 downto 0));
end rom_viteza;

architecture Behavioral of rom_viteza is
type rom_vector_v is array (0 to 3) of std_logic_vector (7 downto 0);
signal rom_mem_viteza: rom_vector_v := ("00000000","00000101","00001010","00001111");
begin
data_viteza <= rom_mem_viteza(conv_integer(addr_viteza));
end Behavioral;
