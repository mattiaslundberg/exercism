defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t()
  def build_shape(char) do
    to_keep = build_keep(char)

    shape =
      char
      |> build_rows()
      |> Enum.zip(to_keep)
      |> Enum.map_join("\n", fn {row, keep} ->
        Regex.replace(~r/[^#{<<keep>>}]/, to_string(row), " ")
      end)

    shape <> "\n"
  end

  def build_rows(char), do: List.duplicate(build_row(char), (char - ?A) * 2 + 1)

  def build_row(?A), do: [?A]
  def build_row(char), do: Enum.concat(char..?A, ?B..char)

  def build_keep(?A), do: [?A]
  def build_keep(char), do: Enum.concat(?A..char, (char - 1)..?A)
end
