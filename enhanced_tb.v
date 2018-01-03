module enhanced_tb ();
	reg clock,reset,Aeq0,Apos,enter;
	reg [2:0] ir;
	wire IRload,JMPmux,PCload,Meminst,MemWr;
	wire [1:0] Asel;
	wire Aload,Sub,Halt;
	wire [3:0] showstate;
  wire [9:0] simulate;
  reg [9:0] expect1;
  
  parameter s0=4'b0000,s1=4'b0001,s2=4'b0010,s3=4'b1000,s4=4'b1001,s5=4'b1010,s6=4'b1011,s7=4'b1100,s8=4'b1101,s9=4'b1110,s10=4'b1111;
  assign simulate = {IRload,JMPmux,PCload,Meminst,MemWr,Asel[1:0],Aload,Sub,Halt};
  integer error=0;
  integer cycle=0;
  
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
  $display("Simulated		Expected		State");
  test();
  #9000 $finish;
  end
  
enhanced try1(clock,reset,Aeq0,Apos,enter,ir[2:0],IRload,JMPmux,PCload,Meminst,MemWr,Asel[1:0],Aload,Sub,Halt,showstate[3:0]);

always@(simulate,expect1)
begin
check(simulate,expect1);
end

always@(showstate)
  begin
  case(showstate)
    s0: expect1 = 10'b0000000000;
    s1: expect1 = 10'b1010000000;
    s2: expect1 = 10'b0001000000;
    s3: expect1 = 10'b0000010100;
    s4: expect1 = 10'b0001100000;
    s5: expect1 = 10'b0000000100;
    s6: expect1 = 10'b0000000110;
    s7: expect1 = 10'b0000001100;
    s8: if(Aeq0 == 1)
        expect1 = 10'b0110000000;
        else
        expect1 = 10'b0100000000;
    s9: if(Apos ==1)
        expect1 = 10'b0110000000;
        else
        expect1 = 10'b0100000000;
    s10: expect1 = 10'b0000000001;
    default: expect1 = 10'b1111111111;
endcase
end     


task test();
begin
	Aeq0=0;
	Apos=0;
	enter=0;
	ir=0;
	
	#800 ir<=3'b001;
	
	#800 ir<=3'b010;
	
	#800 ir<=3'b011;
	
	#800 ir<=3'b100;
		 enter<=0;
	
	#800 ir<=3'b100; 
		 enter<=1;
	
	#800 ir<=3'b101;
		 Aeq0<=1;
	
	#800 ir<=3'b101;
		 Aeq0<=0;
  
	#800 ir<=3'b110;
		 Apos<=1;
	
	#800 ir<=3'b110;
		 Apos<=0;
	
	#800 ir<=3'b111;
end
endtask

task check;
  input [9:0] simulated_value;
  input [9:0] expected_value;
begin
  //enhanced_1();
  
  if(simulated_value[9:0] != expected_value[9:0])
    begin
      error = error +1;
      $display ("Simulated value =%b , Expected value =%b ,error =%d,at time=%d\n",simulated_value,expected_value,error,$time);
    end
   else
   begin
	$display("%b		%b		%h",simulated_value,expected_value,showstate);
	if(showstate>7)
	begin
		cycle = cycle +1;
		$display("You are completed one cycle !Now you are on the %d cycles.Your current state is %h",cycle,showstate);
		$display("Number of error of current cycle =%d",error);
	end
end
end
endtask


endmodule
