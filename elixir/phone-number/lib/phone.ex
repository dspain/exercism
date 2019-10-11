defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("212-555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 055-0100")
  "0000000000"

  iex> Phone.number("(212) 555-0100")
  "2125550100"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t()) :: String.t()
  def number(raw) do
    digits = Regex.replace(~r/[^[:alnum:]]/, raw, "")
    length = String.length(digits)
    first = String.first(digits)
    exchange = String.slice(digits, length - 7, 1)

    cond do
      invalid_number?(digits, length, first, exchange) -> "0000000000"
      length == 11 and first == "1" -> String.slice(digits, 1..-1)
      true -> digits
    end
  end

  defp invalid_number?(digits, length, first, exchange) do
    Regex.match?(~r/[[:alpha:]]/, digits) or (length != 10 and length != 11) or
      (length == 11 and first != "1") or (length == 10 and first in ~w(0 1)) or
      exchange in ~w(0 1)
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("212-555-0100")
  "212"

  iex> Phone.area_code("+1 (212) 555-0100")
  "212"

  iex> Phone.area_code("+1 (012) 555-0100")
  "000"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t()) :: String.t()
  def area_code(raw) do
    raw
    |> number
    |> get_area_code
  end

  defp get_area_code(number) do
    length = String.length(number)

    cond do
      String.first(number) == "0" -> "000"
      length == 10 -> String.slice(number, 0, 3)
      length == 11 -> String.slice(number, 1, 3)
      true -> "000"
    end
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("212-555-0100")
  "(212) 555-0100"

  iex> Phone.pretty("212-155-0100")
  "(000) 000-0000"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t()) :: String.t()
  def pretty(raw) do
    number = number(raw)
    length = String.length(number)
    area_code = get_area_code(number)
    exchange_code = String.slice(number, length - 7, 3)
    subscriber_number = String.slice(number, length - 4, 4)

    cond do
      length == 10 -> "(#{area_code}) #{exchange_code}-#{subscriber_number}"
      length == 11 -> "+1 (#{area_code}) #{exchange_code}-#{subscriber_number}"
      true -> "(000) 000-0000"
    end
  end
end
