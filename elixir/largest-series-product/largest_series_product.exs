defmodule Series do
  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t(), non_neg_integer) :: non_neg_integer
  def largest_product(number_string, size) do
    calculate_product(parse_number_string(number_string), size)
  end

  defp calculate_product(numbers, size) when size < 0 or length(numbers) < size,
    do: raise(ArgumentError)

  defp calculate_product(numbers, size) do
    0..length(numbers)
    |> Enum.reject(fn i -> i > length(numbers) - size end)
    |> Enum.reduce(0, fn i, res ->
      max(res, multiply_next(numbers, i, size))
    end)
  end

  defp parse_number_string(number_string) do
    number_string
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  defp multiply_next(_, _, 0), do: 1

  defp multiply_next(numbers, i, size) do
    Enum.at(numbers, i) * multiply_next(numbers, i + 1, size - 1)
  end
end
