if !System.get_env("EXERCISM_TEST_EXAMPLES") do
  Code.load_file("diamond.exs", __DIR__)
end

ExUnit.start()
ExUnit.configure(exclude: :pending, trace: true)

defmodule DiamondTest do
  use ExUnit.Case

  test "letter A" do
    shape = Diamond.build_shape(?A)
    assert shape == "A\n"
  end

  test "letter B" do
    shape = Diamond.build_shape(?B)

    assert shape == """
           \sA\s
           B B
           \sA\s
           """
  end

  test "letter C" do
    shape = Diamond.build_shape(?C)

    assert shape == """
           \s A \s
           \sB B\s
           C   C
           \sB B\s
           \s A \s
           """
  end

  test "letter E" do
    shape = Diamond.build_shape(?E)

    assert shape == """
           \s   A   \s
           \s  B B  \s
           \s C   C \s
           \sD     D\s
           E       E
           \sD     D\s
           \s C   C \s
           \s  B B  \s
           \s   A   \s
           """
  end
end
