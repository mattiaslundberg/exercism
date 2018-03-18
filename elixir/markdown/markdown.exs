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
    markdown
    |> String.split("\n")
    |> Enum.reduce({false, ""}, &process/2)
    |> (&(elem(&1, 1) <> close_tag(elem(&1, 0)))).()
  end

  defp process(r = "#" <> _, {in_list, res}) do
    [_, h, l] = Regex.run(~r/(#+) (.+)/, r)
    level = String.length(h)

    {false, res <> close_tag(in_list) <> "<h#{level}>#{l}</h#{level}>"}
  end

  defp process("* " <> r, {in_list, res}) do
    {true, res <> open_tag(in_list) <> "<li>" <> process_text(r) <> "</li>"}
  end

  defp process(t, {in_list, res}) do
    {false, res <> close_tag(in_list) <> "<p>#{process_text(t)}</p>"}
  end

  defp process_text(t) do
    t
    |> (&Regex.replace(~r/__(.*)__/, &1, "<strong>\\1</strong>")).()
    |> (&Regex.replace(~r/_(.*)_/, &1, "<em>\\1</em>")).()
  end

  defp close_tag(true), do: "</ul>"
  defp close_tag(false), do: ""

  defp open_tag(false), do: "<ul>"
  defp open_tag(true), do: ""
end
