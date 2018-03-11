defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance(a, b) when length(a) != length(b) do
    {:error, "Lists must be the same length"}
  end

  def hamming_distance('', ''), do: {:ok, 0}

  def hamming_distance([a | r1], [a | r2]) do
    hamming_distance(r1, r2)
  end

  def hamming_distance([_ | r1], [_ | r2]) do
    {:ok, prev} = hamming_distance(r1, r2)
    {:ok, prev + 1}
  end
end
