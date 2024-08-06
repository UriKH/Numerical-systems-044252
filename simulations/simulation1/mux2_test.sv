// 4->1 multiplexer test bench template
module mux2_test;

	// Put your code here
	// ------------------
	logic m_d0;          // Data input 0
    logic m_d1;          // Data input 1
    logic m_sel;   	     // Select input
    logic m_z;           // Output

	mux2 uut(
		.d0(m_d0),
		.d1(m_d1),
		.sel(m_sel),
		.z(m_z)
	);
	
	
	task display_results;
		$display("%b, %b, %b | %b", m_d0, m_d1, m_sel, m_z);
	endtask
	initial begin
		// initialize inputs to 0
		m_d0 = 1'b0;
        m_d1 = 1'b0;
        m_sel = 1'b0;
		#50;
		

		for (int i = 0; i < 2; i++) begin
			for (int j = 0; j < 2; j++) begin
				for (int k = 0; k < 2; k++) begin
					m_d0 = k;
					m_d1 = j;
					m_sel = i;
					#50;  // wait for 50 time units
					display_results;
				end
			end
		end
	end
// End of your code

endmodule
