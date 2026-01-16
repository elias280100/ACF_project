module counter_8bit (
    input clk,
    input rst,
    output [7:0] count
);
    reg [7:0] counter;
    always @(posedge clk)
        if (rst)
            counter <= 8'b0;
        else
            counter <= counter + 1;
    assign count = counter;
endmodule
