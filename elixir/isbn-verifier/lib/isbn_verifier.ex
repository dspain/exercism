defmodule IsbnVerifier do
  @valid_digits ~w(0 1 2 3 4 5 6 7 8 9)
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> ISBNVerifier.isbn?("3-598-21507-X")
      true

      iex> ISBNVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    isbn
    |> String.replace("-", "")
    |> String.graphemes()
    |> multiply_digits()
  end

  defp multiply_digits(digits) when length(digits) != 10, do: false

  defp multiply_digits(digits) do
    rem(do_mult(digits, 10), 11) == 0
  end

  defp do_mult(_, 0), do: 0

  defp do_mult(digits, multiplier) do
    first_digit = parse_first_int(digits)

    case first_digit do
      # this just has to be a number that is != 0 after mod 11
      :error -> 42
      _ -> first_digit * multiplier + do_mult(Enum.slice(digits, 1..-1), multiplier - 1)
    end
  end

  defp parse_first_int(digits) do
    cond do
      String.contains?(Enum.at(digits, 0), @valid_digits) -> String.to_integer(Enum.at(digits, 0))
      Enum.at(digits, 0) == "X" -> 10
      true -> :error
    end
  end
end
