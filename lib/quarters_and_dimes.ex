defmodule QuartersAndDimes do

  def equidistant?(points, tolerance) do
    correct_distance = 360 / length(points)

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

  def step(points) when length(points) < 2, do: points
  def step(points), do: _step(points, 0)

  defp _step(points, index) when index == length(points), do: points
  defp _step(points, index), do: _step(step_single_point(points, index), index + 1)

  def step_single_point(points, index) do
    new_value = reposition(Enum.at(points, index - 1),
                           Enum.at(points, rem(index + 1,
                                               Enum.count(points))))
    replace_at(points, index, new_value)
  end

  def reposition(first, last) when first < last, do: (first + last) / 2
  def reposition(first, last), do: circle_mod(reposition(first, last + 360))

  def circle_mod(n) when n < 0, do: circle_mod(n + 360)
  def circle_mod(n) when n >= 360, do: circle_mod(n - 360)
  def circle_mod(n), do: n

  def replace_at(list, index, value), do: _replace_at(list, index, 0, value)

  defp _replace_at([_|rest], index, position, value) when position == index do
    [value] ++ rest
  end

  defp _replace_at([first | rest], index, position, value) do
    [first] ++ _replace_at(rest, index, position + 1, value)
  end

end
