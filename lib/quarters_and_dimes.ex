defmodule QuartersAndDimes do
  def step(points) do
    []
  end

  def step_single_point(points, index) do
    new_value = reposition(Enum.at(points, index - 1),
                           Enum.at(points, rem(index + 1,
                                               Enum.count(points))))
    replace_at(points, index, 0, new_value)
  end

  def reposition(first, last) do
    if first < last do
      (first + last) / 2
    else
      circle_mod(reposition(first, last + 360))
    end
  end

  def circle_mod(n) do
    cond do
      n < 0 -> circle_mod(n + 360)
      n >= 360 -> circle_mod(n - 360)
      true -> n
    end
  end

  def replace_at(list, index, position, replace_value) do
    if position == index do
      [old | rest] = list
      [replace_value] ++ rest
    else
      [first | rest] = list
      [first] ++ replace_at(rest, index, position + 1, replace_value)
    end

  end

end