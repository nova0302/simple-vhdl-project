library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity led_test is
  generic (NUM_COUNT : natural := 2);
  port (
    clk, rst_n : in  std_logic;
    led0       : out std_logic);
end entity led_test;

architecture bhv of led_test is
begin  -- architecture bhv
  counter_proc : process (clk, rst_n) is
    variable count_r : integer range 0 to 2**NUM_COUNT-1;
    variable led0_r  : std_logic;
  begin  -- process counter_proc
    if rst_n = '0' then                 -- asynchronous reset (active low)
      count_r := 0;
      led0_r  := '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      if count_r = 2**NUM_COUNT-1 then
        count_r := 0;
        led0_r  := not led0_r;
      else
        count_r := count_r + 1;
      end if;
    end if;
    led0 <= led0_r;
  end process counter_proc;
end architecture bhv;
