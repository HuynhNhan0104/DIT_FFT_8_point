`timescale 1ns/1ns

module multiplier_complex_tb;
localparam WIDTH = 32;
reg signed [WIDTH -1 :0] di_real0, di_img0, di_real1, di_img1;
wire signed [WIDTH - 1:0] do_real, do_img;

multiplier_complex #(.WIDTH(WIDTH))  uut (
    .di_real0(di_real0),
    .di_img0(di_img0),
    .di_real1(di_real1),
    .di_img1(di_img1),
    .do_real(do_real),
    .do_img(do_img)
);


initial begin
    $dumpfile("multiplier_complex_tb.vcd");
    $dumpvars(0, multiplier_complex_tb);
end


initial begin
    $display("testing multiplier complex module");
    $monitor("time = %0t\ndata0= %h + i*%h,\n data1= %h + i*%h \n out= %h + i*%h", $time,di_real0, di_img0, di_real1, di_img1,do_real, do_img);
end


initial begin
    // input : 
    di_real0    = 32'h0001_0000;
    di_img0     = 32'h0001_0000;
    di_real1    = 32'h0002_0000;
    di_img1     = 32'h0002_0000;
    #100;
    di_real0    = 32'h0010_0000;
    di_img0     = 32'h0000_0000;
    di_real1    = 32'h0020_0000;
    di_img1     = 32'h0000_0000;
    #100;
    di_real0    = 32'h0001_0000;
    di_img0     = 32'h0002_0000;
    di_real1    = 32'h0003_0000;
    di_img1     = 32'h0004_0000;
    #100;
    $finish;
end
    
endmodule