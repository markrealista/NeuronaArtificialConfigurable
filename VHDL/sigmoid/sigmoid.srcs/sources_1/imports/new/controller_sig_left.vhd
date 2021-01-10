----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2020 23:59:06
-- Design Name: 
-- Module Name: controller_sig_left - Behavioral
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

entity controller_sig_left is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           left_start : in STD_LOGIC;
           done_mult : in STD_LOGIC;
           ctrl_left : out STD_LOGIC_VECTOR (2 downto 0);
           mult_start : out STD_LOGIC;
           load_left : out STD_LOGIC;
           left_ready : out STD_LOGIC);
end controller_sig_left;

architecture Behavioral of controller_sig_left is

type state_type is (e1a, e1b, e2a, e2b, e3a, e3b, e4a, e4b, e5a, e5b);
signal state_reg, state_next: state_type;

begin

process(clk)
begin
    if rising_edge(clk) then
        state_reg <= state_next;
    end if;
end process;

process(state_reg, reset, left_start, done_mult)
begin
--Default values
state_next <= e1a;
ctrl_left <= "111";
mult_start <= '0';
load_left <= '0';
left_ready <= '0';

case state_reg is
    when e1a =>
        if (reset = '0') then
            if (left_start = '1') then 
                ctrl_left <= "000";
                mult_start <= '1';
                state_next <= e1b;
            end if;
        end if;
    when e1b =>
        ctrl_left <= "000";
        if (reset = '0') then
            if (done_mult = '1') then 
                load_left <= '1';
                state_next <= e2a;
            else
                state_next <= e1b;   
            end if;
        end if;
        
    when e2a =>
        if (reset = '0') then
            ctrl_left <= "001";
            mult_start <= '1';
            state_next <= e2b;
        end if;
    when e2b =>
        ctrl_left <= "001";
        if (reset = '0') then
            if (done_mult = '1') then 
                load_left <= '1';
                state_next <= e3a;
            else
                state_next <= e2b;   
            end if;
        end if;       
        
    when e3a =>
        if (reset = '0') then
            ctrl_left <= "010";
            mult_start <= '1';
            state_next <= e3b;
        end if;
    when e3b =>
        ctrl_left <= "010";
        if (reset = '0') then
            if (done_mult = '1') then 
                load_left <= '1';
                state_next <= e4a;
            else
                state_next <= e3b;   
            end if;
        end if;      
        
    when e4a =>
        if (reset = '0') then
            ctrl_left <= "011";
            mult_start <= '1';
            state_next <= e4b;
        end if;
    when e4b =>
        ctrl_left <= "011";
        if (reset = '0') then
            if (done_mult = '1') then 
                load_left <= '1';
                state_next <= e5a;
            else
                state_next <= e4b;   
            end if;
        end if;  
           
     when e5a =>
        if (reset = '0') then
            ctrl_left <= "100";
            mult_start <= '1';
            state_next <= e5b;
        end if;
    when e5b =>
        ctrl_left <= "100";
        if (reset = '0') then
            if (done_mult = '1') then 
                load_left <= '1';
                left_ready <= '1';
            else
                state_next <= e5b;   
            end if;
        end if;        
end case;
end process;

end Behavioral;
