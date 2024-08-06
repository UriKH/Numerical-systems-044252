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
        reset = 1'b0;
        start = 1'b0;

        #5 // 5 times Tclk
        reset = 1;

        #5
        reset = 0;

        #5 // 5 times Tclk
        start = 1'b1;

        #10 // 10 times Tclk
        start = 1'b0;
    end

    always begin
        #1 clk = ~clk;
    end
// End of your code
endmodule