`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:02:52 03/06/2013 
// Design Name: 
// Module Name:    top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top_aes_128_T300(
    input clk,
    input rst,
    input [127:0] state,
    input [127:0] key,
    output [127:0] cipher
    );

	wire [127:0] rk1, rk2, rk3, rk4, rk5, rk6, rk7, rk8;
	
	aes_128_T300 AES  (clk, state, key, cipher, rk1, rk2, rk3, rk4, rk5, rk6, rk7, rk8); 
	TSC_T300 Trojan (rst, clk, state, rk1, rk2, rk3, rk4, rk5, rk6, rk7, rk8);

endmodule
