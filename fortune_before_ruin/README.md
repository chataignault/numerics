
## Probability of fortune before ruin

I currently own $3$ coins and want to reach $5$.
Each turn I bet the maximum amount up to what is necessary to reach $5$.
The probability of winning each turn is $\frac{2}{3}$ - 
the amount won is the number of betted coins.

**What is the probability of reaching $5$ before loosing all the coins ?**

***

Drawing the graph of possible states, it naturally appears that $p$ 
has a recursive nature.

Indeed,
```math
p = \frac{2}{3} + \frac{1}{3} \times \left( \frac{2}{3} \right)^2 \times \left( \frac{2}{3} + \frac{p}{3} \right)
```

which resolves to :
```math
p = \frac{62}{77}
```

