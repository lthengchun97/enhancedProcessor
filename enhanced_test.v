module enhanced_test(
	input CLOCK_50,
	input [0:9]SW,
	input [0:0]KEY,
	output [9:0]LEDR,
	output [3:0]showstate
);
lab4bp1 try2(~reset,CLOCK_50,light);
enhanced(light,KEY[0],SW[0],SW[1],SW[2],SW[3:5],LEDR[9],LEDR[8],LEDR[7],LEDR[6],LEDR[5],LEDR[4:3],LEDR[2],LEDR[1],LEDR[0],showstate[3:0]);

endmodule

