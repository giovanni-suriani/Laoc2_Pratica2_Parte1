library verilog;
use verilog.vl_types.all;
entity contadoresR is
    generic(
        n               : integer := 16
    );
    port(
        R               : in     vl_logic_vector;
        RIn             : in     vl_logic;
        Clear           : in     vl_logic;
        Clock           : in     vl_logic;
        Prox            : in     vl_logic;
        Q               : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of n : constant is 1;
end contadoresR;
