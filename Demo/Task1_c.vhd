----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2025 10:05:18 AM
-- Design Name: 
-- Module Name: task1_hello_world - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2025 10:05:18 AM
-- Design Name: 
-- Module Name: task1_hello_world - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity task1_hello_world is
  Port (
    clk     : in std_logic;     -- 100MHz
    button  : in std_logic;     -- Active-high button
    tx      : out std_logic     -- UART transmit line
   );
end task1_hello_world;

architecture Behavioral of task1_hello_world is
    constant CLK_FREQ   : integer := 100_000_000;
    constant BAUD       : integer := 115200;
    constant BAUD_DIV   : integer := CLK_FREQ / BAUD;                               --cycle per baud (868)
    
    type message_array is array(0 to 10) of std_logic_vector(7 downto 0);           --array with size 11 of 8 bit vector
    constant message : message_array := (
        "01001000",  -- H (0x48)
        "01000101",  -- E (0x45)
        "01001100",  -- L (0x4C)
        "01001100",  -- L (0x4C)
        "01001111",  -- O (0x4F)
        "00100000",  -- Space (0x20)
        "01010111",  -- W (0x57)
        "01001111",  -- O (0x4F)
        "01010010",  -- R (0x52)
        "01001100",  -- L (0x4C)
        "01000100"   -- D (0x44)
    );
        
    signal btn_ff1, btn_ff2 : std_logic := '0';                             --flipflop
    signal start_tx         : std_logic := '0';                             --start sending 
    signal bit_cnt          : integer range 0 to 10 := 0;                   -- bit counter size of 11
    signal char_cnt         : integer range 0 to 10 := 0;                   --char counter
    signal baud_cnt         : integer range 0 to BAUD_DIV := 0;             --baud counter
    signal frame_reg        : std_logic_vector(10 downto 0) := (others => '1'); --frame where bits are be stored
    signal sending          : std_logic := '0';
    signal tx_reg           : std_logic := '1';
    
    function reverse_vector(a: std_logic_vector(7 downto 0)) return std_logic_vector is     --reverse ascii characters in message for LSB first
        variable result: std_logic_vector(7 downto 0);
    begin
        for i in 0 to 7 loop
            result(i) := a(7 - i);
        end loop;
        return result;
    end function;

    function even_parity_bit(data : std_logic_vector(7 downto 0)) return std_logic is           --function for even parity bit
        variable ones : integer := 0;
    begin
        for i in data'range loop
            if data(i) = '1' then
                ones := ones + 1;                               --count how many '1' are data
            end if;
         end loop;
         if (ones mod 2) = 0 then                               --even number of '1' ->  parity bit is 0 
            return '0';
         else
            return '1';                                         --odd -> parity bit is '1'
         end if;
      end function;
    
begin

    process(clk)
    begin
        if rising_edge(clk) then
            btn_ff1 <= button;
            btn_ff2 <= btn_ff1;
        end if;
    end process;

    start_tx <= '1' when btn_ff2 = '0' and btn_ff1 = '1' and sending = '0' else '0';        --start sending when button is pressed and its not already sending

    process(clk)
        variable data_byte : std_logic_vector(7 downto 0);
    begin
        if rising_edge(clk) then
            if start_tx = '1' then                  --button is pressed
                sending   <= '1';                   --sending is active
                char_cnt  <= 0;                     --reset char counter
                bit_cnt   <= 0;                     --reset bit counter
                baud_cnt  <= 0;                     --reset baud counter
                data_byte := reverse_vector(message(0));    --store in data_byte the reverse vector of first vector of message 
                frame_reg <= '0' & data_byte & even_parity_bit(data_byte) & '1';    --frame reg contains start bit, data, parity and stop bit 

            elsif sending = '1' then                --if sending is already active
                if baud_cnt = BAUD_DIV - 1 then     --wait for one baud cycle
                    baud_cnt <= 0;                  --reset baud cycle
                    tx_reg <= frame_reg(10 - bit_cnt);  --picks the bit to transmit
                    if bit_cnt = 10 then                --10 bits are sent
                        if char_cnt = 10 then           --10 char are sent
                            sending <= '0';             --stop sending
                            tx_reg  <= '1';             --stop sending
                        else
                            char_cnt <= char_cnt + 1;       --increment char counter
                            bit_cnt  <= 0;                  --reset bit counter
                            data_byte := reverse_vector(message(char_cnt + 1));     --store in data_byte the reverse vector of next vector of message
                            frame_reg <= '0' & data_byte & even_parity_bit(data_byte) & '1';    --frame_reg stored with new data
                        end if;
                    else
                        bit_cnt <= bit_cnt + 1;         --increment bit counter if its not already 10
                    end if;
                else
                    baud_cnt <= baud_cnt + 1;           --increment baud counter if its not already BAUD_DIV - 1
                end if;
            else
                tx_reg <= '1';                          --not sending
            end if;
        end if;
    end process;

    tx <= tx_reg;

end Behavioral;