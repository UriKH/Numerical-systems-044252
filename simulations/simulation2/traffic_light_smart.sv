//smart traffic light module

module traffic_light_smart(
    //inputs
    input logic clk, // Clock
    input logic reset, // Reset
    input logic start, // Start signal
    input logic t_flicker,
    input logic t_done,
    input logic car_present,
    input logic person_present,

    //outputs
    output logic t_start,
    output logic[4:0] t_length,
    output logic t_freeze,
    output logic[1:0] L_out
);

// Light Duration Parameters - Defaults
// ------------------
parameter RED_DURATION = 5'd30;
parameter YELLOW_DURATION = 5'd3;
parameter GREEN_DURATION = 5'd30;


// Put your code here
// ------------------


// end of your code
endmodule