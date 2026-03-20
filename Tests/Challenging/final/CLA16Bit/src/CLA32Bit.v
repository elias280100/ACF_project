/*
module cla4bit (  // Basis‑Block (dein Beispiel)
    input  [3:0] A, B,
    input        Cin,
    output [3:0] Sum,
    output       Cout,
    output       Pgroup, Ggroup  // Block‑P/G für höheres Level
);
    wire [3:0] P = A ^ B;
    wire [3:0] G = A & B;
    wire [4:0] C;
    assign C[0] = Cin;
    assign C[1] = G[0] | (P[0] & C[0]);
    assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & C[0]);
    assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & C[0]);
    assign C[4] = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) |
                  (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & C[0]);
    assign Sum = P ^ C[3:0];
    assign Cout = C[4];
    
    assign Pgroup = P[3] & P[2] & P[1] & P[0];  // Block propagiert Carry
    assign Ggroup = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]);  // Block generiert Carry
endmodule

module cla4bit_pgroup_only (  // Nur für P/G!
    input  [3:0] A, B,
    output       Pgroup, Ggroup
);
    wire [3:0] P = A ^ B;
    wire [3:0] G = A & B;
    assign Pgroup = &P;  // P[3] & P[2] & P[1] & P[0]
    assign Ggroup = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]);
endmodule


module cla32bit (
    input  [31:0] A, B,
    input         Cin,
    output [31:0] Sum,
    output        Cout
);
    wire [8:0] BlockC;     // Block‑Carries (C0=Cin, C1..C8)
    wire [7:0] BlockP, BlockG;  // Block‑P/G

    genvar j;
    generate
        for (j = 0; j < 8; j++) begin : pg_blocks
            cla4bit_pgroup_only pg(
                .A(A[4*j +: 4]),
                .B(B[4*j +: 4]),
                .Pgroup(BlockP[j]),
                .Ggroup(BlockG[j])
            );
        end
    endgenerate

    

    // Block‑Lookahead: Carries für die 8 Blöcke
    assign BlockC[0] = Cin;
    assign BlockC[1] = BlockG[0] | (BlockP[0] & BlockC[0]);
    assign BlockC[2] = BlockG[1] | (BlockP[1] & BlockG[0]) | (BlockP[1] & BlockP[0] & BlockC[0]);
    assign BlockC[3] = BlockG[2] | (BlockP[2] & BlockG[1]) | (BlockP[2] & BlockP[1] & BlockG[0]) |
                       (BlockP[2] & BlockP[1] & BlockP[0] & BlockC[0]);
    assign BlockC[4] = BlockG[3] | (BlockP[3] & BlockG[2]) | (BlockP[3] & BlockP[2] & BlockG[1]) |
                       (BlockP[3] & BlockP[2] & BlockP[1] & BlockG[0]) | (BlockP[3] & BlockP[2] & BlockP[1] & BlockP[0] & BlockC[0]);
    assign BlockC[5] = BlockG[4] | (BlockP[4] & BlockG[3]) | (BlockP[4] & BlockP[3] & BlockG[2]) |
                       (BlockP[4] & BlockP[3] & BlockP[2] & BlockG[1]) | (BlockP[4] & BlockP[3] & BlockP[2] & BlockP[1] & BlockP[0] & BlockC[0]);
    assign BlockC[6] = BlockG[5] | (BlockP[5] & BlockG[4]) | (BlockP[5] & BlockP[4] & BlockG[3]) |
                       (BlockP[5] & BlockP[4] & BlockP[3] & BlockG[2]) | (BlockP[5] & BlockP[4] & BlockP[3] & BlockP[2] & BlockP[1] & BlockP[0] & BlockC[0]);
    assign BlockC[7] = BlockG[6] | (BlockP[6] & BlockG[5]) | (BlockP[6] & BlockP[5] & BlockG[4]) |
                       (BlockP[6] & BlockP[5] & BlockP[4] & BlockG[3]) | (BlockP[6] & BlockP[5] & BlockP[4] & BlockP[3] & BlockP[2] & BlockP[1] & BlockP[0] & BlockC[0]);
    assign BlockC[8] = BlockG[7] | (BlockP[7] & BlockG[6]) | (BlockP[7] & BlockP[6] & BlockG[5]) |
                       (BlockP[7] & BlockP[6] & BlockP[5] & BlockG[4]) | (BlockP[7] & BlockP[6] & BlockP[5] & BlockP[4] & BlockP[3] & BlockP[2] & BlockP[1] & BlockP[0] & BlockC[0]);

    


    // 8× 4‑Bit‑Blöcke instanziieren
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : blocks
            cla4bit blk(
                .A(A[4*i +: 4]),
                .B(B[4*i +: 4]),
                .Cin(BlockC[i]),
                .Sum(Sum[4*i +: 4])
            );
        end
    endgenerate

    assign Cout = BlockC[8];
endmodule


module cla4bit (  // Basis‑Block (dein Beispiel)
    input  [3:0] A, B,
    input        Cin,
    output [3:0] Sum,
    output       Cout,
    output       Pgroup, Ggroup  // Block‑P/G für höheres Level
);
    wire [3:0] P = A ^ B;
    wire [3:0] G = A & B;
    wire [4:0] C;
    assign C[0] = Cin;
    assign C[1] = G[0] | (P[0] & C[0]);
    assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & C[0]);
    assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & C[0]);
    assign C[4] = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) |
                  (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & C[0]);
    assign Sum = P ^ C[3:0];
    assign Cout = C[4];
    assign Pgroup = P[3] & P[2] & P[1] & P[0];  // Block propagiert Carry
    assign Ggroup = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]);  // Block generiert Carry
endmodule


module cla32bit (
    input  [31:0] A, B,
    input         Cin,
    output [31:0] Sum,
    output        Cout
);
    wire [8:0] BlockC;     // Block‑Carries (C0=Cin, C1..C8)
    wire [7:0] BlockP, BlockG;  // Block‑P/G


    // 8× 4‑Bit‑Blöcke instanziieren
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : blocks
            cla4bit blk(
                .A(A[4*i +: 4]),
                .B(B[4*i +: 4]),
                .Cin(BlockC[i]),
                .Sum(Sum[4*i +: 4]),
                .Cout(),
                .Pgroup(BlockP[i]),
                .Ggroup(BlockG[i])
            );
        end
    endgenerate


    // Block‑Lookahead: Carries für die 8 Blöcke
    assign BlockC[0] = Cin;
    assign BlockC[1] = BlockG[0] | (BlockP[0] & BlockC[0]);
    assign BlockC[2] = BlockG[1] | (BlockP[1] & BlockG[0]) | (BlockP[1] & BlockP[0] & BlockC[0]);
    assign BlockC[3] = BlockG[2] | (BlockP[2] & BlockG[1]) | (BlockP[2] & BlockP[1] & BlockG[0]) |
                       (BlockP[2] & BlockP[1] & BlockP[0] & BlockC[0]);
    assign BlockC[4] = BlockG[3] | (BlockP[3] & BlockG[2]) | (BlockP[3] & BlockP[2] & BlockG[1]) |
                       (BlockP[3] & BlockP[2] & BlockP[1] & BlockG[0]) | (BlockP[3] & BlockP[2] & BlockP[1] & BlockP[0] & BlockC[0]);
    assign BlockC[5] = BlockG[4] | (BlockP[4] & BlockG[3]) | (BlockP[4] & BlockP[3] & BlockG[2]) |
                       (BlockP[4] & BlockP[3] & BlockP[2] & BlockG[1]) | (BlockP[4] & BlockP[3] & BlockP[2] & BlockP[1] & BlockP[0] & BlockC[0]);
    assign BlockC[6] = BlockG[5] | (BlockP[5] & BlockG[4]) | (BlockP[5] & BlockP[4] & BlockG[3]) |
                       (BlockP[5] & BlockP[4] & BlockP[3] & BlockG[2]) | (BlockP[5] & BlockP[4] & BlockP[3] & BlockP[2] & BlockP[1] & BlockP[0] & BlockC[0]);
    assign BlockC[7] = BlockG[6] | (BlockP[6] & BlockG[5]) | (BlockP[6] & BlockP[5] & BlockG[4]) |
                       (BlockP[6] & BlockP[5] & BlockP[4] & BlockG[3]) | (BlockP[6] & BlockP[5] & BlockP[4] & BlockP[3] & BlockP[2] & BlockP[1] & BlockP[0] & BlockC[0]);
    assign BlockC[8] = BlockG[7] | (BlockP[7] & BlockG[6]) | (BlockP[7] & BlockP[6] & BlockG[5]) |
                       (BlockP[7] & BlockP[6] & BlockP[5] & BlockG[4]) | (BlockP[7] & BlockP[6] & BlockP[5] & BlockP[4] & BlockP[3] & BlockP[2] & BlockP[1] & BlockP[0] & BlockC[0]);


    assign Cout = BlockC[8];
endmodule
*/

module CLA16 (
    input  [15:0] A,
    input  [15:0] B,
    input        Cin,
    output [15:0] Sum,
    output       Cout
);
    wire [15:0] P; // Propagate
    wire [15:0] G; // Generate
    wire [15:0] C; // Carry

    // Generate Propagate and Generate signals
    assign P = A ^ B;
    assign G = A & B;

    // Carry Lookahead Logic
    assign C[0] = Cin;
    assign C[1] = G[0] | (P[0] & C[0]);
    assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & C[0]);
    assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & C[0]);
    assign C[4] = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0])
                  | (P[3] & P[2] & P[1] & P[0] & C[0]);
    assign C[5] = G[4] | (P[4] & G[3]) | (P[4] & P[3] & G[2]) | (P[4] & P[3] & P[2] & G[1])
                  | (P[4] & P[3] & P[2] & P[1] & G[0]) | (P[4] & P[3] & P[2] & P[1] & P[0] & C[0]);
    assign C[6] = G[5] | (P[5] & G[4]) | (P[5] & P[4] & G[3]) | (P[5] & P[4] & P[3] & G[2])
                  | (P[5] & P[4] & P[3] & P[2] & G[1]) | (P[5] & P[4] & P[3] & P[2] & P[1] & G[0])
                  | (P[5] & P[4] & P[3] & P[2] & P[1] & P[0] & C[0]);
    assign C[7] = G[6] | (P[6] & G[5]) | (P[6] & P[5] & G[4]) | (P[6] & P[5] & P[4] & G[3])
                  | (P[6] & P[5] & P[4] & P[3] & G[2]) | (P[6] & P[5] & P[4] & P[3] & P[2] & G[1])
                  | (P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & G[0])
                  | (P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & P[0] & C[0]);
    assign C[8] = G[7] | (P[7] & G[6]) | (P[7] & P[6] & G[5]) | (P[7] & P[6] & P[5] & G[4])
                   | (P[7] & P[6] & P[5] & P[4] & G[3]) | (P[7] & P[6] & P[5] & P[4] & P[3] & G[2])
                   | (P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & G[1])
                   | (P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & G[0])
                   | (P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & P[0] & C[0]);
    assign C[9] = G[8] | (P[8] & G[7]) | (P[8] & P[7] & G[6]) | (P[8] & P[7] & P[6] & G[5])
                   | (P[8] & P[7] & P[6] & P[5] & G[4]) | (P[8] & P[7] & P[6] & P[5] & P[4] & G[3])
                   | (P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & G[2])
                   | (P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & G[1])
                   | (P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & G[0])
                   | (P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & P[0] & C[0]);
    assign C[10] = G[9] | (P[9] & G[8]) | (P[9] & P[8] & G[7]) | (P[9] & P[8] & P[7] & G[6])
                   | (P[9] & P[8] & P[7] & P[6] & G[5]) | (P[9] & P[8] & P[7] & P[6] & P[5] & G[4])
                   | (P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & G[3])
                   | (P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & G[2])
                   | (P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & G[1])
                   | (P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & G[0])
                   | (P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & P[0] & C[0]);
    assign C[11] = G[10] | (P[10] & G[9]) | (P[10] & P[9] & G[8]) | (P[10] & P[9] & P[8] & G[7])
                   | (P[10] & P[9] & P[8] & P[7] & G[6]) | (P[10] & P[9] & P[8] & P[7] & P[6] & G[5])
                   | (P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & G[4])
                   | (P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & G[3])
                   | (P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & G[2])
                   | (P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & G[1])
                   | (P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & G[0])
                   | (P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & P[0] & C[0]);
    assign C[12] = G[11] | (P[11] & G[10]) | (P[11] & P[10] & G[9]) | (P[11] & P[10] & P[9] & G[8])
                   | (P[11] & P[10] & P[9] & P[8] & G[7]) | (P[11] & P[10] & P[9] & P[8] & P[7] & G[6])
                   | (P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & G[5])
                   | (P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & G[4])
                   | (P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & G[3])
                   | (P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & G[2])
                   | (P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & G[1])
                   | (P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & G[0])
                   | (P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & P[0] & C[0]);
    assign C[13] = G[12] | (P[12] & G[11]) | (P[12] & P[11] & G[10]) | (P[12] & P[11] & P[10] & G[9])
                   | (P[12] & P[11] & P[10] & P[9] & G[8]) | (P[12] & P[11] & P[10] & P[9] & P[8] & G[7])
                   | (P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & G[6])
                   | (P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & G[5])
                   | (P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & G[4])
                   | (P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & G[3])
                   | (P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & G[2])
                   | (P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & G[1])
                   | (P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & G[0])
                   | (P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & P[0] & C[0]);
    assign C[14] = G[13] | (P[13] & G[12]) | (P[13] & P[12] & G[11]) | (P[13] & P[12] & P[11] & G[10])
                   | (P[13] & P[12] & P[11] & P[10] & G[9]) | (P[13] & P[12] & P[11] & P[10] & P[9] & G[8])
                   | (P[13] & P[12] & P[11] & P[10] & P[9] & P[8] & G[7])
                   | (P[13] & P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & G[6])
                   | (P[13] & P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & G[5])
                   | (P[13] & P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & G[4]) 
                   | (P[13] & P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & G[3])
                   | (P[13] & P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & G[2])
                   | (P[13] & P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & G[1])
                   | (P[13] & P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & G[0])
                   | (P[13] & P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & P[0] & C[0]);
    assign C[15] = G[14] | (P[14] & G[13]) | (P[14] & P[13] & G[12]) | (P[14] & P[13] & P[12] & G[11])
                   | (P[14] & P[13] & P[12] & P[11] & G[10]) | (P[14] & P[13] & P[12] & P[11] & P[10] & G[9])
                   | (P[14] & P[13] & P[12] & P[11] & P[10] & P[9] & G[8])
                   | (P[14] & P[13] & P[12] & P[11] & P[10] & P[9] & P[8] & G[7])
                   | (P[14] & P[13] & P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & G[6])
                   | (P[14] & P[13] & P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & G[5])
                   | (P[14] & P[13] & P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & G[4])
                   | (P[14] & P[13] & P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & G[3])
                   | (P[14] & P[13] & P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & G[2])
                   | (P[14] & P[13] & P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & G[1])
                   | (P[14] & P[13] & P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & G[0])
                   | (P[14] & P[13] & P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & P[0] & C[0]);
    assign Cout = G[15] | (P[15] & G[14]) | (P[15] & P[14] & G[13]) | (P[15] & P[14] & P[13] & G[12])
                   | (P[15] & P[14] & P[13] & P[12] & G[11]) | (P[15] & P[14] & P[13] & P[12] & P[11] & G[10])
                   | (P[15] & P[14] & P[13] & P[12] & P[11] & P[10] & G[9])
                   | (P[15] & P[14] & P[13] & P[12] & P[11] & P[10] & P[9] & G[8])
                   | (P[15] & P[14] & P[13] & P[12] & P[11] & P[10] & P[9] & P[8] & G[7])
                   | (P[15] & P[14] & P[13] & P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & G[6])
                   | (P[15] & P[14] & P[13] & P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & G[5])
                   | (P[15] & P[14] & P[13] & P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & G[4])
                   | (P[15] & P[14] & P[13] & P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & G[3])
                   | (P[15] & P[14] & P[13] & P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & G[2])
                   | (P[15] & P[14] & P[13] & P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & G[1])
                   | (P[15] & P[14] & P[13] & P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & G[0])
                   | (P[15] & P[14] & P[13] & P[12] & P[11] & P[10] & P[9] & P[8] & P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & P[0] & C[0]);


    // Sum Calculation
    assign Sum = P ^ C;
endmodule