module Replication_tb;
reg[2:0] a;
reg[2:0] b;
wire[14:0] result1;
wire[14:0] result2;
wire[14:0] result3;

Replication dut (
    .a(a),
    .b(b),
    .result1(result1),
    .result2(result2),
    .result3(result3)
);

     // ========== Test Task ==========
    task test_replicate1(input [2:0] a_val, b_val, input [14:0] expected);
        begin
            a = a_val;
            b = b_val;
            #10;
            if (result1 == expected) begin
                $display("PASS: %d , %d  => %d (expected %d)", a_val, b_val, result1, expected);

            end else begin
                $display("FAIL: %d , %d  => %d (expected %d)", a_val, b_val, result1, expected);
            end
        end
    endtask

     // ========== Test Task ==========
    task test_replicate2(input [2:0] a_val, input [14:0] expected);
        begin
            a = a_val;
            
            #10;
            if (result2 == expected) begin
                $display("PASS: %d => %d (expected %d)", a_val, result2, expected);

            end else begin
                $display("FAIL: %d => %d (expected %d)", a_val, result2, expected);
            end
        end
    endtask

    // ========== Test Task ==========
    task test_replicate3(input [2:0] a_val, b_val, input [14:0] expected);
        begin
            a = a_val;
            b = b_val;
            #10;
            if (result3 == expected) begin
                $display("PASS: %d , %d  =>%d (expected %d)", a_val, b_val, result3, expected);

            end else begin
                $display("FAIL: %d , %d  => %d (expected %d)", a_val, b_val, result3, expected);
            end
        end
    endtask



    initial begin
        
        test_replicate1(1, 2, 4690);
        test_replicate2(2, 9362);
        test_replicate3(1, 4, 4876);

    end

    endmodule