N = int(input())

for _ in range(N):
    n = int(input())
    l = list(map(int, input().strip().split(' ')))
    m = sum(l)
    # early stopping condition ?
    for i in range(n)[::-1]:
        for j in range(i, n)[::-1]:
            m = max(m, sum(l[:i] + l[j+1:]) + (i + j + 2) * (j-i + 1))
    print(m)
    
