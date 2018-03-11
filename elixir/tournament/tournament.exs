defmodule Tournament do
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    input
    |> Enum.reduce(%{}, fn r, acc ->
      case String.split(r, ";") do
        [t1, t2, "win"] ->
          update_win(acc, t1, t2)

        [t1, t2, "loss"] ->
          update_win(acc, t2, t1)

        [t1, t2, "draw"] ->
          acc = update_draw(acc, t1)
          update_draw(acc, t2)

        _ ->
          acc
      end
    end)
    |> Enum.sort(fn {ta, {_, _, _, _, a}}, {tb, {_, _, _, _, b}} ->
      if a == b do
        ta < tb
      else
        a > b
      end
    end)
    |> Enum.map(&pretty/1)
    |> (&["Team                           | MP |  W |  D |  L |  P" | &1]).()
    |> Enum.join("\n")
  end

  defp pretty({team, {games, won, draw, lost, points}}) do
    "#{String.pad_trailing(team, 30)} |  #{games} |  #{won} |  #{draw} |  #{lost} |  #{points}"
  end

  defp update_win(acc, t1, t2) do
    acc =
      Map.update(acc, t1, {1, 1, 0, 0, 3}, fn {g, w, d, l, p} ->
        {g + 1, w + 1, d, l, p + 3}
      end)

    Map.update(acc, t2, {1, 0, 0, 1, 0}, fn {g, w, d, l, p} ->
      {g + 1, w, d, l + 1, p}
    end)
  end

  defp update_draw(acc, t) do
    Map.update(acc, t, {1, 0, 1, 0, 1}, fn {g, w, d, l, p} ->
      {g + 1, w, d + 1, l, p + 1}
    end)
  end
end
