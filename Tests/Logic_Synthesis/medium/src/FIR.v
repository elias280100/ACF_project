module FIR (
    input clk,
    input rst,
    input [7:0] din,
    output reg [15:0] dout
);
    // Coefficients for a simple low-pass FIR filter
    parameter COEFF0 = 8'd1;        //8 bit decimal value
    parameter COEFF1 = 8'd2;
    parameter COEFF2 = 8'd3;
    parameter COEFF3 = 8'd4;

    reg [7:0] shift_reg [0:3];      //4x8 bit shift register
    integer i;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < 4; i = i + 1) begin
                shift_reg[i] <= 8'd0;
            end
            dout <= 16'd0;
        end 
        else begin
            // Shift the input samples
            shift_reg[0] <= din;
            for (i = 1; i < 4; i = i + 1) begin
                shift_reg[i] <= shift_reg[i-1];
            end

            // Compute the FIR output
            dout <= (shift_reg[0] * COEFF0) +
                    (shift_reg[1] * COEFF1) +
                    (shift_reg[2] * COEFF2) +
                    (shift_reg[3] * COEFF3);
        end
    end
endmodule
