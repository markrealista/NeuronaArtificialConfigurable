----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2020 22:37:28
-- Design Name: 
-- Module Name: sigmoid_controller - Behavioral
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

entity sigmoid_controller is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           start : in STD_LOGIC;
           left_ready : in STD_LOGIC;
           midd_ready : in STD_LOGIC;
           right_ready : in STD_LOGIC;
           left_start : out STD_LOGIC;
           midd_start : out STD_LOGIC;
           right_start : out STD_LOGIC;
           sig_ctrl : out STD_LOGIC_VECTOR (1 downto 0);
           x_in : in signed (N-1 downto 0);
           x_out : out signed (N-1 downto 0) := (others => '0');
           y : in signed (M-1 downto 0);
           sig_out : out signed (M-1 downto 0) := (others => '0');
           sig_ready : out STD_LOGIC);
end sigmoid_controller;

architecture Behavioral of sigmoid_controller is

type state_type is (idle, check, left, right, middle);
signal state_reg, state_next: state_type;
signal x_reg, x_next : signed (N-1 downto 0) := (others => '0');

begin

process(clk)
begin
    if rising_edge(clk) then
        state_reg <= state_next;
        x_reg <= x_next;
    end if;
end process;

process(state_reg, reset, start, x_in, x_reg, left_ready, right_ready, midd_ready, y)
begin
--Default values
state_next <= idle;
x_next <= x_reg;
sig_ctrl <= "00";
left_start <= '0';
midd_start <= '0';
right_start <= '0';
sig_out <= (others => '0');
sig_ready <= '0';

case state_reg is
    when idle =>
        x_out <= x_reg;
        x_next <= x_in;
        sig_ctrl <= "00";
        if (reset='0') then
            if (start='1') then
                state_next <= check;
            end if;
        end if;
        
    when check => 
        x_out <= x_reg;
        if (reset='0') then
            if (x_reg<="11010000") then
                sig_ctrl <= "10";
                left_start <= '1';
                state_next <= left;
            elsif (x_reg>="00110000") then 
                sig_ctrl <= "01";
                right_start <= '1';
                state_next <= right;
            else 
                sig_ctrl <= "11";
                midd_start <= '1';
                state_next <= middle;
            end if;
        end if;
        
    when left =>
        x_out <= x_reg;
        sig_ctrl <= "10";
        if (reset='0') then
            if (left_ready='1') then
                sig_out <= y;
                sig_ready <= '1';
                sig_ctrl <= "00";
                state_next <= idle;
            else
                state_next <= left;  
            end if;
        end if;
        
    when right =>
        x_out <= x_reg;
        sig_ctrl <= "01";
        if (reset='0') then
            if (right_ready='1') then
                sig_out <= y;
                sig_ready <= '1';
                sig_ctrl <= "00";
                state_next <= idle;  
            else
                state_next <= right;        
            end if;
        end if;
        
    when middle =>
        x_out <= x_reg;
        sig_ctrl <= "11";
        if (reset='0') then
            if (midd_ready='1') then
                sig_out <= y;
                sig_ready <= '1';
                sig_ctrl <= "00";
                state_next <= idle;
            else
                state_next <= middle;
            end if;
        end if;
end case;
end process;

end Behavioral;
