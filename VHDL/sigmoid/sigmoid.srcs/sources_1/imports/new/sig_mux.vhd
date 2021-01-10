----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.12.2020 15:06:40
-- Design Name: 
-- Module Name: sig_mux - Behavioral
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

entity sig_mux is
    Port ( left : in signed (M-1 downto 0);
           midd : in signed (M-1 downto 0);
           right : in signed (M-1 downto 0);
           sig_ctrl : in STD_LOGIC_VECTOR (1 downto 0);
           sig_mux_out : out signed (M-1 downto 0));
end sig_mux;

architecture Behavioral of sig_mux is

begin

sig_mux_out <= left when sig_ctrl = "10" else
               midd when sig_ctrl = "11" else
               right when sig_ctrl = "01" else
               (others => '0');

end Behavioral;
