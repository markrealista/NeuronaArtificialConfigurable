----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.10.2020 04:10:11
-- Design Name: 
-- Module Name: SIPO_tb - Behavioral
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

entity SIPO_tb is
--  Port ( );
end SIPO_tb;

architecture Behavioral of SIPO_tb is

component SIPO port (
    qi : in STD_LOGIC;
    q : out STD_LOGIC_VECTOR (P downto 0);
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    done : out STD_LOGIC);
end component;

signal qi : STD_LOGIC;
signal q : STD_LOGIC_VECTOR (P downto 0);
signal clk : STD_LOGIC;
signal reset : STD_LOGIC;
signal done : STD_LOGIC;

constant clk_period : time := 1 ns;

begin

UUT : SIPO port map (
qi => qi,
q => q, 
clk => clk,
reset => reset,
done => done);

clk_process :process
begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
end process;

process 
begin
qi <='0';
reset <= '0';
wait for 0.5 ns;
qi<='1';
wait for 1 ns;
qi <= '0';
wait for 1 ns; 
qi <= '1';
wait for 1 ns;
qi <= '1';
wait;
end process;

end Behavioral;
