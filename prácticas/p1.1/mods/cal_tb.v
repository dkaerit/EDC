// Testbench para modulos fa con retardo en los semisumadores que lo componen
`timescale 1 ns / 10 ps //Directiva que fija la unidad de tiempo de simulación y el del paso de simulacion
module cal_tb;

//declaracion de señales
reg [1:0] test_s;
reg test_a, test_b, test_cin,test_d,test_l;  		//entradas 
wire test_out, test_cout;							//salidas

//instancia del modulo a testear
cal cal1(test_out, test_cout, test_a, test_b, test_l, test_cin, test_s);

initial
begin
  $monitor("tiempo=%0d a=%b b=%b l=%b cin=%b s=%b out=%b cout=%b", $time, test_a, test_b,test_l, test_cin,test_s, test_out, test_cout);
  $dumpfile("fa_v2_tb.vcd");
  $dumpvars;
  //vector de test 0
  test_cin = 1'b0;
  test_a = 1'b0;
  test_b = 1'b0;   //out = 0 c_out = 0
  test_l = 1'b0;
  test_s = 2'b00;
  
  # 20;
  //vector de test 1
  test_cin = 1'b0;
  test_a = 1'b0;
  test_b = 1'b1;   //out = 0
  test_l = 1'b1;
  test_s = 2'b00;
  # 20;
  //vector de test 2
  test_cin = 1'b0;
  test_a = 1'b1;
  test_b = 1'b0;	//out = 1
  test_l = 1'b1;
  test_s = 2'b10;
  # 20;
  //vector de test 3
  test_cin = 1'b0;
  test_a = 1'b1;
  test_b = 1'b1;    //out = 0
  test_l = 1'b1;
  test_s = 2'b11;
  # 20;
  //vector de test 4
  test_cin = 1'b1;
  test_a = 1'b0;
  test_b = 1'b0;	//out = 1 c_out = 0
  test_l = 1'b0;
  test_s = 2'b10;
  # 20;
  //vector de test 5
  test_cin = 1'b1;
  test_a = 1'b0;
  test_b = 1'b1;
  test_l = 1'b0;
  test_s = 2'b11;
  # 20;
  //vector de test 6
  test_cin = 1'b1;
  test_a = 1'b1;
  test_b = 1'b0;
  test_l = 1'b0;
  test_s = 2'b00;
  # 20;
  //vector de test 7
  test_cin = 1'b1;
  test_a = 1'b1;
  test_b = 1'b1;
  test_l = 1'b0;
  test_s = 2'b00;
  # 20;
  //fin simulacion
  $finish;
end

endmodule
