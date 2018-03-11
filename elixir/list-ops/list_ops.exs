defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count([]), do: 0
  def count([_ | r]), do: 1 + count(r)

  @spec reverse(list) :: list
  def reverse(l, acc \\ [])
  def reverse([], acc), do: acc

  def reverse([h | t], acc) do
    reverse(t, [h | acc])
  end

  @spec map(list, (any -> any)) :: list
  def map([], _), do: []

  def map([h | t], f) do
    [f.(h) | map(t, f)]
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], f), do: []

  def filter([h | t], f) do
    if f.(h) do
      [h | filter(t, f)]
    else
      filter(t, f)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, _), do: acc

  def reduce([h | t], acc, f) do
    reduce(t, f.(h, acc), f)
  end

  @spec append(list, list) :: list
  def append([], b), do: b

  def append([h | t], b) do
    [h | append(t, b)]
  end

  @spec concat([[any]]) :: [any]

  def concat([]), do: []

  def concat([[] | t]) do
    concat(t)
  end

  def concat([[h] | t]) do
    concat([h | t])
  end

  def concat([[h | it] | t]) do
    concat([h | [it | t]])
  end

  def concat([h | t]) do
    [h | concat(t)]
  end
end
