defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    number
    |> get_factors(2, [])
    |> Enum.reverse()
  end

  defp get_factors(n, _, factors) when n <= 1, do: factors

  defp get_factors(number, next, factors) do
    if Integer.mod(number, next) == 0 do
      get_factors(div(number, next), next, [next | factors])
    else
      get_factors(number, next + 1, factors)
    end
  end
end
