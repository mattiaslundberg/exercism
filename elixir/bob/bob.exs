defmodule Bob do
  def hey(input) do
    cond do
      is_silence?(input) -> "Fine. Be that way!"
      is_question?(input) -> "Sure."
      is_shouting?(input) -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end

  def is_question?(input) do
    String.ends_with?(input, "?")
  end

  def is_shouting?(input) do
    !Regex.match?(~r/^[0-9\ ,]*$/, input) and input == String.upcase(input)
  end

  def is_silence?(""), do: true
  def is_silence?(" " <> r), do: is_silence?(r)
  def is_silence?(_), do: false
end
