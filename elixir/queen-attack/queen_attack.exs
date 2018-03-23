defmodule Queens do
  @type t :: %Queens{black: {integer, integer}, white: {integer, integer}}
  defstruct black: nil, white: nil

  @doc """
  Creates a new set of Queens
  """
  @spec new() :: Queens.t()
  @spec new({integer, integer}, {integer, integer}) :: Queens.t()
  def new(white \\ {0, 3}, black \\ {7, 3})
  def new(loc, loc), do: raise(ArgumentError)

  def new(white, black) do
    %Queens{
      black: black,
      white: white
    }
  end

  @doc """
  Gives a string reprentation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(%Queens{white: white, black: black}) do
    0..7
    |> Enum.map(fn y ->
      0..7
      |> Enum.map(&symbol_for_loc({y, &1}, white, black))
      |> Enum.join(" ")
    end)
    |> Enum.join("\n")
  end

  defp symbol_for_loc({x, y}, {x, y}, {_, _}), do: "W"
  defp symbol_for_loc({x, y}, {_, _}, {x, y}), do: "B"
  defp symbol_for_loc(_, _, _), do: "_"

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(%Queens{white: {x, _}, black: {x, _}}), do: true
  def can_attack?(%Queens{white: {_, y}, black: {_, y}}), do: true

  def can_attack?(%Queens{white: {wx, wy}, black: {bx, by}}) do
    abs(wx - bx) == abs(wy - by)
  end
end
