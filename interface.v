module interface (
    input clk,
    input [9:0] rawnote, //1-hot encoding keyboard input
    output trig,
    input mode,
    input rec,
    input pitchUP,
    input pitchDown,
    input  rst, //pitch reset

    // UART port
    inout USB_CLOCK,
    inout USB_DATA,
    input [2:0] songselect,
    input ena_i2s,
    input ena_midi,
    
    output dout,
    output bclk,
    output sclk,
    output lrclk,
    output tx // serial port output
    );
    
    wire x,y,z;
    reg [9:0] note;
    wire [3:0] s;
    wire k,m;
    
    
    // button input
    wire btnUP, btnDOWN, btnREC, btnMODE;
    wire [4:0] pitchshift;
    btn_dbc bDOWN (.btn_in(pitchDOWN), .btn(btnDOWN), .rst(rst), .clk(clk), .ena(x));
    btn_dbc bUP (.btn_in(pitchUP), .btn(btnUP), .rst(rst), .clk(clk), .ena(x));
    btn_dbc bMODE (.btn_in(mode), .btn(btnMODE), .rst(rst), .clk(clk), .ena(x));
    
    pitchshifter p0 (.btnl(btnDOWN), .btnr(btnUP), .pitchshift(pitchshift), .clk(clk), .rst(rst));
    
    wire [9:0] rnote;
    wire[9:0] dnote;  
    distance S0(.s_clk(clk),.s_rst_n(0,.trig(trig),.Echo(Echo),.note(dnote));
    //UNNECESSARY CODE??? ena X0 (.clk(clk),.pulse1(x),.pulse2(y),.pulse3(z));//x is diplayed,y120bpm,z60bpm
    
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
    
    wire [9:0] Note;
    wire [4:0] Pitchshift;// Synthesised output consider the keys are played together will stored music
    wire [7:0] modulation;
   
    always@(posedge clk) note <= rnote;
    
    modeselect S1(.clk(clk),.note(note),.pitchshift(pitchshift),.mode(mode),.Note(Note),.Pitchshift(Pitchshift),.autospeed(0),.pulse2(y),.pulse3(z),.rst(rst),.songselect(songselect),.cycle(1));
    
    //UNNECESSARY CODE??? counter X2 (.clk(clk),.keynote(Note),.pulse1(x),.led_sel_n(led_sel_n1),.led_segs_n(led_segs_n1),.p(Pitchshift));

    //DON'T KNOW HOW TO DEAL WITH THESE LINES OF CODE
    usb_mouse T2(.clk(clk),.rst(rst),.led(led),. USB_CLOCK(USB_CLOCK),. USB_DATA( USB_DATA),.mx(modulation));
    test_i2s T3(.pitchshift(Pitchshift), .modulation(modulation), .volume(volume), .key(Note), .clk(clk),.ena(ena_i2s),.dout(dout),.bclk(bclk),.sclk(sclk),.lrclk(lrclk));
    midi(.program(program),.key(Note), .volume(volume), .pitchshift(Pitchshift), .ena(ena_midi), .clk(clk), .tx(tx));
    
endmodule
