module Multiplier_Dadda_Tree_tb;
    reg [7:0] A, B;
    wire [15:0] Product;
    wire [63:0] Debug;


    Multiplier_DaddaTree dut (
        .a(A),
        .b(B),
        .product(Product),
        .debug(Debug)
    );
    initial begin
        // Test Vectors
        A = 8'b00011011; B = 8'b00000101; // 27 * 5 = 135
        #10;
        if (Product !== 16'b0000000010000111) $display("Test 1 Failed: %d * %d != %d", A, B, Product);
        else $display("Test 1 Passed: %d * %d = %d", A, B, Product);
        // $display("Debug Info: %b, %b, %b, %b", Debug[0], Debug[1], Debug[2], Debug[3]);

        A = 8'b00000011; B = 8'b00000011; // 3 * 3 = 9
        #10;
        if (Product !== 16'b0000000000001001) $display("Test 2 Failed: %d * %d != %d", A, B, Product);
        else $display("Test 2 Passed: %d * %d = %d", A, B, Product);
        //$display("Debug Info: %b, %b, %b, %b", Debug[0], Debug[1], Debug[2], Debug[3]);

        A = 8'b11111111; B = 8'b00000010; // 255 * 2 = 510
        #10;
        if (Product !== 16'b0000000111111110) $display("Test 3 Failed: %d * %d != %d", A, B, Product);
        else $display("Test 3 Passed: %d * %d = %d", A, B, Product);

        A = 8'b00010010; B = 8'b00010010; // 18 * 18 = 324
        #10;
        if (Product !== 16'b0000000101000100) $display("Test 4 Failed: %d * %d != %d", A, B, Product);
        else $display("Test 4 Passed: %d * %d = %d", A, B, Product);
        A = 8'b10101010; B = 8'b01010101; // 170 * 85 = 14450
        #10;
        if (Product !== 16'b0011100001110010) $display("Test 5 Failed: %d * %d != %d", A, B, Product);
        else $display("Test 5 Passed: %d * %d = %d", A, B, Product);
        

        $display("All tests completed.");
        $finish;
    end
endmodule