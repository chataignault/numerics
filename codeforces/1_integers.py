from functools import reduce
N = int(input())

for _ in range(N):
    n, a = [int(k) for k in input().strip().split(' ')]
    l = list(map(int, input().strip().split(' ')))
    if reduce(lambda x, _: x+1, filter(lambda x: x < a, l), 0) > reduce(lambda x, _: x+1, filter(lambda x: x > a, l), 0):
        print(a - 1)
    else:
        print(a + 1)

