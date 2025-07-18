`timescale 1ns / 1ps
module main_evm(
input clock,
input mode,
input candidate1,
input candidate2,
input candidate3,
input B1,
input B0,
input [5:0] UID,
input enter,
output [7:0]led
    );
wire reset;
wire pwrst;
wire candidate4;
wire [3:0]votecount;
wire [2:0] result;
wire [7:0] votedfor;
wire [7:0] total_votes_casted;
wire [7:0] e_total_votes_casted;

Control_unit CU(clock,reset,candidate1,candidate2,candidate3,candidate4,mode,UID,enter,B0,B1,led,votecount,result,total_votes_casted,votedfor,pwrst,e_total_votes_casted);
vio_0 v1(clock,e_total_votes_casted,votecount,result,votedfor,total_votes_casted,reset,pwrst,candidate4);
endmodule
