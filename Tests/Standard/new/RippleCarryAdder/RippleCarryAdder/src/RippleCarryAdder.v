module add4
    (input [3:0] A, B,
    input cin, 
    output [3:0] sum,
    output cout
    );

  assign {cout, sum} = A + B + cin;
  
endmodule
