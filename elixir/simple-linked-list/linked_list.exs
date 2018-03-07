defmodule Node do
  defstruct value: nil, next: nil
end

defmodule LinkedList do
  @opaque t :: tuple()

  defstruct head: nil

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new() do
    %LinkedList{}
  end

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(list = %LinkedList{head: nil}, elem) do
    %{list | head: %Node{value: elem}}
  end

  def push(list = %LinkedList{head: h}, elem) do
    %{list | head: push(h, elem)}
  end

  def push(node = %Node{}, elem) do
    %Node{value: elem, next: node}
  end

  @doc """
  Calculate the length of a LinkedList
  """
  @spec length(t) :: non_neg_integer()
  def length(%LinkedList{head: nil}), do: 0
  def length(%LinkedList{head: node}), do: LinkedList.length(node)
  def length(%Node{next: nil}), do: 1

  def length(%Node{next: next}) do
    1 + LinkedList.length(next)
  end

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?(list) do
    LinkedList.length(list) == 0
  end

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek(%LinkedList{head: nil}), do: {:error, :empty_list}
  def peek(%LinkedList{head: %Node{value: v}}), do: {:ok, v}
  def peek(%Node{value: v}), do: {:ok, v}

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail(%LinkedList{head: %Node{next: n}}), do: {:ok, %LinkedList{head: n}}
  def tail(%LinkedList{}), do: {:error, :empty_list}

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop(%LinkedList{head: %Node{value: v, next: n}}) do
    {:ok, v, %LinkedList{head: n}}
  end

  def pop(_) do
    {:error, :empty_list}
  end

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list(list) do
    list
    |> Enum.reverse()
    |> Enum.reduce(LinkedList.new(), fn v, acc -> LinkedList.push(acc, v) end)
  end

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list(%LinkedList{head: h}) do
    to_list(h)
  end

  def to_list(%Node{value: v, next: n}) do
    [v | to_list(n)]
  end

  def to_list(_) do
    []
  end

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list) do
    list
    |> to_list
    |> Enum.reverse()
    |> from_list
  end
end
