  module enhanced (
	input clock,reset,Aeq0,Apos,enter,
	input [2:0] ir,
	output reg IRload,JMPmux,PCload,Meminst,MemWr,
	output reg [1:0] Asel,
	output reg Aload,Sub,Halt,
	output [3:0] showstate
  );
  wire light;
  reg [3:0] state, next_state;
  parameter s0=4'b0000,s1=4'b0001,s2=4'b0010,s3=4'b1000,s4=4'b1001,s5=4'b1010,s6=4'b1011,s7=4'b1100,s8=4'b1101,s9=4'b1110,s10=4'b1111;
  
  always @(posedge clock or negedge reset)
  begin
  if (reset == 0)
	state<=s0;
  else
	state<=next_state;
   end
   
   always @ (state, ir)
   begin
   case (state)
	s0: begin
		{IRload,JMPmux,PCload,Meminst,MemWr,Asel[1:0],Aload,Sub,Halt}=10'b0000000000;
		next_state = s1;
	   end
	s1: begin
		{IRload,JMPmux,PCload,Meminst,MemWr,Asel[1:0],Aload,Sub,Halt}=10'b1010000000;
		next_state = s2;
		end
	s2: begin
		{IRload,JMPmux,PCload,Meminst,MemWr,Asel[1:0],Aload,Sub,Halt}=10'b0001000000;
		case(ir)
		3'b000 : next_state = s3;
		3'b001 : next_state = s4;
		3'b010 : next_state = s5;
		3'b011 : next_state = s6;
		3'b100 : next_state = s7;
		3'b101 : next_state = s8;
		3'b110 : next_state = s9;
		3'b111 : next_state = s10;
		endcase
		end
	s3: begin
		{IRload,JMPmux,PCload,Meminst,MemWr,Asel[1:0],Aload,Sub,Halt}=10'b0000010100;
		next_state = s0;
		end
	s4: begin
		{IRload,JMPmux,PCload,Meminst,MemWr,Asel[1:0],Aload,Sub,Halt}=10'b0001100000;
		next_state = s0;
		end
	s5: begin
		{IRload,JMPmux,PCload,Meminst,MemWr,Asel[1:0],Aload,Sub,Halt}=10'b0000000100;
		next_state = s0;
		end
	s6: begin
		{IRload,JMPmux,PCload,Meminst,MemWr,Asel[1:0],Aload,Sub,Halt}=10'b0000000110;
		next_state = s0;
		end
	s7: begin
		{IRload,JMPmux,PCload,Meminst,MemWr,Asel[1:0],Aload,Sub,Halt}=10'b0000001100;
		if(enter == 1)
		next_state = s0;
		else
		next_state = s7;
		end
	s8: begin
		if(Aeq0 == 1)
		{IRload,JMPmux,PCload,Meminst,MemWr,Asel[1:0],Aload,Sub,Halt}=10'b0110000000;
		else
		{IRload,JMPmux,PCload,Meminst,MemWr,Asel[1:0],Aload,Sub,Halt}=10'b0100000000;
		next_state = s0;
		end
	s9: begin
		if(Apos == 1)
		{IRload,JMPmux,PCload,Meminst,MemWr,Asel[1:0],Aload,Sub,Halt}=10'b0110000000;
		else
		{IRload,JMPmux,PCload,Meminst,MemWr,Asel[1:0],Aload,Sub,Halt}=10'b0100000000;
		next_state = s0;
		end
	s10: begin
		{IRload,JMPmux,PCload,Meminst,MemWr,Asel[1:0],Aload,Sub,Halt}=10'b0000000001;
		next_state = s10;
		end
	default : next_state = s0;
	endcase
	end
	assign showstate = state;
	endmodule
		
		
		
		
	