----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.12.2020 19:30:29
-- Design Name: 
-- Module Name: shifter_out - Behavioral
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

entity shifter_out is
    Port ( paralel_in : in STD_LOGIC_VECTOR (P+P+P+P-1 downto 0);
           serial_out : out STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           load : in STD_LOGIC);
end shifter_out;

architecture Behavioral of shifter_out is

signal reg_state, next_state : STD_LOGIC_VECTOR (P+P+P+P-1 downto 0);

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

next_state <= paralel_in when load='1' else 
              '0'&reg_state(P+P+P+P-1 downto 1);

serial_out <= reg_state(0);

end Behavioral;
