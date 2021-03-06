module enhanced_dp_tb();
	reg clock,reset,IRload,JMPmux,PCload,Meminst,MemWr,Aload,sub;
	reg [1:0] Asel;
	reg [7:0] input1;
	wire Aeq0,Apos;
	wire [2:0] ir;
	wire [7:0] out1;

  parameter s0=3'b000,s1=3'b001,s2=4'b010,s3=3'b011,s4=3'b100,s5=3'b101,s6=3'b110,s7=3'b111;
  wire [2:0] simulated_ir;
  reg [2:0] expected_ir;
  wire simulated_Apos,simulated_Aeq0;
  reg expected_Aeq0,expected_Apos;
  integer error = 0;
  
  assign simulated_Apos = Apos;
  assign simulated_Aeq0 = Aeq0;
  assign simulated_ir = ir[2:0];
  
  initial
  begin
  clock <=0;
  forever #10 clock = ~clock;
  end
  
  initial
  begin
  reset <=0;
  @(posedge clock);
  @(negedge clock) reset = 1;
  end
  
  initial
  begin
  $display("Simulated_IR		Expected_IR		Simulated_Apos		Expected_Apos		Simulated_Aeq0		Expected_Aeq0");
  test();
  #6000 $finish;
  end
  
  task test();
  begin
	IRload = 0;
	JMPmux = 0;
	PCload = 0;
	Meminst = 0;
	MemWr = 0;
	Aload = 0;
	sub = 0;
	Asel = 0;
	input1 = 0;
	
 
	#800 input1 <= 8'b10001011;
		 Asel <= 2'b01;
		 Aload <= 1;
		 
	#800 Asel <= 2'b10;
		 Aload <= 1;
		 Meminst <= 1;
		 JMPmux <= 1;
		 MemWr <= 1;
		 sub <= 1;
		 
	#800 Asel <= 2'b00;
		 Aload <= 1;
		 
	#800 PCload <=1 ;
		 JMPmux <=1 ;
		 Asel <= 2'b10;
		 IRload <= 1;
		 Meminst <= 0;
		 MemWr <= 0;
		 Aload <= 1;
		 sub <= 0;
	
	
	#800 {IRload,JMPmux,PCload,Meminst,MemWr,Asel[1:0],Aload,sub}=9'b101000000;
	
	#800 {IRload,JMPmux,PCload,Meminst,MemWr,Asel[1:0],Aload,sub}=9'b000100000;
	
	#800 {IRload,JMPmux,PCload,Meminst,MemWr,Asel[1:0],Aload,sub}=9'b000001010;
	
	#800 {IRload,JMPmux,PCload,Meminst,MemWr,Asel[1:0],Aload,sub}=9'b000000010;
	
	#800 {IRload,JMPmux,PCload,Meminst,MemWr,Asel[1:0],Aload,sub}=9'b000000011;
	
	#800 {IRload,JMPmux,PCload,Meminst,MemWr,Asel[1:0],Aload,sub}=9'b000000110;
	
	#800 {IRload,JMPmux,PCload,Meminst,MemWr,Asel[1:0],Aload,sub}=9'b011000000;
	
	#800 {IRload,JMPmux,PCload,Meminst,MemWr,Asel[1:0],Aload,sub}=9'b010000000;
	
	#800 {IRload,JMPmux,PCload,Meminst,MemWr,Asel[1:0],Aload,sub}=9'b011000000;

	#800 {IRload,JMPmux,PCload,Meminst,MemWr,Asel[1:0],Aload,sub}=9'b010000000;
	
  end
  
  endtask
  
  enhanced_dp test1(clock,reset,IRload,JMPmux,PCload,Meminst,MemWr,Aload,sub,Asel[1:0],input1[7:0],Aeq0,Apos,ir[2:0],out1[7:0]);

always@(PCload)
  begin
  if(PCload == 1) begin
	expected_Aeq0=0;
	expected_Apos=0;
	end
  else
  begin
	expected_Aeq0=1;
	expected_Apos=1;
	end
end     

always@(ir) begin
  case(ir)
    s0: expected_ir = 3'b000;
    s1: expected_ir = 3'b001;
    s2: expected_ir = 3'b010;
    s3: expected_ir = 3'b011;
    s4: expected_ir = 3'b100;
    s5: expected_ir = 3'b101;
    s6: expected_ir = 3'b110;
    s7: expected_ir = 3'b111;
    default: expected_ir = 3'b000;
  endcase
  end


always@(expected_ir,expected_Apos,expected_Aeq0)
begin
check(simulated_ir,simulated_Apos,simulated_Aeq0,expected_ir,expected_Apos,expected_Aeq0);
end
  
  task check;
  input [2:0] simulated_ir;
  input simulated_Apos,simulated_Aeq0;
  input [2:0] expected_ir;
  input expected_Apos,expected_Aeq0;
begin
   if(simulated_ir[2:0] != expected_ir[2:0] || simulated_Apos != expected_Apos || simulated_Aeq0 != expected_Aeq0  )
    begin
      error = error +1;
      $display ("Simulated ir =%b , Expected ir =%b ",simulated_ir,expected_ir);
      $display ("Simulated Apos =%b , Expected Apos =%b ",simulated_Apos,expected_Apos);
      $display ("Simulated Aeq0 =%b , Expected Aeq0 =%b ",simulated_Aeq0,expected_Aeq0);
      $display ("Found error at this time ! Current error = %d ,time = %d\n",error,$time);
    end
   else
   begin
	$display("%b			%b			%b			%b			%b			%b",simulated_ir,expected_ir,simulated_Apos,expected_Apos,simulated_Aeq0,expected_Aeq0);
end
end
endtask

  endmodule
  