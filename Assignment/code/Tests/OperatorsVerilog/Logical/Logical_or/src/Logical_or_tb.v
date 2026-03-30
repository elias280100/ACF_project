module Logical_or_tb;
    reg [3:0] a;
    reg [3:0] b;
    wire result;

    Logical_or dut (
        .a(a),
        .b(b),
        .result(result)
    );

    initial begin
        // Test case 1: Both a and b are non-zero
        a = 4'b0001; // 1 in decimal
        b = 4'b0010; // 2 in decimal
        #10; // Wait for 10 time units
        $display("Test case 1: a = %b, b = %b, result = %b", a, b, result);

        // Test case 2: a is zero and b is non-zero
        a = 4'b0000; // 0 in decimal
        b = 4'b0010; // 2 in decimal
        #10; // Wait for 10 time units
        $display("Test case 2: a = %b, b = %b, result = %b", a, b, result);

        // Test case 3: a is non-zero and b is zero
        a = 4'b0001; // 1 in decimal
        b = 4'b0000; // 0 in decimal
        #10; // Wait for 10 time units
        $display("Test case 3: a = %b, b = %b, result = %b", a, b, result);

        // Test case 4: Both a and b are zero
        a = 4'b0000; // 0 in decimal
        b = 4'b0000; // 0 in decimal
        #10; // Wait for 10 time units
        $display("Test case 4: a = %b, b = %b, result = %b", a, b, result);

        // Test case 5: Both a and b are equal
        a = 4'b1010; // 10 in decimal
        b = 4'b1010; // 10 in decimal
        #10; // Wait for 10 time units
        $display("Test case 5: a = %b, b = %b, result = %b", a, b, result);

        $finish; // End the simulation
    end
endmodule