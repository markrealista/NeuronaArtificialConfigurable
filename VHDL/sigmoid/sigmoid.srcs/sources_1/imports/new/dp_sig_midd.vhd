----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2020 1M-1:35:4M-1
-- Design Name: 
-- Module Name: dp_sig_midd - Behavioral
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

entity dp_sig_midd is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           ctrl_midd : in STD_LOGIC_VECTOR (2 downto 0);
           mult : in signed (M-1 downto 0);
           sum : in signed (M-1 downto 0);
           sal_mux1 : out signed (M-1 downto 0);
           sal_mux2 : out signed (M-1 downto 0);
           load_midd : in STD_LOGIC);
end dp_sig_midd;

architecture Behavioral of dp_sig_midd is

component mux_midd port (
    en1 : in signed (M-1 downto 0);
    en2 : in signed (M-1 downto 0);
    en3 : in signed (M-1 downto 0);
    en4 : in signed (M-1 downto 0);
    en5 : in signed (M-1 downto 0);
    ctrl_midd : in STD_LOGIC_VECTOR (2 downto 0);
    sal : out signed (M-1 downto 0));
end component;

component registro port (
    d : in signed (M-1 downto 0);
    q : out signed (M-1 downto 0) := (others => '0'); --Necesario para que las señales no sean undefined
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    load : in STD_LOGIC);
end component;

signal sal_reg : signed (M-1 downto 0) := (others => '0');

begin

MUX_MIDD_1 : mux_midd port map (
    en1 => "0000000001001", -- +1/480
    en2 => sal_reg,
    en3 => sum,
    en4 => sal_reg,
    en5 => sum,
    ctrl_midd => ctrl_midd,
    sal => sal_mux1);

REG_2 : registro port map (
    d => mult,
    q => sal_reg,
    clk => clk,
    reset => reset,
    load => load_midd);
    
MUX_MIDD_2 : mux_midd port map (
    en1 => (others => '0'),
    en2 => "1111110101011", -- -1/48
    en3 => (others => '0'),
    en4 => "0010000000000", -- +1/4
    en5 => "0100000000000", -- +1/2
    ctrl_midd => ctrl_midd,
    sal => sal_mux2);

end Behavioral;
