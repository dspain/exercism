defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2) do
    cond do
      length(strand1) != length(strand2) -> {:error, "Lists must be the same length"}
      strand1 == strand2 -> {:ok, 0}
      true -> get_hamming_distance(strand1, strand2)
    end
  end

  defp get_hamming_distance(strand1, strand2) do
    combined = Enum.zip(strand1, strand2)

    {:ok,
     Enum.reduce(combined, 0, fn tup, acc ->
       cond do
         elem(tup, 0) == elem(tup, 1) -> 0
         elem(tup, 0) != elem(tup, 1) -> 1
       end + acc
     end)}
  end
end
