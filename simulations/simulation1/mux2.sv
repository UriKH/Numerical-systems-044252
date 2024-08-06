// 2->1 multiplexer template
module mux2 (
    input logic d0,          // Data input 0
    input logic d1,          // Data input 1
    input logic sel,         // Select input
    output logic z           // Output
);

	// Put your code here
	// ------------------
	logic g1, g2, g3, g4, g5;

	NAND2 #(.Tpdlh(10), .Tpdhl(10)) g1_nand2(
		.A(sel),
		.B(sel),
		.Z(g1)
	);
	
	NAND2 #(.Tpdlh(10), .Tpdhl(10)) g2_nand2(
		.A(d0),
		.B(g1),
		.Z(g2)
	);
	
	NAND2 #(.Tpdlh(10), .Tpdhl(10)) g3_nand2(
		.A(g2),
		.B(g2),
		.Z(g3)
	);
	
	NAND2 #(.Tpdlh(10), .Tpdhl(10)) g4_nand2(
		.A(sel),
		.B(d1),
		.Z(g4)
	);
	
	NAND2 #(.Tpdlh(10), .Tpdhl(10)) g5_nand2(
		.A(g4),
		.B(g4),
		.Z(g5)
	);
		
	OR2 #(.Tpdlh(5), .Tpdhl(5)) g6_or2(
		.A(g3),
		.B(g5),
		.Z(z)
	);
	// End of your code
endmodule
