----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.10.2020 02:23:48
-- Design Name: 
-- Module Name: PISO_M - Behavioral
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

entity PISO_M is
    Port ( a : in STD_LOGIC_VECTOR (M-1 downto 0);
           ai: out STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           load : in STD_LOGIC);
end PISO_M;

architecture Behavioral of PISO_M is

signal a_next, a_reg : STD_LOGIC_VECTOR (M-1 downto 0) := (others => '0');

begin

--Register logic
process(clk)
begin
    if (clk'event and clk='1') then 
        if (reset='1') then
            a_reg <= (others => '0');
        else
            a_reg <= a_next;
        end if;
    end if;
end process;

--Next state logic
process(load, a, a_reg)
begin
    if (load='1') then
        a_next <= a;
    else
        a_next <= '0'&a_reg(M-1 downto 1);
    end if;
end process;

--a_next <= a when load='1' else 
--           '0'&a_reg(M-1 downto 1);

--Output logic
ai <= a_reg(0);

end Behavioral;