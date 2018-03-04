defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.replace(~r/[^\p{L}\d-]/iu, " ")
    |> String.downcase()
    |> String.split(" ", trim: true)
    |> Enum.reduce(%{}, fn w, acc -> Map.update(acc, w, 1, &(&1 + 1)) end)
  end
end
