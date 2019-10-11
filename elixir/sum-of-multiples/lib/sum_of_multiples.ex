defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    1..(limit - 1)
    |> Enum.filter(&is_factor(&1, factors))
    |> Enum.sum()
  end

  defp is_factor(number, []), do: false

  defp is_factor(number, [first | rest]) do
    rem(number, first) == 0 or is_factor(number, rest)
  end
end
