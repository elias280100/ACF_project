module Logical_right_shift_tb;
    reg [7:0] data;
    reg [3:0] shift;
    wire [7:0] result;

    Logical_right_shift dut (
        .data(data),
        .shift(shift),
        .result(result)
    );

    initial begin
        //Test 1
        data = 8'b10100110;
        shift = 4'b0010;
        #10;
        $display("data = %b, shift = %b, result = %b", data, shift, result);

        //Test 2
        data = 8'b10100110;
        shift = 4'b0000;
        #10;
        $display("data = %b, shift = %b, result = %b", data, shift, result);

        //Test 3
        data = 8'b10100110;
        shift = 4'b0001;
        #10;
        $display("data = %b, shift = %b, result = %b", data, shift, result);


    end
endmodule