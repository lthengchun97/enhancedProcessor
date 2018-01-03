module enhanced_dp(
	input clock,reset,
	input IRload,JMPmux,PCload,Meminst,MemWr,Aload,sub,
	input [1:0] Asel,
	input [7:0] input1,
	output Aeq0,Apos,
	output [2:0] ir,
	output [7:0] out1
);
reg [7:0] inData;
reg [7:0] ir_reg;
reg [4:0] pc;
reg [7:0] avalue;
reg [7:0] ram [31:0];

always @ (posedge clock , negedge reset) begin
if (reset == 0)
begin
	ir_reg <= 0;
end
else
	if(IRload == 0)
	begin
	ir_reg <= ir_reg;
	end
	else
	begin
	ir_reg[7:5] <= inData[7:5];
	ir_reg[4:0] <= inData[4:0];
	end
end

always @ (posedge clock , negedge reset)begin
if (reset ==0)
	pc <= 0;
else
	begin
	if (PCload == 0)
	pc <= pc;
	else
	begin
	if (JMPmux == 1)
	pc <= ir_reg[4:0];
	else
	pc <= pc +1;
	end
	end
end

always @ (posedge clock)begin
ram[0] = 8'b10000000;
ram[1] = 8'b01111111;
ram[2] = 8'b10100100;
ram[3] = 8'b11000001;
ram[4] = 8'b11111111;
ram[31] = 8'b00000001;

if (MemWr == 0)
	begin
	if(Meminst == 1) begin
	inData <= ram[ir_reg[4:0]];
	end
	else
	inData<=ram[pc];
	end
else
	begin
	if(Meminst ==1)
	ram[ir_reg[4:0]] <=  avalue;
	else
	ram[pc] <= avalue;
	end
end

always @ (posedge clock , negedge reset) begin
if (reset ==0)
	avalue <= 0;
else
	if(Aload == 0)
	avalue <= avalue;
	else
	begin
	case (Asel)
	2'b00 : begin
			if(sub == 1)
			avalue = avalue - inData;
			else
			avalue = avalue + inData;
			end
	2'b01 : avalue <= input1;
	2'b10 : avalue <= inData;
	default : avalue <= avalue;
	endcase
	end
end

assign Aeq0= ~(|avalue);
assign Apos= ~(avalue>>7);
assign out1= avalue;
assign ir = ir_reg[7:5];
endmodule
