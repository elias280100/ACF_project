module Bitwise_negation_tb;
    reg [3:0] a;
    wire [3:0] result;

    Bitwise_negation dut (
        .a(a),
        .result(result)
    );

    initial begin
        //Test 1
        a = 4'b1010;
        #10;
        $display("a = %b, result = %b", a, result);

        //Test 2
        a = 4'b1111;
        #10;
        $display("a = %b, result = %b", a, result);

        //Test 3
        a = 4'b0000;
        #10;
        $display("a = %b, result = %b", a, result);
    end
endmodule