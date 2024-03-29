defmodule Hexadecimal do
  @doc """
    Accept a string representing a hexadecimal value and returns the
    corresponding decimal value.
    It returns the integer 0 if the hexadecimal is invalid.
    Otherwise returns an integer representing the decimal value.

    ## Examples

      iex> Hexadecimal.to_decimal("invalid")
      0

      iex> Hexadecimal.to_decimal("af")
      175

  """

  @spec to_decimal(binary) :: integer
  def to_decimal(hex) do
    hex
    |> String.downcase()
    |> String.split("", trim: true)
    |> Enum.reverse()
    |> Enum.reduce_while({0, 1}, fn x, {res, mult} ->
      case value(x) do
        :error -> {:halt, {0, 0}}
        v -> {:cont, {res + v * mult, mult * 16}}
      end
    end)
    |> elem(0)
  end

  defp value(str) do
    case str do
      "0" -> 0
      "1" -> 1
      "2" -> 2
      "3" -> 3
      "4" -> 4
      "5" -> 5
      "6" -> 6
      "7" -> 7
      "8" -> 8
      "9" -> 9
      "a" -> 10
      "b" -> 11
      "c" -> 12
      "d" -> 13
      "e" -> 14
      "f" -> 15
      _ -> :error
    end
  end
end
