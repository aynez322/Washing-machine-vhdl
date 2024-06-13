library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_1164.ALL;

entity rom_clatire is
Port (addr_clatire: in std_logic; 
      data_clatire: out std_logic_vector (7 downto 0));
end rom_clatire;

architecture Behavioral of rom_clatire is
type rom_vector_c is array (0 to 1) of std_logic_vector(7 downto 0);
signal rom_mem_clatire : rom_vector_c := ("00000000","00001010");
begin
data_clatire <= rom_mem_clatire(conv_integer(addr_clatire));
end Behavioral;
