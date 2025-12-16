## Probability of intersection of random segments

Flower $A$ and $B$ blossom in the coming $40$ days uniformly independently.
Flower $A$ lasts $4$ days and flower $B$ blossoms during $16$ days. 

> What is the probability to observe both flowers blossomed in the next 40 days ?

**Solution :**

$$
[A, (A+4) \wedge 40 ] \cap [B, (B+16) \wedge 40 ] \neq \emptyset \\
\Leftrightarrow \left(B \leq A \leq B+16\right) \cup \left( A \leq B \leq A+4 \right) \\
\Leftrightarrow -4 \leq A - B \leq 16   
$$

While the distribution $A - B$ can be computed, 
it seems more direct to condition the computation on the realisation of either variable.

$$
\begin{align*} 
p & = P (-4 \leq A - B \leq 16) \\
& = \sum_{k=1}^{40} P (-4 + B \leq A \leq 16 + B | B = k) P(B=k) \\
& = \frac{1}{40} \left( \sum_{k=1}^3 p_k + \sum_{k=4}^{24} p_k + \sum_{k=25}^{40} p_k \right)
\end{align*}
$$

With distinct cases depending on the contact with either boundaries of the interval.

$$
\begin{cases}
p_k = \frac{16 + k}{40}, \hspace{.5cm} k \in 1\dots 3 \\
p_k = \frac{1}{2}, \hspace{.95cm} k \in 4 \dots 24 \\
p_k = \frac{44 - k}{40}, \hspace{.5cm} k \in 25 \dots 40
\end{cases}
$$

Eventuallly : 
$$p = \frac{654}{1600}$$

