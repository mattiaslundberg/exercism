defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    1..(limit - 1)
    |> Enum.reject(&(not has_factor(&1, factors)))
    |> Enum.reduce(0, fn x, acc -> x + acc end)
  end

  defp has_factor(x, factors) do
    Enum.any?(factors, &(Integer.mod(x, &1) == 0))
  end
end
