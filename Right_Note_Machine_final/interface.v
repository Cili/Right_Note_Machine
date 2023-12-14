`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 
// Design Name: 
// Module Name: interface
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

//This code is a heavily modified version of the controller file from the original code.
module interface (
    input clk,
    input [9:0] rawnote, //1-hot encoding keyboard input HOWEVER, will be hooked to switches for ease
    input mode, //will be connected to right button
    input rec, //will be connected to left button
    input pitchUP, //will be connected to up button
    input pitchDOWN, //will be connected to bottom button
    input rst, //pitch reset, center button

    // UART port
    inout USB_CLOCK,
    inout USB_DATA,
    input [3:0] songselect, //mapped to the far right switches
    output tx // serial port output
    );
    
    reg [9:0] note;
    reg [6:0] program = 7'b0000000;
    reg [1:0] present_state, next_state;
    reg onvalue = 1; //allows for data to be passed through midi
    
    // button input
    wire btnUP, btnDOWN, btnREC, btnMODE;
    wire [4:0] pitchshift;
    wire x,y,z;
    
    btn_dbc bUP(clk, pitchUP, rst, x, btnUP);
    btn_dbc bDOWN(clk, pitchDOWN, rst, x, btnDOWN);
    btn_dbc bREC(clk, rec, rst, x, btnREC);
    btn_dbc bMODE(clk, mode, rst, x, btnMODE);
    
    reg playbackMode = 0;
    reg recMode = 0;
    reg counter = 0;
    always @(*) begin
        if(btnMODE) playbackMode <= ~playbackMode;
        if(btnREC | counter == 10) begin
            recMode <= ~recMode;
            counter = 0;
        end   
    end
    
    //pitchshifter p0 (.btnl(btnDOWN), .btnr(btnUP), .pitchshift(pitchshift), .clk(clk), .rst(rst));
    pitchshifter p0(clk, btnDOWN, btnUP, rst, pitchshift); 
    ena x0(clk, x, y, z);
    
    // the following code would have been used if we had implmented the keyboard proberly.
    //debouncer#(.COUNT_MAX(255), .COUNT_WIDTH(8)) Y0(.clk(clk),.I(rawnote[0]),.O(debnote[0]));
    //debouncer#(.COUNT_MAX(255), .COUNT_WIDTH(8)) Y1(.clk(clk),.I(rawnote[1]),.O(debnote[1]));
    //debouncer#(.COUNT_MAX(255), .COUNT_WIDTH(8)) Y2(.clk(clk),.I(rawnote[2]),.O(debnote[2]));
    //debouncer#(.COUNT_MAX(255), .COUNT_WIDTH(8)) Y3(.clk(clk),.I(rawnote[3]),.O(debnote[3]));
    //debouncer#(.COUNT_MAX(255), .COUNT_WIDTH(8)) Y4(.clk(clk),.I(rawnote[4]),.O(debnote[4]));
    //debouncer#(.COUNT_MAX(255), .COUNT_WIDTH(8)) Y5(.clk(clk),.I(rawnote[5]),.O(debnote[5]));
    //debouncer#(.COUNT_MAX(255), .COUNT_WIDTH(8)) Y6(.clk(clk),.I(rawnote[6]),.O(debnote[6]));
    //debouncer#(.COUNT_MAX(255), .COUNT_WIDTH(8)) Y7(.clk(clk),.I(rawnote[7]),.O(debnote[7]));
    //debouncer#(.COUNT_MAX(255), .COUNT_WIDTH(8)) Y8(.clk(clk),.I(rawnote[8]),.O(debnote[8]));
    //debouncer#(.COUNT_MAX(255), .COUNT_WIDTH(8)) Y9(.clk(clk),.I(rawnote[9]),.O(debnote[9]));
    //wire [9:0] debnote; UNUSED UNTIL KEYBOARD IS IMPLEMENTED
    
    parameter [1:0] playState = 0; 
    parameter [1:0] recordState = 1; 
    parameter [1:0] playbackState = 2;
    
    initial present_state = playState;
 
    always @(rst or btnREC or btnMODE) begin
        case (present_state)
           playState: if(btnREC) next_state <= recordState; 
                      else if(btnMODE) next_state <= playbackState;
           recordState: if(btnREC) next_state <= playState;
           playbackState: if(btnMODE) next_state <= playState;
        endcase
   end
    
   always @(posedge clk) begin
        present_state<=next_state;
   end

    wire [9:0] Note; // will either be passed the input note OR a playback note depending on mode
    wire [4:0] Pitchshift;// will either be passed the input pitch OR a playback pitch
   
    //the following wires are USELESS. just a way to reroute outputs from og code
    wire [15:0] led; //rerouting output from USB mouse file
    wire [7:0] modulation; //rerouting output from USB mouse file
    
    //NOTE (pun intended): the following function, modeselect, is passed the input of rawnote INSTEAD of debnote.
    // if we got keyboard successfully working, we would have passed debnote instead
    modeselect S1(clk, rst, recMode, rawnote, pitchshift, playbackMode, 0, songselect, 1, y, z, Note, Pitchshift); // STEP 1: determine play VS playback
    usb_mouse T2(clk, rst, USB_CLOCK, USB_DATA, mx, led);
    midi(clk, Note, on_value, program, Pitchshift, tx); //STEP 2: configure note with pitch, output bit by bit to tx
    
endmodule
