# QuartersAndDimes

This project exists to solve one specific problem and do so in elixir.

Given an arbitrary number of points on a circle which are randomly (or in some
deterministic fashion) distributed, how long does it take performing steps of
the following process to converge to a uniform spacing within some bound?

Each step loops through every point and repositions it such that it is
equidistant from the two closest points (along the surface of the circle).

For now, we're assuming that there are at least 3 points.
