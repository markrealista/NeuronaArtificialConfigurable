----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.10.2020 04:08:29
-- Design Name: 
-- Module Name: PISO_M_tb - Behavioral
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

entity PISO_M_tb is
--  Port ( );
end PISO_M_tb;

architecture Behavioral of PISO_M_tb is

component PISO_M port (
    a : in STD_LOGIC_VECTOR (M downto 0);
    ai : out STD_LOGIC;
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    start : in STD_LOGIC);
end component;

signal a : STD_LOGIC_VECTOR (M downto 0);
signal ai : STD_LOGIC;
signal clk : STD_LOGIC;
signal reset : STD_LOGIC;
signal start : STD_LOGIC;

constant clk_period : time := 1 ns;

begin

UUT: PISO_M port map (
a => a,
ai => ai,
clk => clk,
reset => reset,
start => start);

clk_process :process
begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
end process;

process
begin
a <= "1101";
reset <= '0';
start <= '1'; wait for 1.5 ns; start <= '0'; 
wait for 6 ns;
start <= '1'; wait for 4 ns; start <= '0'; 
wait for 2 ns;
reset <= '1'; wait for 1 ns; reset <= '0';
wait for 2 ns;
start <= '1'; wait for 1 ns; start <= '0';
wait;
end process;

end Behavioral;
