defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(s, size) do
    if size < 1 or String.length(s) < size do
      []
    else
      [String.slice(s, 0, size) | slices(String.slice(s, 1..-1), size)]
    end
  end
end
