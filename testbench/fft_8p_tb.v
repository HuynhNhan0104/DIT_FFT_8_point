`timescale 1ns/1ns

module fft_8p_tb;
localparam WIDTH = 32;

localparam Q_LENGTH = 16;
reg clk, reset;

reg signed [WIDTH-1 : 0] x0_real , x0_img;
reg signed [WIDTH-1 : 0] x1_real , x1_img;
reg signed [WIDTH-1 : 0] x2_real , x2_img;
reg signed [WIDTH-1 : 0] x3_real , x3_img;
reg signed [WIDTH-1 : 0] x4_real , x4_img;
reg signed [WIDTH-1 : 0] x5_real , x5_img;
reg signed [WIDTH-1 : 0] x6_real , x6_img;
reg signed [WIDTH-1 : 0] x7_real , x7_img;

wire signed [WIDTH-1 : 0] y0_real, y0_img;
wire signed [WIDTH-1 : 0] y1_real, y1_img;
wire signed [WIDTH-1 : 0] y2_real, y2_img;
wire signed [WIDTH-1 : 0] y3_real, y3_img;
wire signed [WIDTH-1 : 0] y4_real, y4_img;
wire signed [WIDTH-1 : 0] y5_real, y5_img;
wire signed [WIDTH-1 : 0] y6_real, y6_img;
wire signed [WIDTH-1 : 0] y7_real, y7_img;


fft_8p #(.WIDTH(WIDTH), .Q_LENGTH(Q_LENGTH))  uut (
    .clk(clk), .reset(reset),
    .x0_real(x0_real), .x0_img(x0_img),
    .x1_real(x1_real), .x1_img(x1_img),
    .x2_real(x2_real), .x2_img(x2_img),
    .x3_real(x3_real), .x3_img(x3_img),
    .x4_real(x4_real), .x4_img(x4_img),
    .x5_real(x5_real), .x5_img(x5_img),
    .x6_real(x6_real), .x6_img(x6_img),
    .x7_real(x7_real), .x7_img(x7_img),

    .y0_real(y0_real), .y0_img(y0_img),
    .y1_real(y1_real), .y1_img(y1_img),
    .y2_real(y2_real), .y2_img(y2_img),
    .y3_real(y3_real), .y3_img(y3_img),
    .y4_real(y4_real), .y4_img(y4_img),
    .y5_real(y5_real), .y5_img(y5_img),
    .y6_real(y6_real), .y6_img(y6_img),
    .y7_real(y7_real), .y7_img(y7_img)
);


initial begin
    $dumpfile("fft_8p_tb.vcd");
    $dumpvars(0,fft_8p_tb);
end


initial begin
    $display("testing fast fourier transform module");
    $monitor(
        "time = %0t \n input:\n x0 = %h + i * %h\n x1 = %h + i * %h\n x2 = %h + i * %h\n x3 = %h + i * %h\n x4 = %h + i * %h\n x5 = %h + i * %h\n x6 = %h + i * %h\n x7 = %h + i * %h\n output: \n y0 = %h + i * %h\n y1 = %h + i * %h\n y2 = %h + i * %h\n y3 = %h + i * %h\n y4 = %h + i * %h\n y5 = %h + i * %h\n y6 = %h + i * %h\n y7 = %h + i * %h\n ", 
        $time,
        x0_real, x0_img, 
        x1_real, x1_img,
        x2_real, x2_img,
        x3_real, x3_img,
        x4_real, x4_img,
        x5_real, x5_img, 
        x6_real, x6_img,
        x7_real, x7_img,
        y0_real, y0_img,
        y1_real, y1_img,
        y2_real, y2_img,
        y3_real, y3_img,
        y4_real, y4_img,
        y5_real, y5_img,
        y6_real, y6_img,
        y7_real, y7_img
    );




end

initial begin
    reset = 0;
    clk = 1'b1;
    forever #50 clk = ~clk;
end

initial begin
    x0_real <= 32'h0000_0000; x0_img <= 32'h0000_0000;
    x1_real <= 32'h0000_0000; x1_img <= 32'h0000_0000;
    x2_real <= 32'h0000_0000; x2_img <= 32'h0000_0000;
    x3_real <= 32'h0000_0000; x3_img <= 32'h0000_0000;
    x4_real <= 32'h0000_0000; x4_img <= 32'h0000_0000;
    x5_real <= 32'h0000_0000; x5_img <= 32'h0000_0000;
    x6_real <= 32'h0000_0000; x6_img <= 32'h0000_0000;
    x7_real <= 32'h0000_0000; x7_img <= 32'h0000_0000;
end


initial begin
    #90;
    // testcase 1: all is 0
    // input: all is 0
    // expected: all is 0
    x0_real <= 32'h0000_0000; x0_img <= 32'h0000_0000;
    x1_real <= 32'h0000_0000; x1_img <= 32'h0000_0000;
    x2_real <= 32'h0000_0000; x2_img <= 32'h0000_0000;
    x3_real <= 32'h0000_0000; x3_img <= 32'h0000_0000;
    x4_real <= 32'h0000_0000; x4_img <= 32'h0000_0000;
    x5_real <= 32'h0000_0000; x5_img <= 32'h0000_0000;
    x6_real <= 32'h0000_0000; x6_img <= 32'h0000_0000;
    x7_real <= 32'h0000_0000; x7_img <= 32'h0000_0000;
    #100;
  
    // testcase 2: all real > 0, img = 0
    // input:
    // x0 = 184.14      + j* 0.00      = 00B823D7       + j * 00000000
    // x1 = 111.57      + j* 0.00      = 006F91EB       + j * 00000000
    // x2 = 179.18      + j* 0.00      = 00B32E14       + j * 00000000
    // x3 = 15.58       + j* 0.00      = 000F947A       + j * 00000000
    // x4 = 124.03      + j* 0.00      = 007C07AE       + j * 00000000
    // x5 = 90.28       + j* 0.00      = 005A47AE       + j * 00000000
    // x6 = 141.97      + j* 0.00      = 008DF851       + j * 00000000
    // x7 = 127.48      + j* 0.00      = 007F7AE1       + j * 00000000
    // ouput:
    // y0 = 974.23      + j* 0.00      = 03CE3AE1       + j * 00000000
    // y1 = 154.29      + j* 26.86     = 009A4A20       + j * 001ADC66
    // y2 = -12.98      + j* -58.79    = FFF3051F       + j * FFC535C3
    // y3 = -34.07      + j* 101.28    = FFDDEE32       + j * 006547EC
    // y4 = 284.41      + j* 0.00      = 011C68F5       + j * 00000000
    // y5 = -34.07      + j* -101.28   = FFDDEE32       + j * FF9AB814
    // y6 = -12.98      + j* 58.79     = FFF3051F       + j * 003ACA3D
    // y7 = 154.29      + j* -26.86    = 009A4A20       + j * FFE5239A
    x0_real <= 32'h00B8_23D7; x0_img <= 32'h0000_0000;
    x1_real <= 32'h006F_91EB; x1_img <= 32'h0000_0000;
    x2_real <= 32'h00B3_2E14; x2_img <= 32'h0000_0000;
    x3_real <= 32'h000F_947A; x3_img <= 32'h0000_0000;
    x4_real <= 32'h007C_07AE; x4_img <= 32'h0000_0000;
    x5_real <= 32'h005A_47AE; x5_img <= 32'h0000_0000;
    x6_real <= 32'h008D_F851; x6_img <= 32'h0000_0000;
    x7_real <= 32'h007F_7AE1; x7_img <= 32'h0000_0000;
    #100;
    // testcase 3: all real = 0, all img > 0
    // input: 
    // x0 = 0.00        + j* 6.65      = 00000000       + j* 0006A666
    // x1 = 0.00        + j* 131.87    = 00000000       + j* 0083DEB8
    // x2 = 0.00        + j* 97.52     = 00000000       + j* 0061851E
    // x3 = 0.00        + j* 18.64     = 00000000       + j* 0012A3D7
    // x4 = 0.00        + j* 6.84      = 00000000       + j* 0006D70A
    // x5 = 0.00        + j* 84.05     = 00000000       + j* 00540CCC
    // x6 = 0.00        + j* 91.62     = 00000000       + j* 005B9EB8
    // x7 = 0.00        + j* 174.35    = 00000000       + j* 00AE5999
    // expected:
    // y0 = 0.00        + j* 611.54    = 00000000       + j* 02638A3D
    // y1 = -70.39      + j* 143.73    = FFB99C3A       + j* 008FBA39
    // y2 = 22.93       + j* -175.65   = 0016EE14       + j* FF50599A
    // y3 = -82.19      + j* -144.11   = FFADCF6D       + j* FF6FE47F
    // y4 = 0.00        + j* -206.28   = 00000000       + j* FF31B852
    // y5 = 82.19       + j* -144.11   = 00523093       + j* FF6FE47F
    // y6 = -22.93      + j* -175.65   = FFE911EC       + j* FF50599A
    // y7 = 70.39       + j* 143.73    = 004663C6       + j* 008FBA39
    x0_real <= 32'h0000_0000; x0_img <= 32'h0006_A666;
    x1_real <= 32'h0000_0000; x1_img <= 32'h0083_DEB8;
    x2_real <= 32'h0000_0000; x2_img <= 32'h0061_851E;
    x3_real <= 32'h0000_0000; x3_img <= 32'h0012_A3D7;
    x4_real <= 32'h0000_0000; x4_img <= 32'h0006_D70A;
    x5_real <= 32'h0000_0000; x5_img <= 32'h0054_0CCC;
    x6_real <= 32'h0000_0000; x6_img <= 32'h005B_9EB8;
    x7_real <= 32'h0000_0000; x7_img <= 32'h00AE_5999;
    #200;
    // testcase 4: all real <  0, all img = 0
    // input: 
    // x0 = -68.54      + j* 0.00      = FFBB75C3       + j* 00000000
    // x1 = -34.64      + j* 0.00      = FFDD5C29       + j* 00000000
    // x2 = -2.60       + j* 0.00      = FFFD6667       + j* 00000000
    // x3 = -188.31     + j* 0.00      = FF43B0A4       + j* 00000000
    // x4 = -13.31      + j* 0.00      = FFF2B0A4       + j* 00000000
    // x5 = -52.41      + j* 0.00      = FFCB970B       + j* 00000000
    // x6 = -183.49     + j* 0.00      = FF488290       + j* 00000000
    // x7 = -186.33     + j* 0.00      = FF45AB86       + j* 00000000
    // OUTPUT:
    // y0 = -729.63     + j* 0.00      = FD265EB9       + j* 00000000
    // y1 = -41.26      + j* -192.06   = FFD6BC41       + j* FF3FF1DE
    // y2 = 104.24      + j* -287.59   = 00683D70       + j* FEE068F6
    // y3 = -69.20      + j* 169.72    = FFBACDFD       + j* 00A9B98B
    // y4 = 193.75      + j* 0.00      = 00C1C000       + j* 00000000
    // y5 = -69.20      + j* -169.72   = FFBACDFD       + j* FF564675
    // y6 = 104.24      + j* 287.59    = 00683D70       + j* 011F970A
    // y7 = -41.26      + j* 192.06    = FFD6BC41       + j* 00C00E22
    x0_real <= 32'hFFBB_75C3; x0_img <= 32'h0000_0000;
    x1_real <= 32'hFFDD_5C29; x1_img <= 32'h0000_0000;
    x2_real <= 32'hFFFD_6667; x2_img <= 32'h0000_0000;
    x3_real <= 32'hFF43_B0A4; x3_img <= 32'h0000_0000;
    x4_real <= 32'hFFF2_B0A4; x4_img <= 32'h0000_0000;
    x5_real <= 32'hFFCB_970B; x5_img <= 32'h0000_0000;
    x6_real <= 32'hFF48_8290; x6_img <= 32'h0000_0000;
    x7_real <= 32'hFF45_AB86; x7_img <= 32'h0000_0000;
    #200;
    // testcase 5: all real = 0, all img  < 0
    // input: 
    // x0 = 0.00        + j* -40.90    = 00000000       + j* FFD7199A
    // x1 = 0.00        + j* -39.03    = 00000000       + j* FFD8F852
    // x2 = 0.00        + j* -178.09   = 00000000       + j* FF4DE8F6
    // x3 = 0.00        + j* -145.53   = 00000000       + j* FF6E7852
    // x4 = 0.00        + j* -123.45   = 00000000       + j* FF848CCD
    // x5 = 0.00        + j* -5.24     = 00000000       + j* FFFAC290
    // x6 = 0.00        + j* -2.27     = 00000000       + j* FFFDBAE2
    // x7 = 0.00        + j* -73.70    = 00000000       + j* FFB64CCD
    // expected:
    // y0 = 0.00        + j* -608.21   = 00000000       + j* FD9FCA3E
    // y1 = -250.50     + j* 109.45    = FF057ED2       + j* 006D72C6
    // y2 = 174.96      + j* 16.01     = 00AEF5C2       + j* 0010028F
    // y3 = 101.14      + j* 55.65     = 006522A8       + j* 0037A6D3
    // y4 = 0.00        + j* -81.21    = 00000000       + j* FFAECA3E
    // y5 = -101.14     + j* 55.65     = FF9ADD58       + j* 0037A6D3
    // y6 = -174.96     + j* 16.01     = FF510A3E       + j* 0010028F
    // y7 = 250.50      + j* 109.45    = 00FA812E       + j* 006D72C6
    x0_real <= 32'h0000_0000; x0_img <= 32'hFFD7_199A;
    x1_real <= 32'h0000_0000; x1_img <= 32'hFFD8_F852;
    x2_real <= 32'h0000_0000; x2_img <= 32'hFF4D_E8F6;
    x3_real <= 32'h0000_0000; x3_img <= 32'hFF6E_7852;
    x4_real <= 32'h0000_0000; x4_img <= 32'hFF84_8CCD;
    x5_real <= 32'h0000_0000; x5_img <= 32'hFFFA_C290;
    x6_real <= 32'h0000_0000; x6_img <= 32'hFFFD_BAE2;
    x7_real <= 32'h0000_0000; x7_img <= 32'hFFB6_4CCD;
    #200;
    // testcase 6: all real > 0, all img  > 0
    // input: 
    // x0 = 74.55       + j* 20.31     = 004A8CCC       + j* 00144F5C
    // x1 = 44.42       + j* 159.58    = 002C6B85       + j* 009F947A
    // x2 = 23.06       + j* 27.24     = 00170F5C       + j* 001B3D70
    // x3 = 144.36      + j* 80.09     = 00905C28       + j* 0050170A
    // x4 = 86.06       + j* 186.68    = 00560F5C       + j* 00BAAE14
    // x5 = 21.21       + j* 165.36    = 001535C2       + j* 00A55C28
    // x6 = 67.75       + j* 148.50    = 0043C000       + j* 00948000
    // x7 = 195.17      + j* 64.08     = 00C32B85       + j* 0040147A
    // expected:
    // y0 = 656.58      + j* 851.84    = 0290947A       + j* 0353D70A
    // y1 = -73.20      + j* -117.57   = FFB6CDC3       + j* FF8A6DA5
    // y2 = 250.57      + j* 305.15    = 00FA91EB       + j* 01312666
    // y3 = 64.64       + j* -176.14   = 0040A4C6       + j* FF4FDD30
    // y4 = -153.74     + j* -86.38    = FF664290       + j* FFA99EB9
    // y5 = -192.34     + j* -125.79   = FF3FA801       + j* FF823633
    // y6 = -110.97     + j* -242.65   = FF9107AF       + j* FF0D599A
    // y7 = 154.86      + j* -245.98   = 009ADB39       + j* FF0A0419
    x0_real <= 32'h004A_8CCC; x0_img <= 32'h0014_4F5C;
    x1_real <= 32'h002C_6B85; x1_img <= 32'h009F_947A;
    x2_real <= 32'h0017_0F5C; x2_img <= 32'h001B_3D70;
    x3_real <= 32'h0090_5C28; x3_img <= 32'h0050_170A;
    x4_real <= 32'h0056_0F5C; x4_img <= 32'h00BA_AE14;
    x5_real <= 32'h0015_35C2; x5_img <= 32'h00A5_5C28;
    x6_real <= 32'h0043_C000; x6_img <= 32'h0094_8000;
    x7_real <= 32'h00C3_2B85; x7_img <= 32'h0040_147A;
    #200;
    // testcase 7: all real > 0, all img  < 0
    // input: 
    // x0 = 55.33       + j* -69.15    = 0037547A       + j* FFBAD99A
    // x1 = 55.77       + j* -13.13    = 0037C51E       + j* FFF2DEB9
    // x2 = 26.93       + j* -4.85     = 001AEE14       + j* FFFB2667
    // x3 = 136.97      + j* -169.64   = 0088F851       + j* FF565C29
    // x4 = 168.85      + j* -155.21   = 00A8D999       + j* FF64CA3E
    // x5 = 39.72       + j* -15.09    = 0027B851       + j* FFF0E8F6
    // x6 = 133.73      + j* -111.18   = 0085BAE1       + j* FF90D1EC
    // x7 = 108.91      + j* -42.07    = 006CE8F5       + j* FFD5EE15
    // expected:
    // y0 = 726.21      + j* -580.32   = 02D635C2       + j* FDBBAE15
    // y1 = -104.50     + j* 253.26    = FF977F7B       + j* 00FD42D4
    // y2 = 247.01      + j* 42.06     = 00F7028F       + j* 002A0F5C
    // y3 = -300.18     + j* -143.52   = FED3D29B       + j* FF707A5D
    // y4 = 43.47       + j* -100.46   = 002B7851       + j* FF9B8A3E
    // y5 = 90.12       + j* 132.46    = 005A1F3D       + j* 0084757D
    // y6 = -119.97     + j* -258.72   = FF8807AF       + j* FEFD47AF
    // y7 = -139.52     + j* 102.04    = FF747A33       + j* 00660AC1
    x0_real <= 32'h0037_547A; x0_img <= 32'hFFBA_D99A;
    x1_real <= 32'h0037_C51E; x1_img <= 32'hFFF2_DEB9;
    x2_real <= 32'h001A_EE14; x2_img <= 32'hFFFB_2667;
    x3_real <= 32'h0088_F851; x3_img <= 32'hFF56_5C29;
    x4_real <= 32'h00A8_D999; x4_img <= 32'hFF64_CA3E;
    x5_real <= 32'h0027_B851; x5_img <= 32'hFFF0_E8F6;
    x6_real <= 32'h0085_BAE1; x6_img <= 32'hFF90_D1EC;
    x7_real <= 32'h006C_E8F5; x7_img <= 32'hFFD5_EE15;
    #200
    // testcase 8: all real < 0, all img  > 0
    // input: 
    // x0 = -54.84      + j* 149.66    = FFC928F6       + j* 0095A8F5
    // x1 = -35.43      + j* 6.74      = FFDC91EC       + j* 0006BD70
    // x2 = -163.47     + j* 68.12     = FF5C87AF       + j* 00441EB8
    // x3 = -122.08     + j* 188.66    = FF85EB86       + j* 00BCA8F5
    // x4 = -113.03     + j* 93.45     = FF8EF852       + j* 005D7333
    // x5 = -140.37     + j* 167.88    = FF73A148       + j* 00A7E147
    // x6 = -13.59      + j* 166.23    = FFF268F6       + j* 00A63AE1
    // x7 = -53.27      + j* 5.11      = FFCABAE2       + j* 00051C28
    // expected:
    // y0 = -696.08     + j* 845.85    = FD47EB86       + j* 034DD999
    // y1 = 98.79       + j* -63.19    = 0062C93B       + j* FFC0CF42
    // y2 = -9.96       + j* 9.21      = FFF60A3E       + j* 000935C2
    // y3 = 49.29       + j* 124.51    = 00314955       + j* 007C83CE
    // y4 = 6.22        + j* 109.07    = 00063851       + j* 006D11EB
    // y5 = -178.63     + j* 475.37    = FF4D5FBB       + j* 01DB5ED2
    // y6 = 28.34       + j* 8.31      = 001C570A       + j* 00084F5C
    // y7 = 263.31      + j* -311.85   = 01075044       + j* FEC82528
    x0_real <= 32'hFFC9_28F6; x0_img <= 32'h0095_A8F5;
    x1_real <= 32'hFFDC_91EC; x1_img <= 32'h0006_BD70;
    x2_real <= 32'hFF5C_87AF; x2_img <= 32'h0044_1EB8;
    x3_real <= 32'hFF85_EB86; x3_img <= 32'h00BC_A8F5;
    x4_real <= 32'hFF8E_F852; x4_img <= 32'h005D_7333;
    x5_real <= 32'hFF73_A148; x5_img <= 32'h00A7_E147;
    x6_real <= 32'hFFF2_68F6; x6_img <= 32'h00A6_3AE1;
    x7_real <= 32'hFFCA_BAE2; x7_img <= 32'h0005_1C28;
    #200
    // testcase 9: all real < 0,  all img < 0
    // input: 
    // x0 = -134.65     + j* -173.74   = FF79599A       + j* FF524290
    // x1 = -77.83      + j* -20.89    = FFB22B86       + j* FFEB1C29
    // x2 = -83.76      + j* -11.15    = FFAC3D71       + j* FFF4D99A
    // x3 = -139.61     + j* -79.30    = FF7463D8       + j* FFB0B334
    // x4 = -180.87     + j* -60.10    = FF4B2148       + j* FFC3E667
    // x5 = -195.63     + j* -73.04    = FF3C5EB9       + j* FFB6F5C3
    // x6 = -19.61      + j* -125.57   = FFEC63D8       + j* FF826E15
    // x7 = -132.00     + j* -14.95    = FF7C0000       + j* FFF10CCD
    // expected:
    // y0 = -963.96     + j* -558.74   = FC3C0A3E       + j* FDD14290
    // y1 = 240.69      + j* -45.03    = 00F0B109       + j* FFD2F8CB
    // y2 = -211.83     + j* -95.27    = FF2C2B86       + j* FFA0BAE2
    // y3 = -165.50     + j* -338.08   = FF5A7EBB       + j* FEADEA7D
    // y4 = 126.18      + j* -182.38   = 007E2E14       + j* FF499EB9
    // y5 = 80.59       + j* -53.95    = 005096A4       + j* FFCA0C54
    // y6 = -212.47     + j* -98.97    = FF2B87AF       + j* FF9D07AF
    // y7 = 29.10       + j* -17.50    = 001D1ADE       + j* FFEE8109
    x0_real <= 32'hFF79_599A; x0_img <= 32'hFF52_4290;
    x1_real <= 32'hFFB2_2B86; x1_img <= 32'hFFEB_1C29;
    x2_real <= 32'hFFAC_3D71; x2_img <= 32'hFFF4_D99A;
    x3_real <= 32'hFF74_63D8; x3_img <= 32'hFFB0_B334;
    x4_real <= 32'hFF4B_2148; x4_img <= 32'hFFC3_E667;
    x5_real <= 32'hFF3C_5EB9; x5_img <= 32'hFFB6_F5C3;
    x6_real <= 32'hFFEC_63D8; x6_img <= 32'hFF82_6E15;
    x7_real <= 32'hFF7C_0000; x7_img <= 32'hFFF1_0CCD;
    #200;
    // testcase 10: general 
    // input: 
    // x0 = 47.23       + j* -104.07   = 002F3AE1       + j* FF97EE15
    // x1 = 185.66      + j* 163.59    = 00B9A8F5       + j* 00A3970A
    // x2 = -192.09     + j* -32.27    = FF3FE8F6       + j* FFDFBAE2
    // x3 = -81.88      + j* -99.09    = FFAE1EB9       + j* FF9CE8F6
    // x4 = -174.45     + j* 40.10     = FF518CCD       + j* 00281999
    // x5 = -175.04     + j* -184.48   = FF50F5C3       + j* FF47851F
    // x6 = 35.76       + j* -156.15   = 0023C28F       + j* FF63D99A
    // x7 = -131.21     + j* 55.88     = FF7CCA3E       + j* 0037E147
    // expected:
    // y0 = -486.02     + j* -316.49   = FE19FAE2       + j* FEC38290
    // y1 = 702.27      + j* 149.45    = 02BE462F       + j* 009572B0
    // y2 = 51.43       + j* -99.26    = 00336E14       + j* FF9CBD71
    // y3 = 14.17       + j* -1017.66  = 000E2BA4       + j* FC06578F
    // y4 = -81.08      + j* -188.29   = FFAEEB86       + j* FF43B5C3
    // y5 = -11.15      + j* 17.91     = FFF4D88A       + j* 0011E978
    // y6 = 6.79        + j* 348.16    = 0006CA3D       + j* 015C28F5
    // y7 = 181.43      + j* 273.62    = 00B56DF4       + j* 01119E34
    x0_real <= 32'h002F_3AE1; x0_img <= 32'hFF97_EE15;
    x1_real <= 32'h00B9_A8F5; x1_img <= 32'h00A3_970A;
    x2_real <= 32'hFF3F_E8F6; x2_img <= 32'hFFDF_BAE2;
    x3_real <= 32'hFFAE_1EB9; x3_img <= 32'hFF9C_E8F6;
    x4_real <= 32'hFF51_8CCD; x4_img <= 32'h0028_1999;
    x5_real <= 32'hFF50_F5C3; x5_img <= 32'hFF47_851F;
    x6_real <= 32'h0023_C28F; x6_img <= 32'hFF63_D99A;
    x7_real <= 32'hFF7C_CA3E; x7_img <= 32'h0037_E147;
    #200;
    // testcase 10: general 
    // input:
    // x0 = 117.25      + j* 185.34    = 00754000       + j* 00B9570A
    // x1 = 103.19      + j* -86.87    = 006730A3       + j* FFA92148
    // x2 = -114.02     + j* -63.04    = FF8DFAE2       + j* FFC0F5C3
    // x3 = 161.47      + j* 45.54     = 00A17851       + j* 002D8A3D
    // x4 = -161.28     + j* 125.79    = FF5EB852       + j* 007DCA3D
    // x5 = -196.94     + j* -75.98    = FF3B0F5D       + j* FFB4051F
    // x6 = 141.39      + j* 187.21    = 008D63D7       + j* 00BB35C2
    // x7 = -14.90      + j* -5.04     = FFF1199A       + j* FFFAF5C3
    // expected:
    // y0 = 36.16       + j* 312.95    = 002428F5       + j* 0138F333
    // y1 = 143.86      + j* -65.44    = 008FDB4A       + j* FFBE8ECA
    // y2 = -274.75     + j* 427.28    = FEED4000       + j* 01AB47AE
    // y3 = 469.33      + j* -489.33   = 01D55562       + j* FE16AB63
    // y4 = -69.48      + j* 557.65    = FFBA851F       + j* 022DA666
    // y5 = -87.30      + j* 695.36    = FFA8B412       + j* 02B75CBB
    // y6 = 131.95      + j* -53.36    = 0083F333       + j* FFCAA3D8
    // y7 = 588.23      + j* 97.61     = 024C39F9       + j* 00619C4B

    x0_real <= 32'h0075_4000; x0_img <= 32'h00B9_570A;
    x1_real <= 32'h0067_30A3; x1_img <= 32'hFFA9_2148;
    x2_real <= 32'hFF8D_FAE2; x2_img <= 32'hFFC0_F5C3;
    x3_real <= 32'h00A1_7851; x3_img <= 32'h002D_8A3D;
    x4_real <= 32'hFF5E_B852; x4_img <= 32'h007D_CA3D;
    x5_real <= 32'hFF3B_0F5D; x5_img <= 32'hFFB4_051F;
    x6_real <= 32'h008D_63D7; x6_img <= 32'h00BB_35C2;
    x7_real <= 32'hFFF1_199A; x7_img <= 32'hFFFA_F5C3;
    #200;



    $finish;
end
    
endmodule