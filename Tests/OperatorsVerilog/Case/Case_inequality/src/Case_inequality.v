module Case_inequality (
    input [3:0] a,
    input [3:0] b,
    output result
);
    assign result = (a !== b);
endmodule