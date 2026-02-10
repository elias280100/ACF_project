module Divide_tb;
    reg [7:0] a, b;
    wire [7:0] c;

    Divide dut (
        .a(a),
        .b(b),
        .c(c)
    );

    initial begin
        // Test case 1: 10 / 2 = 5
        a = 10; b = 2; #10;
        $display("Test case 1: %b / %b = %b", a, b, c);

        // Test case 2: 20 / 4 = 5
        a = 20; b = 4; #10;
        $display("Test case 2: %b / %b = %b", a, b, c);

        // Test case 3: 15 / 3 = 5
        a = 15; b = 3; #10;
        $display("Test case 3: %b / %b = %b", a, b, c);

        // Test case 4: Division by zero (should handle gracefully)
        a = 10; b = 0; #10;
        $display("Test case 4: %b / %b = %b", a, b, c);

        // Test case 5: 28 / 7 = 4
        a = 28; b = 7; #10;
        $display("Test case 5: %b / %b = %b", a, b, c);
        
        $finish;
    end
endmodule