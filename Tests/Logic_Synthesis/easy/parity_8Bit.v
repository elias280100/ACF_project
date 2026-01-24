module parity_8Bit (
    input [7:0] data_in,
    output parity_out
);
   wire [3:0] level1;
   wire [1:0] level2;

   assign level1[0] = data_in[0] ^ data_in[1];
   assign level1[1] = data_in[2] ^ data_in[3];
   assign level1[2] = data_in[4] ^ data_in[5];
   assign level1[3] = data_in[6] ^ data_in[7];

   assign level2[0] = level1[0] ^ level1[1];
   assign level2[1] = level1[2] ^ level1[3];

   assign parity_out = level2[0] ^ level2[1];

endmodule