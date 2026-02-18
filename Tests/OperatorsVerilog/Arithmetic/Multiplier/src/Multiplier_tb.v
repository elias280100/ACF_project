module Multiplier_tb;
    reg [3:0] A;
    reg [3:0] B;
    wire [7:0] P;

    Multiplier dut (
        .A(A),
        .B(B),
        .P(P)
    );


        // ========== Test Task ==========
    task test_multiplication(input [3:0] a_val, b_val, input [7:0] expected);
        begin
            A = a_val;
            B = b_val;
            #10;
            if (P == expected) begin
                $display("PASS: %d × %d = %d (expected %d)", a_val, b_val, P, expected);
            end else begin
                $display("FAIL: %d × %d = %d (expected %d)", a_val, b_val, P, expected);
            end
        end
    endtask
    
    initial begin
        $display("=== 4-Bit Multiplier Testbench ===\n");
        
        // Test 1: Zero cases
        $display("--- Test 1: Zero Cases ---");
        test_multiplication(4'd0, 4'd0, 8'd0);
        test_multiplication(4'd0, 4'd5, 8'd0);
        test_multiplication(4'd7, 4'd0, 8'd0);
        
        // Test 2: Ones
        $display("\n--- Test 2: Multiply by One ---");
        test_multiplication(4'd1, 4'd1, 8'd1);
        test_multiplication(4'd5, 4'd1, 8'd5);
        test_multiplication(4'd1, 4'd15, 8'd15);
        
        // Test 3: Small numbers
        $display("\n--- Test 3: Small Numbers ---");
        test_multiplication(4'd2, 4'd3, 8'd6);
        test_multiplication(4'd4, 4'd5, 8'd20);
        test_multiplication(4'd3, 4'd7, 8'd21);
        
        // Test 4: Powers of 2
        $display("\n--- Test 4: Powers of 2 ---");
        test_multiplication(4'd2, 4'd2, 8'd4);
        test_multiplication(4'd2, 4'd4, 8'd8);
        test_multiplication(4'd4, 4'd4, 8'd16);
        test_multiplication(4'd8, 4'd2, 8'd16);
        
        // Test 5: Medium numbers
        $display("\n--- Test 5: Medium Numbers ---");
        test_multiplication(4'd6, 4'd7, 8'd42);
        test_multiplication(4'd9, 4'd5, 8'd45);
        test_multiplication(4'd10, 4'd6, 8'd60);
        
        // Test 6: Maximum values
        $display("\n--- Test 6: Maximum Values ---");
        test_multiplication(4'd15, 4'd15, 8'd225);  // 15 × 15 = 225
        test_multiplication(4'd15, 4'd14, 8'd210);
        test_multiplication(4'd14, 4'd13, 8'd182);
        
        // Test 7: Asymmetric
        $display("\n--- Test 7: Asymmetric ---");
        test_multiplication(4'd1, 4'd15, 8'd15);
        test_multiplication(4'd15, 4'd1, 8'd15);
        test_multiplication(4'd3, 4'd11, 8'd33);
        
        // Test 8: Edge cases (partial products)
        $display("\n--- Test 8: Edge Cases ---");
        test_multiplication(4'd7, 4'd8, 8'd56);
        test_multiplication(4'd11, 4'd12, 8'd132);
        test_multiplication(4'd13, 4'd13, 8'd169);
        
        $display("\n=== Test Complete ===");
        $finish;
    end
    
endmodule
