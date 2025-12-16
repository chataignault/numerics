# Analytical Solution: Variance of Maximum Die Game

### 2. Second Moment E[P²]

For P²:
- When x ≤ q and y < x: contributes x²
- When x ≤ q and y > x: contributes y²
- When x > q: contributes x²

Reorganizing the double sum by swapping indices:

```
E[P²] = (1/pq)[2·Σ_{x=1}^q x²(x-1) + q·Σ_{x=q+1}^p x²]
```

Using:
- Σ_{x=1}^n (x³ - x²) = [n(n+1)/2]² - n(n+1)(2n+1)/6 = n(n+1)(3n² - n - 2)/12
- Σ_{x=1}^n x² = n(n+1)(2n+1)/6

We get:

```
E[P²] = (1/p)[(q+1)(3q² - q - 2)/6 + (p(p+1)(2p+1) - q(q+1)(2q+1))/6]
```

### 3. Variance Decomposition

#### Conditional Analysis

**When X ≤ q** (probability q/p):
- E[P | X ≤ q] = 0 (by symmetry - both players in same range)
- Var(P | X ≤ q) = E[P² | X ≤ q] requires computing:

```
E[P² | X=x] = (1/q)[x²(x-1) + q(q+1)(2q+1)/6 - x(x+1)(2x+1)/6]
```

This involves a complex double sum (computed as s₀ in the code).

**When X > q** (probability (p-q)/p):
- E[P | X > q] = E[X | X > q] = (p+q+1)/2
- Var(P | X > q) = Var(X | X > q) = [(p-q)² - 1]/12

For p=30, q=20:
- E[P | X > q] = 25.5
- Var(P | X > q) = 8.25

#### Total Variance

By law of total variance:

```
Var(P) = E[Var(P|condition)] + Var(E[P|condition])
```

The final formula (as implemented in the code):

```
Var(P) = (2/3)·s₀ + [p(p+1)(2p+1) - (q+1)(q+2)(2q+3)]/(18(p-q))
```

where s₀ captures the variance contribution from the X ≤ q region:

```
s₀ = Σ_{k=1}^{q-1} [Σ_{j=k}^{q-1} (1/j)] · [q(q+1)(2q+1) - (k+1)(k+2)(2k+3)] / [6(q-k)]
     · (q-1)/(q²)
```
