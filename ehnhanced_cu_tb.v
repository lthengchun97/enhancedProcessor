enhanced_dp_tb();
	reg clock,reset;
	reg IRload,JMPmux,PCload,Meminst,MemWr,Aload,sub;
	reg [1:0] Asel;
	reg [7:0] input1;
	wire Aeq0,Apos;
	wire [2:0] ir;
	wire [7:0] out1;

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
  
  
  
  task 
  
 