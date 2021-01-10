----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.10.2020 13:14:52
-- Design Name: 
-- Module Name: configurable_multiplier_tb - Behavioral
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

entity configurable_multiplier_tb is
--  Port ( );
end configurable_multiplier_tb;

architecture Behavioral of configurable_multiplier_tb is

component configurable_multiplier port (
    a : in STD_LOGIC_VECTOR (M-1 downto 0);
    b : in STD_LOGIC_VECTOR (N-1 downto 0);
    ca : in STD_LOGIC_VECTOR (M-1 downto 0);
    cb : in STD_LOGIC_VECTOR (N-1 downto 0);
    q3 : out STD_LOGIC_VECTOR (P-1 downto 0);
    q2 : out STD_LOGIC_VECTOR (P-1 downto 0);
    q1 : out STD_LOGIC_VECTOR (P-1 downto 0);
    q0 : out STD_LOGIC_VECTOR (P-1 downto 0);
    ctrl : in STD_LOGIC_VECTOR (ctrl_size-1 downto 0);
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    start : in STD_LOGIC;
    done : out STD_LOGIC);
end component;

signal a : STD_LOGIC_VECTOR (M-1 downto 0);
signal b :  STD_LOGIC_VECTOR (N-1 downto 0);
signal ca : STD_LOGIC_VECTOR (M-1 downto 0);
signal cb : STD_LOGIC_VECTOR (N-1 downto 0);
signal q3 :  STD_LOGIC_VECTOR (P-1 downto 0);
signal q2 :  STD_LOGIC_VECTOR (P-1 downto 0);
signal q1 :  STD_LOGIC_VECTOR (P-1 downto 0);
signal q0 :  STD_LOGIC_VECTOR (P-1 downto 0);
signal ctrl : STD_LOGIC_VECTOR (ctrl_size-1 downto 0);
signal clk : STD_LOGIC;
signal reset : STD_LOGIC;
signal start : STD_LOGIC;
signal done : STD_LOGIC;

constant clk_period : time := 1 ns;

begin

UUT : configurable_multiplier port map (
    a => a,     
    b => b,     
    ca => ca,    
    cb => cb,    
    q3 => q3,   
    q2 => q2,    
    q1 => q1,    
    q0 => q0,    
    ctrl => ctrl,  
    clk => clk,   
    reset => reset, 
    start => start,
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
a <= "0111111111";
b <= "1000000000000000"; 
ca <= "1000000000";
cb <= "1000000000000000";
ctrl <= "00";
reset <= '0';
start <= '1'; wait for 1.5 ns; start <= '0'; 
wait for 6 ns;
start <= '1'; wait for 4 ns; start <= '0'; 
wait for 2 ns;
--reset <= '1'; wait for 1 ns; reset <= '0';
wait for 2 ns;
start <= '1'; wait for 1 ns; start <= '0';
wait;
end process;

--process 
--begin
--a <= "0010";
--b <= "00001110"; 
--ca <= "1000";
--cb <= "10000000";
--ctrl <= "01";
--reset <= '0';
--start <= '1';
--wait for 4.5 ns;
--start <= '0';
--wait for 20.5ns;
----reset <= '1';
--wait for 1 ns;
--reset <= '0';
--start <= '1';
--wait for 5.5 ns;
--start <= '0';
--wait;
--end process;

end Behavioral;