----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2020 23:01:5M-1
-- Design Name: 
-- Module Name: sigmoid - Behavioral
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

entity sigmoid is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           x : in signed (N-1 downto 0);
           start : in STD_LOGIC;
           sig_out : out signed (M-1 downto 0);
           sig_ready : out STD_LOGIC;
           ca : in STD_LOGIC_VECTOR (M-1 downto 0);
           cb : in STD_LOGIC_VECTOR (N-1 downto 0);
           ctrl : in STD_LOGIC_VECTOR (ctrl_size-1 downto 0));
end sigmoid;

architecture Behavioral of sigmoid is

component sig_left port (
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    left_start : in STD_LOGIC;
    done_mult : in STD_LOGIC;
    sum : in signed (M-1 downto 0);
    mult_start : out STD_LOGIC;
    sal_mux1 : out signed (M-1 downto 0);
    sal_mux2 : out signed (M-1 downto 0);
    load_left : out STD_LOGIC;
    left_ready : out STD_LOGIC);
end component;

component sig_midd port (
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    midd_start : in STD_LOGIC;
    done_mult : in STD_LOGIC;
    mult : in signed (M-1 downto 0);
    sum : in signed (M-1 downto 0);
    mult_start : out STD_LOGIC;
    sal_mux1 : out signed (M-1 downto 0);
    sal_mux2 : out signed (M-1 downto 0);
    load_midd : out STD_LOGIC;
    midd_ready : out STD_LOGIC);
end component;

component sig_right port (
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    right_start : in STD_LOGIC;
    done_mult : in STD_LOGIC;
    sum : in signed (M-1 downto 0);
    mult_start : out STD_LOGIC;
    sal_mux1 : out signed (M-1 downto 0);
    sal_mux2 : out signed (M-1 downto 0);
    load_right : out STD_LOGIC;
    right_ready : out STD_LOGIC);
end component;

component sigmoid_controller port (
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    start : in STD_LOGIC;
    left_ready : in STD_LOGIC;
    midd_ready : in STD_LOGIC;
    right_ready : in STD_LOGIC;
    left_start : out STD_LOGIC;
    midd_start : out STD_LOGIC;
    right_start : out STD_LOGIC;
    sig_ctrl : out STD_LOGIC_VECTOR (1 downto 0);
    x_in : in signed (N-1 downto 0);
    x_out : out signed (N-1 downto 0) := (others => '0');
    y : in signed (M-1 downto 0);
    sig_out : out signed (M-1 downto 0) := (others => '0');
    sig_ready : out STD_LOGIC);
end component;

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

component sig_mux port (
    left : in signed (M-1 downto 0);
    midd : in signed (M-1 downto 0);
    right : in signed (M-1 downto 0);
    sig_ctrl : in STD_LOGIC_VECTOR (1 downto 0);
    sig_mux_out : out signed (M-1 downto 0));
end component;

component sig_mux_2 port (
    left : in STD_LOGIC;
    midd : in STD_LOGIC;
    right : in STD_LOGIC;
    sig_ctrl : in STD_LOGIC_VECTOR (1 downto 0);
    sig_mux_out : out STD_LOGIC);
end component;

component registro port (
    d : in signed (M-1 downto 0);
    q : out signed (M-1 downto 0) := (others => '0'); --Necesario para que las señales no sean undefined
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    load : in STD_LOGIC);
end component;

--Señales del controlador
signal midd_start_aux, left_start_aux, right_start_aux : STD_LOGIC := '0';
signal midd_ready_aux, left_ready_aux, right_ready_aux : STD_LOGIC := '0';
signal sig_ctrl_aux : STD_LOGIC_VECTOR (1 downto 0) := (others => '0');
signal x_out_aux : signed (N-1 downto 0) := (others => '0');
--Seañales de salida de los bloques SL, SM y SR
signal midd_mux_mult, left_mux_mult, right_mux_mult : signed (M-1 downto 0) := (others => '0');
signal midd_mux_sum, left_mux_sum, right_mux_sum : signed (M-1 downto 0) := (others => '0');
signal mult_start_midd, mult_start_left, mult_start_right : STD_LOGIC := '0';
signal load_register_midd, load_register_left, load_register_right : STD_LOGIC := '0';
--Seañales de salida de los multiplexores
signal mux_mult_out, mux_sum_out : signed (M-1 downto 0) := (others => '0');
signal mux_start_out, mux_load_out : STD_LOGIC := '0';
--Señales de suma
signal s_out_aux : signed (sum_size-1 downto 0) := (others => '0');
signal reg_s_out : signed (M-1 downto 0) := (others => '0');
--Señales del multiplicador
signal q3_aux, q2_aux, q1_aux, q0_aux : STD_LOGIC_VECTOR (P-1 downto 0) := (others => '0');
signal done_aux : STD_LOGIC := '0';

begin
s_out_aux <= ('0'&signed(q0_aux(mult_max downto mult_min))) + ('0'&mux_sum_out);

CONTROLLER_SIGMOID : sigmoid_controller port map (
    clk => clk,
    reset => reset,
    start => start,
    left_ready => left_ready_aux,
    midd_ready => midd_ready_aux,
    right_ready => right_ready_aux,
    left_start => left_start_aux,
    midd_start => midd_start_aux,
    right_start => right_start_aux,
    sig_ctrl => sig_ctrl_aux,
    x_in => x,
    x_out => x_out_aux,
    y => reg_s_out,
    sig_out => sig_out,
    sig_ready => sig_ready);

SIGMOID_LEFT : sig_left port map (
    clk => clk,
    reset => reset,
    left_start => left_start_aux,
    done_mult => done_aux,
    sum => reg_s_out,
    mult_start => mult_start_left,
    sal_mux1 => left_mux_mult,
    sal_mux2 => left_mux_sum,
    load_left => load_register_left,
    left_ready => left_ready_aux);

SIGMOID_MIDDLE : sig_midd port map (
    clk => clk,
    reset => reset,
    midd_start => midd_start_aux,
    done_mult => done_aux,
    mult => signed(q0_aux(mult_max downto mult_min)),
    sum => reg_s_out,
    mult_start => mult_start_midd,
    sal_mux1 => midd_mux_mult,
    sal_mux2 => midd_mux_sum,
    load_midd => load_register_midd,
    midd_ready => midd_ready_aux);

SIGMOID_RIGHT : sig_right port map (
    clk => clk,
    reset => reset,
    right_start => right_start_aux,
    done_mult => done_aux,
    sum => reg_s_out,
    mult_start => mult_start_right,
    sal_mux1 => right_mux_mult,
    sal_mux2 => right_mux_sum,
    load_right => load_register_right,
    right_ready => right_ready_aux);
    
CONFIG_MULTIPLIER : configurable_multiplier port map (
    a => std_logic_vector(mux_mult_out),
    b => std_logic_vector(x_out_aux),
    ca => ca,
    cb => cb,
    q3 => q3_aux,
    q2 => q2_aux,
    q1 => q1_aux,
    q0 => q0_aux,
    ctrl => ctrl,
    clk => clk,
    reset => reset,
    start => mux_start_out,
    done => done_aux);    
    
MUX_MULT : sig_mux port map (
    left => left_mux_mult,
    midd => midd_mux_mult,
    right => right_mux_mult,
    sig_ctrl => sig_ctrl_aux,
    sig_mux_out => mux_mult_out);

MUX_SUM : sig_mux port map (    
    left => left_mux_sum,
    midd => midd_mux_sum,
    right => right_mux_sum,
    sig_ctrl => sig_ctrl_aux,
    sig_mux_out => mux_sum_out);

MUX_START_MULT : sig_mux_2 port map (    
    left => mult_start_left,
    midd => mult_start_midd,
    right => mult_start_right,
    sig_ctrl => sig_ctrl_aux,
    sig_mux_out => mux_start_out);
    
MUX_LOAD_REGISTER : sig_mux_2 port map (    
    left => load_register_left,
    midd => load_register_midd,
    right => load_register_right,
    sig_ctrl => sig_ctrl_aux,
    sig_mux_out => mux_load_out);
    
REG_1 : registro port map (
    d => s_out_aux(M-1 downto 0),
    q => reg_s_out,
    clk => clk,
    reset => reset,
    load => mux_load_out);
    
end Behavioral;
