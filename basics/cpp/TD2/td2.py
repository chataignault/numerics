import sys

def factorial(n:int)->int:
    m = 1
    for i in range(1, n+1):
        m*=i
    return m


if __name__ == "__main__":
    n = int(sys.argv[1])
    print(factorial(n))