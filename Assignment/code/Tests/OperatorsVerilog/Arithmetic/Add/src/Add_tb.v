module ADD_tb;
    reg [7:0] a, b;
    wire [7:0] sum;

    ADD dut (
        .a(a),
        .b(b),
        .sum(sum)
    );

    initial begin
        
        a = 0; b = 0; #10;
        $display("Test case 1: %b + %b = %b", a, b, sum);

        
        a = 0; b = 1; #10;
        $display("Test case 2: %b + %b = %b", a, b, sum);
        
        a = 1; b = 0; #10;
        $display("Test case 3: %b + %b = %b", a, b, sum);

        
        a = 1; b = 1; #10;
        $display("Test case 4: %b + %b = %b", a, b, sum);
        
        $finish;
    end
endmodule