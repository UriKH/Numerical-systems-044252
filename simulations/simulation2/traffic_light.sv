// traffic light module

module traffic_light(
    //inputs
    input logic clk, // Clock
    input logic reset, // Reset
    input logic start, // Start signal
    input logic t_flicker,
    input logic t_done,

    //outputs
    output logic t_start,
    output logic[4:0] t_length,
    output logic[1:0] L_out
);


// Light Duration Parameters - Defaults
// ------------------

parameter RED_DURATION = 5'd30;
parameter YELLOW_DURATION = 5'd3;
parameter GREEN_DURATION = 5'd30;

// Put your code here
// ------------------
typedef enum  { idle_st, red_st, yellow_st, yellowShortcut_st, green_st, flashing_st } sm_type;

sm_type current_state;
sm_type next_state;

always_ff @(posedge clk, posedge reset) begin
    if (reset == 1'b1) begin
        current_state <= idle_st;
    end
    else begin
        current_state <= next_state;
    end
end

always_comb begin
    // default
    t_start = 1'b0;
    t_length = 5'b0;
    L_out = 2'b0;
    next_state = current_state;

    case (current_state)
    idle_st: begin
        if (start == 1'b1) begin
            next_state = red_st;
            L_out = 2'b01;
            t_start = 1'b1;
            L_out = RED_DURATION;
            next_state = red_st;
        end
    end
    red_st: begin
        if (t_done == 1'b1) begin
            next_state = yellow_st;
            L_out = 2'b10;
            t_start = 1'b1;
            L_out = YELLOW_DURATION;
        end
        else begin
            next_state = current_state;
            L_out = 2'b01;
            t_start = 1'b0;
            L_out = RED_DURATION;
        end
    end
    yellow_st: begin
        if (t_done == 1'b1) begin
            next_state = yellow_st;
            L_out = 2'b11;
            t_start = 1'b1;
            L_out = GREEN_DURATION;
        end
        else begin
            next_state = current_state;
            L_out = 2'b010;
            t_start = 1'b0;
            L_out = YELLOW_DURATION;
        end
    end
    green_st: begin
        if (t_flicker == 1'b1) begin
            next_state = flashing_st;
            L_out = 2'b00;
            t_start = 1'b0;
            L_out = GREEN_DURATION;
        end
        else begin
            next_state = current_state;
            L_out = 2'b011;
            t_start = 1'b0;
            L_out = GREEN_DURATION;
        end
    end
    flashing_st: begin
        if (t_done == 1'b1) begin
            next_state = yellowShortcut_st;
            L_out = 2'b10;
            t_start = 1'b1;
            L_out = YELLOW_DURATION;
        end
        else begin
            next_state = green_st;
            L_out = 2'b011;
            t_start = 1'b0;
            L_out = GREEN_DURATION;
        end
    end
    yellowShortcut_st: begin
        if (t_done == 1'b1) begin
            next_state = red_st;
            L_out = 2'b01;
            t_start = 1'b1;
            L_out = RED_DURATION;
        end
        else begin
            next_state = current_state;
            L_out = 2'b010;
            t_start = 1'b0;
            L_out = YELLOW_DURATION;
        end
    end
end

// end of your code
endmodule
