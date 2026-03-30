module Relational (
    input [3:0] a,
    input [3:0] b,
    output reg gt, // greater than
    output reg lt, // less than
    output reg gq, // greater than or equal to
    output reg lq  // less than or equal to
);
    always @(*) begin
        gt = (a > b);
        lt = (a < b);
        gq = (a >= b);
        lq = (a <= b);
    end
endmodule