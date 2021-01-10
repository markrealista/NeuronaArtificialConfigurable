----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.12.2020 21:48:39
-- Design Name: 
-- Module Name: sig_mux_2 - Behavioral
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

entity sig_mux_2 is
    Port ( left : in STD_LOGIC;
           midd : in STD_LOGIC;
           right : in STD_LOGIC;
           sig_ctrl : in STD_LOGIC_VECTOR (1 downto 0);
           sig_mux_out : out STD_LOGIC);
end sig_mux_2;

architecture Behavioral of sig_mux_2 is

begin

sig_mux_out <= left when sig_ctrl = "10" else
               midd when sig_ctrl = "11" else
               right when sig_ctrl = "01" else
               '0';
           
end Behavioral;
