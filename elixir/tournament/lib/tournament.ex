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
    |> Enum.map(&String.split(&1, ";"))
    |> Enum.map(&process_results(&1))
    |> Enum.reduce(%{}, fn x, acc ->
      Map.merge(acc, x, fn _k, v1, v2 -> Map.merge(v1, v2, fn _kk, vv1, vv2 -> vv1 + vv2 end) end)
    end)
    |> print_results
  end

  defp process_results(game) do
    {team1, team2, result} = {Enum.at(game, 0), Enum.at(game, 1), Enum.at(game, 2)}

    cond do
      Enum.count(game) != 3 ->
        %{}

      result == "win" ->
        %{
          team1 => %{"MP" => 1, "W" => -1, "D" => 0, "L" => 0, "P" => -3},
          team2 => %{"MP" => 1, "W" => 0, "D" => 0, "L" => -1, "P" => 0}
        }

      result == "loss" ->
        %{
          team1 => %{"MP" => 1, "W" => 0, "D" => 0, "L" => -1, "P" => 0},
          team2 => %{"MP" => 1, "W" => -1, "D" => 0, "L" => 0, "P" => -3}
        }

      result == "draw" ->
        %{
          team1 => %{"MP" => 1, "W" => 0, "D" => -1, "L" => 0, "P" => -1},
          team2 => %{"MP" => 1, "W" => 0, "D" => -1, "L" => 0, "P" => -1}
        }

      true ->
        %{}
    end
  end

  defp print_results(result_map) do
    result =
      result_map
      |> Map.keys()
      |> Enum.map(&{&1, result_map[&1]})
      |> Enum.sort_by(&{Map.get(elem(&1, 1), "P"), elem(&1, 0)})
      |> Enum.map_join("\n", &format_result_tuple(&1))

    "Team                           | MP |  W |  D |  L |  P\n" <> result
  end

  defp format_result_tuple(tuple) do
    "#{String.pad_trailing(elem(tuple, 0), 30)} |" <>
      " #{String.pad_leading(Integer.to_string(Map.get(elem(tuple, 1), "MP")), 2)} |" <>
      " #{String.pad_leading(Integer.to_string(-Map.get(elem(tuple, 1), "W")), 2)} |" <>
      " #{String.pad_leading(Integer.to_string(-Map.get(elem(tuple, 1), "D")), 2)} |" <>
      " #{String.pad_leading(Integer.to_string(-Map.get(elem(tuple, 1), "L")), 2)} |" <>
      " #{String.pad_leading(Integer.to_string(-Map.get(elem(tuple, 1), "P")), 2)}"
  end
end
