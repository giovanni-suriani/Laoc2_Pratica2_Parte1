library verilog;
use verilog.vl_types.all;
entity contador3Bits is
    port(
        clear           : in     vl_logic;
        clock           : in     vl_logic;
        run             : in     vl_logic;
        Q               : out    vl_logic_vector(2 downto 0)
    );
end contador3Bits;
