----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.10.2020 03:16:54
-- Design Name: 
-- Module Name: SIPO - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
use work.package_CM.all;

entity SIPO is
    Port ( qi : in STD_LOGIC;
           q : out STD_LOGIC_VECTOR (P-1 downto 0);
           done_sipo : in STD_LOGIC;
           done : out STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC);
end SIPO;

architecture Behavioral of SIPO is

signal q_next, q_reg : STD_LOGIC_VECTOR (P-1 downto 0) := (others => '0');

begin

--Register logic
process(clk)
begin
    if rising_edge(clk) then
        if (reset='1') then
            q_reg <= (others => '0');
        else
            q_reg <= q_next;
        end if;
    end if;
end process;

--Next state logic
process(qi, q_reg, done_sipo)
begin
--Default values 
q_next <= q_reg;
done <= '0';
    if (done_sipo = '0') then
        q_next <= qi & q_reg(P-1 downto 1);  
    else
        done <= '1';
    end if;
end process;

----Output logic
--done <= '1' when n_reg>3 else
--        '0'; 
q <= q_reg;

end Behavioral;
