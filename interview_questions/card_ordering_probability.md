## Ordering probability

A deck of 64 cards is well shuffled.

Cards are drawn one by one until the 2 of hearts is drawn and the game stops.

> What is the probability of drawing exactly one king, one queen and one jack before the game stops ?

**Solution :**

There are 4 cards for each of the three heads and and the 2 of hearts.
The ordering of all other cards does not matter.

Therefore the probability model is considered on the ordering and position
of the 13 distinguishable cards.

Since :

- the number of ordering of 13 elements is $13!$,
- the number of position combinations these cards can be placed at is given by binomial numbers,

The total number of combinations is :

$$13 ! \begin{pmatrix} 64 \\\ 13 \end{pmatrix}$$

Then, a combination that is valid satisfies :

- there is exactly one king, one queen and one jack at the start,
- then the 2 of hearts
- then all other cards

The number of combination for the three first cards is $4^3 = 64 $, their order is $3! = 6$,
and the number of ordering for the remaining 9 distinguishable cards 
(therefore excluding the 2 of hearts since it has a fixed position)
is $9!$.

The number of combinations for the indistinguishable cards is the same as before.

Eventually, the probability is :

$$\frac{6 \times 64 \times 9!}{13 !}$$

