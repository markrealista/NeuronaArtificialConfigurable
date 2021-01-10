----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.12.2020 19:09:50
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
use work.package_CM.all;

entity top is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           start : in STD_LOGIC;
           entrada : in STD_LOGIC;
           ctrl : in STD_LOGIC_VECTOR (ctrl_size-1 downto 0);
           load : in STD_LOGIC;
           salida : out STD_LOGIC; 
           done : out STD_LOGIC);
end top;

architecture Behavioral of top is

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

component shifter_in port (
    serial_in : in STD_LOGIC;
    paralel_out : out STD_LOGIC_VECTOR (M+M+N+N-1 downto 0);
    clk : in STD_LOGIC;
    reset : in STD_LOGIC);
end component;

component shifter_out port (
    paralel_in : in STD_LOGIC_VECTOR (P+P+P+P-1 downto 0);
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

signal paralel_out_aux : STD_LOGIC_VECTOR (M+M+N+N-1 downto 0);
signal q3_aux, q2_aux, q1_aux, q0_aux : STD_LOGIC_VECTOR (P-1 downto 0);
signal q_out : STD_LOGIC_VECTOR (P+P+P+P-1 downto 0);
signal clk_out1_aux : STD_LOGIC;

begin
q_out <= q3_aux&q2_aux&q1_aux&q0_aux;

Uclk_mod: clk_mod port map(
    clk_in1 => clk,
    reset => '0',
    locked => open,
    clk_out1 => clk_out1_aux);

CM : configurable_multiplier port map (
    b => paralel_out_aux(M+N+M+N-1 downto M+N+M),
    a => paralel_out_aux(M+N+M-1 downto M+N),
    cb => paralel_out_aux(M+N-1 downto M),
    ca => paralel_out_aux(M-1 downto 0),
    q3 => q3_aux,
    q2 => q2_aux,
    q1 => q1_aux,
    q0 => q0_aux,
    ctrl => ctrl,
    clk => clk_out1_aux,
    reset => reset,
    start => start,
    done => done);

SIN : shifter_in port map (
    serial_in => entrada,
    paralel_out => paralel_out_aux,
    clk => clk_out1_aux,
    reset => reset);
    
SOUT : shifter_out port map (
    paralel_in => q_out,
    serial_out => salida,
    reset => reset,
    clk => clk_out1_aux,
    load => load);

end Behavioral;
