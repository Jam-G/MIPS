library verilog;
use verilog.vl_types.all;
entity WR is
    port(
        Rd_write_byte_en: in     vl_logic_vector(3 downto 0);
        RegWrite        : in     vl_logic;
        MemData_Wr      : in     vl_logic_vector(31 downto 0);
        WBData_Wr       : in     vl_logic_vector(31 downto 0);
        MemRead         : in     vl_logic;
        Data            : out    vl_logic_vector(31 downto 0);
        Rd_write_byte_en_new: out    vl_logic_vector(3 downto 0)
    );
end WR;
