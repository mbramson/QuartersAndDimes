defmodule QuartersAndDimes do

  @doc """
  Returns true if the values (degrees) in points are equidistant within the
  tolerance parameter. It calculates the distance between each sequential point
  and ensures that it is either greater than or equal to 360 / number of points
  - tolerance or less than or equal to 360 / number of points + tolerance.
  """
  def equidistant?(points, tolerance) do
    correct_distance = 360 / length(points)
    points = Enum.sort(points)
    _equidistant?(points ++ [List.first(points)],
                  correct_distance - tolerance,
                  correct_distance + tolerance)
  end

  defp _equidistant?([first| [ last | [] ] ], lower, upper) do
    _spaced_within_tolerance?(first, last, lower, upper)
  end

  defp _equidistant?([first|points], lower, upper) do
    _spaced_within_tolerance?(first, List.first(points), lower, upper) and
    _equidistant?(points, lower, upper)
  end

  defp _spaced_within_tolerance?(current, next, lower, upper) do
    distance = circle_mod(next - current)
    distance >= lower and distance <= upper
  end

  @doc """
  Returns a list of points on a circle where each point has been shifted
  sequentially to exactly between its surrounding two points.
  """
  def step(points) when length(points) < 2, do: points
  def step(points), do: _step(points, 0)

  defp _step(points, index) when index == length(points), do: points
  defp _step(points, index), do: _step(step_single_point(points, index), index + 1)

  @doc """
  Returns a list of points on a circle where the point at the specified index
  has been moved to exactly between the two surrounding points.
  """
  def step_single_point(points, index) do
    new_value = reposition(Enum.at(points, index - 1),
                           Enum.at(points, rem(index + 1,
                                               Enum.count(points))))
    replace_at(points, index, new_value)
  end

  @doc """
  Returns the location in degrees half-way between the first and last parameters
  on a circle.
  """
  def reposition(first, last) when first < last, do: (first + last) / 2
  def reposition(first, last), do: circle_mod(reposition(first, last + 360))

  @doc """
  Returns a degree value that is between 0 and 360 from a degree value that may
  be outside that range. Equivalent to rem(n, 360) but can accept floats.
  """
  def circle_mod(n) when n < 0, do: circle_mod(n + 360)
  def circle_mod(n) when n >= 360, do: circle_mod(n - 360)
  def circle_mod(n), do: n

  @doc """
  Returns a list with the value at index in list with value.
  Equivalent to Enum.replace_at, but rewritten for fun.
  """
  def replace_at(list, index, value), do: _replace_at(list, index, 0, value)

  defp _replace_at([_|rest], same, same, value), do: [value] ++ rest
  defp _replace_at([first | rest], index, position, value) do
    [first] ++ _replace_at(rest, index, position + 1, value)
  end

end
