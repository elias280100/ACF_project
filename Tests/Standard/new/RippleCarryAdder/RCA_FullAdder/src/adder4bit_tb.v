module adder4bit_tb;
    reg [3:0] a, b;
    reg carry_in;
    wire [3:0] sum;
    wire carry_out;

    // Instantiate the 4-bit ripple carry adder
    adder_ripple_carry dut (
        .A(a),
        .B(b),
        .Cin(carry_in),
        .Sum(sum),
        .Cout(carry_out)
    );

    initial begin
        // Test case 1
        a = 4'b0001; // 1
        b = 4'b0010; // 2
        carry_in = 0;
        #10; // Wait for 10 time units
        $display("Test case 1: A = %b, B = %b, Cin = %b, Sum = %b, Cout = %b", a, b, carry_in, sum, carry_out);

        // Test case 2
        a = 4'b0101; // 5
        b = 4'b0110; // 6
        carry_in = 0;
        #10;
        $display("Test case 2: A = %b, B = %b, Cin = %b, Sum = %b, Cout = %b", a, b, carry_in, sum, carry_out);

        // Test case 3
        a = 4'b1111; // 15
        b = 4'b0001; // 1
        carry_in = 0;
        #10;
        $display("Test case 3: A = %b, B = %b, Cin = %b, Sum = %b, Cout = %b", a, b, carry_in, sum, carry_out);

        // Test case 4
        a = 4'b1010; // 10
        b = 4'b0101; // 5
        carry_in = 1;
        #10;
        $display("Test case 4: A = %b, B = %b, Cin = %b, Sum = %b, Cout = %b", a, b, carry_in, sum, carry_out);

        $finish; // End simulation
    end
endmodule