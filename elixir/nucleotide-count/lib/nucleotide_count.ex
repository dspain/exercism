defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    count_each(strand, nucleotide)
  end

  defp count_each([], _n), do: 0

  defp count_each([n | rest], n) do
    count_each(rest, n) + 1
  end

  defp count_each([_first | rest], n) do
    count_each(rest, n)
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    @nucleotides
    |> Enum.map(fn n -> {n, count(strand, n)} end)
    |> Map.new()
  end
end
