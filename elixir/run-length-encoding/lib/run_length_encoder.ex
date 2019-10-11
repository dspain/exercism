defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    do_encode(String.slice(string, 1..-1), String.first(string), 1)
  end

  defp do_encode("", nil, _count), do: ""
  defp do_encode("", letter, 1), do: letter
  defp do_encode("", letter, count) when count != 1, do: "#{count}#{letter}"

  defp do_encode(string, letter, count) do
    cond do
      String.first(string) == letter ->
        do_encode(String.slice(string, 1..-1), letter, count + 1)

      count == 1 ->
        letter <> do_encode(String.slice(string, 1..-1), String.first(string), 1)

      true ->
        "#{count}#{letter}" <> do_encode(String.slice(string, 1..-1), String.first(string), 1)
    end
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    String.split(string, ~r/()[0-9]*[a-zA-Z ]/, on: [1], trim: true)
    |> Enum.map(&do_decode(&1))
    |> Enum.join()
  end

  defp do_decode([]), do: ""

  defp do_decode(string) do
    first_encoded = String.split(string, ~r/()[a-zA-Z ]()/, on: [1, 2], trim: true)

    cond do
      length(first_encoded) == 1 ->
        Enum.at(first_encoded, 0)

      true ->
        String.duplicate(Enum.at(first_encoded, 1), String.to_integer(Enum.at(first_encoded, 0)))
    end
  end
end
