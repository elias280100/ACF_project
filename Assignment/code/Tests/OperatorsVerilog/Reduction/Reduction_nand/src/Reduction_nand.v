module Reduction_nand (
    input [3:0] a,
    output result
);
    assign result = ~&a;
endmodule