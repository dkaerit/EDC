// Testbench para modulo alu
`timescale 1 ns / 10 ps //Directiva que fija la unidad de tiempo de simulación y la precision de la unidad
module alu_tb;
//declaracion de señales
reg [1:0] t_Op;
reg t_L;
reg [3:0] t_A, t_B;
wire [3:0] t_R;
wire t_z, t_c, t_s;
integer errores;
//instancia del modulo a testear
alu mat(t_R, t_z, t_c, t_s, t_A, t_B, t_Op, t_L);

initial
begin
  $dumpfile("alu.vcd");
  $dumpvars;
/*  $monitor("tiempo=%0d A=%b B=%b L=%b Op=%b R=%b, Z=%b, C=%b, S=%b", $time, t_A, t_B, t_L, t_Op, t_R, t_z, t_c, t_s);
*/
  errores = 0;
  t_L = 1'b0;
  repeat(2)
	begin
	t_Op = 2'b0;
	repeat(4)
		begin
		  t_A = 4'b0;
		  repeat(16) 
		  begin
			t_B = 4'b0;
			repeat(16) 
			begin
				# 2 check;
				t_B = t_B + 1;
			end
			t_A = t_A + 1;
		  end
		  t_Op = t_Op + 1;
		end
		t_L = t_L + 1;
	end
	$display("Encontradas %d operaciones erroneas", errores);
  //fin simulacion
  $finish;
end

// Tarea para hacer la comprobación automática de resultados
task check;
reg [4:0] result;
reg flag_zero, flag_carry, flag_sign;
begin
	// Si las operaciones son lógicas
	if (t_L)
	begin
		case (t_Op)
			2'b00: result[3:0] = t_A & t_B;
			2'b01: result[3:0] = t_A | t_B;
			2'b10: result[3:0] = t_A ^ t_B;
			2'b11: result[3:0] = ~t_A;
			default: $display("ERROR. Valor no esperado para t_Op: %b", t_Op);
		endcase
		flag_carry = 1'bx;
		flag_sign = 1'bx;
	end
	else
	begin
		case (t_Op)
			2'b00: result = t_A + t_B;
			2'b01: result = t_A + ((t_B ^4'b1111) + 1);
			2'b10: result = (t_A ^4'b1111) + 4'b0001;
			2'b11: result = (t_B ^4'b1111) + 4'b0001;
			default: $display("ERROR. Valor no esperado para t_Op: %b", t_Op);
		endcase
		flag_carry = result[4];
		flag_sign = result[3];
	if (flag_sign !== t_s || flag_carry !== t_c)
		begin
		errores = errores + 1;
		$display("ERROR con operación L=%b, OP=%b A=%b B=%b", t_L, t_Op, t_A, t_B);
		if (flag_sign !== t_s)
			$display("ERROR. Flag de signo esperado %b, obtenido %b", flag_sign, t_s);
		if (flag_carry !== t_c)
			$display("\tFlag de acarreo esperado %b, obtenido %b", flag_carry, t_c);
		end
	end
	flag_zero = ~| result[3:0];
	if (result[3:0] !== t_R || flag_zero !== t_z)
		begin
		errores = errores + 1;
		$display("ERROR con operación L=%b, OP=%b A=%b B=%b", t_L, t_Op, t_A, t_B);
		if (result[3:0] !== t_R)
			$display("\tResultado esperado %b, obtenido %b", result[3:0], t_R);
		if (flag_zero !== t_z)
			$display("\tFlag de cero esperado %b, obtenido %b", flag_zero, t_z);
		end
end
endtask
endmodule
