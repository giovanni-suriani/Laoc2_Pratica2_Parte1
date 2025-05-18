library verilog;
use verilog.vl_types.all;
entity contadoresR is
    generic(
        n               : integer := 16
    );
    port(
        RegEntrada      : in     vl_logic_vector;
        RIn             : in     vl_logic;
        Clear           : in     vl_logic;
        Clock           : in     vl_logic;
        IncrPc          : in     vl_logic;
        RegSaida        : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of n : constant is 1;
end contadoresR;
