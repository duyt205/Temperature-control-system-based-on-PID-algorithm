`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/31 12:27:54
// Design Name: 
// Module Name: lcd1602_driver
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


module lcd1602_driver(
    input           clk,
    input           rst,
    input   [7:0]  Temp_bcd,
    input           Temp_done,
    output          OE,
    output reg      lcd_rs = 1,
    output          lcd_rw,
    output reg      lcd_en = 1,
    output reg [7:0]lcd_data = 8'hff
);
                      
//--------------------lcd1602 order----------------------------
parameter   Mode_Set   =  8'h38,
             Cursor_Set  =  8'h0c,
             Address_Set =  8'h06,
             Clear_Set   =  8'h01;
reg [7:0]state; 
reg clk_50M = 0; 
always @(posedge clk)
begin
clk_50M = ~clk_50M;
end
/****************************LCD1602 Display Data****************************/ 
wire [7:0] data0,data1; //counter data
wire [7:0] addr;   //write address
//-------------------bcd-------------------
reg [7:0]Temp_reg;
reg [7:0]Temp1, Temp0;
always @(posedge clk) begin
    if(Temp_done)
        Temp_reg <= Temp_bcd;
end

always @(posedge clk_50M) begin
    if(state == 8'd8) begin
        Temp1 <= Temp_reg[7:4] + 8'h30;
        Temp0 <= Temp_reg[3:0] + 8'h30;
    end
end

 
//-------------------address------------------
localparam addr1 = 8'h80;
localparam addr2 = 8'hc0;
 
/****************************LCD1602 Driver****************************/            
//-----------------------lcd1602 clk_50M_en---------------------
reg [31:0] cnt;
reg lcd_clk_50M_en;
always @(posedge clk_50M or negedge rst)      
begin
    if(!rst)
        begin
            cnt <= 1'b0;
            lcd_clk_50M_en <= 1'b0;
        end
    else if(cnt == 32'h24999)   //500us
        begin
            lcd_clk_50M_en <= 1'b1;
            cnt <= 1'b0;
        end
    else
        begin
            cnt <= cnt + 1'b1;
            lcd_clk_50M_en <= 1'b0;
        end
end
 
//-----------------------lcd1602 display state-------------------------------------------
always@(posedge clk_50M or negedge rst)
begin
    if(!rst)
        begin
            state <= 1'b0;
            lcd_rs <= 1'b0;
            lcd_en <= 1'b0;
            lcd_data <= 1'b0;   
        end
    else if(lcd_clk_50M_en)     
        begin
            case(state)
                //-------------------init_state---------------------
                8'd0: begin               
                        lcd_rs <= 1'b0;
                        lcd_en <= 1'b1;
                        lcd_data <= Mode_Set;   
                        state <= state + 1'd1;
                        end
                8'd1: begin
                        lcd_en <= 1'b0;
                        state <= state + 1'd1;
                        end
                8'd2: begin
                        lcd_rs <= 1'b0;
                        lcd_en <= 1'b1;
                        lcd_data <= Cursor_Set;
                        state <= state + 1'd1;
                        end
                8'd3: begin
                        lcd_en <= 1'b0;
                        state <= state + 1'd1;
                        end
                8'd4: begin
                        lcd_rs <= 1'b0;
                        lcd_en <= 1'b1;
                        lcd_data <= Address_Set;
                        state <= state + 1'd1;
                        end
                8'd5: begin
                        lcd_en <= 1'b0;
                        state <= state + 1'd1;
                        end
                8'd6: begin
                        lcd_rs <= 1'b0;
                        lcd_en <= 1'b1;
                        lcd_data <= Clear_Set;
                        state <= state + 1'd1;
                        end
                8'd7: begin
                        lcd_en <= 1'b0;
                        state <= state + 1'd1;
                        end
                         
                //--------------------work state--------------------
                8'd8: begin             
                        lcd_rs <= 1'b0;
                        lcd_en <= 1'b1;
                        lcd_data <= addr1;   //write addr
                        state <= state + 1'd1;
                        end
                8'd9: begin
                        lcd_en <= 1'b0;
                        state <= state + 1'd1;
                        end
                8'd10: begin
                        lcd_rs <= 1'b1;
                        lcd_en <= 1'b1;
                        lcd_data <= "T";   //TEMP data
                        state <= state + 1'd1;
                         end
                8'd11: begin
                        lcd_en <= 1'b0;
                        state <= state + 1'd1;
                        end
                8'd12: begin
                        lcd_rs <= 1'b1;
                        lcd_en <= 1'b1;
                        lcd_data <= ":";   //TEMP data
                        state <= state + 1'd1;
                         end
                8'd13: begin
                        lcd_en <= 1'b0;
                        state <= state + 1'd1;
                        end
                8'd14: begin
                        lcd_rs <= 1'b1;
                        lcd_en <= 1'b1;
                        lcd_data <= Temp1;   //TEMP data
                        state <= state + 1'd1;
                         end
                8'd15: begin
                        lcd_en <= 1'b0;
                        state <= state + 1'd1;
                        end
                8'd16: begin
                        lcd_rs <= 1'b1;
                        lcd_en <= 1'b1;
                        lcd_data <= Temp0;   //TEMP data
                        state <= state + 1'd1;
                        end
                8'd17:begin
                        lcd_en <= 1'b0;
                        state <= state + 1'd1;
                        end
                8'd18: begin
                        lcd_en <= 1'b0;
                        state <= 8'd8;
                       end
                
                default: state <= 8'bxxxx_xxxx;
            endcase
        end
end
 
assign lcd_rw = 1'b0;   //only write

assign OE = 1'b1;


endmodule // lcd1602_driver
