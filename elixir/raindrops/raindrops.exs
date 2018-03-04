defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(n) do
    s = handle(n, 3, "Pling") <> handle(n, 5, "Plang") <> handle(n, 7, "Plong")

    case s do
      "" -> Integer.to_string(n)
      v -> v
    end
  end

  def handle(n, d, s) do
    case Integer.mod(n, d) do
      0 -> s
      _ -> ""
    end
  end
end
