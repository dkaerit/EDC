
module mux4_1 (output reg out, input wire e0, e1, e2, e3, input wire [1:0] s);

always@ (e0, e1, e2, e3, s)
	begin
	case(s)
		2'b00 : out = e0;
		2'b01 : out = e1;
		2'b10 : out = e2;
		2'b11 : out = e3;
		default: out = 1'bx;
	endcase
	end

endmodule

