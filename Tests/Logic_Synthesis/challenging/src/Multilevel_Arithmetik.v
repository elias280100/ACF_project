module full_adder (
    input a,
    input b,
    input c,
    input d,
    input cin,
    output sum,
    output cout
);
    assign sum = a ^ b ^ c ^ d ^ cin;
    assign cout = (a & b) | (a & c) | (a & d) | (a & cin) |
                  (b & c) | (b & d) | (b & cin) |
                  (c & d) | (c & cin) |
                  (d & cin);
endmodule

module adder_ripple_carry (
    input [8:0] A,
    input [8:0] B,
    input Cin,
    output [8:0] Sum,
    output Cout
);
    wire [8:0] carry;
    full_adder fa0 (
        .a(A[0]),
        .b(B[0]),
        .c(1'b0),
        .d(1'b0),
        .cin(Cin),
        .sum(Sum[0]),
        .cout(carry[0])
    );
    full_adder fa1 (
        .a(A[1]),
        .b(B[1]),
        .c(1'b0),
        .d(1'b0),
        .cin(carry[0]),
        .sum(Sum[1]),
        .cout(carry[1])
    );
    full_adder fa2 (
        .a(A[2]),
        .b(B[2]),
        .c(1'b0),
        .d(1'b0),
        .cin(carry[1]),
        .sum(Sum[2]),
        .cout(carry[2])
    );
    full_adder fa3 (
        .a(A[3]),
        .b(B[3]),
        .c(1'b0),
        .d(1'b0),
        .cin(carry[2]),
        .sum(Sum[3]),
        .cout(carry[3])
    );
    full_adder fa4 (
        .a(A[4]),
        .b(B[4]),
        .c(1'b0),
        .d(1'b0),
        .cin(carry[3]),
        .sum(Sum[4]),
        .cout(carry[4])
    );
    full_adder fa5 (
        .a(A[5]),
        .b(B[5]),
        .c(1'b0),
        .d(1'b0),
        .cin(carry[4]),
        .sum(Sum[5]),
        .cout(carry[5])
    );
    full_adder fa6 (
        .a(A[6]),
        .b(B[6]),
        .c(1'b0),
        .d(1'b0),
        .cin(carry[5]),
        .sum(Sum[6]),
        .cout(carry[6])
    );
    full_adder fa7 (
        .a(A[7]),
        .b(B[7]),
        .c(1'b0),
        .d(1'b0),
        .cin(carry[6]),
        .sum(Sum[7]),
        .cout(carry[7])
    );
    full_adder fa8 (
        .a(A[8]),
        .b(B[8]),
        .c(1'b0),
        .d(1'b0),
        .cin(carry[7]),
        .sum(Sum[8]),
        .cout(Cout)
    );
    
endmodule

// AxB + CxD + ExF
module mult_4bit (
    input [3:0] a,
    input [3:0] b,
    input [3:0] c,
    input [3:0] d,
    input [3:0] e,
    input [3:0] f,
    output [7:0] product,
    output [7:0] product2,
    output [7:0] product3,
    output [8:0] result
);
    wire [3:0] partial_products[3:0];
    wire [3:0] partial_products2[3:0];
    wire [3:0] partial_products3[3:0];


    // Generate partial products for a*b
    assign partial_products[0][0] = a[0] & b[0];
    assign partial_products[0][1] = a[1] & b[0];
    assign partial_products[0][2] = a[2] & b[0];
    assign partial_products[0][3] = a[3] & b[0];

    assign partial_products[1][0] = a[0] & b[1];
    assign partial_products[1][1] = a[1] & b[1];
    assign partial_products[1][2] = a[2] & b[1];
    assign partial_products[1][3] = a[3] & b[1];

    assign partial_products[2][0] = a[0] & b[2];
    assign partial_products[2][1] = a[1] & b[2];
    assign partial_products[2][2] = a[2] & b[2];
    assign partial_products[2][3] = a[3] & b[2];

    assign partial_products[3][0] = a[0] & b[3];
    assign partial_products[3][1] = a[1] & b[3];
    assign partial_products[3][2] = a[2] & b[3];
    assign partial_products[3][3] = a[3] & b[3];

    assign product[0] = partial_products[0][0];


    // Add partial products for a*b
    wire col1_sum, col1_carry;
    full_adder fa_col1 (
        .a(partial_products[0][1]),
        .b(partial_products[1][0]),
        .c(1'b0),
        .d(1'b0),
        .cin(1'b0),
        .sum(col1_sum),
        .cout(col1_carry)
    );
    assign product[1] = col1_sum;

    wire col2_sum1, col2_carry1;
    full_adder fa_col2_1 (
        .a(partial_products[0][2]),
        .b(partial_products[1][1]),
        .c(partial_products[2][0]),
        .d(1'b0),
        .cin(col1_carry),
        .sum(col2_sum1),
        .cout(col2_carry1)
    );
    assign product[2] = col2_sum1;

    wire col3_sum1, col3_carry1;
    full_adder fa_col3_1 (
        .a(partial_products[0][3]),
        .b(partial_products[1][2]),
        .c(partial_products[2][1]),
        .d(partial_products[3][0]),
        .cin(col2_carry1),
        .sum(col3_sum1),
        .cout(col3_carry1)
    );
    assign product[3] = col3_sum1;

    wire col4_sum1, col4_carry1;
    full_adder fa_col4_1 (
        .a(1'b0),
        .b(partial_products[1][3]),
        .c(partial_products[2][2]),
        .d(partial_products[3][1]),
        .cin(col3_carry1),
        .sum(col4_sum1),
        .cout(col4_carry1)
    );
    assign product[4] = col4_sum1;

    wire col5_sum1, col5_carry1;
    full_adder fa_col5_1 (
        .a(1'b0),
        .b(1'b0),
        .c(partial_products[2][3]),
        .d(partial_products[3][2]),
        .cin(col4_carry1),
        .sum(col5_sum1),
        .cout(col5_carry1)
    );
    assign product[5] = col5_sum1;

    wire col6_sum1, col6_carry1;
    full_adder fa_col6_1 (
        .a(1'b0),
        .b(1'b0),
        .c(1'b0),
        .d(partial_products[3][3]),
        .cin(col5_carry1),
        .sum(col6_sum1),
        .cout(col6_carry1)
    );
    assign product[6] = col6_sum1;

    assign product[7] = col6_carry1;

    // Generate partial products for c*d
    assign partial_products2[0][0] = c[0] & d[0];
    assign partial_products2[0][1] = c[1] & d[0];
    assign partial_products2[0][2] = c[2] & d[0];
    assign partial_products2[0][3] = c[3] & d[0];

    assign partial_products2[1][0] = c[0] & d[1];
    assign partial_products2[1][1] = c[1] & d[1];
    assign partial_products2[1][2] = c[2] & d[1];
    assign partial_products2[1][3] = c[3] & d[1];

    assign partial_products2[2][0] = c[0] & d[2];
    assign partial_products2[2][1] = c[1] & d[2];
    assign partial_products2[2][2] = c[2] & d[2];
    assign partial_products2[2][3] = c[3] & d[2];

    assign partial_products2[3][0] = c[0] & d[3];
    assign partial_products2[3][1] = c[1] & d[3];
    assign partial_products2[3][2] = c[2] & d[3];
    assign partial_products2[3][3] = c[3] & d[3];

    assign product2[0] = partial_products2[0][0];

    // Add partial products for c*d
    wire col1_sum_cd, col1_carry_cd;
    full_adder fa_col1_cd (
        .a(partial_products2[0][1]),
        .b(partial_products2[1][0]),
        .c(1'b0),
        .d(1'b0),
        .cin(1'b0),
        .sum(col1_sum_cd),
        .cout(col1_carry_cd)
    );
    assign product2[1] = col1_sum_cd;

    wire col2_sum1_cd, col2_carry1_cd;
    full_adder fa_col2_1_cd (
        .a(partial_products2[0][2]),
        .b(partial_products2[1][1]),
        .c(partial_products2[2][0]),
        .d(1'b0),
        .cin(col1_carry_cd),
        .sum(col2_sum1_cd),
        .cout(col2_carry1_cd)
    );
    assign product2[2] = col2_sum1_cd;

    wire col3_sum1_cd, col3_carry1_cd;
    full_adder fa_col3_1_cd (
        .a(partial_products2[0][3]),
        .b(partial_products2[1][2]),
        .c(partial_products2[2][1]),
        .d(partial_products2[3][0]),
        .cin(col2_carry1_cd),
        .sum(col3_sum1_cd),
        .cout(col3_carry1_cd)
    );
    assign product2[3] = col3_sum1_cd;

    wire col4_sum1_cd, col4_carry1_cd;
    full_adder fa_col4_1_cd (
        .a(1'b0),
        .b(partial_products2[1][3]),
        .c(partial_products2[2][2]),
        .d(partial_products2[3][1]),
        .cin(col3_carry1_cd),
        .sum(col4_sum1_cd),
        .cout(col4_carry1_cd)
    );
    assign product2[4] = col4_sum1_cd;

    wire col5_sum1_cd, col5_carry1_cd;
    full_adder fa_col5_1_cd (
        .a(1'b0),
        .b(1'b0),
        .c(partial_products2[2][3]),
        .d(partial_products2[3][2]),
        .cin(col4_carry1_cd),
        .sum(col5_sum1_cd),
        .cout(col5_carry1_cd)
    );
    assign product2[5] = col5_sum1_cd;

    wire col6_sum1_cd, col6_carry1_cd;
    full_adder fa_col6_1_cd (
        .a(1'b0),
        .b(1'b0),
        .c(1'b0),
        .d(partial_products2[3][3]),
        .cin(col5_carry1_cd),
        .sum(col6_sum1_cd),
        .cout(col6_carry1_cd)
    );
    assign product2[6] = col6_sum1_cd;

    assign product2[7] = col6_carry1_cd;


    // Generate partial products for e*f
    assign partial_products3[0][0] = e[0] & f[0];
    assign partial_products3[0][1] = e[1] & f[0];
    assign partial_products3[0][2] = e[2] & f[0];
    assign partial_products3[0][3] = e[3] & f[0];

    assign partial_products3[1][0] = e[0] & f[1];
    assign partial_products3[1][1] = e[1] & f[1];
    assign partial_products3[1][2] = e[2] & f[1];
    assign partial_products3[1][3] = e[3] & f[1];

    assign partial_products3[2][0] = e[0] & f[2];
    assign partial_products3[2][1] = e[1] & f[2];
    assign partial_products3[2][2] = e[2] & f[2];
    assign partial_products3[2][3] = e[3] & f[2];

    assign partial_products3[3][0] = e[0] & f[3];
    assign partial_products3[3][1] = e[1] & f[3];
    assign partial_products3[3][2] = e[2] & f[3];
    assign partial_products3[3][3] = e[3] & f[3];

    assign product3[0] = partial_products3[0][0];

    // Add partial products for e*f
    wire col1_sum_ef, col1_carry_ef;
    full_adder fa_col1_ef (
        .a(partial_products3[0][1]),
        .b(partial_products3[1][0]),
        .c(1'b0),
        .d(1'b0),
        .cin(1'b0),
        .sum(col1_sum_ef),
        .cout(col1_carry_ef)
    );
    assign product3[1] = col1_sum_ef;

    wire col2_sum1_ef, col2_carry1_ef;
    full_adder fa_col2_1_ef (
        .a(partial_products3[0][2]),
        .b(partial_products3[1][1]),
        .c(partial_products3[2][0]),
        .d(1'b0),
        .cin(col1_carry_ef),
        .sum(col2_sum1_ef),
        .cout(col2_carry1_ef)
    );
    assign product3[2] = col2_sum1_ef;

    wire col3_sum1_ef, col3_carry1_ef;
    full_adder fa_col3_1_ef (
        .a(partial_products3[0][3]),
        .b(partial_products3[1][2]),
        .c(partial_products3[2][1]),
        .d(partial_products3[3][0]),
        .cin(col2_carry1_ef),
        .sum(col3_sum1_ef),
        .cout(col3_carry1_ef)
    );
    assign product3[3] = col3_sum1_ef;

    wire col4_sum1_ef, col4_carry1_ef;
    full_adder fa_col4_1_ef (
        .a(4'b0),
        .b(partial_products3[1][3]),
        .c(partial_products3[2][2]),
        .d(partial_products3[3][1]),
        .cin(col3_carry1_ef),
        .sum(col4_sum1_ef),
        .cout(col4_carry1_ef)
    );
    assign product3[4] = col4_sum1_ef;

    wire col5_sum1_ef, col5_carry1_ef;
    full_adder fa_col5_1_ef (
        .a(1'b0),
        .b(1'b0),
        .c(partial_products3[2][3]),
        .d(partial_products3[3][2]),
        .cin(col4_carry1_ef),
        .sum(col5_sum1_ef),
        .cout(col5_carry1_ef)
    );
    assign product3[5] = col5_sum1_ef;

    wire col6_sum1_ef, col6_carry1_ef;
    full_adder fa_col6_1_ef (
        .a(1'b0),
        .b(1'b0),
        .c(1'b0),
        .d(partial_products3[3][3]),
        .cin(col5_carry1_ef),
        .sum(col6_sum1_ef),
        .cout(col6_carry1_ef)
    );
    assign product3[6] = col6_sum1_ef;

    assign product3[7] = col6_carry1_ef;    

    // Final addition: product + product2 + product3
    wire [8:0] temp_sum;
    adder_ripple_carry final_adder (
        .A({{1'b0}, product}),
        .B({{1'b0}, product2}),
        .Cin(1'b0),
        .Sum(temp_sum),
        .Cout()
    );
    
    adder_ripple_carry final_adder2 (
        .A(temp_sum[8:0]),
        .B({{1'b0}, product3}),
        .Cin(1'b0),
        .Sum(result),
        .Cout()
    );
    
    
endmodule

