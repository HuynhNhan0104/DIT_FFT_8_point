import numpy as np
def float_to_fixed_point_hex(value, bit_lenght = 32, fraction_width = 16):
    """ convert float(32 bit) to fixed point QM.N (M = bit_length - faction_width, N = fraction_width)

    Args:
        value (float): 32 bit 
        bit_lenght (int, optional): bit width of value . Defaults to 32.
        fraction_width (int, optional): fraction width. Defaults to 16.

    Returns:
        int: 32 bit value in form QM.N
    """
    fixed_value = int(value*(1 << fraction_width))
    if fixed_value < 0:
        mask = (1 << bit_lenght) - 1
        # convert to 2's
        fixed_value = ((abs(fixed_value) ^ mask) + 1) & mask
    return fixed_value 



def fixed_point_to_float(fixed_point_value, bit_lenght = 32, fractional_bits=16):
    """ convert float(32 bit) to fixed point QM.N (M = bit_length - faction_width, N = fraction_width)

    Args:
        fixed_point_value (int):  32 bit value in form QM.N
        bit_lenght (int, optional): bit width of value . Defaults to 32.
        fraction_width (int, optional): fraction width. Defaults to 16

    Returns:
        float: 32 bit 
    """
    if fixed_point_value&( 1 << (bit_lenght-1)):
        fixed_point_value = -((1 << bit_lenght) - fixed_point_value)
    return float(fixed_point_value) / (1<<fractional_bits)


def convert_array_to_fixed_point(fixed_point_value, bit_lenght = 32, fractional_bits=16):
    pass


def test():
    input = 0.7071067811865476
    print(f"input = {input}")
    hex_val = float_to_fixed_point_hex(input)
    print(hex(hex_val))
    input_hex = hex_val
    float_val = fixed_point_to_float(input_hex)
    print(float_val)
    
    
if __name__ == "__main__":
    test()

    