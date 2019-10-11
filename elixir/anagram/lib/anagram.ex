defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, []), do: []

  def match(base, [first | rest]) do
    base_sorted = normalize(base)
    first_sorted = normalize(first)

    cond do
      String.downcase(base) == String.downcase(first) -> match(base, rest)
      base_sorted == first_sorted -> [first | match(base, rest)]
      true -> match(base, rest)
    end
  end

  defp normalize(word) do
    word
    |> String.downcase()
    |> String.graphemes()
    |> Enum.sort()
  end
end
