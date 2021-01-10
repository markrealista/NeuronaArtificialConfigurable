----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2020 01:10:11
-- Design Name: 
-- Module Name: sig_right - Behavioral
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

entity sig_right is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           right_start : in STD_LOGIC;
           done_mult : in STD_LOGIC;
           sum : in signed (M-1 downto 0);
           mult_start : out STD_LOGIC;
           sal_mux1 : out signed (M-1 downto 0);
           sal_mux2 : out signed (M-1 downto 0);
           load_right : out STD_LOGIC;
           right_ready : out STD_LOGIC);
end sig_right;

architecture Behavioral of sig_right is

component dp_sig_right port (
    ctrl_right : in STD_LOGIC_VECTOR (2 downto 0);
    sum : in signed (M-1 downto 0);
    sal_mux1 : out signed (M-1 downto 0);
    sal_mux2 : out signed (M-1 downto 0));
end component;

component controller_sig_right port (
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    right_start : in STD_LOGIC;
    done_mult : in STD_LOGIC;
    ctrl_right : out STD_LOGIC_VECTOR (2 downto 0);
    mult_start : out STD_LOGIC;
    load_right : out STD_LOGIC;
    right_ready : out STD_LOGIC);
end component;

signal ctrl_right_aux : STD_LOGIC_VECTOR (2 downto 0) := (others => '0');

begin

DATAPATH_SIGRIGHT : dp_sig_right port map (
    ctrl_right => ctrl_right_aux,
    sum => sum,
    sal_mux1 => sal_mux1,
    sal_mux2 => sal_mux2);

CONTROLLER_SIGRIGHT : controller_sig_right port map (
    clk => clk,
    reset  => reset,
    ctrl_right => ctrl_right_aux,
    right_ready => right_ready,
    right_start => right_start,
    mult_start => mult_start,
    done_mult => done_mult,
    load_right => load_right);

end Behavioral;
