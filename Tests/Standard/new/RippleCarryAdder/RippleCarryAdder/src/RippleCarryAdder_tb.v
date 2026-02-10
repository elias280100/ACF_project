module RCA_tb;
    reg [3:0] A, B;
    reg cin;
    wire [3:0] sum;
    wire cout;

    add4 dut (
        .A(A),
        .B(B),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    initial begin
        // Test case 1: 0 + 0 + 0 = 0
        A = 4'b0000; B = 4'b0000; cin = 0; #10;
        $display("Test case 1: %b + %b + %b = %b, cout = %b", A, B, cin, sum, cout);

        // Test case 2: 1 + 1 + 0 = 2 (in binary, this will be represented as '0010')
        A = 4'b0001; B = 4'b0001; cin = 0; #10;
        $display("Test case 2: %b + %b + %b = %b, cout = %b", A, B, cin, sum, cout);

        // Test case 3: 1 + 1 + 1 = 3 (in binary, this will be represented as '0011')
        A = 4'b0001; B = 4'b0001; cin = 1; #10;
        $display("Test case 3: %b + %b + %b = %b, cout = %b", A, B, cin, sum, cout);

        // Test case 4: 15 + 15 + 1 = 31 (in binary, this will be represented as '11111')
        A = 4'b1111; B = 4'b1111; cin = 1; #10;
        $display("Test case 4: %b + %b + %b = %b, cout = %b", A, B, cin, sum, cout);

        // Test case 5: 5 + 10 + 0 = 15 (in binary, this will be represented as '01111')
        A = 4'b0101; B = 4'b1010; cin = 0; #10;
        $display("Test case 5: %b + %b + %b = %b, cout = %b", A, B, cin, sum, cout);
        
        $finish;
    end
endmodule