`timescale 1ns / 1ps
module clockdivision(
    input nClk,
    input Reset,
    output Clk190
    );

reg [18:0] Clk_Div;
    always@(posedge nClk, posedge Reset)
    begin
        if(Reset==1)
            Clk_Div=0;
        else
            Clk_Div=Clk_Div+1;
        end

assign Clk190=Clk_Div[18];

endmodule