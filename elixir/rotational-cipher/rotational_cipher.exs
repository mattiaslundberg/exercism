defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(<<char>> <> rest, shift) when char < 65, do: <<char>> <> rotate(rest, shift)
  def rotate(<<char>> <> rest, 0), do: <<char>> <> rotate(rest, 0)
  def rotate(<<?Z>> <> rest, shift), do: rotate(<<?A>>, shift - 1) <> rotate(rest, shift)
  def rotate(<<?z>> <> rest, shift), do: rotate(<<?a>>, shift - 1) <> rotate(rest, shift)
  def rotate(<<char>> <> rest, shift), do: rotate(<<char + 1>>, shift - 1) <> rotate(rest, shift)
  def rotate(_, _), do: ""
end
