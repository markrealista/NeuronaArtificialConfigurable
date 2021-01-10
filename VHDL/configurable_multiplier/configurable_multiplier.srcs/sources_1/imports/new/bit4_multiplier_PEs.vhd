----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.10.2020 19:17:45
-- Design Name: 
-- Module Name: bit4_multiplier_PEs - Behavioral
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

entity bit4_multiplier_PEs is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC_VECTOR (3 downto 0);
           ca : in STD_LOGIC;
           cb : in STD_LOGIC_VECTOR (3 downto 0);
           sin : in STD_LOGIC;
           sout : out STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC);
end bit4_multiplier_PEs;

architecture Behavioral of bit4_multiplier_PEs is

component PE port ( 
    a : in STD_LOGIC;
    b : in STD_LOGIC;
    ca : in STD_LOGIC;
    cb : in STD_LOGIC;
    sin : in STD_LOGIC;
    sout : out STD_LOGIC;
    clk : in STD_LOGIC;
    reset : in STD_LOGIC);
end component;

--Señales de salida de los PE
signal sout3, sout2, sout1 : STD_LOGIC := '0';

begin

PE3 : PE port map (
    a => a,
    b => b(3),
    ca => ca,
    cb => cb(3),
    sin => sin,
    sout => sout3,
    clk => clk,
    reset => reset);

PE2 : PE port map (
    a => a,
    b => b(2),
    ca => ca,
    cb => cb(2),
    sin => sout3,
    sout => sout2,
    clk => clk,
    reset => reset);

PE1 : PE port map (
    a => a,
    b => b(1),
    ca => ca,
    cb => cb(1),
    sin => sout2,
    sout => sout1,
    clk => clk,
    reset => reset);

PE0 : PE port map (
    a => a,
    b => b(0),
    ca => ca,
    cb => cb(0),
    sin => sout1,
    sout => sout,
    clk => clk,
    reset => reset);

end Behavioral;
