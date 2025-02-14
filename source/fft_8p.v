// +HC -------------------------------------------------
// File: .v
// Module: fft_8p.v
// Function: module of fastfourier transform
// ------------------------------------------------------
// keywords: FFT, fast fourier transform
// ------------------------------------------------------
// Remarks:
// ------------------------------------------------------
// History: Version, Date, Author, Description
// v1.0, 05.FEB.2025, Nhan Huynh, new release
//
// 
////////////////////////////////////////////////////////////////////////////
// header
///////////////////////////////////////////////////////////////////////////

module fft_8p (
    clk, reset,
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
    y7_real, y7_img,
);

// parameters
parameter WIDTH = 32;
parameter Q_LENGTH = 16;
// twiddle factor
// / W0 = 1 + j0
parameter signed [31:0] W0_REAL = 32'h00010000;  // 1.000000
parameter signed [31:0] W0_IMG  = 32'h00000000;  // 0.000000

// W1 = 0.707 - j0.707 
parameter signed [31:0] W1_REAL = 32'h0000B504;  // 0.707107
parameter signed [31:0] W1_IMG  = 32'hFFFF4AFC;  // -0.707107

// W2 = 0 - j1
parameter signed [31:0] W2_REAL = 32'h00000000;  // 0.000000 
parameter signed [31:0] W2_IMG  = 32'hFFFF0000;  // -1.000000

// W3 = -0.707 - j0.707
parameter signed [31:0] W3_REAL = 32'hFFFF4AFC;  // -0.707107
parameter signed [31:0] W3_IMG  = 32'hFFFF4AFC;  // -0.707107


// port
// input
input clk, reset;

input signed [WIDTH-1 : 0] x0_real , x0_img;
input signed [WIDTH-1 : 0] x1_real , x1_img;
input signed [WIDTH-1 : 0] x2_real , x2_img;
input signed [WIDTH-1 : 0] x3_real , x3_img;
input signed [WIDTH-1 : 0] x4_real , x4_img;
input signed [WIDTH-1 : 0] x5_real , x5_img;
input signed [WIDTH-1 : 0] x6_real , x6_img;
input signed [WIDTH-1 : 0] x7_real , x7_img;

// output
output reg signed [WIDTH-1 : 0] y0_real , y0_img;
output reg signed [WIDTH-1 : 0] y1_real , y1_img;
output reg signed [WIDTH-1 : 0] y2_real , y2_img;
output reg signed [WIDTH-1 : 0] y3_real , y3_img;
output reg signed [WIDTH-1 : 0] y4_real , y4_img;
output reg signed [WIDTH-1 : 0] y5_real , y5_img;
output reg signed [WIDTH-1 : 0] y6_real , y6_img;
output reg signed [WIDTH-1 : 0] y7_real , y7_img;


// internal wire


// output of stage1 is store in order i, i+1 with i is index of 4 pair of input;
wire signed [WIDTH-1 : 0] stage1_real [7 : 0];
wire signed [WIDTH-1 : 0] stage1_img  [7 : 0];
wire signed [WIDTH-1 : 0] stage2_real [7 : 0];
wire signed [WIDTH-1 : 0] stage2_img  [7 : 0];
wire signed [WIDTH-1 : 0] stage3_real [7 : 0];
wire signed [WIDTH-1 : 0] stage3_img  [7 : 0];


// stage 1: result of butterfly operation for (x0, x4), (x1 ,x5), (x2 ,x6),(x3 ,x7)
// name of butterfly module R<stage index><index of mudule>_<input_index1><input_index2>_<output_index1><output_index2>
// index is start from 0 in the schematic of fft 8 point from top to bottom in a stage
// example for name: first butterfly module in stage 1, input is x0 and x4, output is 0 and 1 -> R11_04_01
// example for name: first butterfly module in stage 2, input is output of stage 1 at index 0 and 2, output is 0 and 2 -> R12_02_02
butterfly_radix2 #(.WIDTH(WIDTH) , .Q_LENGTH(Q_LENGTH)) R10_04_01(
    .di_real0 (x0_real), .di_img0 (x0_img),
    .di_real1 (x4_real), .di_img1 (x4_img),
    .W_N_real (W0_REAL), .W_N_img (W0_IMG),
    .do_real0 (stage1_real[0]), .do_img0 (stage1_img[0]),
    .do_real1 (stage1_real[1]), .do_img1 (stage1_img[1])
);

// R2_15-(x1 ,x5)
butterfly_radix2 #(.WIDTH(WIDTH) , .Q_LENGTH(Q_LENGTH)) R11_26_23(
    .di_real0 (x2_real), .di_img0 (x2_img),
    .di_real1 (x6_real), .di_img1 (x6_img),
    .W_N_real (W0_REAL), .W_N_img (W0_IMG),
    .do_real0 (stage1_real[2]), .do_img0 (stage1_img[2]),
    .do_real1 (stage1_real[3]), .do_img1 (stage1_img[3])
);

// R3_26-(x2 ,x6)
butterfly_radix2 #(.WIDTH(WIDTH) , .Q_LENGTH(Q_LENGTH)) R12_15_45(
    .di_real0 (x1_real), .di_img0 (x1_img),
    .di_real1 (x5_real), .di_img1 (x5_img),
    .W_N_real (W0_REAL), .W_N_img (W0_IMG),
    .do_real0 (stage1_real[4]), .do_img0 (stage1_img[4]),
    .do_real1 (stage1_real[5]), .do_img1 (stage1_img[5])
);

// R4_37-(x3 ,x7)

butterfly_radix2 #(.WIDTH(WIDTH) , .Q_LENGTH(Q_LENGTH)) R13_37_67(
    .di_real0 (x3_real), .di_img0 (x3_img),
    .di_real1 (x7_real), .di_img1 (x7_img),
    .W_N_real (W0_REAL), .W_N_img (W0_IMG),
    .do_real0 (stage1_real[6]), .do_img0 (stage1_img[6]),
    .do_real1 (stage1_real[7]), .do_img1 (stage1_img[7])
);

// stage 2: result of butterfly operation
//input: output of stage 1 at index 0 and 2, twiddle factor is W0
butterfly_radix2 #(.WIDTH(WIDTH) , .Q_LENGTH(Q_LENGTH)) R20_02_02(
    .di_real0 (stage1_real[0]), .di_img0 (stage1_img[0]),
    .di_real1 (stage1_real[2]), .di_img1 (stage1_img[2]),
    .W_N_real (W0_REAL), .W_N_img (W0_IMG),
    .do_real0 (stage2_real[0]), .do_img0 (stage2_img[0]),
    .do_real1 (stage2_real[2]), .do_img1 (stage2_img[2])
);

butterfly_radix2 #(.WIDTH(WIDTH) , .Q_LENGTH(Q_LENGTH)) R21_13_13(
    .di_real0 (stage1_real[1]), .di_img0 (stage1_img[1]),
    .di_real1 (stage1_real[3]), .di_img1 (stage1_img[3]),
    .W_N_real (W2_REAL), .W_N_img (W2_IMG),
    .do_real0 (stage2_real[1]), .do_img0 (stage2_img[1]),
    .do_real1 (stage2_real[3]), .do_img1 (stage2_img[3])
);

butterfly_radix2 #(.WIDTH(WIDTH) , .Q_LENGTH(Q_LENGTH)) R22_46_46(
    .di_real0 (stage1_real[4]), .di_img0 (stage1_img[4]),
    .di_real1 (stage1_real[6]), .di_img1 (stage1_img[6]),
    .W_N_real (W0_REAL), .W_N_img (W0_IMG),
    .do_real0 (stage2_real[4]), .do_img0 (stage2_img[4]),
    .do_real1 (stage2_real[6]), .do_img1 (stage2_img[6])
);


butterfly_radix2 #(.WIDTH(WIDTH) , .Q_LENGTH(Q_LENGTH)) R23_57_57(
    .di_real0 (stage1_real[5]), .di_img0 (stage1_img[5]),
    .di_real1 (stage1_real[7]), .di_img1 (stage1_img[7]),
    .W_N_real (W2_REAL), .W_N_img (W2_IMG),
    .do_real0 (stage2_real[5]), .do_img0 (stage2_img[5]),
    .do_real1 (stage2_real[7]), .do_img1 (stage2_img[7])
);



// stage3

butterfly_radix2 #(.WIDTH(WIDTH) , .Q_LENGTH(Q_LENGTH)) R30_04_04(
    .di_real0 (stage2_real[0]), .di_img0 (stage2_img[0]),
    .di_real1 (stage2_real[4]), .di_img1 (stage2_img[4]),
    .W_N_real (W0_REAL), .W_N_img (W0_IMG),
    .do_real0 (stage3_real[0]), .do_img0 (stage3_img[0]),
    .do_real1 (stage3_real[4]), .do_img1 (stage3_img[4])
);

butterfly_radix2 #(.WIDTH(WIDTH) , .Q_LENGTH(Q_LENGTH)) R31_15_15(
    .di_real0 (stage2_real[1]), .di_img0 (stage2_img[1]),
    .di_real1 (stage2_real[5]), .di_img1 (stage2_img[5]),
    .W_N_real (W1_REAL), .W_N_img (W1_IMG),
    .do_real0 (stage3_real[1]), .do_img0 (stage3_img[1]),
    .do_real1 (stage3_real[5]), .do_img1 (stage3_img[5])
);

butterfly_radix2 #(.WIDTH(WIDTH) , .Q_LENGTH(Q_LENGTH)) R32_26_26(
    .di_real0 (stage2_real[2]), .di_img0 (stage2_img[2]),
    .di_real1 (stage2_real[6]), .di_img1 (stage2_img[6]),
    .W_N_real (W2_REAL), .W_N_img (W2_IMG),
    .do_real0 (stage3_real[2]), .do_img0 (stage3_img[2]),
    .do_real1 (stage3_real[6]), .do_img1 (stage3_img[6])
);
butterfly_radix2 #(.WIDTH(WIDTH) , .Q_LENGTH(Q_LENGTH)) R33_37_37(
    .di_real0 (stage2_real[3]), .di_img0 (stage2_img[3]),
    .di_real1 (stage2_real[7]), .di_img1 (stage2_img[7]),
    .W_N_real (W3_REAL), .W_N_img (W3_IMG),
    .do_real0 (stage3_real[3]), .do_img0 (stage3_img[3]),
    .do_real1 (stage3_real[7]), .do_img1 (stage3_img[7])
);


always @(posedge clk) begin
    if(reset) begin
        y0_real <= 32'd0 ; y0_img <= 32'd0;
        y1_real <= 32'd0 ; y1_img <= 32'd0;
        y2_real <= 32'd0 ; y2_img <= 32'd0;
        y3_real <= 32'd0 ; y3_img <= 32'd0;
        y4_real <= 32'd0 ; y4_img <= 32'd0;
        y5_real <= 32'd0 ; y5_img <= 32'd0;
        y6_real <= 32'd0 ; y6_img <= 32'd0;
        y7_real <= 32'd0 ; y7_img <= 32'd0;
    end
    else begin
        y0_real <= stage3_real[0]; y0_img <= stage3_img[0];
        y1_real <= stage3_real[1]; y1_img <= stage3_img[1];
        y2_real <= stage3_real[2]; y2_img <= stage3_img[2];
        y3_real <= stage3_real[3]; y3_img <= stage3_img[3];
        y4_real <= stage3_real[4]; y4_img <= stage3_img[4];
        y5_real <= stage3_real[5]; y5_img <= stage3_img[5];
        y6_real <= stage3_real[6]; y6_img <= stage3_img[6];
        y7_real <= stage3_real[7]; y7_img <= stage3_img[7];
    end
end

endmodule