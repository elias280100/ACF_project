module Parity_tb;
    reg [15:0] in;
    wire       out;

    parity dut (
        .in(in),
        .out(out)   
    );

    // ========== Test Task ==========
    task test_parity(input [15:0] in_val, input expected_out);
        begin
            in = in_val;
        
            #10;
            if (out == expected_out) begin
                $display("✓ PASS: Parity of %b = %b (expected %b)", 
                         in_val, out, expected_out);
            end else begin
                $display("✗ FAIL: Parity of %b = %b (expected %b)", 
                         in_val, out, expected_out);
            end
        end
    endtask

    initial begin
        $display("=== 16-Bit Parity Testbench ===\n");
        
        // Test Cases
        $display("--- Test Cases ---");
        test_parity(16'b0000000000000000, 1'b0); // Even parity
        test_parity(16'b0000000000000001, 1'b1); // Odd parity
        test_parity(16'b1111111111111111, 1'b0); // Even parity
        test_parity(16'b1010101010101010, 1'b0); // Even parity
        test_parity(16'b1111000011110000, 1'b0); // Even parity
        test_parity(16'b1100110011001100, 1'b0); // Even parity
        test_parity(16'b0000111100001111, 1'b0); // Even parity
        test_parity(16'b1000000000000000, 1'b1); // Odd parity

    end
endmodule