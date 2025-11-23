import re

N = int(input())

def max_drift_length(l):
    if len(l) < 2:
        return 1
    if "oo" in l or ">o" in l or "o<" in l:
        return -1
    #elif re.search(r".*>.*<.*", l):
    elif "><" in l or ">o<" in l:
        return -1
    else:
        return max(len(l.replace('>', '')), len(l.replace('<', '')))

for _ in range(N):
    flow = input()
    print(max_drift_length(flow.replace('*', 'o')))

