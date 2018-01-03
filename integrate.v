module integrate(
input clock,reset,enter,
input [7:0] in1,
output halt,
output [7:0] out1,
output [2:0] irOut,
output [3:0] statechg
);

wire light,IRload,JMPmux,Pcload,Meminst,MemWr,Aload,Sub,Aeq0,Apos;
wire [1:0] Asel;
wire [2:0] irReg;

lab4bp1 e0(~reset,clock,light);
enhanced e1(light,reset,Aeq0,Apos,enter,irReg[2:0],IRload,JMPmux,PCload,Meminst,MemWr,Asel[1:0],Aload,Sub,halt,statechg[3:0]);
enhanced_dp e2(light,reset,IRload,JMPmux,PCload,Meminst,MemWr,Aload,Sub,Asel[1:0],in1[7:0],Aeq0,Apos,irReg[2:0],out1[7:0]);

assign irOut = irReg;

endmodule

