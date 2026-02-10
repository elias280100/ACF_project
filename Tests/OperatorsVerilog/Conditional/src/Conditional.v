module Conditional (
    input clk,
    input rst,
    input in,
    output reg out
);
    reg [1:0] state;
    always @(posedge clk) begin
        if (rst) state <= 2'b00;
        else case (state)
            2'b00: state <= in ? 2'b01 : 2'b00;
            2'b01: state <= in ? 2'b10 : 2'b00;
            2'b10: state <= in ? 2'b00 : 2'b10;
            default: state <= 2'b00;
        endcase
    end
    assign out = (state == 2'b10);
endmodule
