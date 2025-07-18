`timescale 1ns / 1ps
module encryption(
input [7:0] bin,
output [7:0] G);
assign G[7] = bin[7];
assign G[6] = bin[7] ^ bin[6];
assign G[5] = bin[6] ^ bin[5];
assign G[4] = bin[5] ^ bin[4];
assign G[3] = bin[4] ^ bin[3];
assign G[2] = bin[3] ^ bin[2];
assign G[1] = bin[2] ^ bin[1];
assign G[0] = bin[1] ^ bin[0];

endmodule

