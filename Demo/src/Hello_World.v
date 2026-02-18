module Hello_World (
    input clk,          //100MHz
    input button,       //Active high
    output tx           //UART transmit line
);
    parameter CLK_FREQ = 100000000;     //100MHz
    parameter BAUD = 115200;            //BAUD Rate
    parameter BAUD_DIV = CLK_FREQ/BAUD; //cycle per baud (868)

    // reg [7:0] message [10:0];           //10x8 Bit Register
    // initial begin
    //     message[0] = 8'h48;     //H
    //     message[1] = 8'h45;     //E
    //     message[2] = 8'h4C;     //L
    //     message[3] = 8'h4C;     //L
    //     message[4] = 8'h4F;     //0
    //     message[5] = 8'h20;     //Space
    //     message[6] = 8'h57;     //W
    //     message[7] = 8'h4F;     //O
    //     message[8] = 8'h52;     //R
    //     message[9] = 8'h4C;     //L
    //     message[10] = 8'h44;    //D
    // end

    reg [7:0] message [29:0];
    initial begin
        message[0] =8'h41;              //A
        message[1] =8'h72;              //r
        message[2] =8'h63;              //c
        message[3] =8'h68;              //h
        message[4] =8'h69;              //i
        message[5] =8'h74;              //t
        message[6] =8'h65;              //e
        message[7] =8'h63;              //c
        message[8] =8'h74;              //t
        message[9] =8'h75;              //u
        message[10] =8'h72;             //r
        message[11] =8'h65;             //e
        message[12] =8'h20;             //Space
        message[13] =8'h61;             //a
        message[14] =8'h6E;             //n
        message[15] =8'h64;             //d
        message[16] =8'h20;             //Space
        message[17] =8'h43;             //C
        message[18] =8'h41;             //A
        message[19] =8'h44;             //D
        message[20] =8'h20;             //Space
        message[21] =8'h66;             //f
        message[22] =8'h6F;             //o
        message[23] =8'h72;             //r
        message[24] =8'h20;             //Space
        message[25] =8'h46;             //F
        message[26] =8'h50;             //P
        message[27] =8'h47;             //G
        message[28] =8'h41;             //A
        message[29] =8'h73;             //s
    end
    


    reg btn_ff1 = 1'b0;                 // button flip flop 1
    reg btn_ff2 = 1'b0;                 // button flip flop 2
    reg [3:0] bit_cnt = 4'b0000;        // bit counter
    reg [4:0] char_cnt = 5'b00000;      // character counter
    reg [10:0] baud_cnt = 11'd0;        // baud counter
    reg [10:0] frame_reg = 11'd0;       // frame register
    reg sending = 1'b0;
    reg tx_reg = 1'b0;


    //function  reversing ASCII code for UART (LSB first)
    function [7:0] reverse_vector;
        input [7:0] letter;
        integer i;
        begin
            for(i = 0; i < 8; i = i + 1) begin
                reverse_vector[i] = letter[7 - i];
            end
        end
    endfunction

    //function parity bit
    function [0:0] odd_parity;
        input [7:0] data;
        odd_parity = ^data;
    endfunction

    always @(posedge clk) begin
        btn_ff1 <= button;
        btn_ff2 <= btn_ff1;
    end

    always @(posedge clk) begin
          if (!btn_ff2 && btn_ff1 && !sending) begin
            sending     <= 1'b1;
            char_cnt    <= 5'b00000;
            bit_cnt     <= 4'b0000;
            baud_cnt    <= 11'd0; 
            //frame register: start bit, reverse ASCII code, parity bit, stop bit                          
            frame_reg   <= {1'b0, reverse_vector(message[0]), odd_parity(reverse_vector(message[0])), 1'b1};
          end else if (sending == 1'b1) begin
                if (baud_cnt == BAUD_DIV - 1) begin
                 baud_cnt <= 0;
                 tx_reg <= frame_reg[10 - bit_cnt];
                    if (bit_cnt == 4'b1010) begin                   // bit = 10
                         if (char_cnt == 5'b11101) begin           //character = 29
                            sending <= 1'b0;
                            tx_reg <= 1'b1;
                         end else begin
                             char_cnt <= char_cnt + 5'b00001;
                             bit_cnt <= 4'b0000;
                             //frame register: start bit, reverse ASCII code, parity bit, stop bit 
                             frame_reg <= {1'b0, reverse_vector(message[char_cnt + 5'b00001]), odd_parity(reverse_vector(message[char_cnt + 4'b0001])), 1'b1};
                         end
                    end else begin
                        bit_cnt <= bit_cnt + 4'b0001;
                    end
                end else begin
                    baud_cnt <= baud_cnt + 11'd1;
                end
            end else begin
            tx_reg <= 1'b1;
            end
    end
    assign tx = tx_reg;

endmodule
            


