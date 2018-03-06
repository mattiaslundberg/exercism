defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      a === b ->
        :equal

      length(a) == length(b) and a !== b ->
        :unequal

      sublist?(b, a) ->
        :sublist

      sublist?(a, b) ->
        :superlist

      true ->
        :unequal
    end
  end

  defp sublist?(_, []), do: true
  defp sublist?([], _), do: false

  defp sublist?(a = [h | r], b) do
    if h === hd(b) and Enum.take(a, Enum.count(b)) == b do
      true
    else
      sublist?(r, b)
    end
  end
end
