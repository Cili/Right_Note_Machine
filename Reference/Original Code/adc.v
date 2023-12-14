`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/30/2020 08:15:10 PM
// Design Name: 
// Module Name: adc
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


module adc(
input clk,
input ena,
input vauxp6,
input vauxn6,
output reg [15:0] data_out
    );
    wire [15:0] data;
    wire ready;
    wire [6:0] addr;
    
    always @ (posedge clk) begin
        if (ready)
            data_out <= data;
    end
    
    assign addr = 8'h16;
    xadc_wiz_0 your_instance_name (
      .di_in(),              // input wire [15 : 0] di_in
      .daddr_in(addr),        // input wire [6 : 0] daddr_in
      .den_in(ena),            // input wire den_in
      .dwe_in(),            // input wire dwe_in
      .drdy_out(ready),        // output wire drdy_out
      .do_out(data),            // output wire [15 : 0] do_out
      .dclk_in(clk),          // input wire dclk_in
      .vp_in(),              // input wire vp_in
      .vn_in(),              // input wire vn_in
      .vauxp6(vauxp6),            // input wire vauxp6
      .vauxn6(vauxn6),            // input wire vauxn6
      .channel_out(),  // output wire [4 : 0] channel_out
      .eoc_out(),          // output wire eoc_out
      .alarm_out(),      // output wire alarm_out
      .eos_out(),          // output wire eos_out
      .busy_out()        // output wire busy_out
    );
endmodule
