import QuartersAndDimes

defmodule QuartersAndDimesTest do
  use ExUnit.Case
  doctest QuartersAndDimes

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "that step returns a list" do
    assert is_list step []
  end

  # reposition tests

  test "that reposition returns a point between two points" do
    assert reposition(3, 7) == 5
  end

  test "that reposition returns a point between two points and wraps" do
    assert reposition(270, 10) == 320
  end

  test "that reposition returns a point between 359 and 1" do
    assert reposition(359, 1) == 0
  end

  # float_mod tests

  test "that circle_mod returns same number if less than 360" do
    assert circle_mod(200) == 200
  end

  test "that circle_mod returns number minus 360" do
    assert circle_mod(460) == 100
  end

  test "that circle_mod returns number less than 360 for large n" do
    assert circle_mod(820) == 100
  end

  test "that circle_mod returns number between 0 and 360 when negative" do
    assert circle_mod(-90) == 270
  end

end
