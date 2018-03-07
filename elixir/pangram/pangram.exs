defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @letters "abcdefghijklmnopqrstuvxyz"

  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence) do
    used_letters =
      sentence
      |> String.downcase()
      |> String.split("", trim: true)

    unused_letters =
      @letters
      |> String.split("", trim: true)
      |> Enum.reject(&(&1 in used_letters))

    length(unused_letters) == 0
  end
end
