module SUB_tb;
    reg [7:0] a, b;
    wire [7:0] c;

    SUB uut (
        .a(a),
        .b(b),
        .c(c)
    );

    initial begin
        // Test case 1
        a = 8'b00001111; // 15 in decimal
        b = 8'b00000101; // 5 in decimal
        #10; // Wait for 10 time units
        $display("Test case 1: a = %d, b = %d, c = %d", a, b, c); // Expected output: c = 10

        // Test case 2
        a = 8'b11111111; // 255 in decimal
        b = 8'b00000001; // 1 in decimal
        #10; // Wait for 10 time units
        $display("Test case 2: a = %d, b = %d, c = %d", a, b, c); // Expected output: c = 254

        // Test case 3
        a = 8'b00000000; // 0 in decimal
        b = 8'b00000001; // 1 in decimal
        #10; // Wait for 10 time units
        $display("Test case 3: a = %d, b = %d, c = %d", a, b, c); // Expected output: c = 255 (since 0 - 1 = -1, which is represented as 255 in two's complement)

        $finish; // End the simulation
    end
endmodule