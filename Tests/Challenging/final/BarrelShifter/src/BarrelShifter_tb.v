module BarrelShifter_tb;
  
  // Signals
  reg [31:0] data_in;
  wire [31:0] data_out;
  reg [$clog2(32)-1:0] shift_amount;
  reg shift_direction; // 0: right shift, 1: left shift
  reg shift_type; // 0: logical shift, 1: arithmetic shift

  // Instantiate the BarrelShifter module
  BarrelShifter #(32) DUT (.*);

  // Stimulus generation
  initial begin
    // Initialize signals
    data_in = 32'd837724824;
    shift_amount = 5;
    shift_direction = 0; // Right shift
    shift_type = 0; // Logical shift

    // Test right shift
    #10;
    if (data_out !== 32'd26178900)
      $fatal(1,"Test failed for right shift");

    // Test left shift
    data_in = 32'd985735613;
    shift_amount = 2; 
    shift_direction = 1; // Left shift
    #10;
    if (data_out !== 32'd3942942452)
      $fatal(1,"Test failed for left shift");

    //Test arithmetic right shift
    data_in = 32'd2147483648; // -16 in signed
    shift_amount = 3;
    shift_direction = 0; // Right shift
    shift_type = 1; // Arithmetic shift
    #10;
    if (data_out !== 32'd4026531840) // Expect -2 in signed
      $fatal(1,"Test failed for arithmetic right shift");

    //Test arithmetic left shift
    data_in = 32'd458762842; // 16 in signed
    shift_amount = 1;
    shift_direction = 1; // Left shift
    shift_type = 1; // Arithmetic shift
    #10;
    if (data_out !== 32'd917525684) // Expect 32 in signed
      $fatal(1,"Test failed for arithmetic left shift");

    // Finish simulation
    #10 $stop;
  end

  // Monitor
  always @(*) begin
    $display("Time=%0t: data_in=%b, shift_type=%b, shift_amount=%0d, \
    shift_direction=%b, data_out=%b",
    $time, data_in, shift_type, shift_amount, shift_direction, data_out);
  end

endmodule
