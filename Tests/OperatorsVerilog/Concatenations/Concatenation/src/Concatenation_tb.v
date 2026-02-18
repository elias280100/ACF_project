module Concatenation_tb;
 reg [1:0] a;
 reg [3:0] b;
 reg [5:0] c;
 wire [11:0] concat;

 Concatenation dut (
    .a(a),
    .b(b),
    .c(c),
    .concat(concat)
 );

     // ========== Test Task ==========
    task test_concat(input [1:0] a_val, input [3:0] b_val, input [5:0] c_val, input [11:0] expected);
        begin
            a = a_val;
            b = b_val;
            c = c_val;
            #10;
            if (concat == expected) begin
                $display("PASS: %d , %d , %d = %d (expected %d)", a_val, b_val, c_val, concat, expected);
            end else begin
                $display("FAIL: %d , %d , %d = %d (expected %d)", a_val, b_val, c_val, concat, expected);
            end
        end
    endtask


    initial begin
        //Test 1
        test_concat(1, 5, 10, 1354);
        test_concat(2, 7, 39, 2535);
        test_concat(3, 3, 28, 3292);

    end

    endmodule
    