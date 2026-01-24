module high_fanin (
    input [15:0] inputs,
    output result
);
    assign result = &inputs;  // 16-input AND
endmodule
