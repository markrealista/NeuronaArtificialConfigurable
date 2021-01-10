----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.10.2020 01:49:22
-- Design Name: 
-- Module Name: PE_tb - Behavioral
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

entity PE_tb is
--  Port ( );
end PE_tb;

architecture Behavioral of PE_tb is

component PE port (
    a : in STD_LOGIC;
    b : in STD_LOGIC;
    ca : in STD_LOGIC;
    cb : in STD_LOGIC;
    sin : in STD_LOGIC;
    sout : out STD_LOGIC;
    clk : in STD_LOGIC;
    reset : in STD_LOGIC);
end component;

signal a : STD_LOGIC;
signal b : STD_LOGIC;
signal ca : STD_LOGIC;
signal cb : STD_LOGIC;
signal sin : STD_LOGIC;
signal sout : STD_LOGIC;
signal clk : STD_LOGIC;
signal reset : STD_LOGIC;

constant clk_period : time := 1 ns;

begin

UUT: PE port map (
ai => ai, 
bi => bi, 
cai => cai, 
cbi => cbi, 
sin => sin, 
sout => sout, 
clk => clk, 
reset => reset);

clk_process :process
begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
end process;

process
begin
a <= '1';
b <= '1';
ca <= '0';
cb <= '0';
sin <= '0';
reset <= '0';
wait;
end process;

end Behavioral;
