`timescale 1ns/1ns

module butterfly_radix2_tb;
parameter WIDTH = 32;
parameter Q_LENGTH =16;

// A0[k] (complex)
reg signed  [WIDTH-1 : 0] di_img0;
reg signed  [WIDTH-1 : 0] di_real0; 
// A1[k] (complex)
reg signed  [WIDTH-1 : 0] di_real1;
reg signed  [WIDTH-1 : 0] di_img1;
// twiddle factor vector (W_N)^k (complex)
reg signed  [WIDTH-1 : 0] W_N_real;
reg signed  [WIDTH-1 : 0] W_N_img;

//output
// X[k] = A0[k] + (W_N)^k*A1[k] (complex)
wire signed [WIDTH-1 : 0] do_real0;
wire  signed [WIDTH-1 : 0] do_img0;
// X[k + N/2] = A0[k] - (W_N)^k*A1[k] (complex)
wire  signed [WIDTH-1 : 0] do_real1;
wire  signed [WIDTH-1 : 0] do_img1;


initial begin
    $dumpfile("butterfly_radix2_tb.vcd");
    $dumpvars(0, butterfly_radix2_tb);
end

initial begin
    $display("---------------------------------Testing butterlfy module-----------------------");
    $monitor("Time =%0t \n input0 = %h + %h *i \n input1 = %h + %h *i \n w = %h + %h *i \n output1 = %h + %h *i \n output2 =  %h + %h *i \n",
        $time, 
        di_real0, di_img0,
        di_real1, di_img1,
        W_N_real, W_N_img,
        do_real0, do_img0,
        do_real1, do_img1
    );
end



initial begin

end


endmodule