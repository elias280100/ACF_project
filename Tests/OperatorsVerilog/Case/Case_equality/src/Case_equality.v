module Case_equality (
    input [3:0] a,
    input [3:0] b,
    output result
);
    assign result = (a === b);
endmodule
