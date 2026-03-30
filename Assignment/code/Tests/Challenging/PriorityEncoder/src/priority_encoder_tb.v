module priority_encoder_tb;

reg [7:0] in;
wire [2:0] out;
wire valid;

priority_encoder DUT (
    .in(in),
    .out(out),
    .valid(valid)
);

initial begin
        // Test case 1: 
        in = 8'b10010010;
        #10; 
        if(out == 3'd7) begin
            $display("successful");
        end
        else begin
            $display("failed");
        end

        // Test case 2: 
        in = 8'b01010010;
        #10; 
        if(out == 3'd6) begin
            $display("successful");
        end
        else begin
            $display("failed");
        end

        // Test case 3: 
        in = 8'b00111111;
        #10; 
        if(out == 3'd5) begin
            $display("successful");
        end
        else begin
            $display("failed");
        end
        // Test case 4: 
        in = 8'b00000111;
        #10; 
        if(out == 3'd2) begin
            $display("successful");
        end
        else begin
            $display("failed");
        end
        // Test case 5: 
        in = 8'b00010101;
        #10; 
        if(out == 3'd4) begin
            $display("successful");
        end
        else begin
            $display("failed");
        end
end

endmodule