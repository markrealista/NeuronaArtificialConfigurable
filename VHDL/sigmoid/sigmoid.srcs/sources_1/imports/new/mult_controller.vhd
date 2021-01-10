----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.11.2020 05:44:01
-- Design Name: 
-- Module Name: mult_controller - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
use work.package_CM.all;

entity mult_controller is
    Port ( done_pipo : out STD_LOGIC;
           done_sipo : out STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           start : in STD_LOGIC;
           load : out STD_LOGIC;
           done : out STD_LOGIC);
end mult_controller;

architecture Behavioral of mult_controller is

type state_type is (idle, shift);
signal state_reg, state_next : state_type;
signal n_reg, n_next : integer range 0 to 299 := 0;

begin

process(clk)
begin 
    if (clk'event and clk='1') then
        n_reg <= n_next;
        state_reg <= state_next;
    end if;
end process;

process(state_reg, reset, start, n_reg)
begin
--Default values
done_pipo <= '0';
done_sipo <= '0';
load <= '0';
n_next <= 0;
state_next <= idle;
done <= '0';

case state_reg is
    when idle =>
        done_sipo <= '1';
        if (reset='0') then
            if (start='1') then
                load <= '1';
                n_next <= n_reg + 1;
                state_next <= shift;
            end if;
        end if;
    when shift => 
        if (reset='0') then
            if (n_reg = M) then
                done_pipo <= '1';
                done_sipo <= '1';
            end if;
            if (n_reg <= P) then
                done_sipo <= '0';
                n_next <= n_reg + 1; 
                state_next <= shift;
            else
                done_sipo <= '1';
                n_next <= 0;
                done <= '1';
            end if;
        end if;
end case;
end process;

end Behavioral;
