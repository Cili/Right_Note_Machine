`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/13/2023 11:04:31 AM
// Design Name: 
// Module Name: usb_keyboard
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


module usb_keyboard(
    
    input clk,
    input rst,
    input ps2_clk,
    input ps2_data,
    inout  USB_CLK,
    inout  USB_DATA
);

    wire [31:0] keycodeout;
    reg [9:0] rawnote;
    reg [3:0] bit_index = 0;
    reg [9:0] data_to_send;
    reg sending = 0;

    // Instance of the PS2 receiver module
    PS2Receiver receiver (
        .clk(clk),
        .kclk(ps2_clk),
        .kdata(ps2_data),
        .keycodeout(keycodeout)
    );

    // Mapping keyboard scan codes to bits
    always @(posedge clk) begin
        if (rst) begin
            rawnote <= 10'b0;
            sending <= 0;
            bit_index <= 0;
        end else begin
            case (keycodeout[7:0])
                8'h15: rawnote[0] <= 1; // 'Q' key
                8'h1D: rawnote[1] <= 1; // 'W' key
                8'h24: rawnote[2] <= 1; // 'E' key
                8'h2D: rawnote[3] <= 1; // 'R' key
                8'h2C: rawnote[4] <= 1; // 'T' key
                8'h35: rawnote[5] <= 1; // 'Y' key
                8'h3C: rawnote[6] <= 1; // 'U' key
                8'h43: rawnote[7] <= 1; // 'I' key
                8'h44: rawnote[8] <= 1; // 'O' key
                8'h4D: rawnote[9] <= 1; // 'P' key
                default: rawnote <= rawnote; // Keep current state for other scan codes
            endcase

            // Prepare data for transmission
            if (keycodeout[7:0] >= 8'h15 && keycodeout[7:0] <= 8'h4D) begin
                data_to_send <= rawnote;
                sending <= 1;
                bit_index <= 0;
            end
        end
    end

    // Sending data over USB-like interface
    always @(posedge clk) begin
        if (sending) begin
            USB_CLK <= ~USB_CLK; // Toggle USB clock
            if (bit_index < 10) begin
                USB_DATA <= data_to_send[bit_index];
                bit_index <= bit_index + 1;
            end else begin
                sending <= 0; // Stop sending after all bits are sent
            end
        end else begin
            USB_CLK <= 1; // Keep USB clock high when not sending
            USB_DATA <= 1; // Idle state
        end
    end

endmodule
