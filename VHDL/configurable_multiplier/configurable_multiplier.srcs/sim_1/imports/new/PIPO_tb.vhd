----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.11.2020 23:32:32
-- Design Name: 
-- Module Name: PIPO_tb - Behavioral
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

entity PIPO_tb is
--  Port ( );
end PIPO_tb;

architecture Behavioral of PIPO_tb is

component PIPO port (
    bin : in STD_LOGIC_VECTOR (N downto 0);
    bout : out STD_LOGIC_VECTOR (N downto 0);
    done_pipo : in STD_LOGIC;
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    load : in STD_LOGIC);
end component;

signal bin : STD_LOGIC_VECTOR (N downto 0);
signal bout : STD_LOGIC_VECTOR (N downto 0);
signal done_pipo : STD_LOGIC;
signal clk : STD_LOGIC;
signal reset : STD_LOGIC;
signal load : STD_LOGIC;

constant clk_period : time := 1 ns;

begin

UUT: PIPO port map (
    bin => bin,
    bout => bout,
    done_pipo => done_pipo,
    clk => clk,
    reset => reset,
    load => load);

clk_process :process
begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
end process;

process
begin
bin <= "1101";
reset <= '0';
load <= '1'; wait for 1.5 ns; load <= '0'; 
wait for 6 ns;
load <= '1'; wait for 4 ns; load <= '0'; 
wait for 2 ns;
reset <= '1'; wait for 1 ns; reset <= '0';
wait for 2 ns;
load <= '1'; wait for 1 ns; load <= '0';
wait;
end process;

end Behavioral;
