defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    number
    |> get_prime_factors(1)
    |> Enum.uniq()
    |> pling_plang_plong()
  end

  defp get_prime_factors(number, divisor) do
    cond do
      divisor > number / 2 + 1 ->
        []

      rem(number, divisor) == 0 ->
        [divisor, div(number, divisor) | get_prime_factors(number, divisor + 1)]

      true ->
        get_prime_factors(number, divisor + 1)
    end
  end

  defp pling_plang_plong(factors) do
    cond do
      Enum.member?(factors, 3) && Enum.member?(factors, 5) && Enum.member?(factors, 7) ->
        "PlingPlangPlong"

      Enum.member?(factors, 3) && Enum.member?(factors, 5) ->
        "PlingPlang"

      Enum.member?(factors, 3) && Enum.member?(factors, 7) ->
        "PlingPlong"

      Enum.member?(factors, 5) && Enum.member?(factors, 7) ->
        "PlangPlong"

      Enum.member?(factors, 3) ->
        "Pling"

      Enum.member?(factors, 5) ->
        "Plang"

      Enum.member?(factors, 7) ->
        "Plong"

      true ->
        Integer.to_string(Enum.max(factors))
    end
  end
end
