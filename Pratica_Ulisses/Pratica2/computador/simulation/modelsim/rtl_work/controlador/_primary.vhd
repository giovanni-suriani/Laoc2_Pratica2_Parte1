library verilog;
use verilog.vl_types.all;
entity controlador is
    port(
        \in\            : in     vl_logic_vector(9 downto 0);
        run             : in     vl_logic;
        resetn          : in     vl_logic;
        cont            : in     vl_logic_vector(2 downto 0);
        G_out           : in     vl_logic_vector(15 downto 0);
        clear           : out    vl_logic;
        done            : out    vl_logic;
        mux_selector    : out    vl_logic_vector(3 downto 0);
        regs_in         : out    vl_logic_vector(12 downto 0);
        ula_op          : out    vl_logic_vector(2 downto 0);
        incr_pc         : out    vl_logic;
        W_D             : out    vl_logic
    );
end controlador;
