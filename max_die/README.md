# Max die game

## Problem setup 

Given two indeoendant discrete uniform random variables :
```math
X \sim U[1, p] \\
Y \sim U[1,q] 
```

Define the variable :
```math
P = \begin{cases} X \ \ \text{if} \ \ X > Y\\ -Y\ \ \text{if} \ \ Y > X \\ 0 \ \ \text{if} \ \  X = Y \end{cases}
```

> What is the expected value and variance of $P$ ?

## Solving approaches

One can write the joint distribution and solve the explicit sums by hand.

Alternatively, one can condition the expectation on the realisation of either $X$ or $Y$, and use a symmetry argument to simplify the computation.

For instance if $p=q$, $X\sim Y$ so the variables are interchangeable.
Since $P$ is an antisymmetric function of $X$ and $Y$ : $P = f(X, Y) = -f(Y, X)$,
Therefore when taking expectations :

```math
\mathbb{E}\left[P\right] = -\mathbb{E}\left[P\right] = 0
```

So for $p>q$, when conditionning on $X\leq q$ the expectation is zero,
and since the $P$ simplifies to $X$ when $X > q$, the rest of the expectation simply is :

```math
\mathbb{E}\left[P | X > q\right] = \frac{p(p-1) - q(q-1)}{2(p-q)}
```

Since :
```math 
p(X > q) = \frac{p-q}{p}
```

The expectation eventually is :

```math
\mathbb{E}\left[P \right] = \frac{p(p-1) - q(q-1)}{2p}
```
