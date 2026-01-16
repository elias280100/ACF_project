module single_lut (
    input a, b,
    output y
);
    assign y = a & b;  // One LUT
endmodule
