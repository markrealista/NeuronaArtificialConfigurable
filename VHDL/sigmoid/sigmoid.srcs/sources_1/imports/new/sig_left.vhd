----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2020 23:5M-1:06
-- Design Name: 
-- Module Name: sig_left - Behavioral
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

entity sig_left is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           left_start : in STD_LOGIC;
           done_mult : in STD_LOGIC;
           sum : in signed (M-1 downto 0);
           mult_start : out STD_LOGIC;
           sal_mux1 : out signed (M-1 downto 0);
           sal_mux2 : out signed (M-1 downto 0);
           load_left : out STD_LOGIC;
           left_ready : out STD_LOGIC);
end sig_left;

architecture Behavioral of sig_left is

component dp_sig_left port (
    ctrl_left : in STD_LOGIC_VECTOR (2 downto 0);
    sum : in signed (M-1 downto 0);
    sal_mux1 : out signed (M-1 downto 0);
    sal_mux2 : out signed (M-1 downto 0));
end component;

component controller_sig_left port (
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    left_start : in STD_LOGIC;
    done_mult : in STD_LOGIC;
    ctrl_left : out STD_LOGIC_VECTOR (2 downto 0);
    mult_start : out STD_LOGIC;
    load_left : out STD_LOGIC;
    left_ready : out STD_LOGIC);
end component;

signal ctrl_left_aux : STD_LOGIC_VECTOR (2 downto 0) := (others => '0');

begin

DATAPATH_SIGLEFT : dp_sig_left port map (
    ctrl_left => ctrl_left_aux,
    sum => sum,
    sal_mux1 => sal_mux1,
    sal_mux2 => sal_mux2);

CONTROLLER_SIGLEFT : controller_sig_left port map (
    clk => clk,
    reset  => reset,
    ctrl_left => ctrl_left_aux,
    left_ready => left_ready,
    left_start => left_start,
    mult_start => mult_start,
    done_mult => done_mult,
    load_left => load_left);

end Behavioral;
