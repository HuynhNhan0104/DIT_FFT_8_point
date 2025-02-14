# DIT FFT 8 point

## Description
This project implements the Fast Fourier Transform (FFT) using the Decimation-In-Time (DIT) method for an 8-point FFT, developed in Verilog. The goal is to demonstrate how to implement the FFT algorithm in digital hardware, providing a learning for digital signal processing.
## Objectives
- Demonstrate FFT Algorithm: Illustrate the computation of FFT through data decomposition and butterfly operations.
- Educational Reference: Serve as a guide for those learning digital circuit design and Verilog programming.
## Fast Fourier Tranform algorithms

1. Butterfly Operation

2. Butterfly Diagram

## Directory Structure
.
├── README.md
├── src
│   ├── butterfly_radix2.v
│   ├── multiplier_complex.v
│   └── fft_8p.v
├── test
│   ├── convert_fixed_point.py
│   ├── helper.py
│   └── module
└── testbench
    ├── butterfly_radix2_tb.v
    ├── multiplier_complex_tb.v
    └── fft_8p_tb.v

* source: verilog file of all module
* test: python files which are used to test and generate testcase and result of FFT
* testbench: verilog file of all testbench module 
## How to Use