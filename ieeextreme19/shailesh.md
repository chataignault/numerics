## Shailesh Triplet solution

### Problem Statement

Find triplet of distinct integers $(a, b, c)$ such that :
```math
\begin{cases}
2N = a + b + c\\
N = a \otimes b \otimes c
\end{cases}
```
where $\otimes$ is the bit-wise \textt{XOR} operation.

> [!WARNING]
> There is no solution if $N$ is odd.

Indeed, $2N = a+b+c$ is always even,
so there must be an even number of odd elements in $a, b, c$.
However,  $a \otimes b \otimes c$ in this case must be even,
so it can't be equal to $N$.

> [!WARNING]
> There is no solution either if $N$ is a power of $2$.

Assume that we choose $a > b > c$, and call $c(x)$
the coefficient of the leading power of $2$ of 
the binary decomposition of a integer $x$.

Write $n = 2^p$.

**For a triplet to be valid, it is necessary that $c(a) = p$**

If it was greater, $a + b + c > a \geq 2N$.
If it was smaller, $a + b + c < 3a < 4a = 2N$.
In either case the total sum condition cannot be satisfied.

For similar reasons, 
$c(b) \leq p-1$ and $c(c) \leq p-1$

The condition :
```math
2^p = a \otimes b \otimes c
```
becomes :
```math
0 = (a - 2^p) \otimes b \otimes c \Leftrightarrow a - 2^p = b \otimes c
```
The leading coefficient of $a - 2^p$ is smaller than or equal to $p - 1$.
If it was $p-1$, $c(b) = p-1, \ c(c) \leq p-2$ 
(from the right hand side of the re-written assumption,
$b$ and $c$ can't have the same leading coefficient).

So $(a - 2^p) + b \geq 2^p$ which implies $c \leq 0$ 
which does not yield a solution.

In the case where $c(a - 2^p) < p-1$, 
it is straightforward that the sum
$(a-2^p) + b + c \leq 3\times 2^{p-2} < 2^p$

> [!NOTE]
> Solution in the general case, where $N$ is even and not a power of $2$.

```math
\begin{cases}
a = N + 2^{p-1}\\
b = \lfloor \frac{N}{2} \rfloor\\
c = \lfloor \frac{N}{2} \rfloor - 2^{p-1}
\end{cases}
```
where $p$ is the greatest power of $2$ that divides $N$,
is one valid decomposition.

While the summability condition is clear, 
the bit-wise operation is verified as follow :
```math
b\otimes c = 2^{p-1}
```
Since `XOR` is associative, 
```math
a\otimes (b \otimes c) = (N + 2^{p-1}) \otimes 2^{p-1} = N
```
where it is understated that :
```math
N = 1 x_{n-1}\dots x_{p+1} 1 \underbrace{0 \dots 0}_{p-1}
```

