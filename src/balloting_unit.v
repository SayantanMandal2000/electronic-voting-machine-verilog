`timescale 1ns / 1ps
module balloting_unit(
input clock,
input reset,
input candidate1,
input candidate2,
input candidate3,
input candidate4,
output validvote1,
output validvote2,
output validvote3,
output validvote4);
clockdivision_1 da(clock,reset,Clk2);
validate_vote v1(Clk2,reset,candidate1,validvote1);
validate_vote v2(Clk2,reset,candidate2,validvote2);
validate_vote v3(Clk2,reset,candidate3,validvote3);
validate_vote v4(Clk2,reset,candidate4,validvote4);
endmodule

