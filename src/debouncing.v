`timescale 1ns / 1ps
module debouncing(
    input clock,
    input Reset,
    input din,
    output dout
    );
 reg A, B,C;
always@(posedge clock, posedge Reset)
begin
    if(Reset==1)
        begin
            A<=0;
            B<=0;
            C<=0;
        end
    else
        begin
            A<=din;
            B<=A;
            C<=B;
        end
    end

assign dout=A & B & ~C;

endmodule
