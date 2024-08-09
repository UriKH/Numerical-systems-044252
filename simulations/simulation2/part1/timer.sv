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
        if (reset == 1) begin
            counter <= 1;
            t_flicker <= 0;
            t_done <= 0;
        end
        else begin
            if (t_start == 1) begin
                counter <= 1;
                t_done <= 0;
                t_flicker <= 0;

                if (t_length < 5 || counter == t_length - 6) begin
                    t_flicker <= 1;
                end
            end else if (counter < t_length) begin
                counter <= counter + 1;
                
                if (t_length < 5 || counter == t_length - 6) begin
                    t_flicker <= 1;
                end
                if (counter == t_length - 1) begin
                    t_done <= 1;
                end
            end
        end
    end
// End of your code
endmodule