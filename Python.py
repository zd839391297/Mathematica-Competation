# print("hello,world")

import numpy as np
from scipy import integrate
import math


def f(x, y):
    return math.sin(x)*y


#a = integrate.quad(f, 0, math.pi/2)
#print(a)

b = integrate.dblquad(f,0, 1, lambda x: 0, lambda x: x+1)
print(b)
