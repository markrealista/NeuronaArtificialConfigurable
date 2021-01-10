----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.10.2020 18:57:05
-- Design Name: 
-- Module Name: configurable_multiplier - Behavioral
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

entity configurable_multiplier is
    Port ( a : in STD_LOGIC_VECTOR (M-1 downto 0);
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
end configurable_multiplier;

architecture Behavioral of configurable_multiplier is

component mult_controller port (
    done_pipo : out STD_LOGIC;
    done_sipo : out STD_LOGIC;
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    start : in STD_LOGIC;
    load : out STD_LOGIC;
    done : out STD_LOGIC);
end component;

component PISO_M port (
    a : in STD_LOGIC_VECTOR (M-1 downto 0);
    ai : out STD_LOGIC;
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    load : in STD_LOGIC);
end component;

component PISO_N port (
    b : in STD_LOGIC_VECTOR (N-1 downto 0);
    bi : out STD_LOGIC;
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    load : in STD_LOGIC);
end component;

component PIPO is port ( 
    bin : in STD_LOGIC_VECTOR (N-1 downto 0);
    bout : out STD_LOGIC_VECTOR (N-1 downto 0);
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    load : in STD_LOGIC;
    done_pipo : in STD_LOGIC);
end component;

component bit4_multiplier_PEs port (
    a : in STD_LOGIC;
    b : in STD_LOGIC_VECTOR (3 downto 0);
    ca : in STD_LOGIC;
    cb : in STD_LOGIC_VECTOR (3 downto 0);
    sout : out STD_LOGIC;
    sin : in STD_LOGIC;
    clk : in STD_LOGIC;
    reset : in STD_LOGIC);
end component;

component mux_select port (
    a : in STD_LOGIC;
    b : in STD_LOGIC;
    c : in STD_LOGIC;
    ctrl : in STD_LOGIC_VECTOR (ctrl_size-1 downto 0);
    s : out STD_LOGIC);
end component; 

component fa_block port (
    sin : in STD_LOGIC;
    ca : in STD_LOGIC;
    cb : in STD_LOGIC;
    q : out STD_LOGIC_VECTOR (P-1 downto 0);
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    done_sipo : in STD_LOGIC);
end component;

--Señales de salida de los PISO
signal ai_aux, cai_aux, cbi_aux : STD_LOGIC := '0';
--Señales de salida de los PIPO
signal b_aux, cb_aux : STD_LOGIC_VECTOR (N-1 downto 0) := (others => '0');
--Señales de salida de los bit4_multiplier_PEs
signal sout12, sout8, sout4, sout0 : STD_LOGIC := '0';
--Señales de salida de los multiplexores
signal mux12, mux12_ca, mux8, mux8_ca, mux4, mux4_ca : STD_LOGIC := '0';
--Señales de salida del controlador
signal done_pipo_aux, done_sipo_aux, load_aux : STD_LOGIC := '0';

begin

CONTROLADOR : mult_controller port map (
    done_pipo => done_pipo_aux,
    done_sipo => done_sipo_aux,
    clk => clk,
    reset => reset,
    start => start,
    load => load_aux,
    done => done);

PISO_A : PISO_M port map (
    a => a,
    ai => ai_aux,
    clk => clk,
    reset => reset,
    load => load_aux);

PISO_CA : PISO_M port map (
    a => ca,
    ai => cai_aux,
    clk => clk,
    reset => reset,
    load => load_aux);
    
PIPO_B : PIPO port map (
    bin => b,
    bout => b_aux,
    clk => clk,
    reset => reset,
    load => load_aux,
    done_pipo => done_pipo_aux);
    
PIPO_CB : PIPO port map (
    bin => cb,
    bout => cb_aux,
    clk => clk,
    reset => reset,
    load => load_aux,
    done_pipo => done_pipo_aux);
    
PISO_CB : PISO_N port map (
    b => cb,
    bi => cbi_aux,
    clk => clk,
    reset => reset,
    load => load_aux);

BIT4_MUL_PES12 : bit4_multiplier_PEs port map (
    a => ai_aux,
    b => b_aux(15 downto 12),
    ca => cai_aux,
    cb => cb_aux(15 downto 12),
    sin => cai_aux,
    sout => sout12,
    clk => clk,
    reset => reset);

BIT4_MUL_PES8 : bit4_multiplier_PEs port map (
    a => ai_aux,
    b => b_aux(11 downto 8),
    ca => cai_aux,
    cb => cb_aux(11 downto 8),
    sin => mux12_ca,
    sout => sout8,
    clk => clk,
    reset => reset);

BIT4_MUL_PES4 : bit4_multiplier_PEs port map (
    a => ai_aux,
    b => b_aux(7 downto 4),
    ca => cai_aux,
    cb => cb_aux(7 downto 4),
    sin => mux8_ca,
    sout => sout4,
    clk => clk,
    reset => reset);

BIT4_MUL_PES0 : bit4_multiplier_PEs port map (
    a => ai_aux,
    b => b_aux(3 downto 0),
    ca => cai_aux,
    cb => cb_aux(3 downto 0),
    sin => mux4_ca,
    sout => sout0,
    clk => clk,
    reset => reset);

MUX_12 : mux_select port map (
    a => '0',
    b => '0',
    c => sout12,
    ctrl => ctrl,
    s => mux12);

MUX_12_CA : mux_select port map (
    a => sout12,
    b => sout12,
    c => cai_aux,
    ctrl => ctrl,
    s => mux12_ca);

MUX_8 : mux_select port map (
    a => '0',
    b => sout8,
    c => sout8,
    ctrl => ctrl,
    s => mux8);

MUX_8_CA : mux_select port map (
    a => sout8,
    b => cai_aux,
    c => cai_aux,
    ctrl => ctrl,
    s => mux8_ca);

MUX_4 : mux_select port map (
    a => '0',
    b => '0',
    c => sout4,
    ctrl => ctrl,
    s => mux4);

MUX_4_CA : mux_select port map (
    a => sout4,
    b => sout4,
    c => cai_aux,
    ctrl => ctrl,
    s => mux4_ca);

FAs_BLOCK12 : fa_block port map (
    sin => mux12,
    ca => cai_aux,
    cb => cbi_aux,
    q => q3,
    clk => clk,
    reset => reset,
    done_sipo => done_sipo_aux);

FAs_BLOCK8 : fa_block port map (
    sin => mux8,
    ca => cai_aux,
    cb => cbi_aux,
    q => q2,
    clk => clk,
    reset => reset,
    done_sipo => done_sipo_aux);

FAs_BLOCK4 : fa_block port map (
    sin => mux4,
    ca => cai_aux,
    cb => cbi_aux,
    q => q1,
    clk => clk,
    reset => reset,
    done_sipo => done_sipo_aux);

FAs_BLOCK0 : fa_block port map (
    sin => sout0,
    ca => cai_aux,
    cb => cbi_aux,
    q => q0,
    clk => clk,
    reset => reset,
    done_sipo => done_sipo_aux);

end Behavioral;
