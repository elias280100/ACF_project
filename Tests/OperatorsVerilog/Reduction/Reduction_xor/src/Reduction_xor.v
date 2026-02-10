module Reduction_xor (
    input [3:0] a,
    output result
);
    assign result = ^a;
endmodule