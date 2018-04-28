defmodule SimpleCipher do
  @doc """
  Given a `plaintext` and `key`, encode each character of the `plaintext` by
  shifting it by the corresponding letter in the alphabet shifted by the number
  of letters represented by the `key` character, repeating the `key` if it is
  shorter than the `plaintext`.

  For example, for the letter 'd', the alphabet is rotated to become:

  defghijklmnopqrstuvwxyzabc

  You would encode the `plaintext` by taking the current letter and mapping it
  to the letter in the same position in this rotated alphabet.

  abcdefghijklmnopqrstuvwxyz
  defghijklmnopqrstuvwxyzabc

  "a" becomes "d", "t" becomes "w", etc...

  Each letter in the `plaintext` will be encoded with the alphabet of the `key`
  character in the same position. If the `key` is shorter than the `plaintext`,
  repeat the `key`.

  Example:

  plaintext = "testing"
  key = "abc"

  The key should repeat to become the same length as the text, becoming
  "abcabca". If the key is longer than the text, only use as many letters of it
  as are necessary.
  """
  def encode(plaintext, key) do
    plaintext
    |> String.split("", trim: true)
    |> Enum.zip(repeat_key(key, String.length(plaintext)))
    |> Enum.map(&encode_with/1)
    |> Enum.join("")
  end

  defp encode_with({<<p>>, t}) when p not in ?a..?z, do: <<p>>

  defp encode_with({<<p>>, t}), do: <<Integer.mod(t - 2 * ?a + p, 26) + ?a>>

  @doc """
  Given a `ciphertext` and `key`, decode each character of the `ciphertext` by
  finding the corresponding letter in the alphabet shifted by the number of
  letters represented by the `key` character, repeating the `key` if it is
  shorter than the `ciphertext`.

  The same rules for key length and shifted alphabets apply as in `encode/2`,
  but you will go the opposite way, so "d" becomes "a", "w" becomes "t",
  etc..., depending on how much you shift the alphabet.
  """
  def decode(ciphertext, key) do
    ciphertext
    |> String.split("", trim: true)
    |> Enum.zip(repeat_key(key, String.length(ciphertext)))
    |> Enum.map(&decode_with/1)
    |> Enum.join("")
  end

  defp decode_with({<<c>>, t}) when c not in ?a..?z, do: <<c>>
  defp decode_with({<<c>>, t}), do: <<Integer.mod(t - c, 26) + ?a>>

  defp repeat_key(key, len) do
    key
    |> String.duplicate(len)
    |> String.split("", trim: true)
    |> Enum.map(fn <<k>> -> k end)
  end
end
