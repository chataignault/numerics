## Card game optimal strategy

$N = 100$, $x \in [ 1 \dots 10 ]$ 

Taking turns, first to $100$ wins.

> Strategy and how should start first ?

**Solution :**

<p style="color:green">
Start and add 1 to the total count. <br> 
Then complete each turn to total $11$ with what the opponent has played
(if opponent adds k to the total, place 11-k). <br>
After the 8th round, the sum reaches 89, being at opponent's turn. <br>
Whatever the other player does, 100 can be reached at the next move. <br>
</p>

***

One player game with two hidden boxes.
For 100 turns, the player chooses either to `place` or `take`.
- `place` adds $1$ to either boxes at random.
- `take` returns the content of either box at random, 
regardless of their content.

The player can only know how much he obtained at the end of the game.

> What is the optimal strategy ? What is the expected sum that the player will get ?

**Solution :**

<p style="color:green">
If there was only one box, the optimal strategy would be to `place` until the 99th round and the `take`. 
The expected payoff of doing so is 99 and is an upper bound for the game. <br>
The same strategy but with the two boxes has an expected payoff of 49,5. <br>
The problem is then :
</p>

$$
\left(\mathcal{P}\right):\ \max_m \left[ \frac{100 - m}{2} \sum_{k=0}^{m-1} 2^{-k}  \right] \\
\left(\mathcal{P}\right):\ \max_m \left[ (100 - m) \left( 1 - 2^{-m} \right) \right]
$$

<p style="color:green">
Which is maximum for m=6,
so the optimal strategy is to `place` 94 times and then `take` until the game finishes. <br>
The expected sum is then 2961/32 ~ 92,5.
</p>

