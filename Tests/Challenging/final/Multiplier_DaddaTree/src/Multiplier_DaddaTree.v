//half adder
module half_adder (
    input a,
    input b,
    output sum,
    output cout
);
    assign sum = a ^ b;
    assign cout = a & b;
endmodule

//full adder
module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);
endmodule

//Multiplier Dadda Tree
module Multiplier_DaddaTree (
    input [7:0] a,
    input [7:0] b,
    output [15:0] product,
    //output [63:0] debug // For debugging purposes
);

    wire [7:0] partial_products[7:0];
    // Generate partial products
    genvar i, j;
    generate
        for (i = 0; i < 8; i = i + 1) begin : gen_partial_products
            for (j = 0; j < 8; j = j + 1) begin : gen_bits
                assign partial_products[i][j] = a[j] & b[i];            //partial products is 8x8 array storing result of a&b
            end
        end
    endgenerate

    wire [63:0] col_sum, col_carry;

    //Level 1 stage 1
    half_adder ha1 (
        .a(partial_products[0][6]),
        .b(partial_products[1][5]),
        .sum(col_sum[0]),
        .cout(col_carry[0])
    );
    //Debug
    // assign debug[0] = col_sum[0];
    // assign debug[1] = col_carry[0];
    full_adder fa1 (
        .a(partial_products[0][7]),
        .b(partial_products[1][6]),
        .cin(partial_products[2][5]),
        .sum(col_sum[1]),
        .cout(col_carry[1])
    );
    //Debug
    // assign debug[2] = col_sum[1];
    // assign debug[3] = col_carry[1];
    full_adder fa2 (
        .a(partial_products[1][7]),
        .b(partial_products[2][6]),
        .cin(partial_products[3][5]),
        .sum(col_sum[2]),
        .cout(col_carry[2])
    );
    full_adder fa3 (
        .a(partial_products[2][7]),
        .b(partial_products[3][6]),
        .cin(partial_products[4][5]),
        .sum(col_sum[3]),
        .cout(col_carry[3])
    );
    //Level 1 stage 2
    half_adder ha2 (
        .a(partial_products[3][4]),
        .b(partial_products[4][3]),
        .sum(col_sum[4]),
        .cout(col_carry[4])
    );
    half_adder ha3 (
        .a(partial_products[4][4]),
        .b(partial_products[5][3]),
        .sum(col_sum[5]),
        .cout(col_carry[5])
    );

    //Level 2 stage 1
    half_adder ha4 (
        .a(partial_products[0][4]),
        .b(partial_products[1][3]),
        .sum(col_sum[6]),
        .cout(col_carry[6])
    );
    full_adder fa4 (
        .a(partial_products[0][5]),
        .b(partial_products[1][4]),
        .cin(partial_products[2][3]),
        .sum(col_sum[7]),
        .cout(col_carry[7])
    );
    full_adder fa5 (
        .a(col_sum[0]),
        .b(partial_products[2][4]),
        .cin(partial_products[3][3]),
        .sum(col_sum[8]),
        .cout(col_carry[8])
    );
    full_adder fa6 (
        .a(col_carry[0]),
        .b(col_sum[1]),
        .cin(col_sum[4]),
        .sum(col_sum[9]),
        .cout(col_carry[9])
    );
    full_adder fa7 (
        .a(col_carry[1]),
        .b(col_carry[4]),
        .cin(col_sum[2]),
        .sum(col_sum[10]),
        .cout(col_carry[10])
    );
    full_adder fa8 (
        .a(col_carry[2]),
        .b(col_carry[5]),
        .cin(col_sum[3]),
        .sum(col_sum[11]),
        .cout(col_carry[11])
    );
    full_adder fa9 (
        .a(col_carry[3]),
        .b(partial_products[3][7]),
        .cin(partial_products[4][6]),
        .sum(col_sum[12]),
        .cout(col_carry[12])
    );
    full_adder fa10 (
        .a(partial_products[4][7]),
        .b(partial_products[5][6]),
        .cin(partial_products[6][5]),
        .sum(col_sum[13]),
        .cout(col_carry[13])
    );



    //level 2 stage 2
    half_adder ha5 (
        .a(partial_products[3][2]),
        .b(partial_products[4][1]),
        .sum(col_sum[14]),
        .cout(col_carry[14])
    );
    full_adder fa11 (
        .a(partial_products[4][2]),
        .b(partial_products[5][1]),
        .cin(partial_products[6][0]),
        .sum(col_sum[15]),
        .cout(col_carry[15])
    );
    full_adder fa12 (
        .a(partial_products[5][2]),
        .b(partial_products[6][1]),
        .cin(partial_products[7][0]),
        .sum(col_sum[16]),
        .cout(col_carry[16])
    );
    full_adder fa13 (
        .a(col_sum[5]),
        .b(partial_products[6][2]),
        .cin(partial_products[7][1]),
        .sum(col_sum[17]),
        .cout(col_carry[17])
    );
    full_adder fa14 (
        .a(partial_products[5][4]),
        .b(partial_products[6][3]),
        .cin(partial_products[7][2]),
        .sum(col_sum[18]),
        .cout(col_carry[18])
    );
    full_adder fa15 (
        .a(partial_products[5][5]),
        .b(partial_products[6][4]),
        .cin(partial_products[7][3]),
        .sum(col_sum[19]),
        .cout(col_carry[19])
    );

    //level 3 stage 1
    half_adder ha6 (
        .a(partial_products[0][3]),
        .b(partial_products[1][2]),
        .sum(col_sum[20]),
        .cout(col_carry[20])
    );
    full_adder fa16 (
        .a(col_sum[6]),
        .b(partial_products[2][2]),
        .cin(partial_products[3][1]),
        .sum(col_sum[21]),
        .cout(col_carry[21])
    );
    full_adder fa17 (
        .a(col_carry[6]),
        .b(col_sum[7]),
        .cin(col_sum[14]),
        .sum(col_sum[22]),
        .cout(col_carry[22])
    );
    full_adder fa18 (
        .a(col_carry[7]),
        .b(col_carry[14]),
        .cin(col_sum[8]),
        .sum(col_sum[23]),
        .cout(col_carry[23])
    );
    full_adder fa19 (
        .a(col_carry[8]),
        .b(col_carry[15]),
        .cin(col_sum[9]),
        .sum(col_sum[24]),
        .cout(col_carry[24])
    );
    full_adder fa20 (
        .a(col_carry[9]),
        .b(col_carry[16]),
        .cin(col_sum[10]),
        .sum(col_sum[25]),
        .cout(col_carry[25])
    );
    full_adder fa21 (
        .a(col_carry[10]),
        .b(col_carry[17]),
        .cin(col_sum[11]),
        .sum(col_sum[26]),
        .cout(col_carry[26])
    );
    full_adder fa22 (
        .a(col_carry[11]),
        .b(col_carry[18]),
        .cin(col_sum[12]),
        .sum(col_sum[27]),
        .cout(col_carry[27])
    );
    full_adder fa23 (
        .a(col_carry[12]),
        .b(col_carry[19]),
        .cin(col_sum[13]),
        .sum(col_sum[28]),
        .cout(col_carry[28])
    );
    full_adder fa24 (
        .a(col_carry[13]),
        .b(partial_products[5][7]),
        .cin(partial_products[6][6]),
        .sum(col_sum[29]),
        .cout(col_carry[29])
    );

    // level 4 stage 1

    half_adder ha7 (
        .a(partial_products[0][2]),
        .b(partial_products[1][1]),
        .sum(col_sum[30]),
        .cout(col_carry[30])
    );
    full_adder fa25 (
        .a(col_sum[20]),
        .b(partial_products[2][1]),
        .cin(partial_products[3][0]),
        .sum(col_sum[31]),
        .cout(col_carry[31])
    );
    full_adder fa26 (
        .a(col_carry[20]),
        .b(col_sum[21]),
        .cin(partial_products[4][0]),
        .sum(col_sum[32]),
        .cout(col_carry[32])
    );
    full_adder fa27 (
        .a(col_carry[21]),
        .b(col_sum[22]),
        .cin(partial_products[5][0]),
        .sum(col_sum[33]),
        .cout(col_carry[33])
    );
    full_adder fa28 (
        .a(col_carry[22]),
        .b(col_sum[23]),
        .cin(col_sum[15]),
        .sum(col_sum[34]),
        .cout(col_carry[34])
    );
    full_adder fa29 (
        .a(col_carry[23]),
        .b(col_sum[24]),
        .cin(col_sum[16]),
        .sum(col_sum[35]),
        .cout(col_carry[35])
    );
    full_adder fa30 (
        .a(col_carry[24]),
        .b(col_sum[25]),
        .cin(col_sum[17]),
        .sum(col_sum[36]),
        .cout(col_carry[36])
    );
    full_adder fa31 (
        .a(col_carry[25]),
        .b(col_sum[26]),
        .cin(col_sum[18]),
        .sum(col_sum[37]),
        .cout(col_carry[37])
    );
    full_adder fa32 (
        .a(col_carry[26]),
        .b(col_sum[27]),
        .cin(col_sum[19]),
        .sum(col_sum[38]),
        .cout(col_carry[38])
    );
    full_adder fa33 (
        .a(col_carry[27]),
        .b(col_sum[28]),
        .cin(partial_products[7][4]),
        .sum(col_sum[39]),
        .cout(col_carry[39])
    );
    full_adder fa34 (
        .a(col_carry[28]),
        .b(col_sum[29]),
        .cin(partial_products[7][5]),
        .sum(col_sum[40]),
        .cout(col_carry[40])
    );  
    full_adder fa35 (
        .a(col_carry[29]),
        .b(partial_products[6][7]),
        .cin(partial_products[7][6]),
        .sum(col_sum[41]),
        .cout(col_carry[41])
    );


    
    // Final addition
    full_adder final_adder1 (
        .a(partial_products[0][1]),
        .b(partial_products[1][0]),
        .cin(1'b0),
        .sum(col_sum[42]),
        .cout(col_carry[42])
    );

    full_adder final_adder2 (
        .a(col_sum[30]),
        .b(partial_products[2][0]),
        .cin(col_carry[42]),
        .sum(col_sum[43]),
        .cout(col_carry[43])
    );
    full_adder final_adder3 (
        .a(col_carry[30]),
        .b(col_sum[31]),
        .cin(col_carry[43]),
        .sum(col_sum[44]),
        .cout(col_carry[44])
    );
    full_adder final_adder4 (
        .a(col_carry[31]),
        .b(col_sum[32]),
        .cin(col_carry[44]),
        .sum(col_sum[45]),
        .cout(col_carry[45])
    );
    full_adder final_adder5 (
        .a(col_carry[32]),
        .b(col_sum[33]),
        .cin(col_carry[45]),
        .sum(col_sum[46]),
        .cout(col_carry[46])
    );
    full_adder final_adder6 (
        .a(col_carry[33]),
        .b(col_sum[34]),
        .cin(col_carry[46]),
        .sum(col_sum[47]),
        .cout(col_carry[47])
    );
    full_adder final_adder7 (
        .a(col_carry[34]),
        .b(col_sum[35]),
        .cin(col_carry[47]),
        .sum(col_sum[48]),
        .cout(col_carry[48])
    );
    full_adder final_adder8 (
        .a(col_carry[35]),
        .b(col_sum[36]),
        .cin(col_carry[48]),
        .sum(col_sum[49]),
        .cout(col_carry[49])
    );
    full_adder final_adder9 (
        .a(col_carry[36]),
        .b(col_sum[37]),
        .cin(col_carry[49]),
        .sum(col_sum[50]),
        .cout(col_carry[50])
    );
    full_adder final_adder10 (
        .a(col_carry[37]),
        .b(col_sum[38]),
        .cin(col_carry[50]),
        .sum(col_sum[51]),
        .cout(col_carry[51])
    );
    full_adder final_adder11 (
        .a(col_carry[38]),
        .b(col_sum[39]),
        .cin(col_carry[51]),
        .sum(col_sum[52]),
        .cout(col_carry[52])
    );
    full_adder final_adder12 (
        .a(col_carry[39]),
        .b(col_sum[40]),
        .cin(col_carry[52]),
        .sum(col_sum[53]),
        .cout(col_carry[53])
    );
    full_adder final_adder13 (
        .a(col_carry[40]),
        .b(col_sum[41]),
        .cin(col_carry[53]),
        .sum(col_sum[54]),
        .cout(col_carry[54])
    );  
    full_adder final_adder14 (
        .a(col_carry[41]),
        .b(partial_products[7][7]),
        .cin(col_carry[54]),
        .sum(col_sum[55]),
        .cout(col_carry[55])
    );

    assign product[0] = partial_products[0][0];
    assign product[1] = col_sum[42];
    assign product[2] = col_sum[43];
    assign product[3] = col_sum[44];
    assign product[4] = col_sum[45];
    assign product[5] = col_sum[46];
    assign product[6] = col_sum[47];
    assign product[7] = col_sum[48];
    assign product[8] = col_sum[49];
    assign product[9] = col_sum[50];
    assign product[10] = col_sum[51];
    assign product[11] = col_sum[52];
    assign product[12] = col_sum[53];
    assign product[13] = col_sum[54];
    assign product[14] = col_sum[55];
    assign product[15] = col_carry[55];
    


    endmodule

