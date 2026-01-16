module sync_reset_counter (
    input clk,
    input sync_rst,
    output [3:0] count
);
    reg [3:0] counter;
    always @(posedge clk)
        if (sync_rst)
            counter <= 4'b0;
        else
            counter <= counter + 1;
    assign count = counter;
endmodule
