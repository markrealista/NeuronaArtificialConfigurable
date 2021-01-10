----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.12.2020 21:06:24
-- Design Name: 
-- Module Name: top - Behavioral
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

entity top is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           start : in STD_LOGIC;        
           ctrl : in STD_LOGIC_VECTOR (ctrl_size-1 downto 0);
           load : in STD_LOGIC;
           entrada: in STD_LOGIC;
           salida : out STD_LOGIC; 
           sig_ready : out STD_LOGIC);
end top;

architecture Behavioral of top is

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

component shifter_in port (
    serial_in : in STD_LOGIC;
    paralel_out : out STD_LOGIC_VECTOR (M+N+N-1 downto 0);
    clk : in STD_LOGIC;
    reset : in STD_LOGIC);
end component;

component shifter_out port (
    paralel_in : in signed (M-1 downto 0);
    serial_out : out STD_LOGIC;
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    load : in STD_LOGIC);
end component;

component clk_mod
     Port ( clk_in1 : in STD_LOGIC;
            reset : in STD_LOGIC;
            locked : out STD_LOGIC;
            clk_out1 : out STD_LOGIC);
end component;

signal paralel_out_aux : STD_LOGIC_VECTOR (M+N+N-1 downto 0);
signal sig_out_aux : signed (M-1 downto 0);
signal clk_out1_aux : STD_LOGIC;

begin

Uclk_mod: clk_mod port map(
    clk_in1 => clk,
    reset => '0',
    locked => open,
    clk_out1 => clk_out1_aux);

SIG : sigmoid port map (
    clk => clk_out1_aux,
    reset => reset,
    x => signed(paralel_out_aux(M+N+N-1 downto M+N)),
    start => start,
    sig_out => sig_out_aux,
    sig_ready => sig_ready,
    ca => paralel_out_aux(M+N-1 downto N),
    cb => paralel_out_aux(N-1 downto 0),
    ctrl => ctrl);

SIN : shifter_in port map (
    serial_in => entrada,
    paralel_out => paralel_out_aux,
    clk => clk_out1_aux,
    reset => reset);
    
SOUT : shifter_out port map (
    paralel_in => sig_out_aux,
    serial_out => salida,
    reset => reset,
    clk => clk_out1_aux,
    load => load);

end Behavioral;
