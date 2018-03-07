defmodule Scrabble do
  @points %{
    "d" => 2,
    "g" => 2,
    "b" => 3,
    "c" => 3,
    "m" => 3,
    "p" => 3,
    "f" => 4,
    "h" => 4,
    "v" => 4,
    "w" => 4,
    "y" => 4,
    "k" => 5,
    "j" => 8,
    "x" => 8,
    "q" => 10,
    "z" => 10
  }
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    Regex.replace(~r/\s/, word, "")
    |> String.downcase()
    |> String.split("", trim: true)
    |> Enum.reduce(0, fn x, acc -> acc + Map.get(@points, x, 1) end)
  end
end
