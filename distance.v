`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/03 20:19:58
// Design Name: 
// Module Name: distance
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


module distance(
    input s_clk,
    input s_rst_n,
    input Echo,
    output reg trig,
    output reg [9:0] note
    );
// generate cnt_17M_en  delay 2 paces
reg [2:0]Echo_delay;
reg[15:0] data;
parameter A = 30'd1010;//pulse width 1000,10us
parameter B = 14'd2941;// divider coefficient£¬17khz clk5882
parameter C = 30'd1250000;//peroid 100000000
always@(posedge s_clk or negedge s_rst_n)
begin
if(!s_rst_n)
    begin
        Echo_delay <= 'd0;
    end
else
    begin
        Echo_delay <= {Echo_delay[1:0], Echo};
    end
end

wire nege_Echo;
wire pose_Echo;
assign pose_Echo= (~Echo_delay[2])&& Echo_delay[1];// posdedge detection
assign nege_Echo = Echo_delay[2]&&(~Echo_delay[1]);// negedge detection

reg cnt_17k_en;
always @(posedge s_clk or negedge s_rst_n)
begin
    if(!s_rst_n)
        cnt_17k_en <= 'd0;
    else
        if(pose_Echo)
            cnt_17k_en <= 1'b1;
        else
            if(nege_Echo)
                cnt_17k_en <= 1'b0;
            else
                cnt_17k_en <= cnt_17k_en;
end

reg[13:0] cnt_17k;
always @(posedge s_clk or negedge s_rst_n)
begin
    if(!s_rst_n)
        cnt_17k <= 'd0;
    else
        if(cnt_17k_en)
            begin
                if(cnt_17k == B)
                    cnt_17k <= 'd0;
                else
                    cnt_17k <= cnt_17k +1'b1;
                end
            else
                cnt_17k <= 'd0;
end

reg clk_17k;
always @(posedge s_clk or negedge s_rst_n)
begin
    if(!s_rst_n)
        clk_17k <= 1'b0;
    else
        if(cnt_17k == B)
            clk_17k <= 1'b1;
        else
            clk_17k <= 1'b0;
end

//generate trig
reg [29:0] cnt_10us;
always @(posedge s_clk or negedge s_rst_n)
begin
    if(!s_rst_n)
        cnt_10us <= 1'b0;
    else
        if(cnt_10us == C)
            cnt_10us <= 'd0;
        else
            cnt_10us <= cnt_10us +1'b1;
end

always @(posedge s_clk or negedge s_rst_n)
begin
    if(!s_rst_n)
        trig <= 1'b0;
    else
        if(cnt_10us <= A)
            trig <= 1'b1;
        else
            trig <= 1'b0;
end

reg [15:0] data_r;
always @ (posedge s_clk or negedge s_rst_n)
begin
	if(!s_rst_n)
		data_r <= 'd0;
	else if(clk_17k == 1'b1)
		begin
				if(data_r[3 :0 ] == 'd9)
					begin
						data_r[7 :4 ] <= 1'b1 + data_r[7 :4 ];
						data_r[3 :0 ] <= 'd0;
					end 
				else 
					if(data_r[7 :4 ] == 'd10)
						begin
							data_r[11:8 ] <= 1'b1 + data_r[11:8 ];
							data_r[7 :4 ] <= 'd0;
						end 
					else 
						if(data_r[11:8 ] == 'd10)
							begin
								data_r[15:12] <= 1'b1 + data_r[15:12];
								data_r[11:8 ] <= 'd0;
							end 
						else 
							data_r <= data_r + 1'b1;
			end 
		else 
			if(cnt_10us == C)
				data_r <= 'd0;
			else
				data_r <= data_r;
end 
// solve the data will become 0 problem
always @ (posedge s_clk or negedge s_rst_n)
begin
	if(!s_rst_n)
		data <= 'd0;
	else 
		if(cnt_10us == (C-1))
			data <= data_r;
		else 
			data <= data ;
end
             always@(posedge s_clk) begin
             if(cnt_10us == C-1)begin
             if (data<16'd9)    note <= 10'b0000000001;
             else if(data<16'd25) note <= 10'b0000000010;
             else if(data<16'd41) note <= 10'b0000000100;
             else if(data<16'd57) note <= 10'b0000001000;
             else if(data<16'd73) note <= 10'b0000010000;
             else if(data<16'd89) note <= 10'b0000100000;
             else if(data<16'd105) note <= 10'b0001000000;
             else if(data<16'd121) note <= 10'b0010000000;
             else if(data<16'd137) note <= 10'b0100000000;
             else if(data<16'd170) note <= 10'b1000000000;
             else  note <= 10'b0000000000;
             end
             end
endmodule