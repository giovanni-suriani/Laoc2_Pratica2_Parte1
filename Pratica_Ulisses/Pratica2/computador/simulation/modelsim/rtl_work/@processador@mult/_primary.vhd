library verilog;
use verilog.vl_types.all;
entity ProcessadorMult is
    port(
        clock           : in     vl_logic;
        resetn          : in     vl_logic;
        run             : in     vl_logic;
        DIN             : in     vl_logic_vector(15 downto 0);
        done            : out    vl_logic;
        ADDR_out        : out    vl_logic_vector(15 downto 0);
        DOUT_out        : out    vl_logic_vector(15 downto 0);
        W_out           : out    vl_logic;
        R0_out          : out    vl_logic_vector(15 downto 0);
        R1_out          : out    vl_logic_vector(15 downto 0);
        R2_out          : out    vl_logic_vector(15 downto 0);
        R3_out          : out    vl_logic_vector(15 downto 0);
        R4_out          : out    vl_logic_vector(15 downto 0);
        R5_out          : out    vl_logic_vector(15 downto 0);
        R7_out          : out    vl_logic_vector(15 downto 0);
        cont            : out    vl_logic_vector(2 downto 0)
    );
end ProcessadorMult;
