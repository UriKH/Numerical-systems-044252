// 32X32 Multiplier test template
module traffic_system(
    input logic clk,
    input logic reset,
    input logic start,
    output logic [1:0] L_out
);

// Enter X and Y here
	localparam X = 5'd1;
	localparam Y = 5'd6;

// Put your code here
// ------------------

    logic t_start, t_length, t_flicker, t_done;

    timer my_timer(
        .clk(clk),
        .reset(reset),
        .t_start(t_start),
        .t_length(t_length),

        .t_flicker(t_flicker),
        .t_done(t_done)
    );

    traffic_light #(
        .RED_DURATION(5'd20 + X),
        .GREEN_DURATION(5'd20 + Y)
    ) light (
        // inputs
        .clk(clk),
        .reset(reset),
        .start(start),
        .t_flicker(t_flicker),
        .t_done(t_done),

        // outputs
        .t_start(t_start),
        .t_length(t_length),
        .L_out(L_out)
    );    
);

// end of your code
endmodule
