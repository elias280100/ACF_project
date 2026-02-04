module pipeline_mult (
    input clk,
    input [7:0] a,
    input [7:0] b,
    output [15:0] result
);
    reg [7:0] a_r1, a_r2, b_r1, b_r2;
    reg [15:0] mult_r;
    
    always @(posedge clk) begin
        a_r1 <= a;
        b_r1 <= b;
        a_r2 <= a_r1;
        b_r2 <= b_r1;
        mult_r <= a_r2 * b_r2;
    end
    assign result = mult_r;
endmodule
