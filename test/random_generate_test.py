import numpy as np
import time
from convert_fixed_point import *



def print_testcase(complex_numbers, char = "x",width = 8):
    for i, num in enumerate(complex_numbers):
        print(f"{char}{i} = {num.real:.2f}\t + j* {num.imag:.2f}",end="\t")
        print(f"= {float_to_fixed_point_hex(num.real):0{width}X}\t + j* {float_to_fixed_point_hex(num.imag):0{width}X}")

def test():
    # Dùng thời gian hiện tại làm seed
    complex_numbers = generate_testcase(-200,200,-200, 200,8)
    print_testcase(complex_numbers)

    
        
def generate_testcase(start_real = -100,end_real = 100, start_imag = -100, end_imag = 100, num = 8):
    current_time = int(time.time())
    np.random.seed(current_time)
    # Sinh 8 số phức
    complex_numbers = np.random.uniform(start_real, end_real, 8) + 1j * np.random.uniform(start_imag,end_imag, num)
    return complex_numbers


if __name__ == "__main__":
    test()
    