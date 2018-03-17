defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(markdown) do
    res =
      markdown
      |> String.split("\n")
      |> Enum.reduce({false, ""}, &process/2)

    case res do
      {false, r} -> r
      {true, r} -> r <> "</ul>"
    end
  end

  defp process(r = "#" <> _, {in_list, res}) do
    [_, h, l] = Regex.run(~r/(#+) (.+)/, r)
    level = String.length(h)

    {false, res <> close_tag(in_list) <> "<h#{level}>#{l}</h#{level}>"}
  end

  defp process("* " <> r, {in_list, res}) do
    {true, res <> open_tag(in_list) <> "<li>" <> process_row(r) <> "</li>"}
  end

  defp process(t, {in_list, res}) do
    {false, res <> close_tag(in_list) <> "<p>#{process_row(t)}</p>"}
  end

  defp process_row(t) do
    t
    |> String.split(" ")
    |> IO.inspect()
    |> Enum.map(&replace_md_with_tag/1)
    |> Enum.join(" ")
  end

  defp replace_md_with_tag(w) do
    replace_suffix_md(replace_prefix_md(w))
  end

  defp replace_prefix_md(w) do
    cond do
      w =~ ~r/^#{"__"}{1}/ -> String.replace(w, ~r/^#{"__"}{1}/, "<strong>", global: false)
      w =~ ~r/^[#{"_"}{1}][^#{"_"}+]/ -> String.replace(w, ~r/_/, "<em>", global: false)
      true -> w
    end
  end

  defp replace_suffix_md(w) do
    cond do
      w =~ ~r/#{"__"}{1}$/ -> String.replace(w, ~r/#{"__"}{1}$/, "</strong>")
      w =~ ~r/[^#{"_"}{1}]/ -> String.replace(w, ~r/_/, "</em>")
      true -> w
    end
  end

  defp close_tag(true), do: "</ul>"
  defp close_tag(false), do: ""

  defp open_tag(false), do: "<ul>"
  defp open_tag(true), do: ""
end
