// celda aritmético-lógica
module cal (output wire out, c_out, input wire a, b, l, c_in, input wire [1:0] s);

	// sum_inner: salida del full adder (fa), 
	// cl_inne: salida de la celda lógica (cl)
	wire sum_inner, cl_inner;	

	fa fa1 (c_out, sum_inner, a, b, c_in);
	cl cl1 (cl_inner, a, b, s);
	
	// mux 2 a 1, 
	// si l=1, cl_int -> out
	// si l=0, sum_int -> out
	// assign out = l ? cl_inner : sum_inner;
	mux2_1 mux1(out, sum_inner, cl_inner, l);

endmodule