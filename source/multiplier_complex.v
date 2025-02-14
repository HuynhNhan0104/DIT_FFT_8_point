// +HC -------------------------------------------------
// File: .v
// Module: butterfly_radix2
// Function: module of butterfly radix2 operataion
// ------------------------------------------------------
// keywords: butterlfy
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

module multiplier_complex (
    di_real0, di_img0,
    di_real1, di_img1,
    do_real, do_img
);
// parameter
parameter WIDTH = 32;
parameter Q_LENGTH = 16;

// input
// all value in fixed point format Q(WIDTH/2).(WIDTH/2)
input signed  [WIDTH-1 : 0] di_real0; 
input signed  [WIDTH-1 : 0] di_img0;
input signed  [WIDTH-1 : 0] di_real1;
input signed  [WIDTH-1 : 0] di_img1;
//output
output signed [WIDTH-1 : 0] do_real;
output signed [WIDTH-1 : 0] do_img;
//internal port;
wire signed [2*WIDTH-1 : 0] r0r1, i0i1, r0i1, r1i0, temp_real, temp_img;
// wire signed [WIDTH-1 : 0] scale_r0r1, scale_i0i1, scale_r0i1, scale_r1i0;


assign r0r1 = di_real0*di_real1;
assign i0i1 = di_img0*di_img1;
assign r0i1 = di_real0*di_img1; 
assign r1i0 = di_real1*di_img0;


// r*i* is in range [2^(2*(WIDTH-1)) : 0], 
// so we need scale it to [2^(WIDTH-1) : 0] by divide itself to 2^(width-1)
// or shift right (width - 1) bit
// assign sacle_r0r1 = r0r1 >>> (WIDTH-1)/2;
// assign sacle_i0i1 = i0i1 >>> (WIDTH-1);
// assign sacle_r0i1 = r0i1 >>> (WIDTH-1);
// assign sacle_r1i0 = r1i0 >>> (WIDTH-1);


assign temp_real = r0r1 - i0i1;
assign temp_img  = r0i1 + r1i0;

assign do_real = temp_real >>> (Q_LENGTH);
assign do_img = temp_img >>> (Q_LENGTH);

endmodule