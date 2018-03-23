defmodule SaddlePoints do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(str) do
    str
    |> String.split("\n", trim: true)
    |> Enum.map(fn r ->
      r |> String.split(" ", trim: true) |> Enum.map(&String.to_integer/1)
    end)
  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str) do
    str
    |> rows
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(str) do
    rs = rows(str)
    cs = columns(str)

    rs
    |> Enum.with_index()
    |> Enum.reduce({[], 0}, fn {id, v}, {r_ids, val} ->
      cond do
        v == val -> {[id | r_ids], v}
        v > val -> {r_ids, v}
        true -> {r_ids, val}
      end
    end)
  end
end
