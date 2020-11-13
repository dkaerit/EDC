module mux2_1(output wire out, input wire a, input wire b, input wire s);

	assign out = s ? b : a; //oper. condicional de C, sintaxis [condicion ? valor_si_cierta : valor_si_falsa] 

endmodule
