----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.10.2020 02:23:47
-- Design Name: 
-- Module Name: PISO_N - Behavioral
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

entity PISO_N is
    Port ( b : in STD_LOGIC_VECTOR (N-1 downto 0);
           bi: out STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           load : in STD_LOGIC);
end PISO_N;

architecture Behavioral of PISO_N is

signal b_next, b_reg : STD_LOGIC_VECTOR (N-1 downto 0);

begin

--Register logic
process(clk)
begin
    if (clk'event and clk='1') then 
        if (reset='1') then
            b_reg <= (others => '0');
        else
            b_reg <= b_next;
        end if;
    end if;
end process;

--Next state logic
process(load, b, b_reg)
begin
    if (load='1') then
        b_next <= b;
    else
        b_next <= '0'&b_reg(N-1 downto 1);
    end if;
end process;

--b_next <= b when load='1' else 
--           '0'&b_reg(N-1 downto 1);

--Output logic
bi <= b_reg(0);

end Behavioral;