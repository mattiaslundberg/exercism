defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split(" ")
    |> Enum.map(&trans(&1))
    |> Enum.join(" ")
  end

  defp trans(s = "e" <> _), do: add_ay(s)
  defp trans(s = "i" <> _), do: add_ay(s)
  defp trans(s = "o" <> _), do: add_ay(s)
  defp trans(s = "u" <> _), do: add_ay(s)
  defp trans("ch" <> rst), do: rst <> "chay"
  defp trans("qu" <> rst), do: rst <> "quay"
  defp trans("squ" <> rst), do: rst <> "squay"
  defp trans("thr" <> rst), do: rst <> "thray"
  defp trans("th" <> rst), do: rst <> "thay"
  defp trans("sch" <> rst), do: rst <> "schay"
  defp trans("y" <> rst), do: trans_xy("y", rst)
  defp trans("x" <> rst), do: trans_xy("x", rst)

  defp trans(phr) do
    {start, rst} =
      phr
      |> String.graphemes()
      |> Enum.split_while(&is_consonant(&1))

    add_ay(Enum.join(rst ++ start))
  end

  def is_consonant(chr), do: !is_vowel(chr)

  def is_vowel("a"), do: true
  def is_vowel("e"), do: true
  def is_vowel("i"), do: true
  def is_vowel("o"), do: true
  def is_vowel("u"), do: true
  def is_vowel(_), do: false

  def add_ay(s), do: s <> "ay"

  defp trans_xy(xy, s) do
    if s |> String.first() |> is_consonant do
      add_ay(xy <> s)
    else
      add_ay(s <> xy)
    end
  end
end
