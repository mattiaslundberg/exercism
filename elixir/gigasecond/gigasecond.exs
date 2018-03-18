defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          :calendar.datetime()

  def from({{year, month, day}, {hours, minutes, seconds}}) do
    with {:ok, date} <- Date.new(year, month, day),
         {:ok, time} <- Time.new(hours, minutes, seconds),
         {:ok, dt} <- NaiveDateTime.new(date, time) do
      res = NaiveDateTime.add(dt, 1_000_000_000)

      {{res.year, res.month, res.day}, {res.hour, res.minute, res.second}}
    else
      :error ->
        {:error, "invalid input"}
    end
  end
end
