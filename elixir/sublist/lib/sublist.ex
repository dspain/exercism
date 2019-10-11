defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      equal?(a, b) -> :equal
      a_sublist_of_b?(a, b) -> :sublist
      a_superlist_of_b?(a, b) -> :superlist
      true -> :unequal
    end
  end

  defp equal?(a, b) do
    a == b
  end

  defp a_sublist_of_b?(_a, []), do: false
  defp a_sublist_of_b?([], _b), do: true

  defp a_sublist_of_b?(a, b) do
    [first | rest] = b

    cond do
      Enum.count(a) > Enum.count(b) -> false
      true -> a === Enum.slice(b, 0, Enum.count(a)) or a_sublist_of_b?(a, rest)
    end
  end

  defp a_superlist_of_b?(a, b) do
    a_sublist_of_b?(b, a)
  end
end
