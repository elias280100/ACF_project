module Relational_tb;
    reg [3:0] a;
    reg [3:0] b;
    wire gt, lt, gq, lq;

    Relational uut (
        .a(a),
        .b(b),
        .gt(gt),
        .lt(lt),
        .gq(gq),
        .lq(lq)
    );

    initial begin
        // Test case 1: a > b
        a = 4'b1010; // 10
        b = 4'b0101; // 5
        #10;
        $display("Test case 1: a = %b, b = %b, gt = %b, lt = %b, gq = %b, lq = %b", a, b, gt, lt, gq, lq);

        // Test case 2: a < b
        a = 4'b0011; // 3
        b = 4'b0110; // 6
        #10;
        $display("Test case 2: a = %b, b = %b, gt = %b, lt = %b, gq = %b, lq = %b", a, b, gt, lt, gq, lq);

        // Test case 3: a == b
        a = 4'b1111; // 15
        b = 4'b1111; // 15
        #10;
        $display("Test case 3: a = %b, b = %b, gt = %b, lt = %b, gq = %b, lq = %b", a, b, gt, lt, gq, lq);

        $finish;
    end
endmodule