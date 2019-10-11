defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    stripped_sentence(sentence) == Enum.uniq(stripped_sentence(sentence))
  end

  defp stripped_sentence(sentence) do
    sentence
    |> String.downcase()
    |> String.replace(~r/[- ]/, "")
    |> String.graphemes()
  end
end
