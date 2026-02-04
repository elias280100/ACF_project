module Hamming_Code (
    input [6:0] reveived,   //received 7-bit Hamming code
    output [3:0] decoded,   //decoded 4-bit data
    output [2:0] syndrome,  //error bits positions
    output error_detected   //indicates if an error is detected
);

wire r0 = reveived[0];
wire r1 = reveived[1];
wire r2 = reveived[2];
wire r3 = reveived[3];
wire r4 = reveived[4];
wire r5 = reveived[5];
wire r6 = reveived[6];

assign syndrome[0] = r0 ^ r2 ^ r4 ^ r6; // parity bit 1
assign syndrome[1] = r1 ^ r2 ^ r5 ^ r6; // parity bit 2
assign syndrome[2] = r3 ^ r4 ^ r5 ^ r6; // parity bit 4

assign error_detected = (syndrome != 3'b000);

wire [6:0] error_mask;
assign error_mask = (syndrome == 3'b000) ? 7'b0000000 :
                    (syndrome == 3'b001) ? 7'b0000001 :
                    (syndrome == 3'b010) ? 7'b0000010 :
                    (syndrome == 3'b011) ? 7'b0000100 :
                    (syndrome == 3'b100) ? 7'b0001000 :
                    (syndrome == 3'b101) ? 7'b0010000 :
                    (syndrome == 3'b110) ? 7'b0100000 :
                    (syndrome == 3'b111) ? 7'b1000000 :
                                            7'b0000000; 

wire [6:0] corrected = reveived ^ error_mask;

    assign decoded[0] = corrected[2];
    assign decoded[1] = corrected[4];
    assign decoded[2] = corrected[5];
    assign decoded[3] = corrected[6];
endmodule