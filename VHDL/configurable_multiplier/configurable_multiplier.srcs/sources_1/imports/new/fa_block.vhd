----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.10.2020 12:09:00
-- Design Name: 
-- Module Name: fa_block - Behavioral
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

entity fa_block is
    Port ( sin : in STD_LOGIC;
           ca : in STD_LOGIC;
           cb : in STD_LOGIC;
           q : out STD_LOGIC_VECTOR (P-1 downto 0);
           done_sipo : in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC);
end fa_block;

architecture Behavioral of fa_block is

component full_adder port (
    a : in STD_LOGIC;
    b : in STD_LOGIC;
    cin : in STD_LOGIC;
    s : out STD_LOGIC;
    cout : out STD_LOGIC);
end component;

component FF_D port (
    d : in STD_LOGIC;
    q : out STD_LOGIC := '0';
    clk : in STD_LOGIC;
    reset : in STD_LOGIC);
end component;

component SIPO port (
    qi : in STD_LOGIC;
    q : out STD_LOGIC_VECTOR (P-1 downto 0);
    done_sipo : in STD_LOGIC;
    done : out STD_LOGIC;
    clk : in STD_LOGIC;
    reset : in STD_LOGIC);
end component;

--Señales de salida de los sumadores de Ca y Cb
signal ff_cout_ca, fa_cout_ca, fa_ca_out : STD_LOGIC := '0'; 
signal ff_cout_cb, fa_cout_cb, fa_cb_out : STD_LOGIC := '0';

begin

FA_CA : full_adder port map (
    a => ca,
    b => sin,
    cin => ff_cout_ca,
    s => fa_ca_out,
    cout => fa_cout_ca);

FA_CB : full_adder port map (
    a => cb,
    b => fa_ca_out,
    cin => ff_cout_cb,
    s => fa_cb_out,
    cout => fa_cout_cb);

FF_D_CA : FF_D port map (
    d => fa_cout_ca,
    q => ff_cout_ca,
    clk => clk,
    reset => reset);

FF_D_CB : FF_D port map (
    d => fa_cout_cb,
    q => ff_cout_cb,
    clk => clk,
    reset => reset);

SIPO_Q : SIPO port map (
    qi => fa_cb_out,
    q => q,
    done => open,
    done_sipo => done_sipo,
    clk => clk,
    reset => reset);

end Behavioral;
