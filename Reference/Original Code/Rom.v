`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/31 12:57:51
// Design Name: 
// Module Name: Rom
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


module Rom(
    input[9:0] A,
    input [2:0]songselect,
    output reg[9:0] ml,
    output reg[9:0]  romnote,
    output reg[4:0]  rompit,
    output reg[3:0] beat
    );
    parameter ITV = 10'b0000000000;
    parameter H1 = 10'b1000000000;
    parameter M7 = 10'b0100000000;
    parameter M6 = 10'b0010000000;
    parameter M5 = 10'b0001000000;
    parameter M4 = 10'b0000100000;
    parameter M3 = 10'b0000010000;
    parameter M2 = 10'b0000001000;
    parameter M1 = 10'b0000000100;
    parameter L7 = 10'b0000000010;
    parameter L6 = 10'b0000000001;
    always@(A or songselect) begin
        if(songselect==3'b001) begin
            ml = 10'd93;
    case(A)
    0: begin romnote = L6; rompit = 17; beat = 4; end
    1: begin romnote = ITV; rompit = 17; beat = 4; end
    2: begin romnote = L6; rompit = 17; beat = 4; end
    3: begin romnote = M3; rompit = 17; beat = 4; end
    4: begin romnote = M2; rompit = 17; beat = 4; end
    5: begin romnote = ITV; rompit = 17; beat = 4; end
    6: begin romnote = M1; rompit = 17; beat = 4; end
    7: begin romnote = ITV; rompit = 17; beat = 4; end
    8: begin romnote = L7; rompit = 17; beat = 4; end
    9: begin romnote = ITV; rompit = 17; beat = 4; end
    10: begin romnote = L7; rompit = 17; beat = 2; end
    11: begin romnote = ITV; rompit = 17; beat = 2; end
    12: begin romnote = L7; rompit = 17; beat = 2; end
    13: begin romnote = ITV; rompit = 17; beat = 2; end
    14: begin romnote = M2; rompit = 17; beat = 4; end
    15: begin romnote = ITV; rompit = 17; beat = 4; end
    16: begin romnote = M1; rompit = 17; beat = 4; end
    17: begin romnote = L7; rompit = 17; beat = 4; end
    18: begin romnote = L6; rompit = 17; beat = 4; end
    19: begin romnote = ITV; rompit = 17; beat = 4; end
    20: begin romnote = L6; rompit = 17; beat = 4; end
    21: begin romnote = H1; rompit = 17; beat = 4; end
    22: begin romnote = M7; rompit = 17; beat = 4; end
    23: begin romnote = H1; rompit = 17; beat = 4; end
    24: begin romnote = M7; rompit = 17; beat = 4; end
    25: begin romnote = H1; rompit = 17; beat = 4; end
    26: begin romnote = L6; rompit = 17; beat = 4; end
    27: begin romnote = ITV; rompit = 17; beat = 4; end
    28: begin romnote = L6; rompit = 17; beat = 4; end
    29: begin romnote = H1; rompit = 17; beat = 4; end
    30: begin romnote = M7; rompit = 17; beat = 4; end
    31: begin romnote = H1; rompit = 17; beat = 4; end
    32: begin romnote = M7; rompit = 17; beat = 4; end
    33: begin romnote = H1; rompit = 17; beat = 4; end
    34: begin romnote = M1; rompit = 17; beat = 3; end
    35: begin romnote = ITV; rompit = 17; beat = 1; end
    36: begin romnote = M1; rompit = 17; beat = 3; end
    37: begin romnote = ITV; rompit = 17; beat = 1; end
    38: begin romnote = M1; rompit = 17; beat = 3; end
    39: begin romnote = ITV; rompit = 17; beat = 1; end
    40: begin romnote = M1; rompit = 17; beat = 3; end
    41: begin romnote = ITV; rompit = 17; beat = 1; end
    42: begin romnote = M3; rompit = 17; beat = 3; end
    43: begin romnote = ITV; rompit = 17; beat = 1; end
    44: begin romnote = M3; rompit = 17; beat = 3; end
    45: begin romnote = ITV; rompit = 17; beat = 1; end
    46: begin romnote = M3; rompit = 17; beat = 3; end
    47: begin romnote = ITV; rompit = 17; beat = 1; end
    48: begin romnote = M3; rompit = 17; beat = 3; end
    49: begin romnote = ITV; rompit = 17; beat = 1; end
    50: begin romnote = M2; rompit = 17; beat = 3; end
    51: begin romnote = ITV; rompit = 17; beat = 1; end
    52: begin romnote = M2; rompit = 17; beat = 3; end
    53: begin romnote = ITV; rompit = 17; beat = 1; end
    54: begin romnote = M2; rompit = 17; beat = 3; end
    55: begin romnote = ITV; rompit = 17; beat = 1; end
    56: begin romnote = M2; rompit = 17; beat = 3; end
    57: begin romnote = ITV; rompit = 17; beat = 1; end
    58: begin romnote = M5; rompit = 17; beat = 3; end
    59: begin romnote = ITV; rompit = 17; beat = 1; end
    60: begin romnote = M5; rompit = 17; beat = 3; end
    61: begin romnote = ITV; rompit = 17; beat = 1; end
    62: begin romnote = M5; rompit = 17; beat = 3; end
    63: begin romnote = ITV; rompit = 17; beat = 1; end
    64: begin romnote = M5; rompit = 17; beat = 3; end
    65: begin romnote = ITV; rompit = 17; beat = 1; end
    66: begin romnote = M6; rompit = 17; beat = 3; end
    67: begin romnote = ITV; rompit = 17; beat = 1; end
    68: begin romnote = M6; rompit = 17; beat = 3; end
    69: begin romnote = ITV; rompit = 17; beat = 1; end
    70: begin romnote = M6; rompit = 17; beat = 3; end
    71: begin romnote = ITV; rompit = 17; beat = 1; end
    72: begin romnote = M6; rompit = 17; beat = 3; end
    73: begin romnote = ITV; rompit = 17; beat = 1; end
    74: begin romnote = M6; rompit = 17; beat = 3; end
    75: begin romnote = ITV; rompit = 17; beat = 1; end
    76: begin romnote = M6; rompit = 17; beat = 3; end
    77: begin romnote = ITV; rompit = 17; beat = 1; end
    78: begin romnote = M6; rompit = 17; beat = 3; end
    79: begin romnote = ITV; rompit = 17; beat = 1; end
    80: begin romnote = M6; rompit = 17; beat = 3; end
    81: begin romnote = ITV; rompit = 17; beat = 1; end
    82: begin romnote = M6; rompit = 17; beat = 3; end
    83: begin romnote = ITV; rompit = 17; beat = 1; end
    84: begin romnote = M6; rompit = 17; beat = 3; end
    85: begin romnote = ITV; rompit = 17; beat = 1; end
    86: begin romnote = M6; rompit = 17; beat = 3; end
    87: begin romnote = ITV; rompit = 17; beat = 1; end
    88: begin romnote = M6; rompit = 17; beat = 3; end
    89: begin romnote = ITV; rompit = 17; beat = 1; end
    90: begin romnote = M2; rompit = 17; beat = 4; end
    91: begin romnote = M1; rompit = 17; beat = 4; end
    92: begin romnote = L7; rompit = 17; beat = 4; end
    93: begin romnote = L6; rompit = 15; beat = 4; end
    default:begin romnote = ITV;rompit = 0;beat = 4;end
    endcase
    end
    
    else if(songselect==3'b010) begin
        ml = 10'd67;
    case(A)
    0:begin romnote = ITV;rompit = 0;beat = 4;end
    1:begin romnote = ITV;rompit = 0;beat = 4;end    
    2:begin romnote = ITV;rompit = 0;beat = 4;end
    3:begin romnote = M6;rompit = 0;beat = 4;end
    4:begin romnote = M3;rompit = 12;beat = 3;end
    5:begin romnote = M3;rompit = 12;beat = 3;end
    6:begin romnote = M3;rompit = 12;beat = 3;end
    7:begin romnote = M3;rompit = 12;beat = 9;end
    8:begin romnote = ITV;rompit = 0;beat = 3;end
    9:begin romnote = M2;rompit = 12;beat = 4;end
    10:begin romnote = M1;rompit = 12;beat = 4;end
    11:begin romnote = M2;rompit = 12;beat = 4;end
    12:begin romnote = M1;rompit = 12;beat = 4;end
    13:begin romnote = L7;rompit = 12;beat = 4;end
    14:begin romnote = L6;rompit = 12;beat = 12;end
    15:begin romnote = ITV;rompit = 0;beat = 4;end
    16:begin romnote = M6;rompit = 12;beat = 3;end
    17:begin romnote = ITV;rompit = 0;beat = 1;end
    18:begin romnote = M6;rompit = 12;beat = 4;end
    19:begin romnote = ITV;rompit = 0;beat = 1;end
    20:begin romnote = M6;rompit = 12;beat = 3;end
    21:begin romnote = ITV;rompit = 0;beat = 1;end
    22:begin romnote = M6;rompit = 12;beat = 4;end
    23:begin romnote = ITV;rompit = 0;beat = 1;end
    24:begin romnote = M6;rompit = 12;beat = 9;end
    25:begin romnote = ITV;rompit = 0;beat = 2;end
    26:begin romnote = M5;rompit = 12;beat = 4;end
    27:begin romnote = M3;rompit = 12;beat = 4;end
    28:begin romnote = M5;rompit = 12;beat = 3;end
    29:begin romnote = M5;rompit = 12;beat = 3;end
    30:begin romnote = M4;rompit = 13;beat = 4;end
    31:begin romnote = M3;rompit = 12;beat = 12;end
    32:begin romnote = ITV;rompit = 0;beat = 1;end
    33:begin romnote = M3;rompit = 12;beat = 3;end
    34:begin romnote = M6;rompit = 12;beat = 3;end
    35:begin romnote = ITV;rompit = 0;beat = 1;end
    36:begin romnote = M6;rompit = 12;beat = 3;end
    37:begin romnote = ITV;rompit = 0;beat = 1;end
    38:begin romnote = M5;rompit = 12;beat = 3;end
    39:begin romnote = M3;rompit = 12;beat = 12;end
    40:begin romnote = M2;rompit = 12;beat = 3;end
    41:begin romnote = ITV;rompit = 0;beat = 1;end
    42:begin romnote = M1;rompit = 12;beat = 3;end
    43:begin romnote = ITV;rompit = 0;beat = 1;end
    44:begin romnote = M2;rompit = 12;beat = 3;end
    45:begin romnote = ITV;rompit = 0;beat = 1;end
    46:begin romnote = M1;rompit = 12;beat = 3;end
    47:begin romnote = L7;rompit = 12;beat = 3;end
    48:begin romnote = L6;rompit = 12;beat = 6;end
    49:begin romnote = M3;rompit = 0;beat = 6;end
    50:begin romnote = ITV;rompit = 0;beat = 1;end
    51:begin romnote = M3;rompit = 0;beat = 3;end
    52:begin romnote = ITV;rompit = 0;beat = 1;end
    53:begin romnote = H1;rompit = 0;beat = 3;end
    54:begin romnote = ITV;rompit = 0;beat = 1;end
    55:begin romnote = H1;rompit = 0;beat = 3;end 
    56:begin romnote = ITV;rompit = 0;beat = 1;end
    57:begin romnote = M7;rompit = 0;beat = 3;end
    58:begin romnote = ITV;rompit = 0;beat = 1;end
    59:begin romnote = M6;rompit = 0;beat = 12;end
    60:begin romnote = ITV;rompit = 0;beat = 1;end
    61:begin romnote = M3;rompit = 12;beat = 4;end
    62:begin romnote = M2;rompit = 12;beat = 4;end
    63:begin romnote = M1;rompit = 12;beat = 4;end
    64:begin romnote = M7;rompit = 0;beat = 4;end 
    65:begin romnote = M5;rompit = 0;beat = 4;end
    66:begin romnote = M6;rompit = 0;beat = 12;end
    67:begin romnote = ITV;rompit = 0;beat = 4;end
    default:begin romnote = ITV;rompit = 0;beat = 4;end
    endcase
    end
    else if(songselect==3'b100) begin
    ml = 10'd374;
    case(A)
    0: begin romnote = L6; rompit = 11; beat = 4; end
    1: begin romnote = ITV; rompit = 11; beat = 4; end
    2: begin romnote = L6; rompit = 11; beat = 4; end
    3: begin romnote = M1; rompit = 11; beat = 4; end
    4: begin romnote = ITV; rompit = 11; beat = 4; end
    5: begin romnote = M1; rompit = 11; beat = 4; end
    6: begin romnote = ITV; rompit = 11; beat = 4; end
    7: begin romnote = M2; rompit = 11; beat = 4; end
    8: begin romnote = ITV; rompit = 11; beat = 4; end
    9: begin romnote = M2; rompit = 11; beat = 4; end
    10: begin romnote = ITV; rompit = 11; beat = 4; end
    11: begin romnote = M5; rompit = 11; beat = 3; end
    12: begin romnote = ITV; rompit = 11; beat = 1; end
    13: begin romnote = M5; rompit = 11; beat = 4; end
    14: begin romnote = M4; rompit = 12; beat = 3; end
    15: begin romnote = ITV; rompit = 11; beat = 1; end
    16: begin romnote = M4; rompit = 12; beat = 6; end
    17: begin romnote = ITV; rompit = 11; beat = 2; end
    18: begin romnote = L6|M1; rompit = 11; beat = 4; end
    19: begin romnote = ITV; rompit = 11; beat = 4; end
    20: begin romnote = M1; rompit = 11; beat = 1; end
    21: begin romnote = ITV; rompit = 11; beat = 1; end
    22: begin romnote = M1; rompit = 11; beat = 1; end
    23: begin romnote = M1|M3; rompit = 11; beat = 4; end
    24: begin romnote = ITV; rompit = 11; beat = 4; end
    25: begin romnote = M1|M3; rompit = 11; beat = 4; end
    26: begin romnote = ITV; rompit = 11; beat = 4; end
    27: begin romnote = M1|M3; rompit = 11; beat = 4; end
    28: begin romnote = ITV; rompit = 11; beat = 4; end
    29: begin romnote = M2; rompit = 11; beat = 4; end
    30: begin romnote = ITV; rompit = 11; beat = 4; end
    31: begin romnote = M5; rompit = 11; beat = 3; end
    32: begin romnote = ITV; rompit = 11; beat = 1; end
    33: begin romnote = M5; rompit = 11; beat = 3; end
    34: begin romnote = ITV; rompit = 11; beat = 1; end
    35: begin romnote = M5; rompit = 11; beat = 3; end
    36: begin romnote = ITV; rompit = 11; beat = 1; end
    37: begin romnote = M4|M6; rompit = 11; beat = 6; end
    38: begin romnote = ITV; rompit = 11; beat = 2; end
    39: begin romnote = L6; rompit = 11; beat = 4; end
    40: begin romnote = ITV; rompit = 11; beat = 4; end
    41: begin romnote = L6; rompit = 11; beat = 4; end
    42: begin romnote = M1; rompit = 11; beat = 4; end
    43: begin romnote = ITV; rompit = 11; beat = 4; end
    44: begin romnote = M1; rompit = 11; beat = 4; end
    45: begin romnote = ITV; rompit = 11; beat = 4; end
    46: begin romnote = M2; rompit = 11; beat = 4; end
    47: begin romnote = ITV; rompit = 11; beat = 4; end
    48: begin romnote = M2; rompit = 11; beat = 4; end
    49: begin romnote = ITV; rompit = 11; beat = 4; end
    50: begin romnote = M5; rompit = 11; beat = 3; end
    51: begin romnote = ITV; rompit = 11; beat = 1; end
    52: begin romnote = M5; rompit = 11; beat = 4; end
    53: begin romnote = M4; rompit = 12; beat = 3; end
    54: begin romnote = ITV; rompit = 11; beat = 1; end
    55: begin romnote = M4; rompit = 12; beat = 6; end
    56: begin romnote = ITV; rompit = 11; beat = 2; end
    57: begin romnote = L6|M1; rompit = 11; beat = 4; end
    58: begin romnote = ITV; rompit = 11; beat = 4; end
    59: begin romnote = M1; rompit = 11; beat = 1; end
    60: begin romnote = ITV; rompit = 11; beat = 1; end
    61: begin romnote = M1; rompit = 11; beat = 1; end
    62: begin romnote = M1|M3; rompit = 11; beat = 4; end
    63: begin romnote = ITV; rompit = 11; beat = 4; end
    64: begin romnote = M1|M3; rompit = 11; beat = 4; end
    65: begin romnote = M5; rompit = 11; beat = 4; end
    66: begin romnote = ITV; rompit = 11; beat = 4; end
    67: begin romnote = M5; rompit = 11; beat = 4; end
    68: begin romnote = M4; rompit = 12; beat = 4; end
    69: begin romnote = ITV; rompit = 11; beat = 4; end
    70: begin romnote = M4; rompit = 12; beat = 12; end
    71: begin romnote = ITV; rompit = 11; beat = 8; end
    72: begin romnote = L6; rompit = 11; beat = 4; end
    73: begin romnote = ITV; rompit = 11; beat = 4; end
    74: begin romnote = M1; rompit = 11; beat = 4; end
    75: begin romnote = L6; rompit = 9; beat = 4; end
    76: begin romnote = ITV; rompit = 11; beat = 4; end
    77: begin romnote = L6; rompit = 11; beat = 2; end
    78: begin romnote = L6|L7; rompit = 11; beat = 2; end
    79: begin romnote = L6|M1; rompit = 11; beat = 2; end
    80: begin romnote = L6|L7; rompit = 11; beat = 2; end
    81: begin romnote = L6; rompit = 11; beat = 2; end
    82: begin romnote = L6; rompit = 9; beat = 2; end
    83: begin romnote = L6; rompit = 11; beat = 4; end
    84: begin romnote = ITV; rompit = 11; beat = 4; end
    85: begin romnote = M1; rompit = 11; beat = 4; end
    86: begin romnote = L6; rompit = 9; beat = 4; end
    87: begin romnote = ITV; rompit = 11; beat = 4; end
    88: begin romnote = L6; rompit = 11; beat = 4; end
    89: begin romnote = L6|M2; rompit = 6; beat = 4; end
    90: begin romnote = L6; rompit = 9; beat = 4; end
    91: begin romnote = L6; rompit = 11; beat = 4; end
    92: begin romnote = ITV; rompit = 11; beat = 4; end
    93: begin romnote = L6; rompit = 9; beat = 3; end
    94: begin romnote = ITV; rompit = 9; beat = 1; end
    95: begin romnote = L6|L7; rompit = 9; beat = 4; end
    96: begin romnote = ITV; rompit = 9; beat = 4; end
    97: begin romnote = L6; rompit = 7; beat = 4; end
    98: begin romnote = L6|M1; rompit = 7; beat = 4; end
    99: begin romnote = ITV; rompit = 11; beat = 4; end
    100: begin romnote = M1|M3; rompit = 6; beat = 4; end
    101: begin romnote = ITV; rompit = 11; beat = 4; end
    102: begin romnote = L6|L7; rompit = 11; beat = 3; end
    103: begin romnote = ITV; rompit = 11; beat = 1; end
    104: begin romnote = L6; rompit = 11; beat = 4; end
    105: begin romnote = L6; rompit = 11; beat = 4; end
    106: begin romnote = L6; rompit = 9; beat = 4; end
    107: begin romnote = M3; rompit = 11; beat = 4; end
    108: begin romnote = ITV; rompit = 11; beat = 4; end
    109: begin romnote = L6; rompit = 11; beat = 4; end
    110: begin romnote = ITV; rompit = 11; beat = 4; end
    111: begin romnote = M1; rompit = 11; beat = 4; end
    112: begin romnote = L6; rompit = 9; beat = 4; end
    113: begin romnote = ITV; rompit = 11; beat = 4; end
    114: begin romnote = L6; rompit = 11; beat = 2; end
    115: begin romnote = L6|L7; rompit = 11; beat = 2; end
    116: begin romnote = L6|M1; rompit = 11; beat = 2; end
    117: begin romnote = L6|L7; rompit = 11; beat = 2; end
    118: begin romnote = L6; rompit = 11; beat = 2; end
    119: begin romnote = L6; rompit = 9; beat = 2; end
    120: begin romnote = L6; rompit = 11; beat = 3; end
    121: begin romnote = ITV; rompit = 11; beat = 1; end
    122: begin romnote = L6; rompit = 11; beat = 4; end
    123: begin romnote = M1; rompit = 11; beat = 4; end
    124: begin romnote = L6; rompit = 11; beat = 4; end
    125: begin romnote = ITV; rompit = 11; beat = 4; end
    126: begin romnote = L6|M1; rompit = 11; beat = 4; end
    127: begin romnote = M1; rompit = 11; beat = 3; end
    128: begin romnote = ITV; rompit = 11; beat = 1; end
    129: begin romnote = M1; rompit = 11; beat = 4; end
    130: begin romnote = L7; rompit = 11; beat = 4; end
    131: begin romnote = ITV; rompit = 11; beat = 4; end
    132: begin romnote = M1|M3; rompit = 6; beat = 3; end
    133: begin romnote = ITV; rompit = 6; beat = 1; end
    134: begin romnote = M1|M3; rompit = 6; beat = 4; end
    135: begin romnote = ITV; rompit = 11; beat = 4; end
    136: begin romnote = M1|M2; rompit = 6; beat = 2; end
    137: begin romnote = M1|M3; rompit = 6; beat = 2; end
    138: begin romnote = M1; rompit = 11; beat = 2; end
    139: begin romnote = L7; rompit = 11; beat = 2; end
    140: begin romnote = L6; rompit = 11; beat = 2; end
    141: begin romnote = L6; rompit = 9; beat = 2; end
    142: begin romnote = L6; rompit = 11; beat = 4; end
    143: begin romnote = ITV; rompit = 11; beat = 4; end
    144: begin romnote = ITV; rompit = 11; beat = 4; end
    145: begin romnote = M3|M5; rompit = 11; beat = 4; end
    146: begin romnote = ITV; rompit = 11; beat = 4; end
    147: begin romnote = M2|M4; rompit = 11; beat = 4; end
    148: begin romnote = M1|M3; rompit = 11; beat = 4; end
    149: begin romnote = L7|M2; rompit = 11; beat = 4; end
    150: begin romnote = ITV; rompit = 11; beat = 4; end
    151: begin romnote = ITV; rompit = 11; beat = 4; end
    152: begin romnote = M5|M1; rompit = 11; beat = 3; end
    153: begin romnote = ITV; rompit = 11; beat = 1; end
    154: begin romnote = M5|M1; rompit = 11; beat = 4; end
    155: begin romnote = ITV; rompit = 11; beat = 4; end
    156: begin romnote = M2|L6; rompit = 11; beat = 4; end
    157: begin romnote = M2|L6; rompit = 11; beat = 4; end
    158: begin romnote = ITV; rompit = 11; beat = 4; end
    159: begin romnote = ITV; rompit = 11; beat = 4; end
    160: begin romnote = ITV; rompit = 11; beat = 4; end
    161: begin romnote = M5|M1; rompit = 11; beat = 3; end
    162: begin romnote = ITV; rompit = 11; beat = 1; end
    163: begin romnote = M5|M1; rompit = 11; beat = 4; end
    164: begin romnote = ITV; rompit = 11; beat = 4; end
    165: begin romnote = L6|M3; rompit = 11; beat = 4; end
    166: begin romnote = L6|M3; rompit = 11; beat = 4; end
    167: begin romnote = ITV; rompit = 11; beat = 4; end
    168: begin romnote = ITV; rompit = 11; beat = 4; end
    169: begin romnote = M1; rompit = 3; beat = 1; end
    170: begin romnote = ITV; rompit = 11; beat = 1; end
    171: begin romnote = M1; rompit = 3; beat = 2; end
    172: begin romnote = M1; rompit = 6; beat = 4; end
    173: begin romnote = M1; rompit = 3; beat = 4; end
    174: begin romnote = M1; rompit = 6; beat = 4; end
    175: begin romnote = M1; rompit = 3; beat = 4; end
    176: begin romnote = M1; rompit = 6; beat = 4; end
    177: begin romnote = L6; rompit = 11; beat = 4; end
    178: begin romnote = L6; rompit = 11; beat = 4; end
    179: begin romnote = ITV; rompit = 11; beat = 4; end
    180: begin romnote = ITV; rompit = 11; beat = 4; end
    181: begin romnote = M3|M5; rompit = 11; beat = 4; end
    182: begin romnote = ITV; rompit = 11; beat = 4; end
    183: begin romnote = M2|M4; rompit = 11; beat = 4; end
    184: begin romnote = M1|M3; rompit = 11; beat = 4; end
    185: begin romnote = L6|M2; rompit = 11; beat = 4; end
    186: begin romnote = ITV; rompit = 11; beat = 4; end
    187: begin romnote = ITV; rompit = 11; beat = 4; end
    188: begin romnote = M5|M1; rompit = 11; beat = 3; end
    189: begin romnote = ITV; rompit = 11; beat = 1; end
    190: begin romnote = M5|M1; rompit = 11; beat = 4; end
    191: begin romnote = ITV; rompit = 11; beat = 4; end
    192: begin romnote = M2|L6; rompit = 11; beat = 4; end
    193: begin romnote = M2|L6; rompit = 11; beat = 4; end
    194: begin romnote = ITV; rompit = 11; beat = 4; end
    195: begin romnote = ITV; rompit = 11; beat = 4; end
    196: begin romnote = ITV; rompit = 11; beat = 4; end
    197: begin romnote = M1; rompit = 11; beat = 4; end
    198: begin romnote = L7; rompit = 11; beat = 4; end
    199: begin romnote = L7; rompit = 11; beat = 4; end
    200: begin romnote = L6; rompit = 11; beat = 4; end
    201: begin romnote = L6; rompit = 9; beat = 4; end
    202: begin romnote = L6; rompit = 9; beat = 4; end
    203: begin romnote = L6|M3; rompit = 11; beat = 4; end
    204: begin romnote = L6|M3; rompit = 11; beat = 4; end
    205: begin romnote = L6|M3; rompit = 11; beat = 4; end
    206: begin romnote = L6|M3; rompit = 11; beat = 4; end
    207: begin romnote = L6|M3; rompit = 11; beat = 4; end
    208: begin romnote = L6|M3; rompit = 11; beat = 4; end
    209: begin romnote = ITV; rompit = 11; beat = 4; end
    210: begin romnote = ITV; rompit = 11; beat = 4; end
    211: begin romnote = ITV; rompit = 11; beat = 4; end
    212: begin romnote = L6; rompit = 11; beat = 4; end
    213: begin romnote = L7; rompit = 11; beat = 4; end
    214: begin romnote = M1; rompit = 11; beat = 4; end
    215: begin romnote = ITV; rompit = 11; beat = 4; end
    216: begin romnote = ITV; rompit = 11; beat = 4; end
    217: begin romnote = M1|M6; rompit = 11; beat = 3; end
    218: begin romnote = ITV; rompit = 11; beat = 1; end
    219: begin romnote = M1; rompit = 11; beat = 4; end
    220: begin romnote = L7; rompit = 11; beat = 4; end
    221: begin romnote = L6|M5; rompit = 11; beat = 4; end
    222: begin romnote = L6; rompit = 9; beat = 3; end
    223: begin romnote = ITV; rompit = 9; beat = 1; end
    224: begin romnote = L6; rompit = 9; beat = 4; end
    225: begin romnote = M3; rompit = 11; beat = 4; end
    226: begin romnote = L6; rompit = 11; beat = 3; end
    227: begin romnote = ITV; rompit = 11; beat = 1; end
    228: begin romnote = L6; rompit = 11; beat = 4; end
    229: begin romnote = ITV; rompit = 11; beat = 4; end
    230: begin romnote = M3; rompit = 11; beat = 4; end
    231: begin romnote = M2; rompit = 11; beat = 4; end
    232: begin romnote = M1; rompit = 11; beat = 4; end
    233: begin romnote = L7; rompit = 11; beat = 4; end
    234: begin romnote = M1; rompit = 11; beat = 4; end
    235: begin romnote = ITV; rompit = 11; beat = 4; end
    236: begin romnote = L7; rompit = 11; beat = 4; end
    237: begin romnote = M1; rompit = 11; beat = 4; end
    238: begin romnote = M2; rompit = 11; beat = 4; end
    239: begin romnote = M1; rompit = 11; beat = 4; end
    240: begin romnote = M2; rompit = 11; beat = 3; end
    241: begin romnote = ITV; rompit = 11; beat = 1; end
    242: begin romnote = M2; rompit = 11; beat = 4; end
    243: begin romnote = ITV; rompit = 11; beat = 4; end
    244: begin romnote = M3; rompit = 11; beat = 4; end
    245: begin romnote = M2|M5; rompit = 11; beat = 4; end
    246: begin romnote = ITV; rompit = 11; beat = 4; end
    247: begin romnote = M5; rompit = 11; beat = 4; end
    248: begin romnote = M1|M6; rompit = 8; beat = 4; end
    249: begin romnote = L7; rompit = 11; beat = 4; end
    250: begin romnote = M1; rompit = 11; beat = 4; end
    251: begin romnote = ITV; rompit = 11; beat = 4; end
    252: begin romnote = ITV; rompit = 11; beat = 4; end
    253: begin romnote = M1|M6; rompit = 11; beat = 3; end
    254: begin romnote = ITV; rompit = 11; beat = 1; end
    255: begin romnote = M1; rompit = 11; beat = 4; end
    256: begin romnote = L7; rompit = 11; beat = 4; end
    257: begin romnote = L6|M5; rompit = 11; beat = 4; end
    258: begin romnote = L6; rompit = 9; beat = 3; end
    259: begin romnote = ITV; rompit = 9; beat = 1; end
    260: begin romnote = L6; rompit = 9; beat = 4; end
    261: begin romnote = M3; rompit = 11; beat = 4; end
    262: begin romnote = L6; rompit = 11; beat = 3; end
    263: begin romnote = ITV; rompit = 11; beat = 1; end
    264: begin romnote = L6; rompit = 11; beat = 4; end
    265: begin romnote = ITV; rompit = 11; beat = 4; end
    266: begin romnote = M3; rompit = 11; beat = 4; end
    267: begin romnote = M2; rompit = 11; beat = 4; end
    268: begin romnote = M1; rompit = 11; beat = 4; end
    269: begin romnote = L7; rompit = 11; beat = 4; end
    270: begin romnote = M1; rompit = 11; beat = 4; end
    271: begin romnote = ITV; rompit = 11; beat = 4; end
    272: begin romnote = L7; rompit = 11; beat = 4; end
    273: begin romnote = M1; rompit = 11; beat = 4; end
    274: begin romnote = M2; rompit = 11; beat = 4; end
    275: begin romnote = M1; rompit = 11; beat = 4; end
    276: begin romnote = M2; rompit = 11; beat = 3; end
    277: begin romnote = ITV; rompit = 11; beat = 1; end
    278: begin romnote = M2; rompit = 11; beat = 4; end
    279: begin romnote = ITV; rompit = 11; beat = 4; end
    280: begin romnote = M3; rompit = 11; beat = 4; end
    281: begin romnote = M2|M6; rompit = 11; beat = 4; end
    282: begin romnote = ITV; rompit = 11; beat = 4; end
    283: begin romnote = ITV; rompit = 11; beat = 4; end
    284: begin romnote = ITV; rompit = 11; beat = 4; end
    285: begin romnote = ITV; rompit = 11; beat = 4; end
    286: begin romnote = ITV; rompit = 11; beat = 4; end
    287: begin romnote = ITV; rompit = 11; beat = 4; end
    288: begin romnote = M3|M7; rompit = 11; beat = 4; end
    289: begin romnote = M3; rompit = 11; beat = 4; end
    290: begin romnote = M3; rompit = 11; beat = 4; end
    291: begin romnote = M3; rompit = 11; beat = 4; end
    292: begin romnote = L6|M3; rompit = 11; beat = 4; end
    293: begin romnote = L7; rompit = 11; beat = 4; end
    294: begin romnote = M1; rompit = 11; beat = 4; end
    295: begin romnote = ITV; rompit = 11; beat = 4; end
    296: begin romnote = ITV; rompit = 11; beat = 4; end
    297: begin romnote = M1|M6; rompit = 11; beat = 3; end
    298: begin romnote = ITV; rompit = 11; beat = 1; end
    299: begin romnote = M1; rompit = 11; beat = 4; end
    300: begin romnote = L7; rompit = 11; beat = 4; end
    301: begin romnote = L6|M5; rompit = 11; beat = 4; end
    302: begin romnote = L6; rompit = 9; beat = 3; end
    303: begin romnote = ITV; rompit = 9; beat = 1; end
    304: begin romnote = L6; rompit = 9; beat = 4; end
    305: begin romnote = M3; rompit = 11; beat = 4; end
    306: begin romnote = L6; rompit = 11; beat = 3; end
    307: begin romnote = ITV; rompit = 11; beat = 1; end
    308: begin romnote = L6; rompit = 11; beat = 4; end
    309: begin romnote = ITV; rompit = 11; beat = 4; end
    310: begin romnote = M3; rompit = 11; beat = 4; end
    311: begin romnote = M2; rompit = 11; beat = 4; end
    312: begin romnote = M1|M2; rompit = 11; beat = 4; end
    313: begin romnote = L7; rompit = 11; beat = 4; end
    314: begin romnote = M1; rompit = 11; beat = 4; end
    315: begin romnote = ITV; rompit = 11; beat = 4; end
    316: begin romnote = L7; rompit = 11; beat = 4; end
    317: begin romnote = M1; rompit = 11; beat = 4; end
    318: begin romnote = M2; rompit = 11; beat = 4; end
    319: begin romnote = M1; rompit = 11; beat = 4; end
    320: begin romnote = M2; rompit = 11; beat = 3; end
    321: begin romnote = ITV; rompit = 11; beat = 1; end
    322: begin romnote = M2; rompit = 11; beat = 4; end
    323: begin romnote = ITV; rompit = 11; beat = 4; end
    324: begin romnote = M3; rompit = 11; beat = 4; end
    325: begin romnote = M2|M5; rompit = 11; beat = 4; end
    326: begin romnote = ITV; rompit = 11; beat = 4; end
    327: begin romnote = M5; rompit = 11; beat = 4; end
    328: begin romnote = M1|M6; rompit = 8; beat = 4; end
    329: begin romnote = L7; rompit = 11; beat = 4; end
    330: begin romnote = M1; rompit = 11; beat = 4; end
    331: begin romnote = ITV; rompit = 11; beat = 4; end
    332: begin romnote = ITV; rompit = 11; beat = 4; end
    333: begin romnote = M1|M6; rompit = 11; beat = 3; end
    334: begin romnote = ITV; rompit = 11; beat = 1; end
    335: begin romnote = M1; rompit = 11; beat = 4; end
    336: begin romnote = L7; rompit = 11; beat = 4; end
    337: begin romnote = L6|M5; rompit = 11; beat = 4; end
    338: begin romnote = L6; rompit = 9; beat = 3; end
    339: begin romnote = ITV; rompit = 9; beat = 1; end
    340: begin romnote = L6; rompit = 9; beat = 4; end
    341: begin romnote = M3; rompit = 11; beat = 4; end
    342: begin romnote = L6; rompit = 11; beat = 3; end
    343: begin romnote = ITV; rompit = 11; beat = 1; end
    344: begin romnote = L6; rompit = 11; beat = 4; end
    345: begin romnote = ITV; rompit = 11; beat = 4; end
    346: begin romnote = M3; rompit = 11; beat = 4; end
    347: begin romnote = M2; rompit = 11; beat = 4; end
    348: begin romnote = M1; rompit = 11; beat = 4; end
    349: begin romnote = L7; rompit = 11; beat = 4; end
    350: begin romnote = M1; rompit = 11; beat = 4; end
    351: begin romnote = ITV; rompit = 11; beat = 4; end
    352: begin romnote = L7; rompit = 11; beat = 4; end
    353: begin romnote = M1; rompit = 11; beat = 4; end
    354: begin romnote = M2; rompit = 11; beat = 4; end
    355: begin romnote = M1; rompit = 11; beat = 4; end
    356: begin romnote = M2; rompit = 11; beat = 3; end
    357: begin romnote = ITV; rompit = 11; beat = 1; end
    358: begin romnote = M2; rompit = 11; beat = 4; end
    359: begin romnote = ITV; rompit = 11; beat = 4; end
    360: begin romnote = M3; rompit = 11; beat = 4; end
    361: begin romnote = M2|M6; rompit = 11; beat = 4; end
    362: begin romnote = ITV; rompit = 11; beat = 4; end
    363: begin romnote = ITV; rompit = 11; beat = 4; end
    364: begin romnote = ITV; rompit = 11; beat = 4; end
    365: begin romnote = ITV; rompit = 11; beat = 4; end
    366: begin romnote = ITV; rompit = 11; beat = 4; end
    367: begin romnote = ITV; rompit = 11; beat = 4; end
    368: begin romnote = M3|M7; rompit = 11; beat = 4; end
    369: begin romnote = M3; rompit = 11; beat = 4; end
    370: begin romnote = M3; rompit = 11; beat = 4; end
    371: begin romnote = M3; rompit = 11; beat = 4; end
    372: begin romnote = M3; rompit = 11; beat = 4; end
    373: begin romnote = ITV; rompit = 11; beat = 4; end
    374: begin romnote = ITV; rompit = 11; beat = 4; end
    default:begin romnote = ITV;rompit = 0;beat = 4;end
    endcase
    end
     else 
      ml = 10'd200;
    end
endmodule
