`timescale 1ns / 1ps

module Controller(
    input clk,
    input [9:0]rawnote,//Inputs£¬using JA 1~4&8 JxADC 1~4 & 8 pin£¨We will use keyboard£©
    //input Echo,// for ultrasound mod
    //output trig,
    input keysel,//input mode of the key, 0 for ultra sound(doing nothing in our code)
    //input knob_in, // knob tuning volume(XADC 1¿Ú)
    //input [7:0] volume, // Volume input TBD
    //input [7:0] modulation, // PWM input TBD
    input btnl_in,
    input btnr_in, // button input(we will use keyboard keys)
    
    
    output [3:0] led_sel_n1,
    output [6:0] led_segs_n1,//7-seg display on the key
    //input Vtest,
    //output reg Ltest,//to test the voltage JC 2pin for voltage input, "."will indicate display output
    input  rst,//mouse volume reset,btnc in constraint file
    //output [15:0] led,//output mouse location
    // UART port
    inout             USB_CLOCK,
    inout             USB_DATA,
    input             mode,//mod selection 0 manual play 1 automatic play
    input             [2:0]songselect,
    input              cycle,// play one sound, btnc
    // input ena_i2s,
    input ena_midi,
    //input [6:0]program,//midi tone switching(we will possibly not need it)
    
    //output dout,
    //output bclk,
    //output sclk,
    //output lrclk,
    output tx // serial port output
    );
    
    wire x,y,z;
    reg [9:0] note;
    wire [3:0] s;
    wire k,m;
    wire [15:0] led;
    
    //always@(posedge clk) begin
    //if(Vtest)
    //Ltest <= 1;
    //else
    //Ltest <= 0;
    //end
    
    
// knob input(volume control)
    wire [7:0] volume;
    wire [15:0] knob_data;
    wire knob_ena, knob_gnd;
    assign knob_ena = 1;
    assign knob_gnd = 0;
    //adc (.clk(clk), .data_out(knob_data), .ena(knob_ena), .vauxp6(knob_in), .vauxn6(knob_gnd)); // ÐýÅ¥ÊäÈë
    assign volume = knob_data[15:8];
    
    // button input
    wire btnl, btnr,btnu;
    wire [4:0] pitchshift;
    btn_dbc bl (.btn_in(btnl_in), .btn(btnl), .rst(rst), .clk(clk), .ena(x));
    btn_dbc br (.btn_in(btnr_in), .btn(btnr), .rst(rst), .clk(clk), .ena(x));
    btn_dbc bu (.btn_in(keysel), .btn(btnu), .rst(rst), .clk(clk), .ena(x));
    
    pitchshifter (.btnl(btnl), .btnr(btnr), .pitchshift(pitchshift), .clk(clk), .rst(rst));
    
    
    wire [9:0]rnote;wire[9:0]dnote;reg ksel = 0;//1 ultrasound£¬0 keyboard    
    //distance S0(.s_clk(clk),.s_rst_n(ksel),.trig(trig),.Echo(Echo),.note(dnote));
    ena X0 (.clk(clk),.pulse1(x),.pulse2(y),.pulse3(z));//x is diplayed,y120bpm,z60bpm
always@(posedge clk) begin
    if(rst)
    ksel <= 0;
    else if(btnu)
    ksel <= ~ksel;
  end
    
    debouncer#(.COUNT_MAX(255), .COUNT_WIDTH(8)) Y0(.clk(clk),.I(rawnote[0]),.O(rnote[0]));
    debouncer#(.COUNT_MAX(255), .COUNT_WIDTH(8)) Y1(.clk(clk),.I(rawnote[1]),.O(rnote[1]));
    debouncer#(.COUNT_MAX(255), .COUNT_WIDTH(8)) Y2(.clk(clk),.I(rawnote[2]),.O(rnote[2]));
    debouncer#(.COUNT_MAX(255), .COUNT_WIDTH(8)) Y3(.clk(clk),.I(rawnote[3]),.O(rnote[3]));
    debouncer#(.COUNT_MAX(255), .COUNT_WIDTH(8)) Y4(.clk(clk),.I(rawnote[4]),.O(rnote[4]));
    debouncer#(.COUNT_MAX(255), .COUNT_WIDTH(8)) Y5(.clk(clk),.I(rawnote[5]),.O(rnote[5]));
    debouncer#(.COUNT_MAX(255), .COUNT_WIDTH(8)) Y6(.clk(clk),.I(rawnote[6]),.O(rnote[6]));
    debouncer#(.COUNT_MAX(255), .COUNT_WIDTH(8)) Y7(.clk(clk),.I(rawnote[7]),.O(rnote[7]));
    debouncer#(.COUNT_MAX(255), .COUNT_WIDTH(8)) Y8(.clk(clk),.I(rawnote[8]),.O(rnote[8]));
    debouncer#(.COUNT_MAX(255), .COUNT_WIDTH(8)) Y9(.clk(clk),.I(rawnote[9]),.O(rnote[9]));
    
    wire [9:0] Note;wire [4:0]Pitchshift;// Synthesised output consider the keys are played together will stored music
   wire [7:0]modulation;
   
   always@(posedge clk) begin
     if(ksel)
        note <= dnote;
        else
        note <= rnote;
    end
    
    modeselect S1(.clk(clk),.note(note),.pitchshift(pitchshift),.mode(mode),.Note(Note),.Pitchshift(Pitchshift),.autospeed(1),.pulse2(y),.pulse3(z),.rst(rst),.songselect(songselect),.cycle(cycle));
    
    counter X2 (.clk(clk),.keynote(Note),.pulse1(x),.led_sel_n(led_sel_n1),.led_segs_n(led_segs_n1),.p(Pitchshift));
    usb_mouse T2(.clk(clk),.rst(rst),.led(led),. USB_CLOCK(USB_CLOCK),. USB_DATA( USB_DATA),.mx(modulation));
    
    // test_i2s T3(.pitchshift(Pitchshift), .modulation(modulation), .volume(volume), .key(Note), .clk(clk),.ena(ena_i2s),.dout(dout),.bclk(bclk),.sclk(sclk),.lrclk(lrclk));
    midi(.program(7'b0000000),.key(Note), .volume(volume), .pitchshift(Pitchshift), .ena(ena_midi), .clk(clk), .tx(tx));
    
endmodule

