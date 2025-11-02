## Discrete optimal execution

An agent has to select $n$ values sequentially.
He has the choice to either take the value from a uniform $\mathcal{U} [a, b]$ 
random variable, 
or to select a fixed-value alternative.

The alternative value can be selected at most $k$ times.

The objective is to find the optimal strategy and compute the expected value over the $n$ steps.

| Variable | Description |
| --- | --- |
| n | Total number of steps |
| p | Fixed alternative value  |
| k | Maximum number of times not using the uniform draw  |
| a, b | Range of the uniform law |

<p style="color:green">
Modelling the problem :
</p>

Assume  $k \geq 1, p < b $ and $n \geq 1$.
The objective function can be written :

$$
M = \min \left( \mathbb{E} \left[ \sum_{j=1}^{n} x_j \right] \right)
$$

Where the $x_j$ are the draws from the random variables resulting of our strategy, which are not independant as decisions are made sequentially :

$$
M = \min \left( \mathbb{E} \left[ \sum_{j=1}^{n} \mathbb{E} \left[x_j | \mathcal{F}_{j-1} \right] \right] \right)
$$

If we know the uniform draws in advance, the optimal strategy would be to choose the $k$ larger draws and to replace it with $\min (x_{(i)}, p)$
where the $x_{(i)}$ are the ordered variables.

It gives a lower bound to the problem :

$$
M \geq \sum_{j=1}^{n-k} \left( a + \frac{j(b-a)}{n+1} \right) 
+\sum_{j=1}^{k} \min (p, a +\frac{(n-k+j)(b-a)}{n+1})
$$

<p style="color:green">
Strategy : keep a flat threshold at the value of the top-k uniform value of n independant draws. <br>
If we reach the point where there are as many k than n, then apply the min.
</p>

The threshold then is $a + \frac{(n-k)(b-a)}{n+1} $

$$
\begin{align*}
\mathbb{E} \left[ \sum_{j=1}^{n} x_j \right] & = 
\mathbb{E} \left[ \sum_{j=1}^{n} \sum_{m=0}^{j \wedge k} \mathbb{E} \left[ x_j | k_j = m \right] P(k_j = m) \right]
\end{align*}
$$

Where the variable $k_i \in [0, i]$ is the number of $u_1, \dots , u_{i-1} $ being above the threshold 
(the factorisation is possible since $u_i \perp (u_j)_{j < i }$ ).

The sum can be rewritten :

$$
\begin{align*}
\mathbb{E} \left[ \sum_{j=1}^{n} x_j \right] & = 
\mathbb{E} \left[ \sum_{j=1}^{k} \sum_{m=0}^{j} \mathbb{E} \left[ x_j | k_j = m \right] P(k_j = m) + \sum_{j=k+1}^{n} \sum_{m=0}^{k} \mathbb{E} \left[ x_j | k_j = m \right] P(k_j = m)\right] \\
& = \int \dots \int \sum_i x_i \frac{du_1 \dots du_n}{(b-a)^n} \\
& = \sum_{\sigma \in P_n} \int_{u_{\sigma(1)} < \dots < u_{\sigma(n)}} \dots \int \sum_i x_i(u_1, \dots , u_n) \frac{du_1 \dots du_n}{(b-a)^n}
\end{align*}
$$


**Law of top-k drawn from a uniform distribution :**

We used the fact fact that the expectation of the top-k value of n independant draws from a uniform variable is : 

$$ 
x_{(k)}^n = a + \frac{k (b-a)}{n+1}
$$

To simplify the computation, let $(u_i)_{i\in [1, \dots, n]} \sim \mathcal{U}[0, c] $ and independant.

Let $k \in [1, n]$ and $\left( u_{(i)} \right)_{i \in [1, \dots, n]}$ the ordered variables.

$$
\begin{aligned}
\mathbb{E} \left[ u_{(k)} \right] &=
\frac{1}{c^n}\int \cdots \int u_{(k)} du_1\cdots du_n \\
&= \frac{n! }{c^n} \int_{u_1 < \cdots < u_n} \int u_k du_1\cdots du_n \\
&= \frac{n! }{(k-1) ! c^n} \int_{u_k < \cdots < u_n} u_k \times u_k^{k-1}\  du_k \cdots du_n \\
&= \frac{n! }{(k-1) ! (k+1)c^n} \int_{u_{k+1} < \cdots < u_n} u_{k+1}^{k+1} \  du_{k+1} \cdots du_n \\
&= \frac{n! }{(k-1) ! (k+1)\cdots n c^n} \int_{0 < u_n < c} u_{n}^{n} \  du_{n} \\
&= \frac{n! }{(k-1) ! (k+1)\cdots n (n+1) c^n} \times c^{n+1} \\
&= \frac{k c}{n+1} 
\end{aligned}
$$

