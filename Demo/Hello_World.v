module Hello_World (
    input clk,          //100MHz
    input button,       //Active high
    output tx           //UART transmit line
);
    parameter CLK_FREQ = 100000000;     //100MHz
    parameter BAUD = 115200;            //BAUD Rate
    parameter BAUD_DIV = CLK_FREQ/BAUD; //cycle per baud (868)

    reg [7:0] message [10:0];           //10x8 Bit Register
    initial begin
        message[0] = 8'h48;     //H
        message[1] = 8'h45;     //E
        message[2] = 8'h4C;     //L
        message[3] = 8'h4C;     //L
        message[4] = 8'h4F;     //0
        message[5] = 8'h20;     //Space
        message[6] = 8'h57;     //W
        message[7] = 8'h4F;     //O
        message[8] = 8'h52;     //R
        message[9] = 8'h4C;     //L
        message[10] = 8'h44;    //D
    end
    


    reg btn_ff1;
    reg btn_ff2;
    wire start_tx;
    reg [3:0] bit_cnt;
    reg [3:0] char_cnt;
    reg [10:0] baud_cnt;
    reg [10:0] frame_reg;
    reg sending;
    reg tx_reg;
    reg [7:0] data_byte;

    function [7:0] reverse_vector;
        input [7:0] letter;
        integer i;
        begin
            for(i = 0; i < 8; i = i + 1) begin
                reverse_vector[i] = letter[7 - i];
            end
        end
    endfunction

    function [0:0] odd_parity;
        input [7:0] data;
        odd_parity = ^data;
    endfunction


    always @(posedge clk) begin
        btn_ff1 <= button;
        btn_ff2 <= btn_ff1;
    end

    assign start_tx = (!btn_ff2 && btn_ff1 && !sending) ? 1'b1 : 1'b0; 

    always @(posedge clk) begin
          
          if (start_tx == 1'b1) begin
            sending     <= 1'b1;
            char_cnt    <= 4'b0000;
            bit_cnt     <= 4'b0000;
            baud_cnt    <= 11'd0;
            data_byte   <= reverse_vector(message[0]);
            frame_reg   <= {1'b0, data_byte, odd_parity(data_byte), 1'b1};
          end else if (sending == 1'b1) begin
                if (baud_cnt == BAUD_DIV - 1) begin
                 baud_cnt <= 0;
                 tx_reg <= frame_reg[10 - bit_cnt];
                    if (bit_cnt == 4'b1010) begin
                         if (char_cnt == 4'b1010) begin
                            sending <= 1'b0;
                            tx_reg <= 1'b1;
                         end else begin
                             char_cnt <= char_cnt + 4'b0001;
                             bit_cnt <= 4'b0000;
                             data_byte <= reverse_vector(message[char_cnt + 1]);
                             frame_reg <= {1'b0, data_byte, odd_parity(data_byte), 1'b1};
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
            


