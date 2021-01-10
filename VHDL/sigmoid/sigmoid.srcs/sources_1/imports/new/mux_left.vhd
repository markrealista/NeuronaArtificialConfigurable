----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2020 23:5M-1:06
-- Design Name: 
-- Module Name: mux_left - Behavioral
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

entity mux_left is
    Port ( en1 : in signed (M-1 downto 0);
           en2 : in signed (M-1 downto 0);
           en3 : in signed (M-1 downto 0);
           en4 : in signed (M-1 downto 0);
           ctrl_left : in STD_LOGIC_VECTOR (2 downto 0);
           sal : out signed (M-1 downto 0));
end mux_left;

architecture Behavioral of mux_left is

begin

sal <= en1 when ctrl_left = "000" else
       en2 when ctrl_left = "001" else
       en3 when ctrl_left = "010" else
       en4 when ctrl_left = "011" else
       (others => '0');

end Behavioral;
