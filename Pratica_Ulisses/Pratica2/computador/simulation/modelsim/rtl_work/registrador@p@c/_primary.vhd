library verilog;
use verilog.vl_types.all;
entity registradorPC is
    port(
        clock           : in     vl_logic;
        R_in            : in     vl_logic;
        incr_pc         : in     vl_logic;
        \in\            : in     vl_logic_vector(15 downto 0);
        resetn          : in     vl_logic;
        \out\           : out    vl_logic_vector(15 downto 0)
    );
end registradorPC;
