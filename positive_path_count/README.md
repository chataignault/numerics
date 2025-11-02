## Positive paths count
Given an integer $n$, count the number of positive paths
that start and end at $0$
and moving $\pm 1$ at each step.

**Solution**

<p style="color:green">
The closed-form expression can be written as Catalan numbers, 
which also represent the number of balanced parenthesis.
</p>

$$ C_{2n} = \begin{pmatrix} 2n \\ n \end{pmatrix} - \begin{pmatrix} 2n \\ n + 1\end{pmatrix}  = \frac{1}{n+1} \begin{pmatrix} 2n+1 \\ n \end{pmatrix}$$

But as one does not necessarily remember this formula from the top of it's head, 
dynamic programming is also implemented.

Computing incrementally all $C(j, k)$ for $0 \leq j \leq k $, being the number of paths 
starting at $0$ and ending at $2k$ in $2j$ steps.
Then the solution is given by $C(n, 0)$.

From a direct first-step analysis, the recurrence relation is :
```math
C(j+1, k) = 
\begin{cases}
2 C(j, k) + C(j, k-1) + C(j, k+1) \ \text{if 0 < k < j} \\
2 C(j, j) + C(j, j-1) \ \text{if k = j}\\
C(j, 1) + C(j, 0) \ \text{if k = 0}
\end{cases}
```

> Tested the [benching crate](https://doc.rust-lang.org/cargo/commands/cargo-bench.html) to have an idea of feasible $n$ with direct computations and dynamic programming. At the time of writing it requires to use the *nightly* channel :
```bash
cargo +nightly run
```

<p style="color:orange">
<i>
This solution quickly runs into numerical overflow with u32.
</i>
</p>

