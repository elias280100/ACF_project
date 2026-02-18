module Divide_tb;
    reg [7:0] a, b;
    wire [7:0] c;

    Divide dut (
        .a(a),
        .b(b),
        .c(c)
    );


        // ========== Test Task ==========
    task test_division(input [7:0] a_val, b_val, expected);
        begin
            a = a_val;
            b = b_val;
            #10;
            if (c == expected) begin
                $display("PASS: %d / %d = %d (expected %d)", a_val, b_val, c, expected);
            end else begin
                $display("FAIL: %d / %d = %d (expected %d)", a_val, b_val, c, expected);
            end
        end
    endtask

    initial begin
        // Test case 1: 10 / 2 = 5
        
        test_division(10, 2, 5);
        #10;

        // Test case 2: 20 / 4 = 5
        
        test_division(20, 4, 5);
        #10;

        // Test case 3: 15 / 3 = 5
        
        test_division(15, 3, 5);
        #10;

        
        // Test case 4: 28 / 7 = 4
        test_division(28, 4, 7);
        #10;

        //Test case 5 : 10 / 0 = x
        a = 10;
        b = 0;
        #10;
        $display("%b / %b = %b",a, b, c);
        
        
        $finish;
    end
endmodule