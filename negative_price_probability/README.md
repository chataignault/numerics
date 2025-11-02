## Negative price probability
Compute the probability of a random walk reaching zero 
before $n$ steps, starting at $s$,
moving by $\pm \delta s$ at each step, 
with probability of moving up being $p \in [0,1]$.

| Variable | Description |
| --- | --- |
| n | Total number of steps |
| p | Probability of going up |
| s | Initial value |
| ds | Step size |

<p style="color:green">
Implemented : <br> 
</p>

- Monte Carlo estimate for verification :
    - simulate a trajectory and check whether is gets to zero
- Incremental solution :
    - Disjoint cases on "how many times the trajectory goes up" :
    - Catalan number being the number of positive paths starting and ending at 0

Looking for paths that do cross zero at $2k+r$ steps for the first time, 
the probability of any of these paths will be :

$$ \tilde{p_k} = p^k (1-p)^{k+r}$$

Let : 

$$r = \lfloor \frac{s}{\delta s} \rfloor $$

(the number of steps needed to reach / cross zero)

The number of paths that will reach zero at step $2k+r$ is : 

$$
c_k = \sum_{G \ \text{integer partition of k}} \left( \prod_{g_i \in G} C_{2g_i}\right) \times \begin{pmatrix} r \\ s \end{pmatrix}
$$

So the solution will be for each $k$ such that $2k + r \leq n $, to incrementally add $\tilde{p_k} c_k $.

**Intuition behind $c_k$ :**

We assume to know that the Catalan numbers represent the number of positive paths of $2n$ steps.

Thinking in terms of *"when does a valid path goes irreversibly down by one"*,
a path that will rise $k$ times and go down $k+r$ times will :
- go down at the last step : remains $r-1$ "right parenthesis" to place,
- "going up $k$ times" can be decomposed in groups of integer partitions of $k$, where each sub-path becomes a positive one (~ Catalan number).
We need at least one right parenthesis between these groups so that they cannot be ambiguous. So if the length of the integer partition is $j$, we need to use $j-1$ right parenthesis at this point to distinguish the "sub-positive-paths" which count we already know.
- The remaining $r-1 - (j-s) = r-j$ right parenthesis to place are equivalent to placing $r-1$ indistinct balls into $j + 1$ distinct buckets, where $j$ is the length of the integer partition of $k$.
This values is :

$$ 
\begin{pmatrix}
(r-j) + (j+1) - 1 \\
(j+1) - 1
\end{pmatrix}= \begin{pmatrix}
r \\
j
\end{pmatrix}
$$

**Efficient computation of integer partitions :**
- [Kelleher, Jerome, and Barry O'Sullivan. "Generating all partitions: A comparison of two encodings." arXiv preprint arXiv:0909.2331 (2009).](https://arxiv.org/pdf/0909.2331)
- https://jeromekelleher.net/generating-integer-partitions.html

**(Weak) Composition of an integer**
The number of ways to decompose an integer $n$ into $k$ non-negative integers is :

$$ 
\begin{pmatrix}
n + k- 1 \\
k - 1
\end{pmatrix}
$$

It is the number of ways one can dispatch $n$ indistinct balls into $k$ distinct buckets, and is also equivalent to the *stars and bars* problem.

The binomial number can be understood as the number of sequences of length $n + k - 1$ ,
containing $n$ unit elements and $k - 1$ separation elements 
(having then $k$ parts, possibly empty to represent zero).


**(Strong) Composition of an integer**

The number of ways to decompose an integer $n$ into $k$ positive integers is :

$$\begin{pmatrix} n - 1 \\ k-1 \end{pmatrix}$$

which [can be seen as](https://en.wikipedia.org/wiki/Composition_(combinatorics)) choosing $k-1$ seperations between $n$ units (therefore having $n-1$ intervals).

One can obtain the result also from point of view of the weak composition, 
seeing, after dispatching one unit to each $k$ parts, that $n-k$ 
indistinguishable units are left to place in $k$ distinct buckets.

**Benching ascending integer partitions algorithms**

Both algorithms from  https://jeromekelleher.net/generating-integer-partitions.html are implemented, 
with the significant difference that they are eager, whereas the Python 
example generates an iterator which in practice is a lot more memory-efficient.

Still, using the `bench` tool from rust, the efficient algorithm has a smaller variance than the simpler one :

```bash
cargo +nightly bench
test tests::bench_exec_time_bf  ... bench:       2,195.70 ns/iter (+/- 959.86)
test tests::bench_exec_time_dyn ... bench:       1,130.59 ns/iter (+/- 684.28)
```

