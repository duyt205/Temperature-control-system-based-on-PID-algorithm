`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/31 12:22:16
// Design Name: 
// Module Name: bin2bcd
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


module bin2bcd(
    input clk,
    input rst,
    input [7:0]bin,
    output reg [7:0]bcd,
    output reg done
);
localparam  idle = 2'b00,
            op = 2'b01,
            finish = 2'b10;

reg [1:0] crt_state,next_state;
reg [7:0] p2s;
reg [3:0] cnt;
reg [3:0] bcd1_reg, bcd0_reg;
wire [3:0] bcd1_temp, bcd0_temp;

always @(posedge clk or negedge rst) begin
    if(!rst)
        crt_state <= 0;
    else
        crt_state <= next_state;
end

always @(*) begin
    case (crt_state)
        idle:
            next_state = op;
        op:
            begin
                if(cnt == 5'b0000)
                    next_state = finish;
                else
                    next_state = op;
            end
        finish:
            next_state = idle;
        default: next_state = idle;
    endcase
end

always @(posedge clk) begin
    case (crt_state)
        idle:
            begin
                p2s <= bin;
                cnt <= 4'd7;
                bcd0_reg <= 0;
                bcd1_reg <= 0;
            end 
        op:
            begin
                done <= 0;
                cnt <= cnt - 1'b1;
                p2s <= p2s << 1;
                bcd0_reg <= {bcd0_temp[2:0], p2s[7]};
                bcd1_reg <= {bcd1_temp[2:0], bcd0_temp[3]};
            end
        finish:
            begin
                done <= 1;
                bcd <= {bcd1_reg, bcd0_reg};
            end
    endcase
end

assign bcd0_temp = (bcd0_reg > 4)? bcd0_reg + 4'h3: bcd0_reg;
assign bcd1_temp = (bcd1_reg > 4)? bcd1_reg + 4'h3: bcd1_reg;

endmodule 
