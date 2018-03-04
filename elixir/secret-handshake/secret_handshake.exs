defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(n) when n >= 16, do: Enum.reverse(commands(n - 16))
  def commands(n) when n >= 8, do: commands(n - 8) ++ ["jump"]
  def commands(n) when n >= 4, do: commands(n - 4) ++ ["close your eyes"]
  def commands(n) when n >= 2, do: commands(n - 2) ++ ["double blink"]
  def commands(n) when n >= 1, do: commands(n - 1) ++ ["wink"]
  def commands(_), do: []
end
