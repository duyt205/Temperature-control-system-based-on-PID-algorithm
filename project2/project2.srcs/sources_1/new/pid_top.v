`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/30 11:35:37
// Design Name: 
// Module Name: pid_top
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


module pid_top(   
    input clk,   //板载时钟100MHz（原始程序里用50MHz仿真的）
    input rst_n,   //复位
    input [7:0] temper_out,   //外部温度
    output uk   //调整信号
    );   

parameter [7:0]temper_set=8'b0111_1111;     //设定温度
wire [8:0]error;
wire [16:0]o_uk;

Substracter Substracter0(
.a(temper_set),
.b(temper_out),
.s(error),
.clk(clk),
.rst_n(rst_n)
);

pid_core pid_core0(
.clk(clk),
.rst_n(rst_n),
.error(error),
.uk(o_uk)
);

para2serial para2serial0(
.clk(clk),
.rst_n(rst_n),
.data_para(o_uk),
.sda(uk),
.sda_en()
);
endmodule  
