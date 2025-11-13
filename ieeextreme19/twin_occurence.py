# parse length of the list and number of elements to search
n, k = map(int, input().strip().split())

# parse the sorted list
if n == 1:
    l = [int(input().strip())]
else:
    l = list(map(int, input().strip().split()))

for _ in range(k):
    j = int(input().strip().split()[0])
    
    # Binary search to find any occurrence
    left, right = 0, n - 1
    found_idx = -1
    
    while left <= right:
        mid = (left + right) // 2
        if l[mid] == j:
            found_idx = mid
            break
        elif j < l[mid]:
            right = mid - 1
        else:
            left = mid + 1
    
    if found_idx == -1:
        print('-1 -1')
    else:
        # Find first occurrence
        first = found_idx
        while first > 0 and l[first - 1] == j:
            first -= 1
        
        # Find last occurrence
        last = found_idx
        while last < n - 1 and l[last + 1] == j:
            last += 1
        
        print(f"{first + 1} {last + 1}")

