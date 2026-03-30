module const_mult_tb;

reg [7:0] a;
reg [7:0] b1;
reg [7:0] b2;
reg [7:0] b3;

wire [10:0] y1;
wire [10:0] y2;
wire [10:0] y3;
wire [10:0] y4;
wire [10:0] y5;
wire [10:0] y6;
wire [10:0] y7;
wire [10:0] y8;


const_mult DUT (
    .a(a),
    .b1(b1),
    .b2(b2),
    .b3(b3),
    .y1(y1),
    .y2(y2),
    .y3(y3),
    .y4(y4),
    .y5(y5),
    .y6(y6),
    .y7(y7),
    .y8(y8)
);

initial begin
    a = 8'b00001101;
    b1 = 8'b00010000;
    b2 = 8'b00100000;
    b3 = 8'b00110000;


    #10;

    $display("y[0] = %d", y1);
    $display("y[1] = %d", y2);
    $display("y[2] = %d", y3);
    $display("y[3] = %d", y4);
    $display("y[4] = %d", y5);
    $display("y[5] = %d", y6);
    $display("y[6] = %d", y7);
    $display("y[7] = %d", y8);

    $stop;
end

endmodule