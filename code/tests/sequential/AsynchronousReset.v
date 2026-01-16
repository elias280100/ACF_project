module async_reset_counter (
    input clk,
    input async_rst,
    output [3:0] count
);
    reg [3:0] counter;
    always @(posedge clk or negedge async_rst)
        if (!async_rst)
            counter <= 4'b0;
        else
            counter <= counter + 1;
    assign count = counter;
endmodule
