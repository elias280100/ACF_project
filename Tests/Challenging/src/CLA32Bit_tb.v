module cla16_tb;
    reg  [15:0] A, B;
    reg          Cin;
    wire [15:0] Sum;
    wire        Cout;
    wire [16:0] expected;  // Referenz: A + B + Cin
    CLA16 dut (  // DUT = Device Under Test
        .A(A), .B(B), .Cin(Cin),
        .Sum(Sum), .Cout(Cout)
    );
    assign expected = A + B + Cin;

    initial begin
        

        

        // Edge Cases
        test(16'h0000, 16'h0000, 0);  // 0+0
        test(16'hFFFF, 16'h0000, 0);  // MAX+0
        test(16'hFFFF, 16'hFFFF, 1);  // MAX+MAX+Cin=1 → Overflow
        test(16'h0001, 16'hFFFF, 0);  // Carry Propagation

        // Random Tests (1000x)
        repeat(10) begin
            A = $random; B = $random; Cin = $random;
            #1 test(A, B, Cin);
        end

        $display("✓ All tests passed!");
        $finish;
    end

    task test(input [15:0] a, b, input cin);
        begin
            A = a; B = b; Cin = cin;
            #1;  // Warte 1 Zeitstep

            if (Sum !== expected[15:0] || Cout !== expected[16]) begin
                $error("✗ FAIL: %h + %h + %b = %h|%b  (exp: %h|%b)",
                       A, B, Cin, Sum, Cout, expected[15:0], expected[16]);
            end else
                $display("✓ OK: %h + %h + %b = %h|%b", A, B, Cin, Sum, Cout);
        end
    endtask
endmodule
