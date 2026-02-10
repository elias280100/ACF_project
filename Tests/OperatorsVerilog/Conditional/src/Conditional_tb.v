module Conditional_tb;
    reg clk, rst, in;
    wire out;
    
    // DUT (Device Under Test) instantiieren
    Conditional dut (
        .clk(clk),
        .rst(rst),
        .in(in),
        .out(out)
    );
    
    // ========== Clock Generator ==========
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10 ns Period (100 MHz)
    end
    
    // ========== Test Sequence ==========
    initial begin
        // Test 1: Reset
        $display("=== Test 1: Reset ===");
        rst = 1; in = 0;
        #10;
        rst = 0;
        #10;
        $display("After reset: out=%b (expected 0)", out);
        
        // Test 2: Übergang S0 → S1 (in=1)
        $display("\n=== Test 2: S0 → S1 (in=1) ===");
        in = 1;
        #10;
        $display("After in=1: out=%b (expected 0, still in S1)", out);
        
        // Test 3: Übergang S1 → S2 (in=1)
        $display("\n=== Test 3: S1 → S2 (in=1) ===");
        in = 1;
        #10;
        $display("After in=1: out=%b (expected 1, now in S2)", out);
        
        // Test 4: Übergang S2 → S0 (in=1)
        $display("\n=== Test 4: S2 → S0 (in=1) ===");
        in = 1;
        #10;
        $display("After in=1: out=%b (expected 0, back to S0)", out);
        
        // Test 5: Bleiben in S0 (in=0)
        $display("\n=== Test 5: S0 → S0 (in=0) ===");
        in = 0;
        #10;
        $display("After in=0: out=%b (expected 0, stay in S0)", out);
        
        // Test 6: Abbruch-Sequenz (in=1 → in=1 → in=0)
        $display("\n=== Test 6: S0 → S1 → S1 (in=0 Abbruch) ===");
        in = 1;
        #10;
        in = 1;
        #10;
        $display("At S1: out=%b", out);
        in = 0;  // Abbruch!
        #10;
        $display("After in=0 (Abbruch): out=%b (back to S0)", out);
        
        // Test 7: Komplette Sequenz (0→1→1→1)
        $display("\n=== Test 7: Komplette Sequenz (in=1,1,1) ===");
        in = 0;
        #10;
        in = 1;  // S0 → S1
        #10;
        $display("Step 1 (S0→S1): out=%b", out);
        in = 1;  // S1 → S2
        #10;
        $display("Step 2 (S1→S2): out=%b", out);
        in = 1;  // S2 → S0
        #10;
        $display("Step 3 (S2→S0): out=%b", out);
        
        // Test 8: Reset während Sequenz
        $display("\n=== Test 8: Reset während Sequenz ===");
        in = 1;
        #10;
        rst = 1;
        #10;
        rst = 0;
        $display("Nach Reset: out=%b (expected 0)", out);
        
        $finish;
    end
    
    // ========== Optional: Monitoring ==========
    initial begin
        $monitor("Time=%0t | clk=%b rst=%b in=%b | out=%b | state=%b", 
                 $time, clk, rst, in, out, dut.state);
    end
endmodule
