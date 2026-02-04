module parity (
    input [15:0] in,
    output out
);
    assign out = ^in;
endmodule