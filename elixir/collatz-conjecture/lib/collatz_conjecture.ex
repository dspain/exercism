defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(1), do: 0

  def calc(input) when input > 1 and is_integer(input) do
    cond do
      input / 2 == div(input, 2) -> 1 + calc(div(input, 2))
      true -> 1 + calc(3 * input + 1)
    end
  end
end
