module Hello_World_tb;
    reg clk;
    reg button;
    reg testbutton;
    wire tx;

    localparam CLK_FREQ = 100000000;
    localparam BAUD     = 115200;
    localparam BAUD_DIV = CLK_FREQ/BAUD;



    // ========== Device uder test ==========
    Hello_World #(
        .CLK_FREQ(CLK_FREQ),
        .BAUD(BAUD)
        )
        dut (
        .clk(clk),
        .button(button),
        .tx(tx)
        );

    // ========== Clock Generator ==========
        initial clk = 1'b0;
        always #5 clk = ~clk;  // 10 ns Period (100 MHz)
        

    //Wavefrom dump
    initial begin
        // Dump für GTKWave/ModelSim
        $dumpfile("hello_world_tb.vcd");
        $dumpvars(0, Hello_World_tb);
    end

    // ========== Stimulus ==========
    initial begin
        button = 1'b0;
        testbutton = 1'b0;

        $display("Button not pressed, value = %b", button);
        $display("Test button not pressed, value = %b", testbutton);
        #100;

        button = 1'b1;
        testbutton = 1'b1;
        $display("Button pressed value = %b", button);
        $display("Test button pressed, value = %b", testbutton);
        #1000000;

        button = 1'b0;
        testbutton = 1'b0;

        #2000000;

        $finish;
    end

endmodule


