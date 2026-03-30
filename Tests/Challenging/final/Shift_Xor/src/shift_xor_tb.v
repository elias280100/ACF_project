module shift_xor_tb;

reg [31:0] key;
wire [31:0] hash;

shift_xor dut (
    .key(key),
    .hash(hash)
);

task test;
        input [31:0] test_key;
        begin
            key = test_key;
            #10;
            $display("key=0x%08h, hash=0x%08h", key, hash);
        end
    endtask

initial begin
    // Typische Werte
    test(32'hDEADBEEF);
    test(32'hCAFEBABE);
    test(32'h12345678);
    test(32'hA5A5A5A5); 
    $finish;
end
endmodule