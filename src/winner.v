`timescale 1ns / 1ps
module winner(votecount1,votecount2,votecount3,votecount4,winner); 

input [7:0]  votecount1,votecount2,votecount3,votecount4;  

output reg [2:0] winner;
always @ (votecount1 or votecount2 or votecount3 or votecount4)

begin 

if((votecount1>votecount2)&(votecount1>votecount3)&(votecount1>votecount4))
winner=3'b001;
else if((votecount2>votecount3)&(votecount2>votecount4)&(votecount2>votecount1))
winner=3'b010;
else if((votecount3>votecount1)&(votecount3>votecount4)&(votecount3>votecount2))
winner=3'b011;
else if((votecount4>votecount1)&(votecount4>votecount2)&(votecount4>votecount3))
winner=3'b100;
else
winner=3'b111;

end 

endmodule