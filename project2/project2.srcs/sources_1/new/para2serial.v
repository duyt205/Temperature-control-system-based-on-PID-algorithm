`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/30 11:37:41
// Design Name: 
// Module Name: para2serial
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


module para2serial(
clk,
rst_n,
data_para,  //并行输入
sda_en,  //外部待传输数据输入
sda  //串行输出
);
 
input wire clk;
input wire rst_n;
input [16:0] data_para;
output reg sda;
output reg sda_en;
 
reg [16:0]sda_buf;
reg [5:0]counter;
reg dv;
 
 
//计数器
always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				dv <= 0;
			end
		else
			begin
			 dv <= 1; 
			 end
	end
	
	
always@(posedge clk or negedge rst_n)
    begin
      if(!rst_n)
         begin
         	sda<=0;
            sda_buf<= 0;
            counter<=0;
            sda_en<=0;  
         end
      else
      begin sda_buf<= data_para;
        if(dv)
            begin
                if(counter<17)
                      begin
                          counter<=counter+1'b1;
                          sda_buf<={sda_buf[15:0],sda_buf[16]};
                          sda<=sda_buf[16];
                          sda_en<=1;
                      end
                         else
                            begin
                               counter<=0;
                               sda<=0;
                               sda_en<=0;
                            end
            end
    end
    end
endmodule

