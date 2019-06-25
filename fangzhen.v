`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:06:43 06/25/2019
// Design Name:   hdbshj
// Module Name:   E:/OneDrive - stu.xjtu.edu.cn/Projects/VHDLlearn/shouhuoji/fangzhen.v
// Project Name:  shouhuoji
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: hdbshj
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module fangzhen;

	// Inputs
	reg bn0;
	reg bn1;
	reg bn2;
	reg bn3;
	reg bn4;
	reg bn5;
	reg bn7;
	reg clk_50M;
	reg reset;
	reg [3:0] KEY_ROW;

	// Outputs
	wire [3:0] KEY_COL;
	wire [7:0] DOUT7;
	wire [2:0] CatL;
	wire led1;
	wire led2;
	wire led3;
	wire led4;
	wire led5;

	// Instantiate the Unit Under Test (UUT)
	hdbshj uut (
		.bn0(bn0), 
		.bn1(bn1), 
		.bn2(bn2), 
		.bn3(bn3), 
		.bn4(bn4), 
		.bn5(bn5), 
		.bn7(bn7), 
		.clk_50M(clk_50M), 
		.reset(reset), 
		.KEY_ROW(KEY_ROW), 
		.KEY_COL(KEY_COL), 
		.DOUT7(DOUT7), 
		.CatL(CatL), 
		.led1(led1), 
		.led2(led2), 
		.led3(led3), 
		.led4(led4), 
		.led5(led5)
	);

	initial begin
		// Initialize Inputs
		bn0 = 0;
		bn1 = 1;
		bn2 = 0;
		bn3 = 0;
		bn4 = 0;
		bn5 = 0;
		bn7 = 0;
		clk_50M = 0;
		reset = 0;
		KEY_ROW = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

