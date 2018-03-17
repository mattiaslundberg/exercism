defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t()], pos_integer) :: map
  def frequency(texts, workers) do
    texts
    |> Task.async_stream(__MODULE__, :analyze, [], max_concurrency: workers)
    |> Enum.reduce(%{}, fn {:ok, map}, acc ->
      Map.merge(map, acc, fn _, v1, v2 -> v1 + v2 end)
    end)
  end

  def analyze(text) do
    text
    |> String.downcase()
    |> (&Regex.replace(~r/[ ,.\d]/, &1, "")).()
    |> String.split("", trim: true)
    |> Enum.reduce(%{}, fn c, acc ->
      Map.update(acc, c, 1, fn e -> e + 1 end)
    end)
  end
end
