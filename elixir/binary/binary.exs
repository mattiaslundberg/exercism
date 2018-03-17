defmodule Binary do
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t()) :: non_neg_integer
  def to_decimal(string) do
    string
    |> String.split("", trim: true)
    |> Enum.reverse()
    |> Enum.reduce_while({1, 0}, fn c, {mult, tot} ->
      case c do
        "0" ->
          {:cont, {mult * 2, tot}}

        "1" ->
          {:cont, {mult * 2, tot + mult}}

        _ ->
          {:halt, {nil, 0}}
      end
    end)
    |> elem(1)
  end
end
