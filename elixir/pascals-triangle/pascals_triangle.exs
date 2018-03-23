defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(1), do: [[1]]

  def rows(n) do
    prev = rows(n - 1)
    last = List.last(prev) ++ [0]

    new =
      last
      |> Enum.reduce({0, []}, fn x, {p, acc} ->
        {x, acc ++ [x + p]}
      end)
      |> elem(1)

    prev ++ [new]
  end
end
