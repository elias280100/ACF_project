module comparator_8bit (
    input [7:0] a,
    input [7:0] b,
    output eq, lt, gt
);
    assign eq = (a == b);
    assign lt = (a < b);
    assign gt = (a > b);
endmodule
