`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/30 11:36:19
// Design Name: 
// Module Name: pid_core
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


module pid_core(
    input clk,   
    input rst_n,   
    input [8:0] error,   
    output reg [16:0] uk   
    );   
  
//reg  [16:0]uk;   
wire [16:0]uk_wire;        
reg [8:0]error_1,error_2;   
parameter k0=5;   
parameter k1=1;   
parameter k2=1;  
parameter C0=0;
wire [1:0] ccc; 

assign ccc = C0;
  
always @(posedge clk)   
begin   
    if(!rst_n)   
        begin   
            error_1<=0;   
            error_2<=0;   
        end   
    else  
        begin   
            error_1<=error;   
            error_2<=error_1;   
        end   
end   
  
//   
reg [14:0]uk1;   
always @(posedge clk)   
begin   
    if(!rst_n)   
        begin   
            uk<=0;   
            uk1<=0;   
        end   
    else  
        begin   
            if((uk_wire>17'd15000)&&(uk_wire<17'b1000_0000_0000_00000))   
                begin   
                    uk<=17'd15000;   
                end   
            else  
                    begin   
                        uk1<=uk[14:0];   
                        uk<=uk_wire;   
                    end    
        end   
end   
  
wire [14:0] p0; 

xbip_multadd_0 u1 (
  .CLK(clk),            // input wire CLK
  .CE(rst_n),              // input wire CE
  .SCLR(ccc),          // input wire SCLR
  .A(error),                // input wire [8 : 0] A
  .B(k0),                // input wire [2 : 0] B
  .C(ccc),                // input wire [1 : 0] C
  .SUBTRACT(ccc),  // input wire SUBTRACT
  .P(p0),                // output wire [15 : 0] P
  .PCOUT()        // output wire [47 : 0] PCOUT
);  
                           
wire [14:0] p1; 

xbip_multadd_0 u2 (
  .CLK(clk),            // input wire CLK
  .CE(rst_n),              // input wire CE
  .SCLR(ccc),          // input wire SCLR
  .A(error_1),                // input wire [8 : 0] A
  .B(k1),                // input wire [2 : 0] B
  .C(ccc),                // input wire [1 : 0] C
  .SUBTRACT(ccc),  // input wire SUBTRACT
  .P(p1),                // output wire [15 : 0] P
  .PCOUT()        // output wire [47 : 0] PCOUT
);  

wire [14:0] p2;   

xbip_multadd_0 u3 (
  .CLK(clk),            // input wire CLK
  .CE(rst_n),              // input wire CE
  .SCLR(ccc),          // input wire SCLR
  .A(error_2),                // input wire [8 : 0] A
  .B(k2),                // input wire [2 : 0] B
  .C(ccc),                // input wire [1 : 0] C
  .SUBTRACT(ccc),  // input wire SUBTRACT
  .P(p2),                // output wire [15 : 0] P
  .PCOUT()        // output wire [47 : 0] PCOUT
);
  
wire [15:0]s1;                         
add           u4 (   
                        .a ( p0 ),   
                        .b ( p1 ),   
                        .s ( s1 ),   
                        .clk ( clk ),
                        .rst_n(rst_n)  
                        );   
  
wire [15:0]s2;   
                      
add           u5 (   
                        .a ( p2 ),   
                        .b ( uk1 ),   
                        .s ( s2 ),   
                        .clk ( clk ),
                        .rst_n(rst_n)    
                        );   
                   
add2             u6 (   
                        .a ( s1 ),   
                        .b ( s2 ),   
                        .s ( uk_wire ),   
                        .clk (clk),
                        .rst_n(rst_n)      
                        );   
  
  
endmodule  

