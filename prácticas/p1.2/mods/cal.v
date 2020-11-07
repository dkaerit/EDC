// celda aritmético-lógica
module cal (output wire out, c_out, input wire a, b, l, c_in, input wire [1:0] s);

	// sum_int: salida del full adder (fa), 
	// cl_int: salida de la celda lógica (cl)
	wire sum_int, cl_int;	

	fa fa1 (c_out, sum_int, a, b, c_in);
	cl cl1 (cl_int, a, b, s);
	
	// mux 2 a 1, 
	// si l=1, cl_int -> out
	// si l=0, sum_int -> out
	assign out = l ? cl_int : sum_int;

endmodule