module cl (output wire out, input wire a, b, input wire [1:0] s);

	// cables que intercanectan las puertas con el MUX
	wire s_and, s_or, s_xor, s_not;

	// interconexiones
	and    and1 (s_and, a, b);
	or 	   or1 	(s_or, a, b);
	xor    xor1 (s_xor, a, b);
	not    not1 (s_not, a);
	mux4_1 mux 	(out, s_and, s_or, s_xor, s_not, s);

endmodule