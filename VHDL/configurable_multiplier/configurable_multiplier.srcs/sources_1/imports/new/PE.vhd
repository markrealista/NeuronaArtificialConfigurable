----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.10.2020 23:25:00
-- Design Name: 
-- Module Name: PE - Behavioral
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

entity PE is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           ca : in STD_LOGIC;
           cb : in STD_LOGIC;
           sin : in STD_LOGIC;
           sout : out STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC);
end PE;

architecture Behavioral of PE is

component FF_D port (
    d : in STD_LOGIC;
    q : out STD_LOGIC := '0'; --Necesario para que las señales no sean undefined
    clk : in STD_LOGIC;
    reset : in STD_LOGIC);
end component;

component and2 port (
    a : in STD_LOGIC;
    b : in STD_LOGIC;
    s : out STD_LOGIC);
end component;

component xor3 port (
    a : in STD_LOGIC;
    b : in STD_LOGIC;
    c : in STD_LOGIC;
    s : out STD_LOGIC);
end component;

component full_adder port (
    a : in STD_LOGIC;
    b : in STD_LOGIC;
    cin : in STD_LOGIC;
    s : out STD_LOGIC;
    cout : out STD_LOGIC);
end component;

signal and2_out, xor3_out, ff_cout, ff_sin, fa_cout : STD_LOGIC := '0';

begin

U_AND2 : and2 port map (
    a => a,
    b => b,
    s => and2_out);

U_XOR3 : xor3 port map (
    a => and2_out,
    b => ca,
    c => cb,
    s => xor3_out);

FA_PE : full_adder port map (
    a => xor3_out,
    b => ff_sin,
    cin => ff_cout,
    s => sout,
    cout => fa_cout);

FF_D_SIN : FF_D port map (
    d => sin,
    q => ff_sin,
    clk => clk,
    reset => reset);

FF_D_COUT : FF_D port map (
    d => fa_cout,
    q => ff_cout,
    clk => clk,
    reset => reset);

end Behavioral;
