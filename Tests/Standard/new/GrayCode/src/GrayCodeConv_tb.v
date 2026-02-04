module GrayCodeConv_tb;
    reg  [7:0] binary_in;
    wire [7:0] gray_out;

    gray_code_conv dut (
        .binary_in(binary_in),
        .gray_out(gray_out)
    );

    // ========== Test Task ==========
    task test_gray_code(input [7:0] bin_val, input [7:0] expected_gray);
        begin
            binary_in = bin_val;
        
            #10;
            if (gray_out == expected_gray) begin
                $display("✓ PASS: Gray code of %b = %b (expected %b)", 
                         bin_val, gray_out, expected_gray);
            end else begin
                $display("✗ FAIL: Gray code of %b = %b (expected %b)", 
                         bin_val, gray_out, expected_gray);
            end
        end
    endtask

    initial begin
        $display("=== 8-Bit Gray Code Conversion Testbench ===\n");
        
        // Test Cases
        $display("--- Test Cases ---");
        test_gray_code(8'b00000000, 8'b00000000); // 0
        test_gray_code(8'b00000001, 8'b00000001); // 1
        test_gray_code(8'b00000010, 8'b00000011); // 2
        test_gray_code(8'b00000011, 8'b00000010); // 3
        test_gray_code(8'b00000100, 8'b00000110); // 4
        test_gray_code(8'b00000101, 8'b00000111); // 5
        test_gray_code(8'b11111111, 8'b10000000); // 255
        test_gray_code(8'b10101010, 8'b11111111); // 170

    end
endmodule