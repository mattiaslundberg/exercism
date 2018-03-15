defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: pos_integer
  def square(1), do: {:ok, 1}

  def square(number) when number in 1..64 do
    {:ok, n} = square(number - 1)
    {:ok, 2 * n}
  end

  def square(_), do: {:error, "The requested square must be between 1 and 64 (inclusive)"}

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total do
    {:ok,
     1..64
     |> Enum.map(&square/1)
     |> Enum.reduce(0, fn {:ok, n}, acc -> acc + n end)}
  end
end
