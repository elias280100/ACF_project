`timescale 1ns / 1ps
module CRC32 (
    input CLK,
    input reset,
    input [7:0] data_in,
    input enable,
    input clear,

    output [31:0] CRC
);
    parameter RESET_SEED = 'h00;
    reg [31:0] CRC_prev, CRC_next;

    always @(posedge CLK or negedge reset) begin
        CRC_prev <= CRC_next;
        if (!reset) begin
            CRC_prev <= RESET_SEED;
        end
    end

    always @(*) begin
        CRC_next = CRC_prev;
        if (clear) begin
            CRC_next = RESET_SEED;
        end else if (enable) begin
            CRC_next[0] = data_in[0] ^ data_in[6] ^ CRC_prev[24] ^ CRC_prev[30];
            CRC_next[1] = data_in[0] ^ data_in[1] ^ data_in[6] ^ data_in[7] ^ CRC_prev[24] ^ CRC_prev[25] ^ CRC_prev[30] ^ CRC_prev[31];
            CRC_next[2] = data_in[0] ^ data_in[1] ^ data_in[2] ^ data_in[6] ^ data_in[7] ^ CRC_prev[24] ^ CRC_prev[25] ^ CRC_prev[26] ^ CRC_prev[30] ^ CRC_prev[31];
            CRC_next[3] = data_in[1] ^ data_in[2] ^ data_in[3] ^ data_in[7] ^ CRC_prev[25] ^ CRC_prev[26] ^ CRC_prev[27] ^ CRC_prev[31];
            CRC_next[4] = data_in[0] ^ data_in[2] ^ data_in[3] ^ data_in[4] ^ data_in[6] ^ CRC_prev[24] ^ CRC_prev[26] ^ CRC_prev[27] ^ CRC_prev[28] ^ CRC_prev[30];
            CRC_next[5] = data_in[0] ^ data_in[1] ^ data_in[3] ^ data_in[4] ^ data_in[5] ^ data_in[6] ^ data_in[7] ^ CRC_prev[24] ^ CRC_prev[25] ^ CRC_prev[27] ^ CRC_prev[28] ^ CRC_prev[29] ^ CRC_prev[30] ^ CRC_prev[31];
            CRC_next[6] = data_in[1] ^ data_in[2] ^ data_in[4] ^ data_in[5] ^ data_in[6] ^ data_in[7] ^ CRC_prev[25] ^ CRC_prev[26] ^ CRC_prev[28] ^ CRC_prev[29] ^ CRC_prev[30] ^ CRC_prev[31];
            CRC_next[7] = data_in[0] ^ data_in[2] ^ data_in[3] ^ data_in[5] ^ data_in[7] ^ CRC_prev[24] ^ CRC_prev[26] ^ CRC_prev[27] ^ CRC_prev[29] ^ CRC_prev[31];
            CRC_next[8] = data_in[0] ^ data_in[1] ^ data_in[3] ^ data_in[4] ^ CRC_prev[0] ^ CRC_prev[24] ^ CRC_prev[25] ^ CRC_prev[27] ^ CRC_prev[28];
            CRC_next[9] = data_in[1] ^ data_in[2] ^ data_in[4] ^ data_in[5] ^ CRC_prev[1] ^ CRC_prev[25] ^ CRC_prev[26] ^ CRC_prev[28] ^ CRC_prev[29];
            CRC_next[10] = data_in[0] ^ data_in[2] ^ data_in[3] ^ data_in[5] ^ CRC_prev[2] ^ CRC_prev[24] ^ CRC_prev[26] ^ CRC_prev[27] ^ CRC_prev[29];
            CRC_next[11] = data_in[0] ^ data_in[1] ^ data_in[3] ^ data_in[4] ^ CRC_prev[3] ^ CRC_prev[24] ^ CRC_prev[25] ^ CRC_prev[27] ^ CRC_prev[28];
            CRC_next[12] = data_in[0] ^ data_in[1] ^ data_in[2] ^ data_in[4] ^ data_in[5] ^ data_in[6] ^ CRC_prev[4] ^ CRC_prev[24] ^ CRC_prev[25] ^ CRC_prev[26] ^ CRC_prev[28] ^ CRC_prev[29] ^ CRC_prev[30];
            CRC_next[13] = data_in[1] ^ data_in[2] ^ data_in[3] ^ data_in[5] ^ data_in[6] ^ data_in[7] ^ CRC_prev[5] ^ CRC_prev[25] ^ CRC_prev[26] ^ CRC_prev[27] ^ CRC_prev[29] ^ CRC_prev[30] ^ CRC_prev[31];
            CRC_next[14] = data_in[2] ^ data_in[3] ^ data_in[4] ^ data_in[6] ^ data_in[7] ^ CRC_prev[6] ^ CRC_prev[26] ^ CRC_prev[27] ^ CRC_prev[28] ^ CRC_prev[30] ^ CRC_prev[31];
            CRC_next[15] = data_in[3] ^ data_in[4] ^ data_in[5] ^ data_in[7] ^ CRC_prev[7] ^ CRC_prev[27] ^ CRC_prev[28] ^ CRC_prev[29] ^ CRC_prev[31];
            CRC_next[16] = data_in[0] ^ data_in[4] ^ data_in[5] ^ CRC_prev[8] ^ CRC_prev[24] ^ CRC_prev[28] ^ CRC_prev[29];
            CRC_next[17] = data_in[1] ^ data_in[5] ^ data_in[6] ^ CRC_prev[9] ^ CRC_prev[25] ^ CRC_prev[29] ^ CRC_prev[30];
            CRC_next[18] = data_in[2] ^ data_in[6] ^ data_in[7] ^ CRC_prev[10] ^ CRC_prev[26] ^ CRC_prev[30] ^ CRC_prev[31];
            CRC_next[19] = data_in[3] ^ data_in[7] ^ CRC_prev[11] ^ CRC_prev[27] ^ CRC_prev[31];
            CRC_next[20] = data_in[4] ^ CRC_prev[12] ^ CRC_prev[28];
            CRC_next[21] = data_in[5] ^ CRC_prev[13] ^ CRC_prev[29];
            CRC_next[22] = data_in[0] ^ CRC_prev[14] ^ CRC_prev[24];
            CRC_next[23] = data_in[0] ^ data_in[1] ^ data_in[6] ^ CRC_prev[15] ^ CRC_prev[24] ^ CRC_prev[25] ^ CRC_prev[30];
            CRC_next[24] = data_in[1] ^ data_in[2] ^ data_in[7] ^ CRC_prev[16] ^ CRC_prev[25] ^ CRC_prev[26] ^ CRC_prev[31];
            CRC_next[25] = data_in[2] ^ data_in[3] ^ CRC_prev[17] ^ CRC_prev[26] ^ CRC_prev[27];
            CRC_next[26] = data_in[0] ^ data_in[3] ^ data_in[4] ^ data_in[6] ^ CRC_prev[18] ^ CRC_prev[24] ^ CRC_prev[27] ^ CRC_prev[28] ^ CRC_prev[30];
            CRC_next[27] = data_in[1] ^ data_in[4] ^ data_in[5] ^ data_in[7] ^ CRC_prev[19] ^ CRC_prev[25] ^ CRC_prev[28] ^ CRC_prev[29] ^ CRC_prev[31];
            CRC_next[28] = data_in[2] ^ data_in[5] ^ data_in[6] ^ CRC_prev[20] ^ CRC_prev[26] ^ CRC_prev[29] ^ CRC_prev[30];
            CRC_next[29] = data_in[3] ^ data_in[6] ^ data_in[7] ^ CRC_prev[21] ^ CRC_prev[27] ^ CRC_prev[30] ^ CRC_prev[31];
            CRC_next[30] = data_in[4] ^ data_in[7] ^ CRC_prev[22] ^ CRC_prev[28] ^ CRC_prev[31];
            CRC_next[31] = data_in[5] ^ CRC_prev[23] ^ CRC_prev[29];
        end
    end

    assign CRC = CRC_prev;

endmodule
    