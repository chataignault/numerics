N = int(input())

for _ in range(N):
    x, y, k = list(map(int, input().strip().split(' ')))
    mults = set()
    for p in range(y, y+x+1):
        mults = mults.union(set([p * i for i in range(1, k // p)]))
    print(k - len(mults))
