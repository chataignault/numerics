# Carnival Wheel 

$m \in \mathbb{N}, 0 \leq a < m, b \in \mathbb{N}$

Find :
```math
\max_{k \in \mathbb{Z}} a + bk \  [m]
```

***

```math
\forall k, j \in \mathbb{Z}, \ \ 
a + bk \equiv a + bk + mj \equiv r \ [m]
```

and since :

```math
b\mathbb{Z} + m\mathbb{Z} = (b\wedge m) \mathbb{Z}
```

The maximum on $r$ becomes :

```math 
\max_k a + (b\wedge m) k \ [m]
```

or :

```math
\left( a + b\mathbb{Z} \right) / m\mathbb{Z} =\left( a + (b\wedge m)\mathbb{Z} \right) / m\mathbb{Z} 
```

Eventually :

```math
\max \left\{k | k \in a + (b\wedge m) \mathbb{Z} / m\mathbb{Z} \right\} = \begin{cases} a \ \ \ \text{if } \ \ b = 0 \\ a + \lfloor \frac{m-1-a}{b\wedge m} \rfloor (b\wedge m) \end{cases}
```

