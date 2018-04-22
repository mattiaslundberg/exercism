defmodule RobotSimulator do
  defstruct [:position, :direction]

  @directions [:north, :east, :south, :west]

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0}) do
    cond do
      direction not in @directions -> {:error, "invalid direction"}
      not valid_position?(position) -> {:error, "invalid position"}
      true -> %RobotSimulator{direction: direction, position: position}
    end
  end

  defp valid_position?({a, b}) when is_integer(a) and is_integer(b), do: true
  defp valid_position?(_), do: false

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any

  def simulate(robot, instructions) do
    instructions
    |> String.split("", trim: true)
    |> Enum.reduce_while(robot, fn x, r ->
      do_simulate(r, x)
    end)
  end

  defp do_simulate(r = %RobotSimulator{direction: direction}, "R") do
    new_direction =
      case direction do
        :north -> :east
        :east -> :south
        :south -> :west
        :west -> :north
      end

    {:cont, %{r | direction: new_direction}}
  end

  defp do_simulate(r = %RobotSimulator{direction: direction}, "L") do
    new_direction =
      case direction do
        :north -> :west
        :west -> :south
        :south -> :east
        :east -> :north
      end

    {:cont, %{r | direction: new_direction}}
  end

  defp do_simulate(r = %RobotSimulator{direction: direction, position: {x, y}}, "A") do
    r =
      case direction do
        :north -> %{r | position: {x, y + 1}}
        :east -> %{r | position: {x + 1, y}}
        :south -> %{r | position: {x, y - 1}}
        :west -> %{r | position: {x - 1, y}}
      end

    {:cont, r}
  end

  defp do_simulate(_, _), do: {:halt, {:error, "invalid instruction"}}

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(%RobotSimulator{direction: direction}) do
    direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(%RobotSimulator{position: position}) do
    position
  end
end
