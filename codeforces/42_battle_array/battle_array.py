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
            bob.pop()
            q -= 1
        else:
            y = bob.pop()
            heapq.heappush(bob, y - x)
        
        # other turn 
        x = bob[0]
        if x <= alice[0]:
            if p == 1:
                print("Bob")
                break
            alice.pop()
            p -= 1
        else:
            y = alice.pop()
            heapq.heappush(alice, y - x)

