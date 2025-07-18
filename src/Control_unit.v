`timescale 1ns / 1ps
module Control_unit(clock,reset,candidate1,candidate2,candidate3,candidate4,mode,UID,enter,B0,B1,led,votecount,result,totalvotes,vvpat_votedfor,pwrst,e_total_votes_casted);
input clock,reset,candidate1,candidate2,candidate3,candidate4,mode,B0,B1,enter;
input [5:0] UID;
input pwrst;
output reg [7:0] led;
output reg [3:0]votecount;
output reg [2:0] result;
output reg [7:0] totalvotes;
output reg [7:0] vvpat_votedfor;

output [7:0]e_total_votes_casted;
parameter s0=8'b00000001,s1=8'b00000010,s2=8'b00000011,s3=8'b00000100;
reg open=0;
reg [63:0]count=0;//Already voted or not is stored in this register
reg validvoter;
reg [3:0] votecount1,votecount2,votecount3,votecount4;
wire validvote1,validvote2,validvote3,validvote4,validvote;
wire [7:0] e_UID;
wire [7:0]d_total_votes_casted;
wire [7:0] total_votes_casted;
wire [2:0] winner;
clockdivision_1 da(clock,reset,Clk2);//Clock division making clock period near to 1sec
balloting_unit BU(clock,reset,candidate1,candidate2,candidate3,candidate4,validvote1,validvote2,validvote3,validvote4);


assign validvote=validvote1|validvote2|validvote3|validvote4;


always@(*)//this always block will turn ON a led when a valid vote is casted.
begin
if(validvote & mode==1 & count[UID]==0 & validvoter)
led[0]<=1'b1;
else
led[0]<=1'b0;
end

always@(*)// This always block indicates whether the voting mode is ON or OFF
begin
if(mode==1'b1)
led[7]<=1'b1;
else
led[7]<=1'b0;
end




always@(posedge Clk2,posedge reset)//In this always block voters are validated and the count of votes gets incremented
begin
if(reset==1)
begin
 votecount1<=0;
 votecount2<=0;
 votecount3<=0;
 votecount4<=0;
 count<=0;
end
else if(mode==1)
begin
if(validvoter)
begin
if(count[UID]==0)
begin
if(validvote1)
begin
votecount1<=votecount1+1;
count[UID]<=1;
end
else if(validvote2)
begin
votecount2<=votecount2+1;
count[UID]<=1;
end
else if(validvote3)
begin
votecount3<=votecount3+1;
count[UID]<=1;
end
else if(validvote4)
begin
votecount4<=votecount4+1;
count[UID]<=1;
end

end
end

end
end



assign total_votes_casted=votecount1+votecount2+votecount3+votecount4;

encryption e1(total_votes_casted,e_total_votes_casted);//here we are encrypting the total votes casted
decryption d1(e_total_votes_casted,d_total_votes_casted);

password pw(clock,pwrst,B0,B1,flag,flag2);// this is a lock module by which we are protecting the results of voting 
winner win(votecount1,votecount2,votecount3,votecount4,winner);// This module gives us who won in election



always@(*)// This always will make open flag to one indicating evm control unit is opened
begin 
if(mode==0)
begin
if(flag==1)
begin
led[6]<=1'b1;
open<=1;
end
else
begin
led[6]<=1'b0;
open<=0;
end
end 
end


always@(*)// in this always block we are assigning the votecount of each candidate
begin
if(mode==1'b0 && open==1)
begin
result<=winner;
totalvotes=d_total_votes_casted;
if(reset==1)
votecount<=0;
else if(candidate1==1)
votecount<=votecount1;
else if(candidate2==1)
votecount<=votecount2;
else if(candidate3==1)
votecount<=votecount3;
else if(candidate4==1)
votecount<=votecount4;
else 
votecount<=0;
end
else 
begin
result<=0;
totalvotes<=0;
end
end

encryption e3({2'b00,UID},e_UID);// encrypting the unique identification number entered
always @(*)// This always block is containing the database of encrypted voters 
    begin
    if(reset==1)
    begin
        validvoter=0;
    end
    else if(enter)
      begin
      validvoter=0;
        case(e_UID)
             8'h03:begin validvoter=1; end
             8'h06:begin validvoter=1; end
             8'h05:begin validvoter=1; end
             8'h0C:begin validvoter=1; end
             8'h0F:begin validvoter=1; end
             8'h04:begin validvoter=1; end
             8'h0A:begin validvoter=1; end
             8'h09:begin validvoter=1; end
             8'h18:begin validvoter=1; end
             8'h1B:begin validvoter=1; end
             8'h1E:begin validvoter=1; end
             8'h19:begin validvoter=1; end
             8'h1A:begin validvoter=1; end
             8'h1F:begin validvoter=1; end
             8'h17:begin validvoter=1; end
             8'h22:begin validvoter=1; end
             8'h11:begin validvoter=1; end
             8'h20:begin validvoter=1; end
             8'h13:begin validvoter=1; end
             8'h30:begin validvoter=1; end
             8'h33:begin validvoter=1; end
             8'h23:begin validvoter=1; end
             8'h35:begin validvoter=1; end
             8'h31:begin validvoter=1; end
             8'h32:begin validvoter=1; end
             8'h37:begin validvoter=1; end
             8'h24:begin validvoter=1; end
             8'h34:begin validvoter=1; end
             8'h3F:begin validvoter=1; end
             8'h3A:begin validvoter=1; end
             8'h39:begin validvoter=1; end
             8'h3E:begin validvoter=1; end
             8'h3B:begin validvoter=1; end
             8'h28:begin validvoter=1; end
             8'h29:begin validvoter=1; end
             8'h2A:begin validvoter=1; end 
         default:validvoter=0;                               
      endcase
      end
      else
      validvoter=0;
      
      end

always@(*)// VVPAt functionality is shown in this always block
begin
if(mode)
begin
if(reset)
vvpat_votedfor<=0;
else if(validvote1 & count[UID]==0 & validvoter)
vvpat_votedfor<=s0;
else if(validvote2 & count[UID]==0 & validvoter)
vvpat_votedfor<=s1;
else if(validvote3 & count[UID]==0 & validvoter)
vvpat_votedfor<=s2;
else if(validvote4 & count[UID]==0 & validvoter)
vvpat_votedfor<=s3;
else 
vvpat_votedfor<=0;
end
end
endmodule
