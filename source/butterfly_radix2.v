// +HC -------------------------------------------------
// File: butterfly_radix2.v
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

module butterfly_radix2 (
    di_real0, di_img0, 
    di_real1, di_img1, 
    W_N_real, W_N_img, 
    do_real0, do_img0, 
    do_real1, do_img1
);


// parameters
parameter WIDTH = 32; // bit width of input and output
parameter Q_LENGTH = 16;
// port
// input

// A0[k] (complex)
input signed  [WIDTH-1 : 0] di_real0; 
input signed  [WIDTH-1 : 0] di_img0;
// A1[k] (complex)
input signed  [WIDTH-1 : 0] di_real1;
input signed  [WIDTH-1 : 0] di_img1;
// twiddle factor vector (W_N)^k (complex)
input signed  [WIDTH-1 : 0] W_N_real;
input signed  [WIDTH-1 : 0] W_N_img;

//output
// X[k] = A0[k] + (W_N)^k*A1[k] (complex)
output wire signed [WIDTH-1 : 0] do_real0;
output wire  signed [WIDTH-1 : 0] do_img0;
// X[k + N/2] = A0[k] - (W_N)^k*A1[k] (complex)
output wire  signed [WIDTH-1 : 0] do_real1;
output wire  signed [WIDTH-1 : 0] do_img1;
// internal signals
// (W_N)^k*A1[k]
wire [WIDTH-1 : 0] w_A1_real;
wire [WIDTH-1 : 0] w_A1_img;


// start logic description


multiplier_complex #(.WIDTH(WIDTH),.Q_LENGTH(Q_LENGTH)) X_k(
    .di_real0(di_real1),
    .di_img0(di_img1),
    .di_real1(W_N_real),
    .di_img1(W_N_img),
    .do_real(w_A1_real),
    .do_img(w_A1_img)
);


assign  do_real0 = di_real0 + w_A1_real; 
assign  do_img0  = di_img0  + w_A1_img;
assign  do_real1 = di_real0 - w_A1_real; 
assign  do_img1  = di_img0  - w_A1_img;

    
endmodule