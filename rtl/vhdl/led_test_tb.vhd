-------------------------------------------------------------------------------
-- Title      : Testbench for design "led_test"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : led_test_tb.vhd
-- Author     : Mike Zamansky  <zamansky@gmail.com>
-- Company    : 
-- Created    : 2018-01-07
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
-- 2018-01-07  1.0      slkim_nvme      Created
-------------------------------------------------------------------------------

library std, ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use std.env.all;

entity led_test_tb is end entity led_test_tb;

architecture bhv of led_test_tb is
  -- component generics
  constant PERIOD    : time    := 20 ns;  -- system clock
  constant NUM_COUNT : natural := 2;

  signal btn : std_logic_vector(1 downto 0) := "11";
  signal led : std_logic_vector(3 downto 0);
  signal Clk : std_logic                    := '1';

  alias stop_s : std_logic is << signal .led_test_tb.DUT.stop : std_logic >>;
  --alias count_r : integer is << variable .led_test_tb.DUT.counter_proc.count_r : integer >>;

begin  -- architecture bhv

  -- component instantiation
  DUT : entity work.led_test
    generic map (NUM_COUNT => NUM_COUNT)
    port map (
      clk => clk,
      btn => btn,
      led => led);

  -- clock generation
  Clk <= not Clk after PERIOD/2;

  -- waveform generation
  WaveGen_Proc : process

    -- purpose: btn procedure
    --procedure onBtn (signal btn_o : out std_logic) is
    --begin  -- procedure onBtn
    --  wait until rising_edge(clk);
    --  btn_o <= '0';
    --  wait until rising_edge(clk);
    --  --wait for PERIOD;
    --  btn_o <= '1';
    --end procedure onBtn;

    procedure onBtn is
    begin  -- procedure onBtn
      wait until rising_edge(clk);
      btn(0) <= '0';
      wait until rising_edge(clk);
      --wait for PERIOD;
      btn(0) <= '1';
    end procedure onBtn;
  begin
    -- insert signal assignments here
    wait until Clk = '1';
    wait until Clk = '1';
    btn(1) <= '0';                      -- reset deassert
    wait for 10*PERIOD;
    --onBtn(btn(0));
    onBtn;
    wait for 10*PERIOD;
    --onBtn(btn(0));
    onBtn;
    wait for 10*PERIOD;
    stop(1);
  end process WaveGen_Proc;

  process(clk)
    variable my_line : line;
  begin
    if(rising_edge(clk))then
      write(my_line, now);
      write(my_line, string'("  rst_n: "));
      write(my_line, btn(1));
      --write(my_line, string'("  count_r: "));
      --write(my_line, count_r);
      write(my_line, string'("  stop_s: "));
      write(my_line, stop_s);
      write(my_line, string'("  btn(0): "));
      write(my_line, btn(0));
      write(my_line, string'("  led: "));
      write(my_line, led);
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
