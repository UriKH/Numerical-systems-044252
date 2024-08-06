// Full Adder/Subtractor template
module fas (
    input logic a,           // Input bit a
    input logic b,           // Input bit b
    input logic cin,         // Carry in
    input logic a_ns,        // A_nS (add/not subtract) control
    output logic s,          // Output S
    output logic cout        // Carry out
);

	// Put your code here
	// -----------------
	logic g1, g2, g5, g6, g7;
	
	// define path to S
	XNOR2 #(.Tpdlh(3), .Tpdhl(3)) g6_xnor2(
		.A(cin),
		.B(b),
		.Z(g6)
	);
	
	XNOR2 #(.Tpdlh(3), .Tpdhl(3)) g4_xnor2(
		.A(a),
		.B(g6),
		.Z(s)
	);	
	
	// define path to Cout
	NAND2 #(.Tpdlh(10), .Tpdhl(10)) g7_nand2(
		.A(b),
		.B(cin),
		.Z(g7)
	);
	
	XNOR2 #(.Tpdlh(3), .Tpdhl(3)) g1_xnor2(
		.A(a_ns),
		.B(a),
		.Z(g1)
	);
	
	OR2 #(.Tpdlh(5), .Tpdhl(5)) g5_or2(
		.A(b),
		.B(cin),
		.Z(g5)
	);
	
	NAND2 #(.Tpdlh(10), .Tpdhl(10)) g2_nand2(
		.A(g1),
		.B(g5),
		.Z(g2)
	);
	
	NAND2 #(.Tpdlh(10), .Tpdhl(10)) g3_nand2(
		.A(g2),
		.B(g7),
		.Z(cout)
	);

	// End of your code

endmodule
