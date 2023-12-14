`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:
// Design Name: 
// Module Name: usb_mouse
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

//This file is nearly identical to the original file. We have left it in the submission because we wanted to implement keyboard but didn't get to.
module usb_mouse(
    input             clk,
    input             rst,
    inout             USB_CLOCK,
    inout             USB_DATA,
    output reg[7:0] mx,
    output reg [15:0] led
);

// USB ports control
wire   USB_CLOCK_OE;
wire   USB_DATA_OE;
wire   USB_CLOCK_out;
wire   USB_CLOCK_in;
wire   USB_DATA_out;
wire   USB_DATA_in;
assign USB_CLOCK = (USB_CLOCK_OE) ? USB_CLOCK_out : 1'bz;
assign USB_DATA = (USB_DATA_OE) ? USB_DATA_out : 1'bz;
assign USB_CLOCK_in = USB_CLOCK;
assign USB_DATA_in = USB_DATA;

wire       PS2_valid;
wire [7:0] PS2_data_in;
wire       PS2_busy;
wire       PS2_error;
wire       PS2_complete;
reg        PS2_enable;
(* dont_touch = "true" *)reg  [7:0] PS2_data_out;

// Used for chipscope
(* dont_touch = "true" *)reg  USB_CLOCK_d;
(* dont_touch = "true" *)reg  USB_DATA_d;

always @(posedge clk or posedge rst) begin
    if(rst) begin
        USB_CLOCK_d <= 1'b0;
        USB_DATA_d  <= 1'b0;
    end
    else begin
        USB_CLOCK_d <= USB_CLOCK_in;
        USB_DATA_d <= USB_DATA_in;
    end
end

// Controller for the PS2 port
// Transfer parallel 8-bit data into serial, or receive serial to parallel
ps2_transmitter ps2_transmitter(
    .clk(clk),
    .rst(rst),
    
    .clock_in(USB_CLOCK_in),
    .serial_data_in(USB_DATA_in),
    .parallel_data_in(PS2_data_in),
    .parallel_data_valid(PS2_valid),
    .busy(PS2_busy),
    .data_in_error(PS2_error),
    
    .clock_out(USB_CLOCK_out),
    .serial_data_out(USB_DATA_out),
    .parallel_data_out(PS2_data_out),
    .parallel_data_enable(PS2_enable),
    .data_out_complete(PS2_complete),
    
    .clock_output_oe(USB_CLOCK_OE),
    .data_output_oe(USB_DATA_OE)
);
// Control of the movement of LED
genvar      i;
// Threshold of pwm wave, the higher, the brighter
reg  [5:0]  led_bright[15:0];
// Counter for pwm wave
reg  [5:0]  led_pwm_count[15:0];
// signal from USB, gathered in state machine
reg         led_move_left, led_move_right;
// LED selection, only light up the selected one
reg  [15:0] led_selection_left, led_selection_right;
// When one LED reach the minimum or maximum, it will indicate to move selection register
reg  [15:0] led_selection_move_left, led_selection_move_right;

always @(posedge clk or posedge rst) begin
    // Original selection is the middle two LEDs
    if(rst) begin
        led_selection_left <= 16'h0100;
        led_selection_right <= 16'h0080;
        mx<= 8'b01000000;

    end
    // Loop shift left
    else if( |led_selection_move_left ) begin
        led_selection_left <= {led_selection_left[14:0], led_selection_left[15]};
        led_selection_right <= {led_selection_right[14:0], led_selection_right[15]};

        if(mx>6'b101111)
        mx<= mx-6'b101111;
        else
        mx <=101111;
    end
    // Loop shift right
    else if( |led_selection_move_right ) begin
        led_selection_left <= {led_selection_left[0], led_selection_left[15:1]};
        led_selection_right <= {led_selection_right[0], led_selection_right[15:1]};

        if(mx < 8'b11100010)
        mx <= mx+6'b111101;
        else
        mx <=8'b0000000;
    end
end

// Every one LED has a separate controller logic
generate
    for(i=0; i<16; i=i+1) begin : LED_control
        // brightness control
        always @(posedge clk or posedge rst) begin
            // Initial
            if(rst) begin
                led_bright[i] <= (i==7) ? 6'h1F : ( (i==8) ? 6'h20 : 6'h00);
            end
            else if(led_move_left) begin
                // When move_left signal asserted, the selected right LED decrease brightness
                if(led_selection_right[i]) begin
                    led_bright[i] <= led_bright[i] - 6'd1;
                end
                // And the left LED increase brightness
                else if(led_selection_left[i]) begin
                    led_bright[i] <= led_bright[i] + 6'd1;
                end
                // Unselected LED keep off
                else begin
                    led_bright[i] <= 6'd0;
                end
            
                // If the right LED is about to reach minimum, indicate selection register to shift left
                if(led_selection_right[i] & led_bright[i] == 6'h01) begin
                    led_selection_move_left[i] <= 1'b1;
                end
                else begin
                    led_selection_move_left[i] <= 1'b0;
                end
            end
            else if(led_move_right) begin
                // When move_right signal asserted, the selected right LED increase brightness
                if(led_selection_right[i]) begin
                    led_bright[i] <= led_bright[i] + 6'd1;
                end
                // And the left LED decrease brightness
                else if(led_selection_left[i]) begin
                    led_bright[i] <= led_bright[i] - 6'd1;
                end
                // Unselected LED keep off
                else begin
                    led_bright[i] <= 6'd0;
                end
            
                // If the left LED is about to reach minimum, indicate selection register to shift right
                if(led_selection_left[i] & led_bright[i] == 6'h01) begin
                    led_selection_move_right[i] <= 1'b1;
                end
                else begin
                    led_selection_move_right[i] <= 1'b0;
                end
            end
            else begin
                led_selection_move_left[i] <= 1'b0;
                led_selection_move_right[i] <= 1'b0;
            end
        end
    
        // Use pwm wave to control the brightness of LEDs
        always @(posedge clk or posedge rst) begin
            if(rst) begin
                led_pwm_count[i] <= 6'd0;
                led[i] <= 1'b0;
            end
            else if(led_pwm_count[i] < led_bright[i])begin
                led_pwm_count[i] <= led_pwm_count[i] + 6'd1;
                led[i] <= 1'b1;
            end
            else begin
                led_pwm_count[i] <= led_pwm_count[i] + 6'd1;
                led[i] <= 1'b0;
            end
        end
    end
endgenerate
// State machine definition
parameter [3:0] IDLE = 4'd0;
parameter [3:0] SEND_RESET = 4'd1;
parameter [3:0] WAIT_ACKNOWLEDGE1 = 4'd2;
parameter [3:0] WAIT_SELF_TEST = 4'd3;
parameter [3:0] WAIT_MOUSE_ID = 4'd4;
parameter [3:0] ENABLE_DATA_REPORT = 4'd5;
parameter [3:0] WAIT_ACKNOWLEDGE2 = 4'd6;
parameter [3:0] GET_DATA1 = 4'd7;
parameter [3:0] GET_DATA2 = 4'd8;
parameter [3:0] GET_DATA3 = 4'd9;

(* dont_touch = "true" *)reg [3:0] state;
(* dont_touch = "true" *)reg [3:0] next_state;

always @(posedge clk or posedge rst) begin
    if(rst) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @(posedge clk) begin
    case(state)
    IDLE: begin
        next_state <= SEND_RESET;
        PS2_enable <= 1'b0;
        PS2_data_out <= 8'h00;
    end
    // First send out a reset, in case the mouse is attached in the beginning
    SEND_RESET: begin
        if(~PS2_busy && PS2_complete) begin
            next_state <= WAIT_ACKNOWLEDGE1;
            PS2_enable <= 1'b0;
        end
        else begin
            next_state <= SEND_RESET;
            PS2_enable <= 1'b1;
            PS2_data_out <= 8'hFF;
        end
    end
    // Wait for the first acknowledge signal 0xFA
    WAIT_ACKNOWLEDGE1: begin
        if(PS2_valid && (PS2_data_in == 8'hFA)) begin   // acknowledged
            next_state <= WAIT_SELF_TEST;
        end
        else begin
            next_state <= WAIT_ACKNOWLEDGE1;
        end
    end
    // The mouse will send back self-test pass signal 0xAA back first
    WAIT_SELF_TEST: begin
        if(PS2_valid && (PS2_data_in == 8'hAA)) begin   // self-test passed
            next_state <= WAIT_MOUSE_ID;
        end
        else begin
            next_state <= WAIT_SELF_TEST;
        end
    end
    // Then followed by the ID 0x00
    WAIT_MOUSE_ID: begin
        if(PS2_valid && (PS2_data_in == 8'h00)) begin   // mouse ID
            next_state <= ENABLE_DATA_REPORT;
        end
        else begin
            next_state <= WAIT_MOUSE_ID;
        end
    end
    // Enable data report mode 0xF4
    ENABLE_DATA_REPORT: begin
        if(~PS2_busy && PS2_complete) begin
            next_state <= WAIT_ACKNOWLEDGE2;
            PS2_enable <= 1'b0;
        end
        else begin
            next_state <= ENABLE_DATA_REPORT;
            PS2_enable <= 1'b1;
            PS2_data_out <= 8'hF4;
        end
    end
    // Wait for the second acknowledge signal 0xFA
    WAIT_ACKNOWLEDGE2: begin
        if(PS2_valid && (PS2_data_in == 8'hFA)) begin   // acknowledged
            next_state <= GET_DATA1;
        end
        else begin
            next_state <= WAIT_ACKNOWLEDGE2;
        end
    end
    // Get first byte from mouse, find if it's moving left or right, and if left clicked and right clicked
    // [4] is the XS bit, 1 means left, 0 means right
    // [1] is right click, [0] is left click, 1 means clicked
    // We don't get the distance here, for simplicity
    GET_DATA1: begin
        if(PS2_valid) begin
            led_move_left <= ((PS2_data_in[4]) | PS2_data_in[0]) ? 1'b1 : 1'b0;
            led_move_right <= ((~PS2_data_in[4]) | PS2_data_in[1]) ? 1'b1 : 1'b0;
            next_state <= GET_DATA2;
        end
        else begin
            led_move_left <= 1'b0;
            led_move_right <= 1'b0;
            next_state <= GET_DATA1;
        end
    end
    // Second byte, X distance
    GET_DATA2: begin
        if(PS2_valid) begin
            next_state <= GET_DATA3;
        end
        else begin
            led_move_left <= 1'b0;
            led_move_right <= 1'b0;
            next_state <= GET_DATA2;
        end
    end
    // Third byte, Y distance, loop back to wait for next data packet
    GET_DATA3: begin
        if(PS2_valid) begin
            next_state <= GET_DATA1;
        end
        else begin
            next_state <= GET_DATA3;
        end
    end
    endcase
end


endmodule
