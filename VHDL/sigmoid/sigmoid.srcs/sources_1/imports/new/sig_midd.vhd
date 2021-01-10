----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.12.2020 12:11:3M-1
-- Design Name: 
-- Module Name: sig_midd - Behavioral
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

entity sig_midd is
    Port ( clk : in STD_LOGIC;
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
end sig_midd;

architecture Behavioral of sig_midd is

component dp_sig_midd port (
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    ctrl_midd : in STD_LOGIC_VECTOR (2 downto 0);
    mult : in signed (M-1 downto 0);
    sum : in signed (M-1 downto 0);
    sal_mux1 : out signed (M-1 downto 0);
    sal_mux2 : out signed (M-1 downto 0);
    load_midd : in STD_LOGIC);
end component;

component controller_sig_midd port (
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    midd_start : in STD_LOGIC;
    done_mult : in STD_LOGIC;
    ctrl_midd : out STD_LOGIC_VECTOR (2 downto 0);
    mult_start : out STD_LOGIC;
    load_midd : out STD_LOGIC;
    midd_ready : out STD_LOGIC);
end component;

signal ctrl_midd_aux : STD_LOGIC_VECTOR (2 downto 0) := (others => '0');
signal load_midd_aux : STD_LOGIC := '0';

begin

DATAPATH_SIGMIDD : dp_sig_midd port map (
    clk  => clk,
    reset => reset,
    ctrl_midd => ctrl_midd_aux,
    mult => mult,
    sum => sum,
    sal_mux1 => sal_mux1,
    sal_mux2 => sal_mux2,
    load_midd => load_midd_aux);

CONTROLLER_SIGMIDD : controller_sig_midd port map (
    clk => clk,
    reset  => reset,
    midd_start => midd_start,
    done_mult => done_mult,
    ctrl_midd => ctrl_midd_aux,
    mult_start => mult_start,
    load_midd => load_midd_aux,
    midd_ready => midd_ready);

load_midd <= load_midd_aux;

end Behavioral;
