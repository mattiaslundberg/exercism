defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(l, size) do
    case String.next_grapheme(l) do
      {h, t} ->
        case head(l, size) do
          "" ->
            slices(t, size)

          v ->
            [v | slices(t, size)]
        end

      _ ->
        []
    end
  end

  def head(_, size) when size <= 0, do: ""

  def head(l, size) do
    if String.length(l) >= size do
      case String.next_grapheme(l) do
        {h, t} ->
          h <> head(t, size - 1)

        nil ->
          ""
      end
    else
      ""
    end
  end
end
