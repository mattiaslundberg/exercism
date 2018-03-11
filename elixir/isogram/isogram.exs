defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    sentence
    |> String.downcase()
    |> (&Regex.replace(~r/[^a-z]/, &1, "")).()
    |> String.to_charlist()
    |> Enum.reduce_while([], fn c, acc ->
      if c in acc do
        {:halt, []}
      else
        {:cont, [c | acc]}
      end
    end)
    |> (&(length(&1) > 0)).()
  end
end
