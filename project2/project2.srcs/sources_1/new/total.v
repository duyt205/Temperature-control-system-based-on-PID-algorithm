`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/30 11:34:37
// Design Name: 
// Module Name: total
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


module total(
    input clk,
    input rst_n,
    output uk,
    inout io_data,
    output OE,
    output lcd_rs,
    output lcd_rw,
    output lcd_en,
    output [7:0]lcd_data
    );
    wire [7:0]temper;
    
    pid_top pid_top0(
    .clk(clk),
    .rst_n(rst_n),
    .temper_out(temper),
    .uk(uk)
    );
    
    dht11 dht11_0(
    .i_clk(clk),
    .i_rst_n(rst_n),
    .io_data(io_data),
    .o_temp(temper),
    .o_humi(),
    .o_state()
    );
    
    lcd_Top lcd_0(
    .clk(clk),
    .rst(rst_n),
    .Temp_bin(temper),
    .OE(OE),
    .lcd_rs(lcd_rs),
    .lcd_rw(lcd_rw),
    .lcd_en(lcd_en),
    .lcd_data(lcd_data)
    );
    
endmodule

