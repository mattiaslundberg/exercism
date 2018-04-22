defmodule Wordy do
  @doc """
  Calculate the math problem in the sentence.
  """
  @spec answer(String.t()) :: integer
  def answer("What is " <> question) do
    question
    |> String.slice(0..-2)
    |> String.replace("by", "")
    |> String.split()
    |> Enum.map(&parse_part/1)
    |> Enum.reduce({&Kernel.+/2, 0}, &combine/2)
    |> elem(1)
  end

  def answer(_) do
    raise ArgumentError
  end

  defp parse_part(x) do
    case x do
      "plus" -> &Kernel.+/2
      "minus" -> &Kernel.-/2
      "multiplied" -> &Kernel.*/2
      "divided" -> &Kernel.//2
      _ -> String.to_integer(x)
    end
  end

  defp combine(x, {op, acc}) when is_integer(x), do: {op, op.(acc, x)}
  defp combine(x, {_, acc}), do: {x, acc}
end
