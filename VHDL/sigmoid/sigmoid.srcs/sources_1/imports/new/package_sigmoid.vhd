----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.12.2020 13:18:17
-- Design Name: 
-- Module Name: package_sigmoid - Behavioral
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

package package_sigmoid is
constant M : integer := 13;
constant N : integer := 8;
constant P : integer := N + M;
constant ctrl_size : integer := 2;

constant sum_size : integer := 14;
constant mult_max : integer := 17;
constant mult_min : integer := 5;
end package_sigmoid;
