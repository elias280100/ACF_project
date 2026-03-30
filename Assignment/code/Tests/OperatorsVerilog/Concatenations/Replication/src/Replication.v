module Replication (
    input [2:0] a, b,
    output [14:0] result1,
    output [14:0] result2,
    output [14:0] result3
);

assign result1 = {{3{a}}, {2{b}}};
assign result2 = {5{a}};
assign result3 = {a, {2{a, b}}};
endmodule