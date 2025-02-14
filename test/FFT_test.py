import numpy as np
from convert_fixed_point import *
from random_generate_test import *

def FFT(xn):
    n = len(xn)
    
    if n == 1: 
        return xn
    elif n%2 != 0: 
        raise ValueError("Lengt of signal is invalid")
    
    
    w = np.exp((-2*np.pi*1j)/n)
    y = np.zeros(n, dtype=np.complex128)
    x0 = xn[::2]
    x1 = xn[1::2]
    y0,y1 = FFT(x0), FFT(x1)
    for k in range(n//2):
        y[k] = y0[k] + (w**k)*y1[k]
        y[k + n//2] = y0[k] - (w**k)*y1[k]
        
    return y

def test_fft_function(testcase,target):
    # Duyệt qua từng test case
    for name, case in testcase:
        # Kết quả chuẩn sử dụng numpy.fft.fft
        expected = np.fft.fft(case)
        # Kết quả từ hàm FFT của bạn
        result = target(case)
        
        # So sánh với sai số nhỏ cho phép
        print(f"{name}") 
        if np.allclose(result, expected):
            print("result: passed!")    
        else:
            print("result: failed.")
            print("Input:", case)
            print("Expected:", expected)
            print("Got:", result)
            
            
def test(testcase):
    for name, case in testcase:
        # Kết quả chuẩn sử dụng numpy.fft.fft
        expected = np.fft.fft(case)
        # expected = FFT(case)
        print(name)
        print("INPUT:")
        print_testcase(case,"x")
        print("OUTPUT:")
        print_testcase(expected,"y")
            
        
            
            
if __name__ == "__main__":
    # Danh sách các test case dưới dạng tuple: (mô tả, input)
    testcases = [
        ("Test case 1: all real = 0, all img = 0",
            np.array([0 + 0j,0 + 0j,0 + 0j, 0 + 0j, 0 + 0j, 0 + 0j, 0 + 0j, 0 + 0j])),
        
        ("Test case 2: all real > 0, all img = 0",
            np.array([ 184.14 + 0j ,111.57 + 0j ,179.18 + 0j , 15.58 + 0j ,124.03+ 0j ,90.28 + 0j ,141.97+ 0j ,127.48+ 0j])),
        
        ("Test case 3: all real = 0, all img > 0",
            np.array([0 + 6.65j, 0 + 131.87j, 0 + 97.52j, 0 + 18.64j, 0 + 6.84j, 0 + 84.05j, 0 + 91.62j, 0 + 174.35j])),
        
    
        ("Test case 4: all real < 0, all img = 0",
            np.array([-68.54 + 0j, -34.64 +0j, -2.60  +0j, -188.31+0j, -13.31 +0j, -52.41 +0j, -183.49+0j, -186.33 +0j ])),
        
        ("Test case 5: all real = 0, all img < 0",
            np.array([0 + -40.90j, 0 + -39.03j, 0 + -178.09j, 0 + -145.53j, 0 + -123.45j, 0 + -5.24j, 0 + -2.27j, 0 + -73.70j])),
        
        
         
        ("Test case 6: all real > 0, all img > 0",
            np.array([74.55 + 20.31j, 44.42 + 159.58j, 23.06 + 27.24j, 144.36 + 80.09j, 86.06 + 186.68j, 21.21 + 165.36j, 67.75  + 148.50j, 195.17 + 64.08j])),
        
        ("Test case 7: all real > 0, all img < 0",
            np.array([55.33 + -69.15j, 55.77 + -13.13j, 26.93 + -4.85j, 136.97 + -169.64j, 168.85 + -155.21j, 39.72 + -15.09j, 133.73  + -111.18j, 108.91 + -42.07j])),
        
        ("Test case 8: all real < 0, all img > 0",
            np.array([-54.84  + 149.66j, -35.43  + 6.74j, -163.47 + 68.12j, -122.08 + 188.66j, -113.03 + 93.45j, -140.37 + 167.88j, -13.59  + 166.23j, -53.27  + 5.11j])),
        
        ("Test case 9: all real < 0, all img < 0",
            np.array([-134.65 + -173.74j, -77.83  + -20.89j, -83.76  + -11.15j, -139.61 + -79.30j, -180.87 + -60.10j, -195.63 + -73.04j, -19.61  + -125.57j, -132.00 + -14.95j ])),


        ("Test case 10: general case",
            np.array([ 47.23   + -104.07j, 185.66  + 163.59j, -192.09 + -32.27j, -81.88  + -99.09j, -174.45 + 40.10j, -175.04 + -184.48j, 35.76   + -156.15j, -131.21 + 55.88j ])),
        
        ("Test case 11: general case",
            np.array([ 117.25  +  185.34j, 103.19  +  -86.87j, -114.02 +  -63.04j, 161.47  +  45.54j, -161.28 +  125.79j, -196.94 +  -75.98j, 141.39  +  187.21j, -14.90  +  -5.04j ]))        
    ]
     
    
    
    
    try:
    
        # test_fft_function(testcases,FFT)
        test(testcases)
    except Exception as e:
        print(e)
    
    
   
    