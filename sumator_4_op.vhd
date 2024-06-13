library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.STD_LOGIC_arith.ALL;

entity sumator_4_op is
Port (clk : in std_logic;
      op1 : in std_logic_vector (7 downto 0);
      op2 : in std_logic_vector (7 downto 0);
      op3 : in std_logic_vector (7 downto 0);
      op4 : in std_logic_vector (7 downto 0);
      rezultat: out std_logic_vector (7 downto 0));
end sumator_4_op;

architecture Behavioral of sumator_4_op is
signal temp : std_logic_vector(7 downto 0) := "00000000";
begin
    process(clk,op1,op2,op3,op4)
        begin
           if rising_edge(clk) then
                temp <= op1+op2+op3+op4;
           end if;
    end process;
rezultat <= temp;
end Behavioral;
