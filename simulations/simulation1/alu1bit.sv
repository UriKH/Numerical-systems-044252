// 1-bit ALU template
module alu1bit (
    input logic a,           // Input bit a
    input logic b,           // Input bit b
    input logic cin,         // Carry in
    input logic [1:0] op,    // Operation
    output logic s,          // Output S
    output logic cout        // Carry out
);

    // Internal signals
    logic z0, fas_s;
    logic or_out, nor_out;
    logic xnor_out, xor_out;

    // NAND gate for generating z0
    NAND2 #(.Tpdlh(10), .Tpdhl(10)) nand2_op (
        .A(op[0]),
        .B(op[0]),
        .Z(z0)
    );

    // OR gate
    OR2 #(.Tpdlh(5), .Tpdhl(5)) or_gate (
        .A(a),
        .B(b),
        .Z(or_out)
    );

    // NOR gate using NAND gate
    NAND2 #(.Tpdlh(10), .Tpdhl(10)) nor_gate (
        .A(or_out),
        .B(or_out),
        .Z(nor_out)
    );

    // XNOR gate
    XNOR2 #(.Tpdlh(3), .Tpdhl(3)) xnor_gate (
        .A(a),
        .B(b),
        .Z(xnor_out)
    );

    // XOR gate using NAND gate
    NAND2 #(.Tpdlh(10), .Tpdhl(10)) xor_gate (
        .A(xnor_out),
        .B(xnor_out),
        .Z(xor_out)
    );
	
	// Full adder instantiation
    fas fas_alu (
        .a(a),
        .b(b),
        .cin(cin),
        .a_ns(z0),
        .cout(cout),
        .s(fas_s)
    );

    // Multiplexer for selecting the operation
    mux4 mux4_inst (
        .d0(nor_out),
        .d1(xor_out),
        .d2(fas_s),
        .d3(fas_s),
        .sel(op[1:0]),
        .z(s)
    );

endmodule
