module Reduction_or (
    input [3:0] a,
    output result
);
    assign result = |a;
endmodule