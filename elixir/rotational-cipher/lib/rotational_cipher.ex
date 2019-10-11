defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    String.to_charlist(text)
    |> Enum.map(&rotate_chars(&1, shift))
    |> String.Chars.to_string()
  end

  defp rotate_chars(char, shift) when char >= ?a and char <= ?z do
    rem(char - ?a + shift, 26) + ?a
  end

  defp rotate_chars(char, shift) when char >= ?A and char <= ?Z do
    rem(char - ?A + shift, 26) + ?A
  end

  defp rotate_chars(char, _), do: char
end
