module FSM_16state_tb;

reg clk;
reg reset;
reg trigger;
wire [3:0] output_state;

parameter CLK_T            = 10000;

parameter   S0 = 16'b0000_0000_0000_0001,
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

initial clk = 1'b0;
always #(CLK_T / 2) clk = ~clk;

FSM_16state #(
    .S0(S0),
    .S1(S1),
    .S2(S2),
    .S3(S3),
    .S4(S4),
    .S5(S5),
    .S6(S6),
    .S7(S7),
    .S8(S8),
    .S9(S9),
    .S10(S10),
    .S11(S11),
    .S12(S12),
    .S13(S13),
    .S14(S14),
    .S15(S15)
) DUT (
    .clk(clk),
    .reset(reset),
    .trigger(trigger),
    .output_state(output_state)
);

task apply_reset;
  begin
    @(posedge clk);
    reset = 1'b1;
    @(posedge clk);
    reset = 1'b0;
  end
endtask

initial begin
  $dumpfile("FSM.vcd");
  $dumpvars(0, FSM_16state);
end

initial begin
    reset = 1'b0;
    trigger = 1'b0;
    apply_reset;

    repeat(10) @(posedge clk);
    trigger <= 1'b1;
    @(posedge clk);
    trigger <= 1'b1;
    
    repeat(100) @(posedge clk);
    $stop;
end
endmodule


