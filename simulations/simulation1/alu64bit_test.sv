// 64-bit ALU test bench template
module alu64bit_test;

	// Put your code here
	// ------------------
	logic [63:0] a;    // Input bit a
    logic [63:0] b;    // Input bit b
    logic cin;         // Carry in
    logic [1:0] op;    // Operation
    logic [63:0] s;    // Output S
    logic cout;        // Carry out
	
	alu64bit uut(
		.a(a),
		.b(b),
		.cin(cin),
		.op(op),
		.s(s),
		.cout(cout)
	);
	
	initial begin
		a = 1'b0;
		b = 1'b1;
		op = 2'b10;
		cin = 1'b0;
		#1639
		
		op = 2'b11;
		#1639
		$stop;
	end
	// End of your code

endmodule
