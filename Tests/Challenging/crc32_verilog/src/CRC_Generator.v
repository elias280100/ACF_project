`timescale 1ns/1ps
module CRC32 (
    input clk,
    input reset,
    input [7:0] data_in,
    input valid,

    output [31:0] crc_out
);

    reg  [31:0] crc;
    reg  [31:0] crc_prev;
    reg  [31:0] crc_next;
    reg  [3:0]  debug;

    integer i, j;   // Schleifenvariablen müssen in Verilog außerhalb deklariert werden

    parameter [31:0] POLY      = 32'h04C11DB7;
    parameter [31:0] final_crc = 32'h00000000;
    parameter [31:0] init      = 32'hffffffff;

    always @(posedge clk) begin
        if (reset) begin
            crc <= init;
        end
        else begin
            if (valid) begin
                crc <= crc_next;
            end
        end
    end

    assign crc_out = crc ^ final_crc;

    generate
        always @(*) begin
            crc_next = crc;
            crc_prev = crc;
            for (i = 0; i < 8; i = i + 1) begin
                crc_next[0] = crc_prev[31] ^ data_in[7 - i];
                for (j = 1; j < 32; j = j + 1) begin
                    if (POLY[j] == 1) begin
                        crc_next[j] = crc_prev[j-1] ^ crc_prev[31] ^ data_in[7 - i];
                    end
                    else begin
                        crc_next[j] = crc_prev[j-1];
                    end
                end
                crc_prev = crc_next;
            end
        end
    endgenerate


endmodule
