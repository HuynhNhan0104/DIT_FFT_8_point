# DIT FFT 8 point

## Description
This project implements the Fast Fourier Transform (FFT) using the Decimation-In-Time (DIT) method for an 8-point FFT, developed in Verilog. The goal is to demonstrate how to implement the FFT algorithm in digital hardware, providing a learning for digital signal processing.
## Objectives
- Demonstrate FFT Algorithm: Illustrate the computation of FFT through data decomposition and butterfly operations.
- Educational Reference: Serve as a guide for those learning digital circuit design and Verilog programming.
## Fast Fourier Tranform algorithms
you can view this algorithms at [this link](https://builtin.com/articles/fast-fourier-transform)
![Ideal for O(NlogN) algorithms](https://www.dspguide.com/graphics/F_12_2.gif)
### Fixed point Number
In this project, We use input and output in fixed point format QM.N (ex Q16.16) which is popular in embedded system.
you can view more at [this link](https://www.sciencedirect.com/topics/computer-science/fixed-point-number)
![fixed point](https://media.geeksforgeeks.org/wp-content/uploads/20220728214912/geeksforgeeksfixedpointrepresentation1.png)
### Butterfly Operation
![Butterfly Operation](https://upload.wikimedia.org/wikipedia/commons/9/98/Butterfly-FFT.png)

### Butterfly Diagram
![Butterfly Diagram](https://d2vlcm61l7u1fs.cloudfront.net/media%2F704%2F704f9f19-f105-4279-b9f0-ae291e459aed%2FphpIhqzNj.png)
### Order of input
![rearrange order of input](https://www.dspguide.com/graphics/F_12_3.gif)
## Directory Structure
```
DIT_FFT_8_point
├── README.md
├── source
│   ├── butterfly_radix2.v
│   ├── fft_8p.v
│   └── multiplier_complex.v
├── test
│   ├── FFT_test.py
│   ├── convert_fixed_point.py
│   └── random_generate_test.py
└── testbench
    ├── butterfly_radix2_tb.v
    ├── fft_8p_tb.v
    └── multiplier_complex_tb.v
```
* source: verilog file of all module
* test: python files which are used to test and generate testcase and result of FFT
* testbench: verilog file of all testbench module 
## Testing
This project use Iverilog to complie an using GTKWay to simulation.
You should note that the output values from the Python code are not exactly the same as those from the Verilog simulation; there may be slight discrepancies since Python represents decimal numbers more accurately.
* To compile testbench module use:
``` bash
    iverilog -o fft_8p_tb.vvp testbench/fft_8p_tb.v source/fft_8p.v  source/butterfly_radix2.v source/multiplier_complex.v
```

* To run testbench for simulation 
``` bash
    vvp fft_8p_tb.vvp
```
* Use FFT_test.py to see testcase and result of its.
``` bash
    python FFT_test.py
```

* To Generate random testcase
``` bash
    python random_generate_test.py
```
## GTKWay
![GTKway](https://github.com/user-attachments/assets/141a73fb-5ee2-413a-b71e-9fd923b1e620)

