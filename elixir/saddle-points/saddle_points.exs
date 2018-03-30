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
    for {r, n1} <- row_max(str),
        {c, n2} <- col_min(str),
        n1 == n2 do
      {r, c}
    end
  end

  defp row_max(str) do
    str
    |> rows()
    |> Enum.with_index()
    |> Enum.map(fn {row, idx} -> {idx, Enum.max(row)} end)
  end

  defp col_min(str) do
    str
    |> columns()
    |> Enum.with_index()
    |> Enum.map(fn {row, idx} -> {idx, Enum.min(row)} end)
  end
end
