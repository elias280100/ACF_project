module FSM_16state (
    input clk,
    input reset,
    input trigger,
    output reg [3:0] output_state
);

    parameter S0 = 16'b0000_0000_0000_0001,
              S1 = 16'b0000_0000_0000_0010,
              S2 = 16'b0000_0000_0000_0100,
              S3 = 16'b0000_0000_0000_1000,
              S4 = 16'b0000_0000_0001_0000,
              S5 = 16'b0000_0000_0010_0000,
              S6 = 16'b0000_0000_0100_0000,
              S7 = 16'b0000_0000_1000_0000,
              S8 = 16'b0000_0001_0000_0000,
              S9 = 16'b0000_0010_0000_0000,
              S10= 16'b0000_0100_0000_0000,
              S11= 16'b0000_1000_0000_0000,
              S12= 16'b0001_0000_0000_0000,
              S13= 16'b0010_0000_0000_0000,
              S14= 16'b0100_0000_0000_0000,
              S15= 16'b1000_0000_0000_0000;

    reg [15:0] state, next_state;

    always @(posedge clk) begin
        if (reset == 1'b1) begin
            state <= S0;
        end
        else begin
            state <= next_state;
        end
    end

    always @(*) begin 
        case (state)
            S0: begin
                output_state = 4'b0000;
                next_state = trigger ? S1 : S0;
            end
            S1: begin
                output_state = 4'b0001;
                next_state = trigger ? S2 : S0;
            end
            S2: begin
                output_state = 4'b0010;
                next_state = trigger ? S3 : S0;
            end
            S3: begin
                output_state = 4'b0011;
                next_state = trigger ? S4 : S0;
            end
            S4: begin
                output_state = 4'b0100;
                next_state = trigger ? S5 : S0;
            end
            S5: begin
                output_state = 4'b0101;
                next_state = trigger ? S6 : S0;
            end
            S6: begin
                output_state = 4'b0110;
                next_state = trigger ? S7 : S0;
            end
            S7: begin
                output_state = 4'b0111;
                next_state = trigger ? S8 : S0;
            end
            S8: begin
                output_state = 4'b1000;
                next_state = trigger ? S9 : S0;
            end
            S9: begin
                output_state = 4'b1001;
                next_state = trigger ? S10 : S0;
            end
            S10: begin
                output_state = 4'b1010;
                next_state = trigger ? S11 : S0;
            end
            S11: begin
                output_state = 4'b1011;
                next_state = trigger ? S12 : S0;
            end
            S12: begin
                output_state = 4'b1100;
                next_state = trigger ? S13 : S0;
            end
            S13: begin
                output_state = 4'b1101;
                next_state = trigger ? S14 : S0;
            end
            S14: begin
                output_state = 4'b1110;
                next_state = trigger ? S15 : S0;
            end
            S15: begin
                output_state = 4'b1111;
                next_state = trigger ? S0 : S15;
            end
            default: begin
                output_state = 4'b0000;
                next_state = S0;
            end
        endcase
    end
endmodule