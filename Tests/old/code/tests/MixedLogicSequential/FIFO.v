module fifo_4entry (
    input clk,
    input rst,
    input we,
    input re,
    input [7:0] data_in,
    output [7:0] data_out,
    output full,
    output empty
);
    reg [7:0] mem [3:0];
    reg [1:0] wr_ptr, rd_ptr;
    
    always @(posedge clk)
        if (rst) begin
            wr_ptr <= 2'b0;
            rd_ptr <= 2'b0;
        end else begin
            if (we && !full)
                wr_ptr <= wr_ptr + 1;
            if (re && !empty)
                rd_ptr <= rd_ptr + 1;
        end
    
    always @(posedge clk)
        if (we)
            mem[wr_ptr] <= data_in;
    
    assign data_out = mem[rd_ptr];
    assign full = (wr_ptr == {~rd_ptr, rd_ptr});
    assign empty = (wr_ptr == rd_ptr);
endmodule
