module Exponent_tb;
    reg [7:0] a, b;
    wire [7:0] c;

    Exponent dut (
        .a(a),
        .b(b),
        .c(c)
    );

    initial begin
        // Test case 1: 2^3 = 8
        a = 8'b00000010; // 2
        b = 8'b00000011; // 3
        #10;
        $display("Test case 1: %d^%d = %d", a, b, c);

        // Test case 2: 5^0 = 1
        a = 8'b00000101; // 5
        b = 8'b00000000; // 0
        #10;
        $display("Test case 2: %d^%d = %d", a, b, c);

        // Test case 3: 3^4 = 81
        a = 8'b00000011; // 3
        b = 8'b00000100; // 4
        #10;
        $display("Test case 3: %d^%d = %d", a, b, c);

        // Test case 4: 0^5 = 0
        a = 8'b00000000; // 0
        b = 8'b00000101; // 5
        #10;
        $display("Test case 4: %d^%d = %d", a, b, c);

        // Test case 5: 1^7 = 1
        a = 8'b00000001; // 1
        b = 8'b00000111; // 7
        #10;
        $display("Test case 5: %d^%d = %d", a, b, c);
        
        $finish;
    end
endmodule