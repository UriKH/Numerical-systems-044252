// Timer module

module timer(
    input logic clk,
    input logic reset,
    input logic t_start,
    input logic[4:0] t_length,

    output logic t_flicker,
    output logic t_done
);

// Put your code here
// ------------------

    logic[4:0] counter;

    always_ff @(posedge clk, posedge reset) begin
        if (reset == 1'b1) begin
            counter <= 5'b0;
        end else if (t_start == 1'b1) begin
            counter <= 5'b0;
            t_flicker <= 1'b0;
        end else if (counter == t_length) begin
            t_done <= 1'b1;
        end else begin
            counter <= counter + 1;
        end

        if (t_length < 5 || counter == t_length - 5) begin
            t_flicker <= 1'b1;
        end

    end


// End of your code
endmodule