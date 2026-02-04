module add4
    (input [3:0] A, B, 
    output [4:0] sum
    );

  wire [3:0] cout;
  assign {cout[0], sum[0]} = A[0] + B[0];
  assign {cout[1], sum[1]} = A[1] + B[1] + cout[0];
  assign {cout[2], sum[2]} = A[2] + B[2] + cout[1];
  assign {cout[3], sum[3]} = A[3] + B[3] + cout[2];
  assign sum[4] = cout[3];
  
endmodule
