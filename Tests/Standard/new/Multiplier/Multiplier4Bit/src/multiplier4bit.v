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

module mult_4bit (
    input [3:0] a,
    input [3:0] b,
    output [7:0] product
);
    wire [3:0] partial_products[3:0];

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

    wire col1_sum, col1_carry;
    full_adder fa_col1 (
        .a(partial_products[0][1]),
        .b(partial_products[1][0]),
        .c(4'b0000),
        .d(4'b0000),
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
        .d(4'b0000),
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
        .a(4'b0000),
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
        .a(4'b0000),
        .b(4'b0000),
        .c(partial_products[2][3]),
        .d(partial_products[3][2]),
        .cin(col4_carry1),
        .sum(col5_sum1),
        .cout(col5_carry1)
    );
    assign product[5] = col5_sum1;

    wire col6_sum1, col6_carry1;
    full_adder fa_col6_1 (
        .a(4'b0000),
        .b(4'b0000),
        .c(4'b0000),
        .d(partial_products[3][3]),
        .cin(col5_carry1),
        .sum(col6_sum1),
        .cout(col6_carry1)
    );
    assign product[6] = col6_sum1;

    assign product[7] = col6_carry1;
endmodule
