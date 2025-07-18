`timescale 1ns / 1ps
module clockdivision_1(
    input clock,
    input reset,
    output Clk2
    );
reg [26:0] Clk_Div;
    always@(posedge clock, posedge reset)
    begin
        if(reset==1)
            Clk_Div=0;
        else
            Clk_Div=Clk_Div+1;
        end

assign Clk2=Clk_Div[25];
endmodule
