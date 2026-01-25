module XOR_dominant (
    input clk,
    input [15:0] data_in,
    //input load,
    output parity_out
    //output [15:0] lfsr_out
);
    wire [7:0] level1;
    wire [3:0] level2;
    wire [1:0] level3;

    assign level1[0] = data_in[0] ^ data_in[1];
    assign level1[1] = data_in[2] ^ data_in[3];
    assign level1[2] = data_in[4] ^ data_in[5];
    assign level1[3] = data_in[6] ^ data_in[7];
    assign level1[4] = data_in[8] ^ data_in[9];
    assign level1[5] = data_in[10] ^ data_in[11];
    assign level1[6] = data_in[12] ^ data_in[13];
    assign level1[7] = data_in[14] ^ data_in[15];

    assign level2[0] = level1[0] ^ level1[1];
    assign level2[1] = level1[2] ^ level1[3];
    assign level2[2] = level1[4] ^ level1[5];
    assign level2[3] = level1[6] ^ level1[7];

    assign level3[0] = level2[0] ^ level2[1];
    assign level3[1] = level2[2] ^ level2[3];

    assign parity_out = level3[0] ^ level3[1];
    
endmodule


    
