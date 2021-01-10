----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.10.2020 23:23:03
-- Design Name: 
-- Module Name: FF_D - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FF_D is
    Port ( d : in STD_LOGIC;
           q : out STD_LOGIC := '0'; --Necesario para que las señales no sean undefined
           clk : in STD_LOGIC;
           reset : in STD_LOGIC);
end FF_D;

architecture Behavioral of FF_D is

begin

process(clk)
begin
    if (clk'event and clk ='1') then
        if (reset='1') then
            q <= '0';
        else
            q <= d;
        end if;
    end if;
end process;

end Behavioral;
