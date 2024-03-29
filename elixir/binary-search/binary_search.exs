defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key) do
    do_search(numbers, key, 0, tuple_size(numbers) - 1)
  end

  defp do_search(n, _, l, h) when tuple_size(n) == 0 or l > h, do: :not_found

  defp do_search(numbers, key, low, high) do
    guess = div(low + high, 2)
    current_value = elem(numbers, guess)

    cond do
      current_value == key ->
        {:ok, guess}

      current_value > key ->
        do_search(numbers, key, low, guess - 1)

      current_value < key ->
        do_search(numbers, key, guess + 1, high)
    end
  end
end
