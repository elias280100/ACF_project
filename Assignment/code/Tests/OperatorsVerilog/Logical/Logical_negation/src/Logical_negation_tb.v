module Logical_negation_tb;
    reg [3:0] a;
    wire y;

    Logical_negation dut (
        .a(a),
        .y(y)
    );

    initial begin
        a = 4'b0001;
        #10;
        $display("Test case 1: a=%b, y=%b",a, y);

        a = 4'b0000;
        #10;
        $display("Test case 2: a=%b, y=%b",a, y);

        a = 4'b1111;
        #10;
        $display("Test case 3: a=%b, y=%b",a, y);

        $finish;
    end
endmodule
