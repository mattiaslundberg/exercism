defmodule BracketPush do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    unmatched =
      str
      |> String.split("", trim: true)
      |> Enum.reduce_while([], &check_bracket/2)

    length(unmatched) == 0
  end

  defp check_bracket(chr, acc) do
    cond do
      chr == "{" ->
        {:cont, ["}" | acc]}

      chr == "[" ->
        {:cont, ["]" | acc]}

      chr == "(" ->
        {:cont, [")" | acc]}

      chr in ["}", "]", ")"] and chr == List.first(acc) ->
        {_, tail} = List.pop_at(acc, 0)
        {:cont, tail}

      chr in ["}", "]", ")"] ->
        {:halt, ["X"]}

      true ->
        {:cont, acc}
    end
  end
end
