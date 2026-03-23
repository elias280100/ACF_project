module const_mult (
    input [7:0] a,
    input [7:0] b1,
    input [7:0] b2,
    input [7:0] b3,

    output [10:0] y1,
    output [10:0] y2,
    output [10:0] y3,
    output [10:0] y4,
    output [10:0] y5,
    output [10:0] y6,
    output [10:0] y7,
    output [10:0] y8
    );


    assign y1 = a * 8;    // = a << 3  
    assign y2 = a * 7;    // = (a<<3) - a  
    assign y3 = a * 255;  // = (a<<8) - a  
    assign y4 = a * 15;     // =(a<<4) -a
    assign y5 = a * 32;     // = a << 5
    assign y6 = b1 / 2;     // = b1>>1
    assign y7 = b2 / 16;    // = b2>>4
    assign y8 = b3 / 8;     // = b3>>3
       
    
endmodule
