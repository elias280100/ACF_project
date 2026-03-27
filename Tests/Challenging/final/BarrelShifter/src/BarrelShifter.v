module BarrelShifter (
	input [31:0] data_in,
    input  [$clog2(32)-1:0] shift_amount,
    input  shift_direction, // 0: right shift, 1: left shift
    input  shift_type, // 0: logical shift, 1: arithmetic shift
    output [31:0] data_out
	);

    reg [31:0] data_out_reg;

    assign data_out = data_out_reg;

	// Barrel shifter logic/arithmetic
  	always @(*) begin
		//logical shift
		if (shift_type == 1'b0)  begin// Logical shift
			if (shift_direction == 1'b0) // Right shift
				data_out_reg = (data_in >> shift_amount) ;
			else // Left shift
				data_out_reg = (data_in << shift_amount) ;
		end 
		//arithmetic shift
		else if (shift_type == 1'b1) begin
			if (shift_direction == 1'b0) // Right shift
			data_out_reg = $signed(data_in) >>> shift_amount ;
			else // Left shift
			data_out_reg = $signed(data_in) <<< shift_amount ;
		end
	end

endmodule : BarrelShifter
