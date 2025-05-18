library verilog;
use verilog.vl_types.all;
entity ULA is
    generic(
        ld              : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi0, Hi0);
        st              : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi0, Hi1);
        mvnz            : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi1, Hi0);
        mv              : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi1, Hi1);
        mvi             : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi0, Hi0);
        add             : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi0, Hi1);
        sub             : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi1, Hi0);
        \OR\            : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi1, Hi1);
        slt             : vl_logic_vector(0 to 3) := (Hi1, Hi0, Hi0, Hi0);
        \sll\           : vl_logic_vector(0 to 3) := (Hi1, Hi0, Hi0, Hi1);
        slr             : vl_logic_vector(0 to 3) := (Hi1, Hi0, Hi1, Hi0)
    );
    port(
        A               : in     vl_logic_vector(15 downto 0);
        B               : in     vl_logic_vector(15 downto 0);
        Opcode          : in     vl_logic_vector(3 downto 0);
        ResultadoULA    : out    vl_logic_vector(15 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of ld : constant is 1;
    attribute mti_svvh_generic_type of st : constant is 1;
    attribute mti_svvh_generic_type of mvnz : constant is 1;
    attribute mti_svvh_generic_type of mv : constant is 1;
    attribute mti_svvh_generic_type of mvi : constant is 1;
    attribute mti_svvh_generic_type of add : constant is 1;
    attribute mti_svvh_generic_type of sub : constant is 1;
    attribute mti_svvh_generic_type of \OR\ : constant is 1;
    attribute mti_svvh_generic_type of slt : constant is 1;
    attribute mti_svvh_generic_type of \sll\ : constant is 1;
    attribute mti_svvh_generic_type of slr : constant is 1;
end ULA;
