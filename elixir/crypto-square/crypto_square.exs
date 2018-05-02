defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t()) :: String.t()
  def encode(str) do
    chars = normalize(str)
    size = length(chars) / 2
    c = trunc(Float.ceil(size))
    r = trunc(Float.floor(size))

    0..c
    |> Enum.reduce({[], chars}, fn col, {res, l} ->
      new_chars = Enum.take_every(l, r) |> Enum.join("")

      {_, next_l} = List.pop_at(l, 1)

      {[new_chars | res], next_l}
    end)
    |> elem(0)
    |> Enum.reverse()
    |> Enum.join(" ")
  end

  defp normalize(str) do
    str
    |> String.downcase()
    |> (&Regex.replace(~r/^[a-z]/, &1, "")).()
    |> String.split("", trim: true)
  end
end
