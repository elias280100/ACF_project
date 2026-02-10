module Modulus_tb;
    reg [7:0] a;
    reg [7:0] b;
    wire [7:0] result;

    Modulus uut (
        .a(a),
        .b(b),
        .result(result)
    );

    initial begin
        // Test case 1
        a = 10; b = 3; #10;
        $display("Test case 1: %d %% %d = %d", a, b, result);

        // Test case 2
        a = 20; b = 6; #10;
        $display("Test case 2: %d %% %d = %d", a, b, result);

        // Test case 3
        a = 15; b = 4; #10;
        $display("Test case 3: %d %% %d = %d", a, b, result);

        // Test case 4
        a = 9; b = 5; #10;
        $display("Test case 4: %d %% %d = %d", a, b, result);

        // Test case 5
        a = 8; b = 2; #10;
        $display("Test case 5: %d %% %d = %d", a, b, result);

        $finish;
    end
endmodule