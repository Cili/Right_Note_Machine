module counter(
    input clk,
    input [9:0] keynote,
    input [4:0] p,
    output reg [6:0] led_segs_n,
    output reg [3:0] led_sel_n,
    input pulse1
    );
    reg[2:0] i = 0;//Use for counting
    reg [6:0] bcd;
    reg[3:0] playnote;

    always @(posedge clk) begin
    if (keynote[0]==1)
    playnote<=0;
    else if(keynote[1]==1)
    playnote<=1;
     else if(keynote[2]==1)
    playnote<=2;
     else if(keynote[3]==1)
    playnote<=3;
     else if(keynote[4]==1)
    playnote<=4;
     else if(keynote[5]==1)
    playnote<=5;
     else if(keynote[6]==1)
    playnote<=6;
     else if(keynote[7]==1)
    playnote<=7;
     else if(keynote[8]==1)
    playnote<=8;
     else if(keynote[9]==1)
    playnote<=9;
     else 
    playnote<=10;

    end
    
   reg[3:0] bd1= 10,bd2=10,bd3 = 10,bd4 = 10;
   
    always @(*) begin
        case (playnote)
        0:begin bd1 = 0;bd2 = 6;end
        1:begin bd1 = 0;bd2 = 7;end
        2:begin bd1 = 8;bd2 = 1;end
        3:begin bd1 = 8;bd2 = 2;end
        4:begin bd1 = 8;bd2 = 3;end
        5:begin bd1 = 8;bd2 = 4;end
        6:begin bd1 = 8;bd2 = 5;end
        7:begin bd1 = 8;bd2 = 6;end
        8:begin bd1 = 8;bd2 = 7;end
        9:begin bd1 = 9;bd2 = 1;end
        default begin bd1 = 10;bd2  = 10;end
    endcase
    case (p)
        5'b00000:begin bd3 = 0;bd4 = 7;end
        5'b00001:begin bd3 = 0;bd4 = 6;end
        5'b00010:begin bd3 = 0;bd4 = 5;end
        5'b00011:begin bd3 = 0;bd4 = 4;end
        5'b00100:begin bd3 = 0;bd4 = 3;end
        5'b00101:begin bd3 = 0;bd4 = 2;end
        5'b00110:begin bd3 = 0;bd4 = 1;end
        5'b00111:begin bd3 = 9;bd4 = 11;end
        5'b01000:begin bd3 = 9;bd4 = 1;end
        5'b01001:begin bd3 = 9;bd4 = 2;end
        5'b01010:begin bd3 = 9;bd4 = 3;end
        5'b01011:begin bd3 = 9;bd4 = 4;end
        5'b01100:begin bd3 = 9;bd4 = 5;end
        5'b01101:begin bd3 = 9;bd4 = 6;end
        5'b01110:begin bd3 = 9;bd4 = 7;end
        5'b01111:begin bd3 = 9;bd4 = 8;end
        5'b10000:begin bd3 = 9;bd4 = 10;end
        5'b10001:begin bd3 = 1;bd4 = 11;end
        5'b10010:begin bd3 = 1;bd4 = 1;end
        5'b10011:begin bd3 = 1;bd4 = 2;end
        default begin bd3 = 10;bd4  = 10;end
        endcase
    end
    
       
    
    always @(posedge clk)
        if(pulse1) begin
        if(i ==3)
        i <= 0;
        else
        i <= i+1'b1;
        end
        
always @(*)
begin
    led_sel_n = 4'b0000;
    case(i)
    0:begin bcd = bd1;led_sel_n = 4'b0111;end
    1:begin bcd = bd2;led_sel_n = 4'b1011;end
    2:begin bcd = bd3;led_sel_n = 4'b1101;end
    3:begin bcd = bd4;led_sel_n = 4'b1110;end
    endcase
 end
    
    always@(*) begin
    if(i <=1)
    case (bcd)
    0:led_segs_n <= 7'b1110001; //L
    1:led_segs_n <= 7'b1001111;
    2:led_segs_n <= 7'b0010010;
    3:led_segs_n <= 7'b0000110;
    4:led_segs_n <= 7'b1001100;
    5:led_segs_n <= 7'b0100100;
    6:led_segs_n <= 7'b0100000;
    7:led_segs_n <= 7'b0001111;
    8:led_segs_n <= 7'b0001001;// M
    9:led_segs_n <= 7'b1001000;// H
    default led_segs_n <= 7'b1111110;//E
    endcase
    else
    case (bcd)
    0:led_segs_n <= 7'b1111110; //-
    1:led_segs_n <= 7'b1001111;
    2:led_segs_n <= 7'b0010010;
    3:led_segs_n <= 7'b0000110;
    4:led_segs_n <= 7'b1001100;
    5:led_segs_n <= 7'b0100100;
    6:led_segs_n <= 7'b0100000;
    7:led_segs_n <= 7'b0001111;
    8:led_segs_n <= 7'b0000000;// 8
    9:led_segs_n <= 7'b1111111;// E
    10:led_segs_n<=7'b0000100;//9
    11:led_segs_n <= 7'b0000001; // "0"
    default led_segs_n <= 7'b1111111;//E
    endcase
    end
endmodule