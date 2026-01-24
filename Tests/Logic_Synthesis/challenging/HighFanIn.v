module High_FanIn (
    input [7:0] a,
    output out
);
    assign out = &a;
endmodule