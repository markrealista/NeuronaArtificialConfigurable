----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2020 01:10:11
-- Design Name: 
-- Module Name: dp_sig_right - Behavioral
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

entity dp_sig_right is
    Port ( ctrl_right : in STD_LOGIC_VECTOR (2 downto 0);
           sum : in signed (M-1 downto 0);
           sal_mux1 : out signed (M-1 downto 0);
           sal_mux2 : out signed (M-1 downto 0));
end dp_sig_right;

architecture Behavioral of dp_sig_right is

component mux_right port (
    en1 : in signed (M-1 downto 0);
    en2 : in signed (M-1 downto 0);
    en3 : in signed (M-1 downto 0);
    en4 : in signed (M-1 downto 0);
    ctrl_right : in STD_LOGIC_VECTOR (2 downto 0);
    sal : out signed (M-1 downto 0));
end component;

begin

MUX_RIGHT_1 : mux_right port map (
    en1 => "1111111111101",
    en2 => sum(M-1 downto 0),
    en3 => sum(M-1 downto 0),
    en4 => sum(M-1 downto 0),
    ctrl_right => ctrl_right,
    sal => sal_mux1);

MUX_RIGHT_3 : mux_right port map (
    en1 => "0000000111010", 
    en2 => "1111001000011",
    en3 => "0011001001001",
    en4 => "0011011011010", 
    ctrl_right => ctrl_right,
    sal => sal_mux2);

end Behavioral;
