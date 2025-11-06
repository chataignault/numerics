## Counting diagonal paths

Starting at $(0,0)$, 
how many paths are there to reach $(4,6)$,
going either UP or RIGHT at each turn,
and avoiding to go three times in the same directlion successively ?

<p style="color:green">
One idea is to consider the total number of paths, without the constraint :
</p>

$$\begin{pmatrix} 10 \\\ 4 \end{pmatrix} = 210$$

<p style="color:green">
and then to retain only valid ones 
by deducting the paths that are not valid,
that is paths containing 
one or more sequence of three successive UP or RIGHT.
</p>

<p style="color:green">
Without a simple expressions from ill-formed paths,
another idea is to consider that a well-formed path is 
an alternating sequence of groups of either one or two elements.
</p>

> [!WARNING]
> This is not a closed form solution, and would not scale to bigger grids.

<p style="color:green">
Splitting cases on the number of groups (for instance of UP arrows),
which amounts to either 3, 4 or 5 groups,
then splitting cases on the number of groups for RIGHT arrows
(3 distinct cases maximum for each),
one can, taking care not to count symmetric sequences twice,
count the number of valid paths constructively.
The solution is 43.

The numerical verification
uses the first idea,
constructing all paths from (0,0) to (4,6),
which is equivalent to picking 4 UPs in the sequence of 10 directions,
and then to verify that each combination is valid.
</p>


