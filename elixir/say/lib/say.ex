defmodule Say do
  @low_numbers %{
    1 => "one",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    8 => "eight",
    9 => "nine",
    10 => "ten",
    11 => "eleven",
    12 => "twelve",
    13 => "thirteen",
    14 => "fourteen",
    15 => "fifteen",
    16 => "sixteen",
    17 => "seventeen",
    18 => "eighteen",
    19 => "nineteen"
  }

  @tens %{
    2 => "twenty",
    3 => "thirty",
    4 => "forty",
    5 => "fifty",
    6 => "sixty",
    7 => "seventy",
    8 => "eighty",
    9 => "ninety"
  }
  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t()}
  def in_english(number) when number < 0 or number > 999_999_999_999 do
    {:error, "number is out of range"}
  end

  def in_english(0), do: {:ok, "zero"}
  def in_english(number), do: {:ok, number_string(number) |> String.split() |> Enum.join(" ")}

  @spec number_string(integer) :: String.t()
  def number_string(0), do: ""

  def number_string(number) when number in 1..19 do
    @low_numbers[number]
  end

  def number_string(number) when number in 20..99 do
    tens = div(number, 10)
    ones = rem(number, 10)

    case ones == 0 do
      true -> @tens[tens]
      false -> "#{@tens[tens]}-#{@low_numbers[ones]}"
    end
  end

  def number_string(number) when number in 100..999 do
    hundreds = div(number, 100)
    remainder = rem(number, 100)
    "#{@low_numbers[hundreds]} hundred " <> number_string(remainder)
  end

  def number_string(number) when number in 1_000..999_999 do
    thousands = div(number, 1000)
    remainder = rem(number, 1000)
    "#{number_string(thousands)} thousand " <> number_string(remainder)
  end

  def number_string(number) when number in 1_000_000..999_999_999 do
    millions = div(number, 1_000_000)
    remainder = rem(number, 1_000_000)
    "#{number_string(millions)} million " <> number_string(remainder)
  end

  def number_string(number) when number in 1_000_000_000..999_999_999_999 do
    billions = div(number, 1_000_000_000)
    remainder = rem(number, 1_000_000_000)
    "#{number_string(billions)} billion " <> number_string(remainder)
  end
end
