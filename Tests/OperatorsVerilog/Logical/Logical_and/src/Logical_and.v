module Logical_and (
    input [3:0] a,
    input [3:0] b,
    output result
);
    assign result = (a != 4'b0000) && (b != 4'b0000);
    
endmodule