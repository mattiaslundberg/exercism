defmodule Garden do
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @default_names [
    :alice,
    :bob,
    :charlie,
    :david,
    :eve,
    :fred,
    :ginny,
    :harriet,
    :ileana,
    :joseph,
    :kincaid,
    :larry
  ]

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @default_names) do
    plant_lists =
      info_string
      |> String.split("\n")
      |> List.to_tuple()

    student_names
    |> Enum.sort()
    |> Enum.reduce({plant_lists, %{}}, fn name, {{r1, r2}, res} ->
      {plants1, rem1} = String.split_at(r1, 2)
      {plants2, rem2} = String.split_at(r2, 2)
      {{rem1, rem2}, Map.put(res, name, translate_str(plants1 <> plants2))}
    end)
    |> elem(1)
  end

  defp translate_str(str) do
    str
    |> String.split("", trim: true)
    |> Enum.map(&translate/1)
    |> List.to_tuple()
  end

  defp translate("R"), do: :radishes
  defp translate("C"), do: :clover
  defp translate("G"), do: :grass
  defp translate("V"), do: :violets
end
