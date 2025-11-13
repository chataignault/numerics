# IEEEXtreme 19 Programming Competition Solutions

<img src="img/xtreme_logo.gif" width="250px" />

Solutions to problems from the 
IEEEXtreme 19.0 [programming competition](https://csacademy.com/ieeextreme19/tasks/). 
These represent completed submissions and post-competition work.

## Written solutions

1. [Ladder](ladder.md)
2. [Shailesh Triplet](shailesh.md)

### Ladder

| | File name | 
| -------- | ------- |
| Original script | `ladder.py` |
| Optimised algorithm | `ladder_solution.py` |
| Solution derivation | `ladder.md` |
| Test input | `ladder.txt` |

Reverse-engineer and optimize a Monte Carlo simulation algorithm. 
The problem involves computing the probability 
that two random sequences of 1s and 2s, 
both summing to n, are identical. 
**Full mathematical derivation and solution provided in `ladder.md`.**

The exercise ranked second of the competition 
in terms of total points worth.

### Shailesh Triplet

| | File name | 
| -------- | ------- |
| Solution script | `shailesh_triplet.py` |
| Solution derivation | `shailesh.md` |

Find triplets (a, b, c) where $2N = a + b + c$ and $N = a \text{XOR} b \text{XOR} c, 
such that $a$, $b$ and $c$ are distinct elements. 
Solution identifies valid triplets based on divisibility 
and power-of-two properties.

### Circular Permutation
`circular_permutation.py`

Arrange N friends around a circular table to minimize the maximum distance anyone needs to move. Tests both clockwise and counterclockwise arrangements starting from each position.

### Do You Know Expectation
`do_you_know_expectation.py`

Calculate the expected value of XOR operations raised to power k across all possible non-empty subsequences of an input array.

### Sequence Decomposition
`sequence_decomposition.py`

Decompose a sequence into fortune cookie patterns following a specific state machine (0→1→1→2→0→1→2). Uses greedy matching to identify and extract complete fortune patterns from the input stream.

### Stable Power Network
`stable_power_network.py`

Find the path in a weighted graph from node 1 to node N that minimizes maximum edge risk, with total time as tiebreaker. Modified Dijkstra's algorithm prioritizing (max_risk, total_time).

### Twin Occurrence
`twin_occurence.py`

Given a sorted list and an integer $k$,
the algorithm should search for the $k$ following integers 
in the list, 
and return indexes of the first and last occurences of each elements
if they are present.

The solution implements a binary search 
to find one occurence of the each element.
Then, the first and last occurrence indices are obtained by
incrementally shifting indexes from the first-found occurence. 

> [!NOTE]
> The first element of the list is indexed $1$.

Return `-1` of position is not found.

