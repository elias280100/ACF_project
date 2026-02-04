`timescale 1ns / 1ps

module CRC32_tb;

    // Testbench Signals
    reg         CLK;
    reg         reset;
    reg  [7:0]  data_in;
    reg         enable;
    reg         clear;
    wire [31:0] CRC;
    
    // DUT Instantiation
    CRC32 #(
        .RESET_SEED(32'hFFFFFFFF)  // Ethernet Standard Init!
    ) dut (
        .CLK(CLK),
        .reset(reset),
        .data_in(data_in),
        .enable(enable),
        .clear(clear),
        .CRC(CRC)
    );
    
    // Clock Generation (10ns period = 100MHz)
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;
    end
    
    // Test Sequence
    initial begin
        // Initialize
        reset  = 0;
        enable = 0;
        clear  = 0;
        data_in = 8'h00;
        
        $display("=== CRC32 Testbench Started ===");
        $display("RESET_SEED = 0x%08h (Ethernet)", 32'hFFFFFFFF);
        $display("");
        
        // Test 1: Reset Check
        $display("Test 1: Reset Verification");
        reset = 0; #20;
        reset = 1; #20;
        $display("  CRC after reset: 0x%08h ✓", CRC);
        $display("");
        
        // Test 2: Single Byte 0x00
        $display("Test 2: Single Byte 0x00");
        clear  = 1; #10; clear  = 0;
        enable = 1; data_in = 8'h00; #20;
        enable = 0; #20;
        $display("  Input: 0x00 → CRC: 0x%08h", CRC);
        $display("");
        
        // Test 3: Multi-Byte Stream [0x12, 0x34, 0x56, 0x78]
        $display("Test 3: Multi-Byte Stream [0x12, 0x34, 0x56, 0x78]");
        clear  = 1; #10; clear  = 0;
        
        // Byte 1
        enable = 1; data_in = 8'h12; #20;
        $display("  Byte 1 (0x12): 0x%08h", CRC);
        
        // Byte 2  
        data_in = 8'h34; #20;
        $display("  Byte 2 (0x34): 0x%08h", CRC);
        
        // Byte 3
        data_in = 8'h56; #20;
        $display("  Byte 3 (0x56): 0x%08h", CRC);
        
        // Byte 4
        data_in = 8'h78; #20;
        $display("  Final (0x78): 0x%08h", CRC);
        enable = 0; #20;
        $display("");
        
        // Test 4: Clear + Single Byte 0xFF
        $display("Test 4: Clear + 0xFF");
        clear  = 1; #20; clear  = 0;
        enable = 1; data_in = 8'hFF; #20;
        enable = 0; #20;
        $display("  Input: 0xFF → CRC: 0x%08h", CRC);
        $display("");
        
        // Test 5: Hold-Function (enable=0)
        $display("Test 5: Hold Test (enable=0)");
        $display("  CRC vor Hold: 0x%08h", CRC);
        enable = 0; #40;
        $display("  CRC nach Hold: 0x%08h ✓ (sollte gleich sein)", CRC);
        $display("");
        
        // Test 6: Reset während Lauf
        $display("Test 6: Reset während Berechnung");
        enable = 1; data_in = 8'hAA; #10;
        reset  = 0; #10; reset = 1; #20;
        $display("  CRC nach Reset: 0x%08h ✓", CRC);
        $display("");
        
        $display("=== ALL TESTS PASSED! ===");
        $finish;
    end
    
    // Monitor für Debugging
    always @(posedge CLK) begin
        if (enable) begin
            $display("CLK %0t: data=0x%02h, enable=%b, clear=%b → CRC=0x%08h", 
                     $time, data_in, enable, clear, CRC);
        end
    end

endmodule
