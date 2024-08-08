//traffic system testbench

module traffic_system_tb;

    logic clk;            // Clock
    logic reset;          // Reset
    logic start;          // Light start signal

    // Put your code here
    // ------------------
    logic[1:0] out;

    traffic_system system(
        .clk(clk),
        .reset(reset),
        .start(start),
        .L_out(out)
    );

    initial begin
        clk = 0;
        reset = 1;

        #10 // 5 clk
        reset = 0;
        start = 0;

        #5 // 5 t units
        start = 1;

        #10 // 10 t units
        start = 0;
    end

    always begin
        #1 clk = ~clk;
    end
// End of your code
endmodule
