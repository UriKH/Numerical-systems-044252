// Full Adder/Subtractor test bench template
module alu1_test;

	// Put your code here
	// ------------------
	logic a;    // Input bit a
    logic b;    // Input bit b
    logic cin;         // Carry in
    logic [1:0] op;    // Operation
    logic s;    // Output S
    logic cout;        // Carry out
	
	alu1bit uut(
		.a(a),
		.b(b),
		.cin(cin),
		.op(op),
		.s(s),
		.cout(cout)
	);

	task display_results;
		$display("%b, %b, %b, %b | %b, %b", a, b, cin, op, cout, s);
	endtask
	initial begin
		// initialize inputs to 0
		a = 1'b0;
        b = 1'b0;
		op = 2'b00;
        cin = 1'b0;
		#500;
		
		
		/* op[0] = 1'b1;
		#50; */
		
		for (int i = 0; i < 4; i++) begin
            for (int j = 0; j < 2; j++) begin
                for (int k = 0; k < 2; k++) begin
                    for (int l = 0; l < 2; l++) begin
                        a = l;
                        b = k;
                        cin = j;
                        op = i[1:0];
                        #500;  // wait for 50 time units
                        display_results;
                    end
                end
            end
        end

        $stop;
	end
	// End of your code

endmodule
