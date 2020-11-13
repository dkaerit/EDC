module cl (output reg out, input wire a, b, input wire [1:0] s);

always@ (a, b, s)
    begin
    case(s)
        2'b00 : out = a&b;
        2'b01 : out = a|b;
        2'b10 : out = a^b;
        2'b11 : out = ~a;
        default: out = 1'bx;
    endcase
    end

endmodule