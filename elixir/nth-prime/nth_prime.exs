defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when is_integer(count) and count > 0 do
    {:ok, r} =
      0..1_000
      |> Enum.filter(&prime?/1)
      |> Enum.fetch(count - 1)

    r
  end

  defp prime?(number) when number <= 1, do: false
  defp prime?(2), do: true

  defp prime?(number) do
    limit = :math.sqrt(number) |> round

    2..limit
    |> Enum.filter(fn x -> rem(number, x) == 0 end)
    |> Enum.empty?()
  end
end
