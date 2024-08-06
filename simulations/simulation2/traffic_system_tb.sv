//traffic system testbench

module traffic_system_tb;

    logic clk;            // Clock
    logic reset;          // Reset
    logic start;          // Light start signal

    // Put your code here
    // ------------------
    logic out;

    traffic_system system(
        .clk(clk),
        .reset(reset),
        .start(start),
        .L_out(out)
    );

    initial begin
        clk = 0;
        reset = 1;
        start = 1;
        #2
        reset = 0;
    end

    always begin
        #2 clk = ~clk;
    end
// End of your code
endmodule
