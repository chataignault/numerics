## Dealing indistinguishable cards

With a deck of 52 cards
and the initial information that it comprises 17 cards facing up and 35 facing down,
find an algorithm for dealing the deck into two piles
such that the two piles have the same number of cards facing upwards.
The only allowed operation is to flip an arbitrary amount of cards.
Cards are not visible before or at any time during the algorithm.

**Solution**

<p style="color:green">
Take 17 of those cards (the same number as cards initially facing up), flip all of them.
This forms one pile and the other cards - untouched - go in the other pile.
</p>

**Why it works**

Suppose among the 17 cards you selected, `k` were facing up and `(17-k)` were facing down.

- After flipping these 17 cards:
  - The `k` cards that were up are now down
  - The `(17-k)` cards that were down are now up
  - This pile has `(17-k)` cards facing up

- The remaining 35 cards (untouched):
  - Originally there were 17 cards up total, and you took `k` of them
  - So this pile has `(17-k)` cards facing up

Both piles have exactly `(17-k)` cards facing up!


## Other references
- https://laurentmazare.github.io/

