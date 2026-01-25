module tb_mult_4bit;
    reg [3:0] a, b, c, d, e, f;
    wire [7:0] product, product2, product3;
    wire [8:0] result;
    
    mult_4bit dut (
        .a(a), .b(b), .c(c), .d(d), .e(e), .f(f),
        .product(product),
        .product2(product2),
        .product3(product3),
        .result(result)
    );
    
    // ========== Test Task ==========
    task test_mult_add(
        input [3:0] a_val, b_val, c_val, d_val, e_val, f_val,
        input [8:0] expected
    );
        begin
            a = a_val; b = b_val; c = c_val; d = d_val; e = e_val; f = f_val;
            #10;
            
            if (result == expected) begin
                $display("✓ PASS: (%d×%d) + (%d×%d) + (%d×%d) = %d (expected %d)", 
                         a_val, b_val, c_val, d_val, e_val, f_val, result, expected);
            end else begin
                $display("✗ FAIL: (%d×%d) + (%d×%d) + (%d×%d) = %d (expected %d)", 
                         a_val, b_val, c_val, d_val, e_val, f_val, result, expected);
            end
        end
    endtask
    
    initial begin
        $display("=== 3×(4-Bit Multiplier) + Adder Testbench ===\n");
        
        // Test 1: All zeros
        $display("--- Test 1: All Zeros ---");
        test_mult_add(4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 9'd0);
        
        // Test 2: Single multiplication
        $display("\n--- Test 2: Single Non-Zero Multiplication ---");
        test_mult_add(4'd2, 4'd3, 4'd0, 4'd0, 4'd0, 4'd0, 9'd6);      // 2×3 = 6
        test_mult_add(4'd0, 4'd0, 4'd5, 4'd4, 4'd0, 4'd0, 9'd20);     // 5×4 = 20
        test_mult_add(4'd0, 4'd0, 4'd0, 4'd0, 4'd7, 4'd2, 9'd14);     // 7×2 = 14
        
        // Test 3: Two multiplications
        $display("\n--- Test 3: Two Non-Zero Multiplications ---");
        test_mult_add(4'd2, 4'd3, 4'd4, 4'd5, 4'd0, 4'd0, 9'd26);     // 2×3 + 4×5 = 6 + 20 = 26
        test_mult_add(4'd3, 4'd3, 4'd3, 4'd3, 4'd0, 4'd0, 9'd18);     // 3×3 + 3×3 = 9 + 9 = 18
        
        // Test 4: All three multiplications
        $display("\n--- Test 4: All Three Multiplications ---");
        test_mult_add(4'd2, 4'd2, 4'd3, 4'd3, 4'd2, 4'd2, 9'd22);     // 2×2 + 3×3 + 2×2 = 4 + 9 + 4 = 17
        $display("Products: %d, %d, %d", product, product2, product3);
        test_mult_add(4'd3, 4'd3, 4'd2, 4'd2, 4'd1, 4'd1, 9'd14);     // 3×3 + 2×2 + 1×1 = 9 + 4 + 1 = 14
        test_mult_add(4'd2, 4'd3, 4'd3, 4'd2, 4'd2, 4'd3, 9'd18);     // 2×3 + 3×2 + 2×3 = 6 + 6 + 6 = 18
        
        // Test 5: Larger numbers
        $display("\n--- Test 5: Larger Numbers ---");
        test_mult_add(4'd5, 4'd4, 4'd3, 4'd6, 4'd2, 4'd7, 9'd80);     // 5×4 + 3×6 + 2×7 = 20 + 18 + 14 = 52
        $display("Products: %d, %d, %d", product, product2, product3);
        test_mult_add(4'd8, 4'd8, 4'd7, 4'd7, 4'd6, 4'd6, 9'd245);    // 8×8 + 7×7 + 6×6 = 64 + 49 + 36 = 149
        
        // Test 6: Maximum values
        $display("\n--- Test 6: Maximum Values ---");
        test_mult_add(4'd15, 4'd15, 4'd15, 4'd15, 4'd15, 4'd15, 9'd480); // 15×15 + 15×15 + 15×15 = 225 + 225 + 225 = 675 (aber max 9-Bit = 511, overflow!)
        
        // Test 7: Edge cases - One factor = 1
        $display("\n--- Test 7: Edge Cases (Factor = 1) ---");
        test_mult_add(4'd1, 4'd15, 4'd1, 4'd14, 4'd1, 4'd13, 9'd42);  // 1×15 + 1×14 + 1×13 = 15 + 14 + 13 = 42
        test_mult_add(4'd15, 4'd1, 4'd14, 4'd1, 4'd13, 4'd1, 9'd42);  // 15×1 + 14×1 + 13×1 = 15 + 14 + 13 = 42
        
        // Test 8: Powers of 2
        $display("\n--- Test 8: Powers of 2 ---");
        test_mult_add(4'd4, 4'd4, 4'd4, 4'd4, 4'd4, 4'd4, 9'd48);     // 4×4 + 4×4 + 4×4 = 16 + 16 + 16 = 48
        test_mult_add(4'd8, 4'd2, 4'd4, 4'd4, 4'd2, 4'd8, 9'd48);     // 8×2 + 4×4 + 2×8 = 16 + 16 + 16 = 48
        
        // Test 9: Asymmetric combinations
        $display("\n--- Test 9: Asymmetric Combinations ---");
        test_mult_add(4'd1, 4'd1, 4'd2, 4'd2, 4'd3, 4'd3, 9'd14);     // 1×1 + 2×2 + 3×3 = 1 + 4 + 9 = 14
        test_mult_add(4'd5, 4'd6, 4'd7, 4'd8, 4'd9, 4'd10, 9'd284);   // 5×6 + 7×8 + 9×10 = 30 + 56 + 90 = 176
        
        $display("\n=== Test Complete ===");
        $finish;
    end
    
    // ========== Optional: Monitor ==========
    initial begin
        $monitor("Time=%0t | (a=%2d×b=%2d) + (c=%2d×d=%2d) + (e=%2d×f=%2d) = %3d", 
                 $time, a, b, c, d, e, f, result);
    end
endmodule
