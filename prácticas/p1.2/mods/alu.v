module alu(output wire [3:0] R, output wire zero, carry, sign, input wire [3:0] A, B, input wire [1:0] ALUOp, input wire L);

wire [3:0] carry_i;
wire [3:0] OP1, OP2, OP_inner;
wire op1_A, op2_B, cpl, cin;

// Conexiones en serie de los cal
cal cal1(R[0], carry_i[1], OP1[0], OP2[0], L, cin, ALUOp);
cal cal2(R[1], carry_i[2], OP1[1], OP2[1], L, carry_i[1], ALUOp);
cal cal3(R[2], carry_i[3], OP1[2], OP2[2], L, carry_i[2], ALUOp);
cal cal4(R[3], carry     , OP1[3], OP2[3], L, carry_i[3], ALUOp);

// MUX y complementador
mux2_4 mux2_A(OP1    , 4'b0000, A, op1_A);
mux2_4 mux2_B(OP_inner , A      , B, op2_B);

compl1 cpl1(OP2, OP_inner, cpl);

// A+B
// A-B = A + C2(B) = A + C1(B) + 1

/*
R[0] R[1] R[2] R[3] 
0|1  0|1  0|1 >0|1< (bit más significativo)
*/

// Diseño de funciones lógicas que controlan los mux
assign op1_A = L | (~ALUOp[1]);
assign op2_B = L | (~ALUOp[1]) |  ALUOp[0];
assign cin   = ALUOp[1] | ALUOp[0];

//Complementador a uno
assign cpl   = (~L & ALUOp[1]) | (~L & ALUOp[0]);

//Funciones lógicas de los flags cero, acarreo y signo
assign zero  = (R == 4'b0000)? 1'b1: 1'b0;

// forma compleja: 
// 		si op1_A y op2_B activos sacan A y B, entonces, A siempre 1 
// 		y si cpl está activo, B debe ser 0, 
// 		si no, B debe ser 1
// assign carry = ((op1_A == 1) & (op1_B == 1)) & ((cpl == 0) & (A == 1) & (B == 1)) | ((cpl == 1) & (A == 1) & (B == 0)) ? 1'b1 : 1'b0

// forma sencilla: para que haya acarreo ambos operadores finales deben valer 1
assign sign  =  R[3];

endmodule




