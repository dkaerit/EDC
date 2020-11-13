module alu(output wire [3:0] R, output wire zero, carry, sign, input wire [3:0] A, B, input wire [1:0] ALUOp, input wire L);

wire [3:0] carry_inner;
wire [3:0] OP1, OP2, OP_inner;
wire op1_A, op2_B, cpl, cin;

// Conexiones en serie de los cal
cal cal1(R[0], carry_inner[1], OP1[0], OP2[0], L, cin,            ALUOp);
cal cal2(R[1], carry_inner[2], OP1[1], OP2[1], L, carry_inner[1], ALUOp);
cal cal3(R[2], carry_inner[3], OP1[2], OP2[2], L, carry_inner[2], ALUOp);
cal cal4(R[3], carry,          OP1[3], OP2[3], L, carry_inner[3], ALUOp);

// MUX
mux2_4 mux2_A(OP1,      4'b0000, A, op1_A);
mux2_4 mux2_B(OP_inner, A      , B, op2_B);

// Complemento a 1
compl1 cpl1(OP2, OP_inner, cpl);

// Diseño de funciones lógicas que controlan los mux y cpls (Karnaughs)
assign op1_A = L | (~ALUOp[1]);
assign op2_B = L | (~ALUOp[1]) |  ALUOp[0];
assign cin   = ALUOp[1] | ALUOp[0];
assign cpl   = (~L & ALUOp[1]) | (~L & ALUOp[0]); // Complemento a 1

//Funciones lógicas de los flags zero, acarreo y signo
//assign zero  = (R == 4'b0000)? 1'b1: 1'b0;
//mux2_1 zero_mux(zero, 1'b0, 1'b1, R[3]); // modificación 2
// Q = (A * S) + (B * S')

wire out_big_or;
or check_ones(out_big_or, R[0], R[1], R[2], R[3]);
not inv_or(zero, out_big_or);


assign sign  =  R[3];
// acarreo inherente en las conexiones en serie de los cal.



endmodule




