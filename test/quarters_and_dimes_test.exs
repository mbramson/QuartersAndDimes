import QuartersAndDimes

defmodule QuartersAndDimesTest do
  use ExUnit.Case
  doctest QuartersAndDimes

  # step tests

  test "that step returns a list" do
    assert is_list step []
  end

  test "that step returns same list when all are equidistant" do
    assert step([0, 90, 180, 270]) == [0, 90, 180, 270]
  end

  test "that step iterates through 3 item list once" do
    assert step([0, 0, 0]) == [180, 270, 45]
  end

  test "that step iterations through 4 item list once" do
    assert step([0, 0, 0, 0]) == [180, 270, 315, 67.5]
  end

  test "that step makes equidistant 4 items for [45, 90, 180, 270]" do
    assert step([45, 90, 180, 270]) == [0, 90, 180, 270]
  end

  test "that two sequential steps gives correct list for 4-identity points" do
    assert step([0, 90, 180, 270]) |> step == [0, 90, 180, 270]
  end

  # equidistant? tests

  test "that equidistant? returns true for 4-identity" do
    assert equidistant?([0, 90, 180, 270], 1)
  end

  test "that equidistant? returns false for non-equidistant points" do
    assert !equidistant?([1, 2, 3], 1)
  end

  test "that equidistant? returns true within tolerance" do
    assert equidistant?([0, 120, 235], 10)
  end

  test "that equidistant? returns true with only two points" do
    assert equidistant?([0, 180], 1)
  end

  # step_single_point tests

  test "that step_single_point alters middle point correctly for [1, 2, 5]" do
    assert step_single_point([1, 2, 5], 1) == [1, 3, 5]
  end

  test "that step_single_point alters middle point correctly for [0, 5, 6]" do
    assert step_single_point([0, 5, 6], 1) == [0, 3, 6]
  end

  test "that step_single_point alterst third point correctlry for [1, 2, 7, 8]" do
    assert step_single_point([1, 2, 7, 8], 2) == [1, 2, 5, 8]
  end

  test "that step_single_point alters first point with wrapping at beginning" do
    assert step_single_point([10, 20, 30], 0) == [205, 20, 30]
  end

  test "that step_single_point alters last point with wrapping at end" do
    assert step_single_point([10, 20, 30], 2) == [10, 20, 195]
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

  test "that reposition returns a decimal point between 10 and 15" do
    assert reposition(10, 15) == 12.5
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

  # replace_at tests
  test " that replace_at replaces first value" do
    assert replace_at([1,3], 0, 2) == [2, 3]
  end

  test "that replace_at replaces second value" do
    assert replace_at([1, 2, 4], 1, 3) == [1, 3, 4]
  end

  test "that replace_at can replace last value" do
    assert replace_at([1,2], 1, 3) == [1, 3]
  end

end
