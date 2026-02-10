module Reduction_xnor_tb;
    reg [3:0] a;
    wire result;

    Reduction_xnor dut (
        .a(a),
        .result(result)
    );

    initial begin
        //Test 1
        a = 4'b0001;
        #10;
        $display("a = %b, result = %b", a, result);

        //Test 2
        a = 4'b0010;
        #10;
        $display("a = %b, result = %b", a, result);

        //Test 3
        a = 4'b0011;
        #10;
        $display("a = %b, result = %b", a, result);

        //Test 4
        a = 4'b0100;
        #10;
        $display("a = %b, result = %b", a, result);

        //Test 5
        a = 4'b0101;
        #10;
        $display("a = %b, result = %b", a, result);

        //Test 6
        a = 4'b0111;
        #10;
        $display("a = %b, result = %b", a, result);

        //Test 7
        a = 4'b1111;
        #10;
        $display("a = %b, result = %b", a, result);

        //Test 8
        a = 4'b0000;
        #10;
        $display("a = %b, result = %b", a, result);
    end
endmodule