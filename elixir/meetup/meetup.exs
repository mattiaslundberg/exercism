defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
          :monday
          | :tuesday
          | :wednesday
          | :thursday
          | :friday
          | :saturday
          | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date()
  def meetup(year, month, weekday, schedule) do
    day_index = weekday_index(weekday)

    day =
      schedule
      |> date_range()
      |> Enum.map(fn d ->
        case Date.new(year, month, d) do
          {:ok, date} -> date
          _ -> nil
        end
      end)
      |> Enum.filter(&(!is_nil(&1)))
      |> Enum.reduce_while(nil, fn d, _ ->
        if Date.day_of_week(d) == day_index do
          {:halt, d.day}
        else
          {:cont, nil}
        end
      end)

    {year, month, day}
  end

  defp date_range(schedule) do
    case schedule do
      :teenth -> 13..19
      :first -> 1..7
      :second -> 8..14
      :third -> 15..22
      :fourth -> 22..30
      :last -> 31..23
    end
  end

  defp weekday_index(w) do
    case w do
      :monday -> 1
      :tuesday -> 2
      :wednesday -> 3
      :thursday -> 4
      :friday -> 5
      :saturday -> 6
      :sunday -> 7
    end
  end
end
