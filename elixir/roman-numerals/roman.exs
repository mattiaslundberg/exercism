defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t()
  def numerals(n) when n >= 1000 do
    "M" <> numerals(n - 1000)
  end

  def numerals(n) when n >= 900 do
    "CM" <> numerals(n - 900)
  end

  def numerals(n) when n >= 500 do
    "D" <> numerals(n - 500)
  end

  def numerals(n) when n >= 400 do
    "CD" <> numerals(n - 400)
  end

  def numerals(n) when n >= 100 do
    "C" <> numerals(n - 100)
  end

  def numerals(n) when n >= 90 do
    "XC" <> numerals(n - 90)
  end

  def numerals(n) when n >= 50 do
    "L" <> numerals(n - 50)
  end

  def numerals(n) when n >= 40 do
    "XL" <> numerals(n - 40)
  end

  def numerals(n) when n >= 10 do
    "X" <> numerals(n - 10)
  end

  def numerals(9) do
    "IX"
  end

  def numerals(n) when n >= 5 do
    "V" <> numerals(n - 5)
  end

  def numerals(4) do
    "IV"
  end

  def numerals(n) when n >= 1 do
    "I" <> numerals(n - 1)
  end

  def numerals(_), do: ""
end
