`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/13/2023 01:11:19 PM
// Design Name: 
// Module Name: PS2Receiver
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


module PS2Receiver(
    input clk,
    input kclk,   // ps2_clk in usb_keyboard
    input kdata,  // ps2_data in usb_keyboard
    output reg [31:0] keycodeout
);

    reg [10:0] shift_reg;
    reg [3:0] bit_count;
    reg frame_started;
    reg [7:0] kclk_stable, kdata_stable; // Debounce counters
    reg kclk_debounced, kdata_debounced; // Debounced signals

    initial begin
        shift_reg = 0;
        bit_count = 0;
        frame_started = 0;
        keycodeout = 0;
        kclk_stable = 0;
        kdata_stable = 0;
        kclk_debounced = 1;
        kdata_debounced = 1;
    end

    // Debounce logic
    always @(posedge clk) begin
        if (kclk == kclk_debounced) begin
            kclk_stable <= 0;
        end else if (kclk_stable < 255) begin
            kclk_stable <= kclk_stable + 1;
            if (kclk_stable == 255) kclk_debounced <= kclk;
        end

        if (kdata == kdata_debounced) begin
            kdata_stable <= 0;
        end else if (kdata_stable < 255) begin
            kdata_stable <= kdata_stable + 1;
            if (kdata_stable == 255) kdata_debounced <= kdata;
        end
    end

    // PS2 receiver logic with debounced signals
    always @(posedge clk) begin
        if (kclk_debounced == 0 && frame_started == 0 && kdata_debounced == 0) begin
            // Start bit detected
            frame_started = 1;
            bit_count = 0;
        end else if (frame_started) begin
            if (bit_count < 11) begin
                shift_reg[bit_count] <= kdata_debounced;
                bit_count <= bit_count + 1;
            end

            if (bit_count == 10) begin
                // Stop bit reached, frame complete
                frame_started = 0;
                keycodeout <= {21'b0, shift_reg[8:1]}; // Assuming 8-bit scan code
                shift_reg <= 0;
            end
        end
    end

endmodule
