-------------------------------------------------------------------------------
-- Title      : Testbench for design "led_test"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : led_test_tb.vhd
-- Author     : Mike Zamansky  <zamansky@gmail.com>
-- Company    : 
-- Created    : 2018-01-07
-- Last update: 2018-01-07
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2018 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2018-01-07  1.0      slkim_nvme	Created
-------------------------------------------------------------------------------

library std,ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use std.env.all;

-------------------------------------------------------------------------------

entity led_test_tb is

end entity led_test_tb;

-------------------------------------------------------------------------------

architecture bhv of led_test_tb is

  -- component generics
  constant NUM_COUNT : natural := 2;

  -- component ports
  signal rst_n : std_logic:='0';
  signal led0       : std_logic;

  -- clock
  signal Clk : std_logic := '1';

begin  -- architecture bhv

  -- component instantiation
  DUT: entity work.led_test
    generic map (
      NUM_COUNT => NUM_COUNT)
    port map (
      clk   => clk,
      rst_n => rst_n,
      led0  => led0);

  -- clock generation
  Clk <= not Clk after 10 ns;

  -- waveform generation
  WaveGen_Proc: process
  begin
    -- insert signal assignments here
    wait until Clk = '1';
    wait until Clk = '1';
    rst_n <= '1';
    wait for 800 ns;
    stop(1);
  end process WaveGen_Proc;

  process(clk)
    variable my_line: line;
  begin
    if(rising_edge(clk))then
      write(my_line, now);
      write(my_line, string'("  led0: "));
      write(my_line, led0);
      writeline(output, my_line);
    end if;
  end process;

end architecture bhv;

-------------------------------------------------------------------------------

configuration led_test_tb_bhv_cfg of led_test_tb is
  for bhv
  end for;
end led_test_tb_bhv_cfg;

-------------------------------------------------------------------------------
