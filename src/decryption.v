`timescale 1ns / 1ps


module decryption(
input [7:0] G, //gray code output
output [7:0] bin   //binary input
        );

assign bin[7] =  G[7];
assign bin[6] =  G[7] ^ G[6];
assign bin[5] =  G[7] ^ G[6] ^ G[5];
assign bin[4] =  G[7] ^ G[6] ^ G[5] ^ G[4];
assign bin[3] =  G[7] ^ G[6] ^ G[5] ^ G[4] ^ G[3];
assign bin[2] =  G[7] ^ G[6] ^ G[5] ^ G[4] ^ G[3] ^ G[2];
assign bin[1] =  G[7] ^ G[6] ^ G[5] ^ G[4] ^ G[3] ^ G[2] ^ G[1];
assign bin[0] =  G[7] ^ G[6] ^ G[5] ^ G[4] ^ G[3] ^ G[2] ^ G[1] ^ G[0];

endmodule

