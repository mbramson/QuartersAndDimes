defmodule QuartersAndDimes do
  def step(points) do
    []
  end

  def reposition(first, last) do
    if first < last do
      (first + last) / 2
    else
      n = reposition(first, last + 360)
      if n >= 360 do
        n = n - 360
      end
      n
    end
  end

  def circle_mod(n) do
    cond do
      n < 0 -> circle_mod(n + 360)
      n >= 360 -> circle_mod(n - 360)
      true -> n
    end
  end

end
