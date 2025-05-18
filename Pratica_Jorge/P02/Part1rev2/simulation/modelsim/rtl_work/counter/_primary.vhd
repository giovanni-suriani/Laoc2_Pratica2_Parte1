library verilog;
use verilog.vl_types.all;
entity counter is
    port(
        Clear           : in     vl_logic;
        Clock           : in     vl_logic;
        CounterSaida    : out    vl_logic_vector(2 downto 0)
    );
end counter;
