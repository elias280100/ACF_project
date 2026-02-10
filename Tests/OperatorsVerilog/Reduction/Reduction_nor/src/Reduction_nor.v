module Reduction_nor (
    input [3:0] a,
    output result
);
    assign result = ~a;
endmodule