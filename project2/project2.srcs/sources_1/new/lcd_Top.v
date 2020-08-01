`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/31 12:18:33
// Design Name: 
// Module Name: lcd_top
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


module lcd_Top(
    input clk,//100Mhz
    input rst,
    input [7:0]Temp_bin,
    output OE,
    output lcd_rs,
    output lcd_rw,
    output lcd_en,
    output [7:0]lcd_data    
);

wire [7:0]Temp_bcd;
wire Temp_done;

bin2bcd Temp(
    .clk(clk),
    .rst(rst),
    .bin(Temp_bin),
    .bcd(Temp_bcd),
    .done(Temp_done)
);

lcd1602_driver lcd(
    .clk(clk),
    .rst(rst),
    .Temp_bcd(Temp_bcd),
    .Temp_done(Temp_done),
    .OE(OE),
    .lcd_rs(lcd_rs),
    .lcd_rw(lcd_rw),
    .lcd_en(lcd_en),
    .lcd_data(lcd_data)
);

endmodule 