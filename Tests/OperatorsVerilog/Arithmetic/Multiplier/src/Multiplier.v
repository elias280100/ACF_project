module Multiplier (
    input  wire [3:0] A,
    input  wire [3:0] B,
    output wire [7:0] P
);
    assign P = A * B;
endmodule