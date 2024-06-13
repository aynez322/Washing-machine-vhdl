library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.STD_LOGIC_arith.ALL;

entity rom_prespalare is
Port (addr_prespalare : in std_logic; 
      data_prespalare : out std_logic_vector (7 downto 0));
end rom_prespalare;

architecture Behavioral of rom_prespalare is
type rom_vector_p is array (0 to 1) of std_logic_vector(7 downto 0);
signal rom_mem_prespalare : rom_vector_p := ("00000000","00001010");
begin
data_prespalare <= rom_mem_prespalare(conv_integer(addr_prespalare));
end Behavioral;
