module redundant_logic (
    input a,
    output y
);
    assign y = a & a & a;  // Can be simplified to just 'a'
endmodule
