module Concatenation (
    input [1:0] a,
    input [3:0] b,
    input [5:0] c,
    output [11:0] concat
);
    assign concat = {a, b, c};
endmodule