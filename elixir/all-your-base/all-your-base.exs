defmodule AllYourBase do
  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: list
  def convert([], _, _), do: nil
  def convert(_, a, b) when a < 2 or b < 2, do: nil

  def convert(digits, from_base, to_base) do
    digits
    |> List.foldr({from_base, 0, 1}, &parse/2)
    |> to_list(to_base, [])
  end

  defp parse(_, :error), do: :error
  defp parse(d, {base, _, _}) when d < 0 or d >= base, do: :error
  defp parse(d, {base, t, f}), do: {base, t + d * f, f * base}

  defp to_list(:error, _, _), do: nil
  defp to_list({_, num, _}, base, acc), do: to_list(num, base, acc)
  defp to_list(0, _, []), do: [0]
  defp to_list(0, _, l), do: l

  defp to_list(num, base, acc) do
    to_list(div(num, base), base, [rem(num, base) | acc])
  end
end
