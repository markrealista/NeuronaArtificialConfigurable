----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2020 01:10:11
-- Design Name: 
-- Module Name: controller_sig_right - Behavioral
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

entity controller_sig_right is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           right_start : in STD_LOGIC;
           done_mult : in STD_LOGIC;
           ctrl_right : out STD_LOGIC_VECTOR (2 downto 0);
           mult_start : out STD_LOGIC;
           load_right : out STD_LOGIC;
           right_ready : out STD_LOGIC);
end controller_sig_right;

architecture Behavioral of controller_sig_right is

type state_type is (e1a, e1b, e2a, e2b, e3a, e3b, e4a, e4b, e5a, e5b);
signal state_reg, state_next: state_type;

begin

process(clk)
begin
    if rising_edge(clk) then
        state_reg <= state_next;
    end if;
end process;

process(state_reg, reset, right_start, done_mult)
begin
--Default values
state_next <= e1a;
ctrl_right <= "111";
mult_start <= '0';
load_right <= '0';
right_ready <= '0';

case state_reg is
    when e1a =>
        if (reset = '0') then
            if (right_start = '1') then 
                ctrl_right <= "000";
                mult_start <= '1';
                state_next <= e1b;
            end if;
        end if;
    when e1b =>
        ctrl_right <= "000";
        if (reset = '0') then
            if (done_mult = '1') then 
                load_right <= '1';
                state_next <= e2a;
            else
                state_next <= e1b;   
            end if;
        end if;
        
    when e2a =>
        if (reset = '0') then
            ctrl_right <= "001";
            mult_start <= '1';
            state_next <= e2b;
        end if;
    when e2b =>
        ctrl_right <= "001";
        if (reset = '0') then
            if (done_mult = '1') then 
                load_right <= '1';
                state_next <= e3a;
            else
                state_next <= e2b;   
            end if;
        end if;       
        
    when e3a =>
        if (reset = '0') then
            ctrl_right <= "010";
            mult_start <= '1';
            state_next <= e3b;
        end if;
    when e3b =>
        ctrl_right <= "010";
        if (reset = '0') then
            if (done_mult = '1') then 
                load_right <= '1';
                state_next <= e4a;
            else
                state_next <= e3b;   
            end if;
        end if;      
        
    when e4a =>
        if (reset = '0') then
            ctrl_right <= "011";
            mult_start <= '1';
            state_next <= e4b;
        end if;
    when e4b =>
        ctrl_right <= "011";
        if (reset = '0') then
            if (done_mult = '1') then 
                load_right <= '1';
                state_next <= e5a;
            else
                state_next <= e4b;   
            end if;
        end if;  
           
     when e5a =>
        if (reset = '0') then
            ctrl_right <= "100";
            mult_start <= '1';
            state_next <= e5b;
        end if;
    when e5b =>
        ctrl_right <= "100";
        if (reset = '0') then
            if (done_mult = '1') then 
                load_right <= '1';
                right_ready <= '1';
            else
                state_next <= e5b;   
            end if;
        end if;        
end case;
end process;

end Behavioral;
