----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.11.2020 12:30:54
-- Design Name: 
-- Module Name: PIPO - Behavioral
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

entity PIPO is
    Port ( bin : in STD_LOGIC_VECTOR (N-1 downto 0);
           bout : out STD_LOGIC_VECTOR (N-1 downto 0);
           done_pipo : in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           load : in STD_LOGIC);
end PIPO;

architecture Behavioral of PIPO is

signal b_next, b_reg : STD_LOGIC_VECTOR (N-1 downto 0) := (others => '0');

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
process(bin, done_pipo, b_reg, load)
begin
--Default values 
b_next <= b_reg;
    if (load='1' and done_pipo='0') then
        b_next <= bin;
    elsif (done_pipo='1') then
        b_next <= (others => '0'); 
    end if;
end process;

--b_next <= bin when (load='1' and done_pipo='0') else
--          b_reg when (load='0' and done_pipo='0') else
--          (others => '0');
                    
bout <= b_reg;

end Behavioral;