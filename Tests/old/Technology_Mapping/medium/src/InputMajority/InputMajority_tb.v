module maj_input_tb;
    reg [6:0] in;
    wire      out;

    maj_input dut (
        .in(in),
        .out(out)   
    );

    // ========== Test Task ==========
    task test_maj_input(input [6:0] in_val, input expected_out);
        begin
            in = in_val;
        
            #10;
            if (out == expected_out) begin
                $display("✓ PASS: Majority of %b = %b (expected %b)", 
                         in_val, out, expected_out);
            end else begin
                $display("✗ FAIL: Majority of %b = %b (expected %b)", 
                         in_val, out, expected_out);
            end
        end
    endtask

    initial begin
        $display("=== 7-Input Majority Testbench ===\n");
        
        // Test Cases
        $display("--- Test Cases ---");
        test_maj_input(7'b0000000, 1'b0); // 0 ones
        test_maj_input(7'b0000001, 1'b0); // 1 one
        test_maj_input(7'b0000111, 1'b1); // 3 ones
        test_maj_input(7'b0001111, 1'b1); // 4 ones
        test_maj_input(7'b0011111, 1'b1); // 5 ones
        test_maj_input(7'b0111111, 1'b1); // 6 ones
        test_maj_input(7'b1111111, 1'b1); // 7 ones
        test_maj_input(7'b1010101, 1'b1); // 4 ones

    end
endmodule