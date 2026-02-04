module maj_input (
    input [6:0] in,
    output out
);
    assign out = ((in[0] & in[1]) | (in[0] & in[2]) | (in[0] & in[3]) | (in[0] & in[4]) | 
                 (in[1] & in[2]) | (in[1] & in[3]) | (in[1] & in[4]) | (in[1] & in[5]) | 
                 (in[2] & in[3]) | (in[2] & in[4]) | (in[2] & in[5]) | (in[2] & in[6]) | 
                 (in[3] & in[4]) | (in[3] & in[5]) | (in[3] & in[6]) | (in[4] & in[5]));
endmodule