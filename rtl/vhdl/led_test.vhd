library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity led_test is
  generic (NUM_COUNT : natural := 24);
  port (
    clk : in  std_logic;
    btn : in  std_logic_vector(1 downto 0);
    led : out std_logic_vector(3 downto 0));
end entity led_test;

architecture bhv of led_test is
  component edge_detect is
    port (
      clk, async_in  : in  std_logic;
      rise_o, fall_o : out std_logic);
  end component edge_detect;

  alias rst    : std_logic is btn(1);
  signal stop  : std_logic;
  signal rst_n : std_logic;
-- Added stop, btn_dly and btn signals for debug using mark_debug attribute.
--  attribute mark_debug : string;
--  attribute keep : string;
--  attribute mark_debug of stop : signal is "true";
--  attribute mark_debug of btn_dly : signal is "true";
--  attribute mark_debug of btn : signal is "true";
--  COMPONENT ila_0
--PORT (
--      clk : IN STD_LOGIC;
--      probe0 : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
--      probe1 : IN STD_LOGIC_VECTOR(3 DOWNTO 0)
--);
--END component  ;

  signal rise, fall : std_logic;
begin  -- architecture bhv

--debug: ila_0 PORT map (
--      clk => clk,
--      probe0 => btn,
--      probe1 => led
--);
  rst_n <= not rst;
  --rst_n <= not btn(1);
  edge_detect_1 : entity work.edge_detect
    port map (
      clk      => clk,
      async_in => btn(0),
      rise_o   => rise,
      fall_o   => fall);

  edge_detect_p : process (clk, rst_n) is
  begin  -- process edge_detect_p
    if rst_n = '0' then
      stop <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      if rise = '1' then
        stop <= not stop;
      end if;
    end if;
  end process edge_detect_p;

  counter_proc : process (clk, rst_n) is
    variable count_r : integer range 0 to 2**NUM_COUNT-1;
    variable led_r   : unsigned(3 downto 0);
  begin  -- process counter_proc
    if rst_n = '0' then                 -- asynchronous reset (active low)
      count_r := 0;
      led_r   := (others => '0');
      led     <= (others => '0');
    elsif clk'event and clk = '1' then  -- rising clock edge
      if stop = '0' then
        if count_r = 2**NUM_COUNT-1 then
          count_r := 0;
          if (led_r = x"F") then
            led_r := (others => '0');
          else
            led_r := led_r + 1;
          end if;
        else
          count_r := count_r + 1;
        end if;
      end if;
      led <= std_logic_vector(led_r);
    end if;
  end process counter_proc;

end architecture bhv;
