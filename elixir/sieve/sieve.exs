defmodule Sieve do
  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) do
    Enum.filter(2..limit, &prime?/1)
  end

  defp prime?(number) when number <= 1, do: false
  defp prime?(2), do: true

  defp prime?(number) do
    limit = :math.sqrt(number) |> round

    2..limit
    |> Enum.filter(fn x -> rem(number, x) == 0 end)
    |> Enum.empty?()
  end
end
