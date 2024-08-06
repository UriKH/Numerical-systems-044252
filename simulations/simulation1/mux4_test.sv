// 4->1 multiplexer test bench template
module mux4_test;

	// Put your code here
	// ------------------
	logic m_d0;          // Data input 0
    logic m_d1;          // Data input 1
    logic m_d2;          // Data input 2
    logic m_d3;          // Data input 3
    logic [1:0] m_sel;   // Select input
    logic m_z;           // Output

	mux4 uut(
		.d0(m_d0),
		.d1(m_d1),
		.d2(m_d2),
		.d3(m_d3),
		.sel(m_sel),
		.z(m_z)
	);
	
	initial begin
		// initialize inputs to 0
		m_d0 = 1'b1;
        m_d1 = 1'b0;
        m_d2 = 1'b0;
        m_d3 = 1'b0;
        m_sel = 2'b00;
		#60
		
		// switch b1 0 -> 1
		m_sel[0] = 1'b1;
		#60
		
		// switch b1 1 -> 0
		m_sel[0] = 1'b0;
		#60
		$stop;	
	end
	// End of your code

endmodule
