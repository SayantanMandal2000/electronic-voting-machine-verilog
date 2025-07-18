`timescale 1ns / 1ps
module password(
input clock,
input Reset,
input B0,
input B1,
output Correct,
output Incorrect

    );
    wire Clk190;
    wire ClkFSM;
    wire B;
    assign B=B0|B1;
    clockdivision n1(clock, Reset, Clk190);
    debouncing n2(Clk190,Reset,B,ClkFSM);
    lock n3(ClkFSM,Reset,B1,Correct,Incorrect);
endmodule
