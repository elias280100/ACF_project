module dead_code (
    input a,
    input b,
    output y
);
    wire unused = a & b;  // This is never used
    assign y = 1'b0;
endmodule
