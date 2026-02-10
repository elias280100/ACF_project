module Reduction_nand_tb;
    reg [3:0] a;
    wire result;

    Reduction_nand dut (
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