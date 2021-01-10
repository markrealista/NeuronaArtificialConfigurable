----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.12.2020 19:02:15
-- Design Name: 
-- Module Name: shifter_in - Behavioral
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

entity shifter_in is
    Port ( serial_in : in STD_LOGIC;
           paralel_out : out STD_LOGIC_VECTOR (M+M+N+N-1 downto 0);
           clk : in STD_LOGIC;
           reset : in STD_LOGIC);
end shifter_in;

architecture Behavioral of shifter_in is

signal reg_state, next_state : STD_LOGIC_VECTOR (M+M+N+N-1 downto 0);

begin

process(clk)
begin
    if (clk'event and clk='1') then
        if (reset='1') then
           reg_state <= (others => '0'); 
        else 
            reg_state <= next_state;
        end if;
    end if;
end process;

next_state <= serial_in&reg_state(M+M+N+N-1 downto 1);

paralel_out <= reg_state;

end Behavioral;
