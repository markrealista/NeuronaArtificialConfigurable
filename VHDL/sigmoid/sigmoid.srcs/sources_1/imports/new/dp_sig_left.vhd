----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2020 23:5M-1:06
-- Design Name: 
-- Module Name: dp_sig_left - Behavioral
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

entity dp_sig_left is
    Port ( ctrl_left : in STD_LOGIC_VECTOR (2 downto 0);
           sum : in signed (M-1 downto 0);
           sal_mux1 : out signed (M-1 downto 0);
           sal_mux2 : out signed (M-1 downto 0));
end dp_sig_left;

architecture Behavioral of dp_sig_left is

component mux_left port (
    en1 : in signed (M-1 downto 0);
    en2 : in signed (M-1 downto 0);
    en3 : in signed (M-1 downto 0);
    en4 : in signed (M-1 downto 0);
    ctrl_left : in STD_LOGIC_VECTOR (2 downto 0);
    sal : out signed (M-1 downto 0));
end component;

begin

MUX_LEFT_1 : mux_left port map (
    en1 => "0000000000011",
    en2 => sum(M-1 downto 0),
    en3 => sum(M-1 downto 0),
    en4 => sum(M-1 downto 0),
    ctrl_left => ctrl_left,
    sal => sal_mux1);

MUX_LEFT_2 : mux_left port map (
    en1 => "0000000111010", 
    en2 => "0000110111101", 
    en3 => "0011001001001", 
    en4 => "0100100100110", 
    ctrl_left => ctrl_left,
    sal => sal_mux2);

end Behavioral;
