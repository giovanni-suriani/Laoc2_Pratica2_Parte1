library verilog;
use verilog.vl_types.all;
entity mux is
    port(
        DIN             : in     vl_logic_vector(15 downto 0);
        R0Saida         : in     vl_logic_vector(15 downto 0);
        R1Saida         : in     vl_logic_vector(15 downto 0);
        R2Saida         : in     vl_logic_vector(15 downto 0);
        R3Saida         : in     vl_logic_vector(15 downto 0);
        R4Saida         : in     vl_logic_vector(15 downto 0);
        R5Saida         : in     vl_logic_vector(15 downto 0);
        R6Saida         : in     vl_logic_vector(15 downto 0);
        R7Saida         : in     vl_logic_vector(15 downto 0);
        GSaida          : in     vl_logic_vector(15 downto 0);
        ROut            : in     vl_logic_vector(7 downto 0);
        GOut            : in     vl_logic;
        DINOut          : in     vl_logic;
        MuxSaida        : out    vl_logic_vector(15 downto 0)
    );
end mux;
