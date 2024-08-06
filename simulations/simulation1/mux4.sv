// 4->1 multiplexer template
module mux4 (
    input logic d0,          // Data input 0
    input logic d1,          // Data input 1
    input logic d2,          // Data input 2
    input logic d3,          // Data input 3
    input logic [1:0] sel,   // Select input
    output logic z           // Output
);

	// Put your code here
	// ------------------
	logic z0, z1;
	
	mux2 mux2_inst0(
		.d0(d0),
		.d1(d1),
		.sel(sel[0]),
		.z(z0)
	);
	
	mux2 mux2_inst1(
		.d0(d2),
		.d1(d3),
		.sel(sel[0]),
		.z(z1)
	);
	
	mux2 mux2_inst2(
		.d0(z0),
		.d1(z1),
		.sel(sel[1]),
		.z(z)
	);
	// End of your code

endmodule
