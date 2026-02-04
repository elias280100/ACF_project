module CLA_tb;
    reg  [7:0] A;
    reg  [7:0] B;
    reg        Cin;
    wire [7:0] Sum;
    wire       Cout;

    CLA8 dut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );

    // ========== Test Task ==========
    task test_addition(input [7:0] a_val, b_val, input cin_val, input [7:0] expected_sum, input expected_cout);
        begin
            A = a_val;
            B = b_val;
            Cin = cin_val;
            #10;
            if (Sum == expected_sum && Cout == expected_cout) begin
                $display("✓ PASS: %d + %d + %d = %d with Cout=%d (expected %d with Cout=%d)", 
                         a_val, b_val, cin_val, Sum, Cout, expected_sum, expected_cout);
            end else begin
                $display("✗ FAIL: %d + %d + %d = %d with Cout=%d (expected %d with Cout=%d)", 
                         a_val, b_val, cin_val, Sum, Cout, expected_sum, expected_cout);
            end
        end
    endtask

    initial begin
        $display("=== 8-Bit CLA Testbench ===\n");
        
        // Test 1: Simple additions without carry-in
        $display("--- Test 1: Simple Additions without Carry-In ---");
        test_addition(8'd15, 8'd10, 1'b0, 8'd25, 1'b0);
        test_addition(8'd100, 8'd28, 1'b0, 8'd128, 1'b0);
        test_addition(8'd200, 8'd55, 1'b0, 8'd255, 1'b0);
        
        // Test 2: Additions with carry-in
        $display("\n--- Test 2: Additions with Carry-In ---");
        test_addition(8'd50, 8'd75, 1'b1, 8'd126, 1'b0);
        test_addition(8'd130, 8'd130, 1'b1, 8'd5, 1'b1);
        test_addition(8'd255, 8'd1, 1'b1, 8'd1, 1'b1);
        // Test 3: Edge cases
        $display("\n--- Test 3: Edge Cases ---");
        test_addition(8'd0, 8'd0, 1'b0, 8'd0, 1'b0);
        test_addition(8'd0, 8'd0, 1'b1, 8'd1, 1'b0);    

    end
endmodule