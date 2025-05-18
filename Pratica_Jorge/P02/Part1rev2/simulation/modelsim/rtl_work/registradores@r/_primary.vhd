library verilog;
use verilog.vl_types.all;
entity registradoresR is
    generic(
        n               : integer := 16
    );
    port(
        RegEntrada      : in     vl_logic_vector;
        RIn             : in     vl_logic;
        Clock           : in     vl_logic;
        RegSaida        : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of n : constant is 1;
end registradoresR;
