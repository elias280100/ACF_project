module Logical_right_shift (
    input  [7:0] data,
    input  [3:0] shift,
    output [7:0] result
);
    assign result = data >> shift;  
endmodule
