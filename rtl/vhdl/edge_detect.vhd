-------------------------------------------------------------------------------
-- Title      : synchronizer and edge detect
-- Project    : 
-------------------------------------------------------------------------------
-- File       : edge_detect.vhd
-- Author     :   <nova0@DESKTOP-UVE1A1Q>
-- Company    : 
-- Created    : 2018-06-16
-- Last update: 2018-06-16
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2018 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2018-06-16  1.0      nova0   Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------

entity edge_detect is
  port (
    clk, async_in  : in  std_logic;
    rise_o, fall_o : out std_logic
    );
end entity edge_detect;

-------------------------------------------------------------------------------

architecture str of edge_detect is
  signal resync : std_logic_vector(2 downto 0);

begin  -- architecture str
  -- purpose: synchronize and edge detect
  -- type   : sequential
  -- inputs : clk, <reset>
  -- outputs: 
  edge_detect_p : process (clk) is
  begin  -- process edge_detect_p
    if clk'event and clk = '1' then     -- rising clock edge
      rise_o <= resync(1) and not resync(2);
      fall_o <= resync(2) and not resync(1);
      resync <= resync(1 downto 0) & async_in;
    end if;
  end process edge_detect_p;


end architecture str;

-------------------------------------------------------------------------------
