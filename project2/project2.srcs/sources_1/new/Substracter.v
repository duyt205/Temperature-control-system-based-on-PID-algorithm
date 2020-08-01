`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/30 11:36:56
// Design Name: 
// Module Name: Substracter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Substracter(
    input [7:0] a,
    input [7:0] b,
    output reg [8:0]s,
    input clk,
    input rst_n
    );

reg [7:0]b0;

always @(posedge clk)   
begin   
    if(!rst_n)   
        begin   
            s <= 0;    
        end
    else
        begin
            b0 <=~b +1'b1;
            s <= a+b0;
        end
end
endmodule

