`timescale 1ns / 1ps

module test_evm(

    );
    
 reg clock,reset,c1,c2,c3,c4,mode,enter;
 reg [5:0] UID;
 wire [7:0]led;
 wire [3:0]votecount;
 wire [2:0]result;
 wire [7:0]totalvotes;
 wire [7:0]vvpat_votedfor;
 wire [7:0]e_total_votes_casted;
 wire [63:0] count;
Control_unit a1(clock,reset,c1,c2,c3,c4,mode,UID,enter,led,votecount,result,totalvotes,vvpat_votedfor,e_total_votes_casted,count);
initial 
clock=1'b0;
always
#5 clock=~clock;


initial begin
reset=1;mode=0;c1=0;c2=0;c3=0;c4=0;UID=0;enter=0;
#2 reset=0; mode=1;UID=6'h02;c1=0;c2=0;c3=0;c4=0;enter=1;
#70 reset=0; mode=1;UID=6'h02;c1=1;c2=0;c3=0;c4=0;enter=1;
#70 reset=0; mode=1;UID=6'h00;c1=0;c2=0;c3=0;c4=0;enter=0;

#70 reset=0; mode=1;UID=6'h11;c1=0;c2=1;c3=0;c4=0;enter=1;
#70 reset=0; mode=1;UID=6'h00;c1=0;c2=0;c3=0;c4=0;enter=0;

#70 reset=0; mode=1;UID=6'h13;c1=0;c2=0;c3=1;c4=0;enter=1;
#70 reset=0; mode=1;UID=6'h00;c1=0;c2=0;c3=0;c4=0;enter=0;

#70 reset=0; mode=1;UID=6'h15;c1=1'b0;c2=1;c3=0;c4=0;enter=1;
#70 reset=0; mode=1;UID=6'h00;c1=0;c2=0;c3=0;c4=0;enter=0;

#70 reset=0; mode=1;UID=6'h3C;c1=0;c2=0;c3=0;c4=1;enter=1;
#70 reset=0; mode=1;UID=6'h00;c1=0;c2=0;c3=0;c4=0;enter=0;


#70 reset=0; mode=1;UID=6'h21;c1=1;c2=0;c3=0;c4=0;enter=1;
#70 reset=0; mode=1;UID=6'h00;c1=0;c2=0;c3=0;c4=0;enter=0;


#70 reset=0; mode=1;UID=6'h3C;c1=1;c2=0;c3=0;c4=0;enter=1;
#70 reset=0; mode=1;UID=6'h00;c1=0;c2=0;c3=0;c4=0;enter=0;


#70 reset=0; mode=1;UID=6'h31;c1=1;c2=0;c3=0;c4=0;enter=1;
#70 reset=0; mode=1;UID=6'h00;c1=0;c2=0;c3=0;c4=0;enter=0;


#70 reset=0; mode=1;UID=6'h38;c1=0;c2=0;c3=0;c4=1;enter=1;
#70 reset=0; mode=1;UID=6'h00;c1=0;c2=0;c3=0;c4=0;enter=0;


#70 reset=0; mode=1;UID=6'h2A;c1=1;c2=0;c3=0;c4=0;enter=1;
#70 reset=0; mode=0;UID=6'h00;c1=0;c2=0;c3=0;c4=0;enter=0;




#70 reset=0; mode=0;UID=6'h00;c1=1;c2=0;c3=0;c4=0;enter=0;
#70 reset=0; mode=0;UID=6'h00;c1=0;c2=1;c3=0;c4=0;enter=0;
#70 reset=0; mode=0;UID=6'h00;c1=0;c2=0;c3=1;c4=0;enter=0;

#70 reset=0; mode=0;UID=6'h00;c1=0;c2=0;c3=0;c4=1;enter=0;
#70 reset=0; mode=0;UID=6'h00;c1=0;c2=1;c3=0;c4=0;enter=0;
#70 reset=0; mode=0;UID=6'h00;c1=0;c2=0;c3=1;c4=0;enter=0;
#70 $finish;
end

endmodule

