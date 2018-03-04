defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    Regex.replace(~r/(\p{L}| )(\1{1,})/u, string, fn all, char ->
      Integer.to_string(String.length(all)) <> char
    end)
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    Regex.replace(~r/(\d+)(\p{L}| )/u, string, fn _, count, char ->
      String.duplicate(char, String.to_integer(count))
    end)
  end
end
