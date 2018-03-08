defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    b = to_downcase_list(base)

    Enum.filter(candidates, &anagram?(b, to_downcase_list(&1)))
  end

  def to_downcase_list(s) do
    s |> String.downcase() |> String.split("", trim: true)
  end

  def anagram?(a, b) when a == b or length(a) != length(b), do: false

  def anagram?(a, b), do: Enum.sort(a) == Enum.sort(b)
end
