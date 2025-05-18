library verilog;
use verilog.vl_types.all;
entity registrador is
    port(
        clock           : in     vl_logic;
        R_in            : in     vl_logic;
        \in\            : in     vl_logic_vector(15 downto 0);
        \out\           : out    vl_logic_vector(15 downto 0)
    );
end registrador;
