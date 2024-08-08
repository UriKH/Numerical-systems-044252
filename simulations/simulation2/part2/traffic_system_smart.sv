// Smart traffic system testbench
module traffic_system_smart(
    input logic clk,
    input logic reset,
    input logic start,
    input logic person_present,
    input logic car_present,
    output logic [1:0] L_out
);

// Enter X and Y here
    localparam X = 5'd1;
    localparam Y = 5'd6;

// Put your code here
// ------------------

    logic[4:0] t_length;
    logic t_start, t_flicker, t_done, t_freeze;

    timer_smart my_timer(
        .clk(clk),
        .reset(reset),
        .t_start(t_start),
        .t_length(t_length),
        .t_freeze(t_freeze),

        .t_flicker(t_flicker),
        .t_done(t_done)
    );

    traffic_light_smart #(
        .RED_DURATION(5'd20 + X),
        .GREEN_DURATION(5'd20 + Y)
    ) light (
        // inputs
        .clk(clk),
        .reset(reset),
        .start(start),
        .t_flicker(t_flicker),
        .t_done(t_done),
        .car_present(car_present),
        .person_present(person_present),

        // outputs
        .t_start(t_start),
        .t_length(t_length),
        .L_out(L_out),
        .t_freeze(t_freeze)
    );

// End of your code
endmodule
