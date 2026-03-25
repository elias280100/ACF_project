module priority_encoder (
    input [7:0] in,
    output reg [2:0] out,
    output reg valid
);
    always @(*) begin      
        casex (in)                   
            8'b1?????zz: out = 3'd7;
            8'b01??xxzz: out = 3'd6;
            8'b001xxx?x: out = 3'd5;
            8'b0001????: out = 3'd4;
            8'b00001?x?: out = 3'd3;
            8'b000001z?: out = 3'd2;
            8'b0000001?: out = 3'd1;
            8'b00000001: out = 3'd0;
            default:     out = 3'd0; // Default case
        endcase
        valid = |in; // Set valid if any input bit is high
    end
endmodule