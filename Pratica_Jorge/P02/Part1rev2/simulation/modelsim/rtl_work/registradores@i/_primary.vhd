library verilog;
use verilog.vl_types.all;
entity registradoresI is
    generic(
        n               : integer := 10
    );
    port(
        InstEntrada     : in     vl_logic_vector;
        IRIn            : in     vl_logic;
        Clock           : in     vl_logic;
        InstSaida       : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of n : constant is 1;
end registradoresI;
