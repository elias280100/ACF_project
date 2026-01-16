module high_fanout (
    input in,
    output [7:0] out
);
    assign out = in & 1'b1;
    assign out = in & 1'b1;
    assign out = in & 1'b1;
    assign out = in & 1'b1;
    assign out = in & 1'b1;
    assign out = in & 1'b1;
    assign out = in & 1'b1;
    assign out = in & 1'b1;  // in drives 8 destinations
endmodule
