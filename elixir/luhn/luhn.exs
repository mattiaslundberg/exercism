defmodule Luhn do
  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    number
    |> String.replace(" ", "")
    |> String.split("", trim: true)
    |> to_integers()
    |> list_valid?()
  end

  def list_valid?(number) when length(number) > 1 do
    number
    |> Enum.with_index()
    |> Enum.reduce(0, &do_validate/2)
    |> rem(10) == 0
  end

  def list_valid?(_), do: false

  def to_integers(str_list) do
    str_list
    |> Enum.reduce_while([], fn c, acc ->
      case Integer.parse(c) do
        {i, ""} -> {:cont, [i | acc]}
        _ -> {:halt, []}
      end
    end)
  end

  defp do_validate({n, i}, sum) do
    if rem(i, 2) != 0 do
      if n > 4 do
        sum + n * 2 - 9
      else
        sum + n * 2
      end
    else
      sum + n
    end
  end
end
