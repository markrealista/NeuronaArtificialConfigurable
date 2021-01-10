----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.12.2020 12:30:5M-1
-- Design Name: 
-- Module Name: registro - Behavioral
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
use work.package_sigmoid.all;

entity registro is
    Port ( d : in signed (M-1 downto 0);
           q : out signed (M-1 downto 0) := (others => '0'); --Necesario para que las señales no sean undefined
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           load : in STD_LOGIC);
end registro;

architecture Behavioral of registro is

begin

process(clk)
begin
    if (clk'event and clk='1') then
        if (reset='1') then
            q <= (others => '0');
        elsif (load='1') then
            q <= d;
        end if;
    end if;
end process;

end Behavioral;
