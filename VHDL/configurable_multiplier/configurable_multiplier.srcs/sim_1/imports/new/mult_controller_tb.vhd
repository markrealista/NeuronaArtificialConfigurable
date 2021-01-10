----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.11.2020 19:20:15
-- Design Name: 
-- Module Name: mult_controller_tb - Behavioral
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

entity mult_controller_tb is
--  Port ( );
end mult_controller_tb;

architecture Behavioral of mult_controller_tb is

component mult_controller port (
    done_pipo : out STD_LOGIC;
    done_sipo : out STD_LOGIC;
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    start : in STD_LOGIC;
    load : out STD_LOGIC);
end component;

signal done_pipo : STD_LOGIC;
signal done_sipo : STD_LOGIC;
signal clk : STD_LOGIC;
signal reset : STD_LOGIC;
signal start : STD_LOGIC;
signal load : STD_LOGIC;

constant clk_period : time := 1 ns;

begin

UUT: mult_controller port map (
    done_pipo => done_pipo,
    done_sipo => done_sipo,
    clk => clk,
    reset => reset,
    start => start,
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
reset <= '0';
start <= '1'; wait for 1.5 ns; start <= '0'; 
wait for 12 ns;
start <= '1'; wait for 4 ns; start <= '0'; 
wait for 2 ns;
reset <= '1'; wait for 5 ns; reset <= '0';
wait for 2 ns;
start <= '1'; wait for 1 ns; start <= '0';
wait;
end process;

end Behavioral;
