defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(map) :: map
  def transform(input) do
    input
    |> Enum.reduce(%{}, fn {k, v}, acc ->
      Enum.reduce(v, acc, fn n, a ->
        Map.put(a, String.downcase(n), k)
      end)
    end)
  end
end
