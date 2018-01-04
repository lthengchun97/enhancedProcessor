module integrate_test(
	input CLOCK_50,
	input [0:9]SW,
	input [0:3]KEY,
	output [6:0] HEX0,
	output [9:0] LEDR,
	output [7:0] LEDG
);

wire [7:0] out;

integrate eeelyeee (CLOCK_50,KEY[0],SW[0],2,LEDR[8],out[7:0],LEDG[7:5],LEDR[3:0]);
lab4bp3(out[6:0],HEX0[6:0]);
 
endmodule
