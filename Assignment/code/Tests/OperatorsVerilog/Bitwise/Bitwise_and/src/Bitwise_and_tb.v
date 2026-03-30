module Bitwise_and_tb;
    reg [3:0] a;
    reg [3:0] b;
    wire [3:0] result;

    Bitwise_and dut (
        .a(a),
        .b(b),
        .result(result)
    );

    initial begin
        //Test 1
        a = 4'b1010;
        b = 4'b1001;
        #10;

        $display("a = %b, b = %b, result = %b", a, b, result);

        //Test 2
        a = 4'b1111;
        b = 4'b1010;
        #10;
        $display("a = %b, b = %b, result = %b", a, b, result);

        //Test 3
        a = 4'b0000;
        b = 4'b1111;
        #10;
        $display("a = %b, b = %b, result = %b", a, b, result);
    end
endmodule