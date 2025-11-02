## Expected number of pairs

Picking $5$ cards out of a deck containing $5$ pairs.

> What is the expected number of pairs picked ?

**Solution :**

<p style="color:green">
No replacement and indistinguishable pairs.<br>
Combinatorics of parts of a fixed size of a set (binomial number).<br>
For a given number of pairs picked, (how many possible pair combination), then of the remaining cards to pick, 
select cards from distinct remaining pairs.  
</p>

With $\lfloor \frac{n}{2} \rfloor \leq p$,

$$
\mathbb{E} \left[ P \right] = \sum_{k=1}^{\lfloor n / 2 \rfloor }
k \frac{
    \begin{pmatrix} p \\\ k \end{pmatrix}
    \begin{pmatrix} p-k \\\ n - 2k \end{pmatrix}
}{
    \begin{pmatrix} 2p \\\ p \end{pmatrix}
}
$$

***

