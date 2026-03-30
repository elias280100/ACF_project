module shift_xor (
    input [31:0] key,
    output [31:0] hash
);

wire [31:0] a, b, c, d, e, f;

    assign a = key  ^ (key  << 13);
    assign b = a    ^ (a    >> 17);
    assign c = b    ^ (b    <<  5);
    assign d = c    ^ (c    >>  7);
    assign e = d    ^ (d    << 12);
    assign f = e    * 32'h45d9f3b; 

    assign hash = f ^ (f >> 16);
endmodule 