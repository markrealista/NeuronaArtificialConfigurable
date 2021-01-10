----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.12.2020 00:33:54
-- Design Name: 
-- Module Name: sigmoid_tb - Behavioral
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

entity sigmoid_tb is
--  Port ( );
end sigmoid_tb;

architecture Behavioral of sigmoid_tb is

component sigmoid port (
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    x : in signed (N-1 downto 0);
    start : in STD_LOGIC;
    sig_out : out signed (M-1 downto 0);
    sig_ready : out STD_LOGIC;
    ca : in STD_LOGIC_VECTOR (M-1 downto 0);
    cb : in STD_LOGIC_VECTOR (N-1 downto 0);
    ctrl : in STD_LOGIC_VECTOR (ctrl_size-1 downto 0));
end component;

signal clk : STD_LOGIC;
signal reset : STD_LOGIC;
signal x : signed (N-1 downto 0) := "10000000";
signal start : STD_LOGIC:='0';
signal sig_out : signed (M-1 downto 0);
signal sig_ready : STD_LOGIC;
signal ca : STD_LOGIC_VECTOR (M-1 downto 0) := "1000000000000";
signal cb : STD_LOGIC_VECTOR (N-1 downto 0) := "10000000";
signal ctrl : STD_LOGIC_VECTOR (ctrl_size-1 downto 0) := "01";

constant clk_period : time := 1 ns;

begin

UUT: sigmoid port map (
    clk => clk,
    reset => reset,
    x => x,
    start => start, 
    sig_out => sig_out,
    sig_ready => sig_ready,
    ca => ca,
    cb => cb,
    ctrl => ctrl);

clk_process :process
begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
end process;

process
begin
reset <= '1';
wait for 1.5ns;
reset <= '0';
wait;
end process;

process
begin
wait for 160ns;
start <= '1';
wait for 1ns;
start <= '0';
x <= x + 2;
end process;

end Behavioral;
