defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count > 0 do
    get_nth_prime(count, 2)
  end

  defp get_nth_prime(0, number), do: number - 1

  defp get_nth_prime(count, number) do
    cond do
      is_prime?(number) -> get_nth_prime(count - 1, number + 1)
      true -> get_nth_prime(count, number + 1)
    end
  end

  defp is_prime?(2), do: true

  defp is_prime?(number) do
    sqrt =
      number
      |> :math.sqrt()
      |> Float.ceil()
      |> trunc

    !Enum.any?(2..sqrt, fn n -> rem(number, n) == 0 end)
  end
end
