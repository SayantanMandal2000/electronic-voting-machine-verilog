`timescale 1ns / 1ps
module validate_vote(clk,rst,person,valid);
input clk,rst,person;
output valid;
debouncing ak(clk,rst,person,valid);
endmodule
