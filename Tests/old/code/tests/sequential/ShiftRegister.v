module shift_register (
    input clk,
    input din,
    output dout
);
    reg [7:0] shift_reg;
    always @(posedge clk)
        shift_reg <= {shift_reg[6:0], din};
    assign dout = shift_reg;
endmodule
