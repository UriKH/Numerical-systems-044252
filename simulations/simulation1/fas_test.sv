// Full Adder/Subtractor test bench template
module fas_test;

	// Put your code here
	// ------------------
	logic fas_a;
	logic fas_b;
	logic fas_cin;
	logic fas_a_ns;

	logic fas_cout;
	logic fas_s;

	fas uut(
		.a(fas_a),
		.b(fas_b),
		.cin(fas_cin),
		.a_ns(fas_a_ns),
		.cout(fas_cout),
		.s(fas_s)
	);
	
	initial begin
		// initialize inputs to 0
		fas_a = 1'b0;
        fas_a_ns = 1'b0;
        fas_b = 1'b0;
        fas_cin = 1'b0;
		#25
		
		// switch b1 0 -> 1
		fas_b = 1'b1;
		#25
		
		// switch b1 1 -> 0
		fas_b = 1'b0;
		#25
        $stop;
	end
	// End of your code

endmodule
