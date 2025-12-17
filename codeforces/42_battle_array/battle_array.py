import heapq

n = int(input().strip())

for _ in range(n):
    p, q = map(int, input().strip().split(" "))

    alice = [-int(k) for k in input().strip().split(" ")]
    bob = [-int(k) for k in input().strip().split(" ")]

    heapq.heapify(alice)
    heapq.heapify(bob)

    while p > 0 and q > 0:
        x = alice[0]
        if x <= bob[0]:
            if q == 1:
                print("Alice")
                break
            heapq.heappop(bob)
            q -= 1
        else:
            y = heapq.heappop(bob)
            heapq.heappush(bob, y - x)
        
        # other turn
        x = bob[0]
        if x <= alice[0]:
            if p == 1:
                print("Bob")
                break
            heapq.heappop(alice)
            p -= 1
        else:
            y = heapq.heappop(alice)
            heapq.heappush(alice, y - x)

