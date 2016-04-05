defmodule QuartersAndDimes do

  def equidistant?(points, tolerance) do
    correct_distance = 360 / length(points)
    lower = correct_distance - tolerance
    upper = correct_distance + tolerance

    equidistant?(points, 0, lower, upper)
  end

  def equidistant?(points, index, lower, upper) when length(points) == index, do: true

  def equidistant?(points, index, lower, upper) do
    first = Enum.at(points, index - 1)
    second = Enum.at(points, index)
    distance = circle_mod(second - first)
    cond do
      distance < lower -> false
      distance > upper -> false
      true -> equidistant?(points, index + 1, lower, upper)
    end
  end

  def step(points) when length(points) < 2, do: points
  def step(points), do: step(points, 0)

  def step(points, index) when index == length(points), do: points

  def step(points, index) do
    step(step_single_point(points, index), index + 1)
  end

  def step_single_point(points, index) do
    new_value = reposition(Enum.at(points, index - 1),
                           Enum.at(points, rem(index + 1,
                                               Enum.count(points))))
    replace_at(points, index, new_value)
  end

  def reposition(first, last) do
    if first < last do
      (first + last) / 2
    else
      circle_mod(reposition(first, last + 360))
    end
  end

  def circle_mod(n) when n < 0, do: circle_mod(n + 360)
  def circle_mod(n) when n >= 360, do: circle_mod(n - 360)
  def circle_mod(n), do: n

  def replace_at(list, index, value), do: replace_at(list, index, 0, value)

  def replace_at([_|rest], index, position, value) when position == index do
    [value] ++ rest
  end

  def replace_at([first | rest], index, position, value) do
    [first] ++ replace_at(rest, index, position + 1, value)
  end

end
