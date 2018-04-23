defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t()) :: String.t()
  def encode(plaintext) do
    plaintext
    |> String.downcase()
    |> (&Regex.replace(~r/[,\ .]+/, &1, "")).()
    |> String.split("", trim: true)
    |> Enum.map(&cipher_char/1)
    |> Enum.chunk_every(5)
    |> Enum.map(&Enum.join(&1, ""))
    |> Enum.join(" ")
  end

  @spec decode(String.t()) :: String.t()
  def decode(cipher) do
    cipher
    |> (&Regex.replace(~r/[,\ .]+/, &1, "")).()
    |> String.split("", trim: true)
    |> Enum.map(&cipher_char/1)
    |> Enum.join("")
  end

  defp cipher_char(<<c>>) do
    if c in ?a..?z do
      <<?z - (c - ?a)>>
    else
      <<c>>
    end
  end
end
